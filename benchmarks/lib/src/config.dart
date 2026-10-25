import 'dart:convert';
import 'dart:io';

class BenchmarkConfig {
  final String suite;
  final int repeats;
  final int warmups;
  final int transitionMs;
  final int transitionTimeoutSeconds;
  final int prepareTimeoutSeconds;
  final int telemetryMs;
  final int timingDrainMs;
  final int soakSeconds;
  final int seed;
  final List<int> grids;
  final List<String> backends;
  final List<String>? effects;
  final List<String>? mediaCases;
  final bool captureFrames;
  final bool exitWhenDone;
  final bool requireTimings;
  final String? mediaDirectory;
  final int expectedWidth;
  final int expectedHeight;

  BenchmarkConfig({
    this.suite = 'standard',
    int? repeats,
    int? warmups,
    this.transitionMs = 1000,
    this.transitionTimeoutSeconds = 45,
    this.prepareTimeoutSeconds = 60,
    this.telemetryMs = 500,
    this.timingDrainMs = 1200,
    int? soakSeconds,
    this.seed = 42,
    List<int>? grids,
    this.backends = const ['canvas', 'shader'],
    this.effects,
    this.mediaCases,
    bool? captureFrames,
    this.exitWhenDone = true,
    this.requireTimings = true,
    this.mediaDirectory,
    this.expectedWidth = 2560,
    this.expectedHeight = 1600,
  }) : repeats = repeats ?? (suite == 'smoke' ? 1 : 3),
       warmups = warmups ?? (suite == 'smoke' ? 0 : 1),
       grids = grids ?? (suite == 'smoke' ? [100, 200] : [100, 150, 200]),
       captureFrames = captureFrames ?? (suite == 'standard'),
       soakSeconds = soakSeconds ?? (suite == 'soak' ? 86400 : 0) {
    if (!['smoke', 'standard', 'soak'].contains(suite)) {
      throw ArgumentError('Unknown suite: $suite');
    }
    if (this.repeats < 1 ||
        this.repeats > 100 ||
        this.warmups < 0 ||
        this.warmups > 100) {
      throw ArgumentError('repeats must be 1..100; warmups 0..100');
    }
    if (transitionMs < 1 ||
        transitionMs > 60000 ||
        transitionTimeoutSeconds < 1 ||
        prepareTimeoutSeconds < 1 ||
        telemetryMs < 100 ||
        timingDrainMs < 1000 ||
        this.soakSeconds < 0 ||
        expectedWidth < 1 ||
        expectedHeight < 1) {
      throw ArgumentError('Invalid timing, telemetry or display settings');
    }
    if (this.grids.isEmpty || this.grids.any((v) => v < 100 || v > 1000)) {
      throw ArgumentError(
        'Mosaic grids must be 100..1000; automatic quality reduction is disabled',
      );
    }
    if (backends.isEmpty ||
        backends.any((v) => !['canvas', 'shader'].contains(v))) {
      throw ArgumentError('backends must contain canvas and/or shader');
    }
    if (effects != null && effects!.isEmpty ||
        mediaCases != null && mediaCases!.isEmpty) {
      throw ArgumentError('Effect/media filters cannot be empty');
    }
  }

  factory BenchmarkConfig.fromJson(Map<String, dynamic> json) {
    const keys = {
      'suite',
      'repeats',
      'warmups',
      'transition_ms',
      'transition_timeout_seconds',
      'prepare_timeout_seconds',
      'telemetry_ms',
      'timing_drain_ms',
      'soak_seconds',
      'seed',
      'grids',
      'backends',
      'effects',
      'media_cases',
      'capture_frames',
      'exit_when_done',
      'require_timings',
      'media_directory',
      'expected_width',
      'expected_height',
    };
    final unknown = json.keys.where((key) => !keys.contains(key));
    if (unknown.isNotEmpty) {
      throw FormatException('Unknown config fields: ${unknown.join(', ')}');
    }
    return BenchmarkConfig(
      suite: json['suite'] as String? ?? 'standard',
      repeats: json['repeats'] as int?,
      warmups: json['warmups'] as int?,
      transitionMs: json['transition_ms'] as int? ?? 1000,
      transitionTimeoutSeconds:
          json['transition_timeout_seconds'] as int? ?? 45,
      prepareTimeoutSeconds: json['prepare_timeout_seconds'] as int? ?? 60,
      telemetryMs: json['telemetry_ms'] as int? ?? 500,
      timingDrainMs: json['timing_drain_ms'] as int? ?? 1200,
      soakSeconds: json['soak_seconds'] as int?,
      seed: json['seed'] as int? ?? 42,
      grids: (json['grids'] as List?)?.cast<int>(),
      backends:
          (json['backends'] as List?)?.cast<String>() ??
          const ['canvas', 'shader'],
      effects: (json['effects'] as List?)?.cast<String>(),
      mediaCases: (json['media_cases'] as List?)?.cast<String>(),
      captureFrames: json['capture_frames'] as bool?,
      exitWhenDone: json['exit_when_done'] as bool? ?? true,
      requireTimings: json['require_timings'] as bool? ?? true,
      mediaDirectory: json['media_directory'] as String?,
      expectedWidth: json['expected_width'] as int? ?? 2560,
      expectedHeight: json['expected_height'] as int? ?? 1600,
    );
  }

  static Future<BenchmarkConfig> load(Map<String, String> environment) async {
    final file = environment['BENCHMARK_CONFIG'];
    final json = file == null || file.isEmpty
        ? <String, dynamic>{}
        : (jsonDecode(await File(file).readAsString()) as Map)
              .cast<String, dynamic>();
    for (final entry in {
      'BENCHMARK_SUITE': 'suite',
      'BENCHMARK_MEDIA_DIR': 'media_directory',
    }.entries) {
      final value = environment[entry.key];
      if (value != null && value.isNotEmpty) json[entry.value] = value;
    }
    if (environment['BENCHMARK_SOAK_SECONDS'] case final String value) {
      json['soak_seconds'] = int.parse(value);
    }
    return BenchmarkConfig.fromJson(json);
  }

  Map<String, Object?> toJson() => {
    'suite': suite,
    'repeats': repeats,
    'warmups': warmups,
    'transition_ms': transitionMs,
    'transition_timeout_seconds': transitionTimeoutSeconds,
    'prepare_timeout_seconds': prepareTimeoutSeconds,
    'telemetry_ms': telemetryMs,
    'timing_drain_ms': timingDrainMs,
    'soak_seconds': soakSeconds,
    'seed': seed,
    'grids': grids,
    'backends': backends,
    'effects': effects,
    'media_cases': mediaCases,
    'capture_frames': captureFrames,
    'exit_when_done': exitWhenDone,
    'require_timings': requireTimings,
    'media_directory': mediaDirectory,
    'expected_width': expectedWidth,
    'expected_height': expectedHeight,
  };
}
