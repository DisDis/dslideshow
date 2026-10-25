import 'dart:async';
import 'dart:convert';
import 'dart:io';

Future<String?> readText(String path) async {
  try {
    return (await File(path).readAsString()).trim();
  } on FileSystemException {
    return null;
  }
}

Future<List<FileSystemEntity>> listEntries(String path) async {
  try {
    return await Directory(path).list().toList();
  } on FileSystemException {
    return [];
  }
}

Future<String?> command(String executable, List<String> args) async {
  try {
    final process = await Process.start(executable, args);
    final timer = Timer(
      const Duration(seconds: 2),
      () => process.kill(ProcessSignal.sigkill),
    );
    final stdout = process.stdout.transform(utf8.decoder).join();
    final stderr = process.stderr.drain<void>();
    final code = await process.exitCode;
    final output = await stdout;
    await stderr;
    timer.cancel();
    return code == 0 ? output.trim() : null;
  } on ProcessException {
    return null;
  }
}

Map<String, int> parseKiB(String text) {
  final result = <String, int>{};
  for (final line in text.split('\n')) {
    final match = RegExp(r'^(\w+):\s+(\d+)\s+kB').firstMatch(line);
    if (match != null) result[match[1]!] = int.parse(match[2]!) * 1024;
  }
  return result;
}

int? processTicks(String text) {
  // comm may contain spaces and parentheses; fields start after the final ')'.
  final end = text.lastIndexOf(')');
  if (end < 0) return null;
  final fields = text.substring(end + 1).trim().split(RegExp(r'\s+'));
  if (fields.length < 13) return null;
  final user = int.tryParse(fields[11]);
  final system = int.tryParse(fields[12]);
  return user == null || system == null ? null : user + system;
}

({int total, int idle})? cpuTicks(String text) {
  final match = RegExp(r'^cpu\s+(.+)', multiLine: true).firstMatch(text);
  final values = match?[1]
      ?.trim()
      .split(RegExp(r'\s+'))
      .map(int.parse)
      .toList();
  if (values == null || values.length < 5) return null;
  return (
    total: values.take(8).fold(0, (a, b) => a + b),
    idle: values[3] + values[4],
  );
}

class LinuxTelemetry {
  final void Function(Map<String, Object?>) onSample;
  final Stopwatch clock = Stopwatch()..start();
  final String Function() stage;
  Timer? _timer;
  Future<void>? _pending;
  int? _lastProcess;
  int? _lastUs;
  ({int total, int idle})? _lastCpu;
  int? ticksPerSecond;
  int? throttleBits;
  int? initialThrottleBits;
  int _lastThrottleUs = -10000000;
  final List<String> _temperaturePaths = [];
  final List<String> _frequencyPaths = [];
  final List<String> _gpuPaths = [];
  final List<Map<String, Object?>> plotSamples = [];
  int samples = 0;
  int? peakRss;
  double? peakTemperature;

  LinuxTelemetry({required this.onSample, required this.stage});

  Future<Map<String, Object?>> initialize() async {
    ticksPerSecond = int.tryParse(await command('getconf', ['CLK_TCK']) ?? '');
    final thermal = Directory('/sys/class/thermal');
    if (await thermal.exists()) {
      for (final entry in await listEntries(thermal.path)) {
        final type = await readText('${entry.path}/type');
        if (type?.contains('cpu') == true || type?.contains('soc') == true) {
          _temperaturePaths.add('${entry.path}/temp');
        }
      }
    }
    final policies = Directory('/sys/devices/system/cpu/cpufreq');
    if (await policies.exists()) {
      for (final entry in await listEntries(policies.path)) {
        if (entry.path.split('/').last.startsWith('policy')) {
          _frequencyPaths.add('${entry.path}/scaling_cur_freq');
        }
      }
    }
    final devfreq = Directory('/sys/class/devfreq');
    if (await devfreq.exists()) {
      for (final entry in await listEntries(devfreq.path)) {
        if (entry.path.contains('gpu') || entry.path.contains('v3d')) {
          _gpuPaths.add('${entry.path}/cur_freq');
        }
      }
    }
    _temperaturePaths.sort();
    _frequencyPaths.sort();
    _gpuPaths.sort();
    final governors = <String, String?>{};
    for (final file in _frequencyPaths) {
      governors[file] = await readText(
        file.replaceFirst('scaling_cur_freq', 'scaling_governor'),
      );
    }
    await sample();
    return {
      'model': (await readText('/proc/device-tree/model'))
          ?.replaceAll('\u0000', ''),
      'kernel': await command('uname', ['-srmo']),
      'os': await readText('/etc/os-release'),
      'processors': Platform.numberOfProcessors,
      'clock_ticks_per_second': ticksPerSecond,
      'cpu_governors': governors,
      'temperature_paths': _temperaturePaths,
      'cpu_frequency_paths': _frequencyPaths,
      'gpu_frequency_paths': _gpuPaths,
      'initial_throttle_bits': initialThrottleBits,
      'gstreamer': await command('gst-launch-1.0', ['--version']),
      'video_plugins': await command('gst-inspect-1.0', ['playbin']),
    };
  }

