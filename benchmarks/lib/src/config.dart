import 'package:dslideshow_flutter/effect.dart'
    show EffectConfig, EffectType, StrictIntConverter;
import 'package:freezed_annotation/freezed_annotation.dart';

import 'dart:convert';
import 'dart:io';

part 'config.freezed.dart';
part 'config.g.dart';

@freezed
@JsonSerializable(
  fieldRename: FieldRename.snake,
  explicitToJson: true,
  disallowUnrecognizedKeys: true,
  converters: [StrictIntConverter()],
)
class BenchmarkConfig with _$BenchmarkConfig {
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
  @JsonKey(
    includeIfNull: false,
    fromJson: _parseEffectConfigs,
    toJson: _effectConfigsToJson,
  )
  final Map<EffectType, List<EffectConfig>>? effectConfigs;
  final List<String>? mediaCases;
  final bool captureFrames;
  final bool exitWhenDone;
  final bool requireTimings;
  final bool vulkanVideo;
  final bool visualAudit;
  final bool productionPhotoInputs;
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
    List<String> backends = const ['canvas', 'shader'],
    List<String>? effects,
    Map<EffectType, List<EffectConfig>>? effectConfigs,
    List<String>? mediaCases,
    bool? captureFrames,
    this.exitWhenDone = true,
    this.requireTimings = true,
    this.vulkanVideo = false,
    this.visualAudit = false,
    this.productionPhotoInputs = false,
    this.mediaDirectory,
    this.expectedWidth = 2560,
    this.expectedHeight = 1600,
  }) : repeats = repeats ?? (suite == 'smoke' ? 1 : 3),
       warmups = warmups ?? (suite == 'smoke' ? 0 : 1),
       grids = List.unmodifiable(
         grids ?? (suite == 'smoke' ? [100, 200] : [100, 150, 200]),
       ),
       backends = List.unmodifiable(backends),
       effects = effects == null ? null : List.unmodifiable(effects),
       effectConfigs = effectConfigs == null
           ? null
           : Map.unmodifiable(
               effectConfigs.map(
                 (type, variants) =>
                     MapEntry(type, List<EffectConfig>.unmodifiable(variants)),
               ),
             ),
       mediaCases = mediaCases == null ? null : List.unmodifiable(mediaCases),
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
    if ((effects != null &&
            effects.isEmpty &&
            (effectConfigs == null || effectConfigs.isEmpty)) ||
        mediaCases != null && mediaCases.isEmpty) {
      throw ArgumentError('Effect/media filters cannot be empty');
    }
  }

  factory BenchmarkConfig.fromJson(Map<String, dynamic> json) {
    try {
      return _$BenchmarkConfigFromJson(json);
    } on UnrecognizedKeysException catch (error) {
      throw FormatException(
        'Unknown config fields: ${error.unrecognizedKeys.join(', ')}',
      );
    }
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
    if (environment['BENCHMARK_VULKAN_VIDEO'] case final String value) {
      if (!['true', 'false'].contains(value)) {
        throw FormatException('BENCHMARK_VULKAN_VIDEO must be true or false');
      }
      json['vulkan_video'] = value == 'true';
    }
    return BenchmarkConfig.fromJson(json);
  }

  Map<String, dynamic> toJson() => _$BenchmarkConfigToJson(this);
}

// Benchmark variants are grouped by the same enum keys as production settings.
// A list per key permits multiple parameter sets for one algorithm.
Map<EffectType, List<EffectConfig>>? _parseEffectConfigs(Object? value) {
  if (value == null) return null;
  final json = value as Map<String, dynamic>;
  final types = EffectType.values.asNameMap();
  final result = <EffectType, List<EffectConfig>>{};
  for (final entry in json.entries) {
    final type = types[entry.key];
    if (type == null || type == EffectType.unknown) {
      throw FormatException('Unknown effect_configs type: ${entry.key}');
    }
    result[type] = (entry.value as List).map((raw) {
      final config = EffectConfig.fromJson(type, raw as Map<String, dynamic>);
      if (config.invalid case final invalid?) {
        throw FormatException(
          'Cannot read effect_configs.${entry.key}: ${invalid.error}',
        );
      }
      return config;
    }).toList();
  }
  return result;
}

Map<String, dynamic>? _effectConfigsToJson(
  Map<EffectType, List<EffectConfig>>? value,
) => value?.map(
  (type, variants) =>
      MapEntry(type.name, variants.map((config) => config.toJson()).toList()),
);
