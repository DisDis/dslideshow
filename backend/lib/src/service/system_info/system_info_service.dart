import 'dart:async';
import 'dart:io' as io;

import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_backend/src/service/hardware/src/hardware_service_config.dart';
import 'package:dslideshow_backend/src/service/system_info/system_command_runner.dart';
import 'package:logging/logging.dart';

class SystemInfoService {
  static final Logger _log = Logger('SystemInfoService');
  static final _environment = {'LC_ALL': 'C'};
  static final _findHardware = RegExp(r'Hardware *[^ ]*([^\n]*)');
  static final _findRevision = RegExp(r'Revision *[^ ]*([^\n]*)');
  static final _findModel = RegExp(r'Model *[^ ]*([^\n]*)');
  static final _findMem = RegExp('Mem:[ ]*([^ ]*)[ ]*([^ ]*)[ ]*([^ ]*)');
  static final _findSwap = RegExp('Swap:[ ]*([^ ]*)[ ]*([^ ]*)[ ]*([^ ]*)');
  static final _diskUsagePattern = RegExp(
    r' *([^ ]*) *([^ ]*) *([^ ]*) *([^ %]*)',
  );
  static final _whitespacePattern = RegExp(r'\s+');
  static final _procMemoryPattern = RegExp(
    r'^([A-Za-z_()]+):\s+(\d+)\s+kB\s*$',
    multiLine: true,
  );
  static final _interfaceNamePattern = RegExp(
    r'^([a-zA-Z0-9_.:@-]+):\s+flags=',
  );
  static final _leadingWhitespacePattern = RegExp(r'\s');
  static const _updatePeriod = Duration(seconds: 1);
  static const _networkInfoUpdatePeriod = Duration(minutes: 1);

  static final flagsRegex = RegExp(r'flags=\d+<([^>]+)>');
  static final ip4Regex = RegExp(r'inet\s+([0-9\.]+)');
  static final ip6Regex = RegExp(r'inet6\s+([a-fA-F0-9:]+)');

  final HardwareConfig _config;
  final SystemCommandRunner _commands;
  final Future<String> Function(String) _readFile;
  final Duration Function()? _monotonicClock;
  final DateTime Function() _wallClock;
  final Stopwatch _clock = Stopwatch()..start();
  SystemInfo? _lastInfo;
  UpdateInfo? _lastUpdate;
  Duration? _updateAt;
  Duration? _networkAt;
  Future<SystemInfo>? _fullInFlight;
  Future<UpdateInfo>? _updateInFlight;
  bool _released = false;
  Future<void>? _releaseFuture;

  SystemInfoService(
    this._config, {
    SystemCommandRunner? commandRunner,
    Future<String> Function(String)? readFile,
    Duration Function()? monotonicClock,
    DateTime Function()? wallClock,
  }) : _commands = commandRunner ?? BoundedSystemCommandRunner(),
       _readFile = readFile ?? ((path) => io.File(path).readAsString()),
       _monotonicClock = monotonicClock,
       _wallClock = wallClock ?? DateTime.now;

  Duration get _tick => _monotonicClock?.call() ?? _clock.elapsed;

  void _checkOpen() {
    if (_released) throw StateError('System information service is released');
  }

  Future<SystemInfo> getFullInfo() {
    _checkOpen();
    return _fullInFlight ??= _observe(
      _collectFullInfo().whenComplete(() {
        _fullInFlight = null;
      }),
    );
  }

  // init() can still be held in HardwareService's readiness list when that
  // service is released. Observe failures even if readiness is never awaited.
  Future<T> _observe<T>(Future<T> future) {
    unawaited(future.then<void>((_) {}, onError: (Object _, StackTrace __) {}));
    return future;
  }