  void start(int milliseconds) {
    _timer = Timer.periodic(Duration(milliseconds: milliseconds), (_) {
      _pending ??= sample().whenComplete(() => _pending = null);
    });
  }

  Future<void> stop() async {
    _timer?.cancel();
    await _pending;
  }

  Future<void> sample() async {
    final us = clock.elapsedMicroseconds;
    final texts = await Future.wait([
      readText('/proc/self/status'),
      readText('/proc/self/stat'),
      readText('/proc/stat'),
      readText('/proc/meminfo'),
      readText('/proc/loadavg'),
    ]);
    final status = texts[0] ?? '';
    final memory = parseKiB(status);
    final systemMemory = parseKiB(texts[3] ?? '');
    final proc = processTicks(texts[1] ?? '');
    final cpu = cpuTicks(texts[2] ?? '');
    double? processPercent;
    double? systemPercent;
    if (_lastUs != null &&
        ticksPerSecond != null &&
        proc != null &&
        _lastProcess != null &&
        us > _lastUs!) {
      processPercent =
          100 *
          (proc - _lastProcess!) /
          ticksPerSecond! /
          ((us - _lastUs!) / 1e6);
    }
    if (cpu != null && _lastCpu != null && cpu.total > _lastCpu!.total) {
      systemPercent =
          100 *
          (1 - (cpu.idle - _lastCpu!.idle) / (cpu.total - _lastCpu!.total));
    }
    _lastProcess = proc;
    _lastCpu = cpu;
    _lastUs = us;
    final temps = await Future.wait(_temperaturePaths.map(readText));
    final frequencies = await Future.wait(_frequencyPaths.map(readText));
    final gpu = await Future.wait(_gpuPaths.map(readText));
    final temperatures = temps
        .map((v) => double.tryParse(v ?? ''))
        .nonNulls
        .map((v) => v / 1000)
        .toList();
    final temperature = temperatures.isEmpty
        ? null
        : temperatures.reduce((a, b) => a > b ? a : b);
    if (us - _lastThrottleUs >= 10000000) {
      final result = await command('vcgencmd', ['get_throttled']);
      final hex = RegExp(r'0x([0-9a-fA-F]+)').firstMatch(result ?? '')?[1];
      throttleBits = hex == null ? null : int.parse(hex, radix: 16);
      initialThrottleBits ??= throttleBits;
      _lastThrottleUs = us;
    }
    final rss = memory['VmRSS'] ?? ProcessInfo.currentRss;
    peakRss = peakRss == null || rss > peakRss! ? rss : peakRss;
    if (temperature != null &&
        (peakTemperature == null || temperature > peakTemperature!)) {
      peakTemperature = temperature;
    }
    int? fds;
    try {
      fds = await Directory('/proc/self/fd').list().length;
    } on FileSystemException {
      /* unavailable */
    }
    final row = <String, Object?>{
      'utc': DateTime.now().toUtc().toIso8601String(),
      'elapsed_ms': us / 1000,
      'stage': stage(),
      'rss_bytes': rss,
      'hwm_bytes': memory['VmHWM'],
      'process_cpu_percent': processPercent,
      'system_cpu_percent': systemPercent,
      'available_memory_bytes': systemMemory['MemAvailable'],
      'swap_free_bytes': systemMemory['SwapFree'],
      'threads': int.tryParse(
        RegExp(r'^Threads:\s+(\d+)', multiLine: true).firstMatch(status)?[1] ??
            '',
      ),
      'open_fds': fds,
      'load_average': texts[4],
      'cpu_temperature_c': temperature,
      'cpu_frequency_khz': frequencies
          .map((v) => int.tryParse(v ?? ''))
          .toList(),
      'gpu_frequency_hz': gpu.map((v) => int.tryParse(v ?? '')).toList(),
      'throttle_bits': throttleBits,
    };
    samples++;
    onSample(row);
    plotSamples.add(row);
    if (plotSamples.length > 2000) {
      final reduced = [
        for (var i = 0; i < plotSamples.length; i += 2) plotSamples[i],
      ];
      plotSamples
        ..clear()
        ..addAll(reduced);
    }
  }
}
