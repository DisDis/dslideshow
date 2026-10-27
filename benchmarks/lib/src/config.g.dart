// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BenchmarkConfig _$BenchmarkConfigFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    allowedKeys: const [
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
      'effect_configs',
      'media_cases',
      'capture_frames',
      'exit_when_done',
      'require_timings',
      'vulkan_video',
      'visual_audit',
      'media_directory',
      'expected_width',
      'expected_height',
    ],
  );
  return BenchmarkConfig(
    suite: json['suite'] as String? ?? 'standard',
    repeats: _$JsonConverterFromJson<Object, int>(
      json['repeats'],
      const StrictIntConverter().fromJson,
    ),
    warmups: _$JsonConverterFromJson<Object, int>(
      json['warmups'],
      const StrictIntConverter().fromJson,
    ),
    transitionMs: json['transition_ms'] == null
        ? 1000
        : const StrictIntConverter().fromJson(json['transition_ms'] as Object),
    transitionTimeoutSeconds: json['transition_timeout_seconds'] == null
        ? 45
        : const StrictIntConverter().fromJson(
            json['transition_timeout_seconds'] as Object,
          ),
    prepareTimeoutSeconds: json['prepare_timeout_seconds'] == null
        ? 60
        : const StrictIntConverter().fromJson(
            json['prepare_timeout_seconds'] as Object,
          ),
    telemetryMs: json['telemetry_ms'] == null
        ? 500
        : const StrictIntConverter().fromJson(json['telemetry_ms'] as Object),
    timingDrainMs: json['timing_drain_ms'] == null
        ? 1200
        : const StrictIntConverter().fromJson(
            json['timing_drain_ms'] as Object,
          ),
    soakSeconds: _$JsonConverterFromJson<Object, int>(
      json['soak_seconds'],
      const StrictIntConverter().fromJson,
    ),
    seed: json['seed'] == null
        ? 42
        : const StrictIntConverter().fromJson(json['seed'] as Object),
    grids: (json['grids'] as List<dynamic>?)
        ?.map((e) => const StrictIntConverter().fromJson(e as Object))
        .toList(),
    backends:
        (json['backends'] as List<dynamic>?)
            ?.map((e) => e as String)
            .toList() ??
        const ['canvas', 'shader'],
    effects: (json['effects'] as List<dynamic>?)
        ?.map((e) => e as String)
        .toList(),
    effectConfigs: _parseEffectConfigs(json['effect_configs']),
    mediaCases: (json['media_cases'] as List<dynamic>?)
        ?.map((e) => e as String)
        .toList(),
    captureFrames: json['capture_frames'] as bool?,
    exitWhenDone: json['exit_when_done'] as bool? ?? true,
    requireTimings: json['require_timings'] as bool? ?? true,
    vulkanVideo: json['vulkan_video'] as bool? ?? false,
    visualAudit: json['visual_audit'] as bool? ?? false,
    mediaDirectory: json['media_directory'] as String?,
    expectedWidth: json['expected_width'] == null
        ? 2560
        : const StrictIntConverter().fromJson(json['expected_width'] as Object),
    expectedHeight: json['expected_height'] == null
        ? 1600
        : const StrictIntConverter().fromJson(
            json['expected_height'] as Object,
          ),
  );
}

Map<String, dynamic> _$BenchmarkConfigToJson(
  BenchmarkConfig instance,
) => <String, dynamic>{
  'suite': instance.suite,
  'repeats': const StrictIntConverter().toJson(instance.repeats),
  'warmups': const StrictIntConverter().toJson(instance.warmups),
  'transition_ms': const StrictIntConverter().toJson(instance.transitionMs),
  'transition_timeout_seconds': const StrictIntConverter().toJson(
    instance.transitionTimeoutSeconds,
  ),
  'prepare_timeout_seconds': const StrictIntConverter().toJson(
    instance.prepareTimeoutSeconds,
  ),
  'telemetry_ms': const StrictIntConverter().toJson(instance.telemetryMs),
  'timing_drain_ms': const StrictIntConverter().toJson(instance.timingDrainMs),
  'soak_seconds': const StrictIntConverter().toJson(instance.soakSeconds),
  'seed': const StrictIntConverter().toJson(instance.seed),
  'grids': instance.grids.map(const StrictIntConverter().toJson).toList(),
  'backends': instance.backends,
  'effects': instance.effects,
  'effect_configs': ?_effectConfigsToJson(instance.effectConfigs),
  'media_cases': instance.mediaCases,
  'capture_frames': instance.captureFrames,
  'exit_when_done': instance.exitWhenDone,
  'require_timings': instance.requireTimings,
  'vulkan_video': instance.vulkanVideo,
  'visual_audit': instance.visualAudit,
  'media_directory': instance.mediaDirectory,
  'expected_width': const StrictIntConverter().toJson(instance.expectedWidth),
  'expected_height': const StrictIntConverter().toJson(instance.expectedHeight),
};

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) => json == null ? null : fromJson(json as Json);