  Future<SystemInfo> _collectFullInfo() async {
    final updateInfo = await getUpdateInfo();
    _checkOpen();
    final previous = _lastInfo;
    if (previous == null) {
      final cpuInfo = await _getCpuInfo();
      final osInfo = await _getOSInfo();
      final networkInfo = await _getNetworkInfo();
      _checkOpen();
      _networkAt = _tick;
      return _lastInfo = SystemInfo(
        updateInfo: updateInfo,
        cpuInfo: cpuInfo,
        osInfo: osInfo,
        networkInfo: networkInfo,
      );
    }
    var networkInfo = previous.networkInfo;
    if (_networkAt == null || _tick - _networkAt! >= _networkInfoUpdatePeriod) {
      networkInfo = await _getNetworkInfo();
      _checkOpen();
      _networkAt = _tick;
    }
    _checkOpen();
    return _lastInfo = previous.copyWith(
      updateInfo: updateInfo,
      networkInfo: networkInfo,
    );
  }

  Future<io.ProcessResult> _run(
    String executable,
    List<String> arguments,
  ) async {
    _checkOpen();
    final result = await _commands.run(
      executable,
      arguments,
      environment: _environment,
    );
    _checkOpen();
    if (result.exitCode != 0) {
      _log.warning(
        'System command $executable exited ${result.exitCode}: ${result.stderr}',
      );
    }
    return result;
  }

  Future<String> _read(String path) async {
    _checkOpen();
    final result = await _readFile(path);
    _checkOpen();
    return result;
  }

  Future<List<NetworkInterfaceInfo>> getNetworkInterfaces() async {
    try {
      final result = await _run(_config.systemIfConfigScript, []);
      if (result.exitCode == 0) {
        return parseIfconfigOutput(result.stdout.toString());
      }
    } catch (e, s) {
      _log.severe('getNetworkInterfaces', e, s);
    }
    return <NetworkInterfaceInfo>[];
  }

  Future<UpdateInfo> getUpdateInfo() {
    _checkOpen();
    final previous = _lastUpdate;
    if (previous != null &&
        _updateAt != null &&
        _tick - _updateAt! < _updatePeriod) {
      return Future.value(previous);
    }
    return _updateInFlight ??= _observe(
      _collectUpdateInfo()
          .then((info) {
            _checkOpen();
            _lastUpdate = info;
            _updateAt = _tick;
            return info;
          })
          .whenComplete(() {
            _updateInFlight = null;
          }),
    );
  }

  Future<UpdateInfo> _collectUpdateInfo() async {
    // Keep the established DTO, defaults and timestamp semantics. A cache hit
    // returns this snapshot without pretending that it was collected again.
    var b = UpdateInfo(
      lastUpdate: _wallClock().millisecondsSinceEpoch,
      cpuLoad1: 1,
      cpuLoad5: 1,
      cpuLoad15: 1,
      memTotal: 1,
      memUsed: 1,
      swapTotal: 1,
      swapUsed: 1,
      diskUsedPercent: 0,
      diskUsed: 0,
      diskAvailable: 0,
      uptime: '',
      sensors: List.empty(),
    );

    try {
      var result = await _run('df', []);
      if (result.exitCode == 0) {
        final diskInfo = result.stdout
            .toString()
            .split('\n')
            .firstWhere(
              (element) => element.startsWith(_config.systemDiskDev),
              orElse: () => '',
            );
        if (diskInfo.isNotEmpty) {
          // The literal device prefix was already matched by startsWith above.
          final info = _diskUsagePattern.firstMatch(
            diskInfo.substring(_config.systemDiskDev.length),
          )!;
          b = b.copyWith(
            diskUsed: int.tryParse(info.group(2)!) ?? 0,
            diskAvailable: int.tryParse(info.group(3)!) ?? 0,
            diskUsedPercent: int.tryParse(info.group(4)!) ?? 0,
          );
        }
      }
      // Keep procps' pretty formatting, including weeks and the final newline.
      result = await _run('uptime', ['-p']);
      if (result.exitCode == 0) {
        b = b.copyWith(uptime: result.stdout.toString());
      }

      final memory = await _getMemory();
      if (memory != null) {
        b = b.copyWith(
          memTotal: memory.total,
          memUsed: memory.used,
          swapTotal: memory.swapTotal,
          swapUsed: memory.swapUsed,
        );
      }
      if (io.Platform.isLinux) {
        b = _withLoad(b, await _read('/proc/loadavg'));
      } else {
        result = await _run('cat', ['/proc/loadavg']);
        if (result.exitCode == 0) {
          b = _withLoad(b, result.stdout.toString());
        }
      }
    } catch (e, s) {
      _log.severe('getUpdateInfo', e, s);
    }
    b = b.copyWith(sensors: await _getSensorInfo());
    _checkOpen();
    return b;
  }

  UpdateInfo _withLoad(UpdateInfo info, String text) {
    final values = text.trim().split(_whitespacePattern);
    if (values.length < 3) throw FormatException('Incomplete load average');
    return info.copyWith(
      cpuLoad1: double.tryParse(values[0]) ?? 0,
      cpuLoad5: double.tryParse(values[1]) ?? 0,
      cpuLoad15: double.tryParse(values[2]) ?? 0,
    );
  }

  Future<_Memory?> _getMemory() async {
    if (io.Platform.isLinux) {
      try {
        final memory = _parseProcMemory(await _read('/proc/meminfo'));
        if (memory != null) return memory;
      } catch (error, stack) {
        _checkOpen();
        _log.fine('Cannot read memory; using free', error, stack);
      }
    }
    final result = await _run('free', []);
    if (result.exitCode != 0) return null;
    final text = result.stdout.toString();
    final memory = _findMem.firstMatch(text)!;
    final swap = _findSwap.firstMatch(text)!;
    return _Memory(
      int.tryParse(memory.group(1)!) ?? 0,
      int.tryParse(memory.group(2)!) ?? 0,
      int.tryParse(swap.group(1)!) ?? 0,
      int.tryParse(swap.group(2)!) ?? 0,
    );
  }

  _Memory? _parseProcMemory(String text) {
    final values = <String, int>{};
    for (final match in _procMemoryPattern.allMatches(text)) {
      final value = int.tryParse(match.group(2)!);
      if (value != null) values[match.group(1)!] = value;
    }
    final total = values['MemTotal'];
    final available = values['MemAvailable'];
    final swapTotal = values['SwapTotal'];
    final swapFree = values['SwapFree'];
    if (total == null ||
        available == null ||
        swapTotal == null ||
        swapFree == null ||
        available > total ||
        swapFree > swapTotal) {
      return null;
    }
    return _Memory(total, total - available, swapTotal, swapTotal - swapFree);
  }

  Future<bool> hasInternet() async {
    try {
      final result = await _run('ping', ['-c', '1', '8.8.8.8']);
      if (result.exitCode == 0) {
        return !result.stdout.toString().contains('100% packet loss');
      }
    } catch (e, s) {
      _log.severe('hasInternet', e, s);
    }
    return false;
  }

  Future<SystemInfo?> init() => getFullInfo();

  Future<void> release() => _releaseFuture ??= _release();

  Future<void> _release() async {
    _released = true;
    _lastInfo = null;
    _lastUpdate = null;
    _clock.stop();
    await _commands.close();
  }

  Future<CpuInfo> _getCpuInfo() async {
    var b = CpuInfo(cores: 0, hardware: '', model: '', revision: '');
    try {
      final result = await _run('nproc', ['--all']);
      if (result.exitCode == 0) {
        b = b.copyWith(cores: int.tryParse(result.stdout.toString()) ?? 0);
      }
      String? text;
      if (io.Platform.isLinux) {
        text = await _read('/proc/cpuinfo');
      } else {
        final result = await _run('cat', ['/proc/cpuinfo']);
        if (result.exitCode == 0) text = result.stdout.toString();
      }
      if (text != null) {
        b = b.copyWith(
          hardware: _findHardware.firstMatch(text)?.group(1) ?? 'Unknown',
          model: _findModel.firstMatch(text)?.group(1) ?? 'Unknown',
          revision: _findRevision.firstMatch(text)?.group(1) ?? 'Unknown',
        );
      }
    } catch (e, s) {
      _log.severe('_getCpuInfo', e, s);
    }
    return b;
  }

  Future<NetworkInfo> _getNetworkInfo() async {
    return NetworkInfo(
      lastUpdate: _wallClock().millisecondsSinceEpoch,
      interfaces: await getNetworkInterfaces(),
      hasInternet: await hasInternet(),
    );
  }

  Future<OSInfo> _getOSInfo() async {
    var b = OSInfo(name: '', osType: OSType.unknown);
    try {
      final result = await _run('uname', ['-a']);
      if (result.exitCode == 0) {
        final osInfo = result.stdout.toString().replaceAll('\n', '');
        b = b.copyWith(name: osInfo, osType: _resolveOSType(osInfo));
      }
    } catch (e, s) {
      _log.severe('_getOSInfo', e, s);
    }
    return b;
  }

  Future<List<SensorInfo>> _getSensorInfo() async {
    final sensors = <SensorInfo>[];
    try {
      final result = await _run(_config.sensorsScript, []);
      if (result.exitCode == 0) {
        final diagnostics = result.stderr.toString().trim();
        if (diagnostics.isNotEmpty) {
          _log.warning('Sensor script ${_config.sensorsScript}: $diagnostics');
        }
        for (final line in result.stdout.toString().split('\n')) {
          if (line.isEmpty) continue;
          final values = line.split('=');
          if (values.length < 2) continue;
          sensors.add(SensorInfo(name: values[0], value: values[1]));
        }
      }
    } catch (e, s) {
      _log.severe('_getSensorInfo', e, s);
    }
    return sensors;
  }

  static List<NetworkInterfaceInfo> parseIfconfigOutput(String output) {
    final List<NetworkInterfaceInfo> interfaces = [];

    // Переменные для хранения состояния текущего парсимого интерфейса
    String? currentName;
    NetworkInterfaceStatus currentStatus = NetworkInterfaceStatus.offline;
    String currentIp4 = '';
    String currentIp6 = '';

    // Вспомогательная функция для сохранения накопленных данных
    void saveCurrentInterface() {
      if (currentName != null) {
        interfaces.add(
          NetworkInterfaceInfo(
            name: currentName,
            status: currentStatus,
            ip4: currentIp4,
            ip6: currentIp6,
          ),
        );
      }
    }

    final lines = output.split('\n');

    for (final line in lines) {
      if (line.trim().isEmpty) continue;

      // Если строка начинается НЕ с пробела, это начало нового интерфейса
      if (!line.startsWith(_leadingWhitespacePattern)) {
        // 1. Сохраняем предыдущий интерфейс, если он был
        saveCurrentInterface();

        // 2. Сбрасываем данные для нового интерфейса
        currentName = null;
        currentStatus = NetworkInterfaceStatus.offline;
        currentIp4 = '';
        currentIp6 = '';

        // 3. Парсим имя
        final nameMatch = _interfaceNamePattern.firstMatch(line);
        if (nameMatch != null) {
          currentName = nameMatch.group(1);
        }

        // 4. Парсим статус из первой строки (флаги)
        final flagsMatch = flagsRegex.firstMatch(line);
        if (flagsMatch != null) {
          final flagsContent = flagsMatch.group(1) ?? '';
          // Если есть флаг RUNNING, считаем статус running, иначе offline
          if (flagsContent.contains('RUNNING')) {
            currentStatus = NetworkInterfaceStatus.running;
          }
        }
      } else {
        // Это строка с параметрами (начинается с отступа)

        // Парсим IPv4 (берем первый найденный)
        if (currentIp4.isEmpty) {
          final ip4Match = ip4Regex.firstMatch(line);
          if (ip4Match != null) {
            currentIp4 = ip4Match.group(1)!;
          }
        }

        // Парсим IPv6 (берем первый найденный)
        if (currentIp6.isEmpty) {
          final ip6Match = ip6Regex.firstMatch(line);
          if (ip6Match != null) {
            currentIp6 = ip6Match.group(1)!;
          }
        }
      }
    }

    // Не забываем сохранить последний интерфейс после выхода из цикла
    saveCurrentInterface();

    return interfaces;
  }

  OSType _resolveOSType(String osInfo) {
    if (osInfo.toLowerCase().contains('linux')) {
      return OSType.linux;
    }

    if (osInfo.toLowerCase().contains('darwin')) {
      return OSType.ios;
    }

    return OSType.unknown;
  }
}

class _Memory {
  final int total;
  final int used;
  final int swapTotal;
  final int swapUsed;

  const _Memory(this.total, this.used, this.swapTotal, this.swapUsed);
}
