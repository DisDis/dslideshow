import 'dart:convert';
import 'dart:io';

import 'package:benchmarks/src/config.dart';
import 'package:benchmarks/src/plan.dart';
import 'package:dslideshow_flutter/effect.dart';
import 'package:flutter_test/flutter_test.dart';

/// Generate a photo-only screening matrix from the current production catalog.
/// Run explicitly with flutter test; identical defaults/presets share one case.
void main() {
  test('screen every family default and preset once, without video or stalls', () {
    final variants = <EffectType, List<EffectConfig>>{};
    void include(EffectType type, EffectOptions options) {
      final variant = EffectConfig(options: options.withDuration(0));
      final family = variants.putIfAbsent(type, () => []);
      if (!family.contains(variant)) family.add(variant);
    }

    for (final type in catalogEffectTypes) {
      include(type, defaultEffectOptions(type));
    }
    for (final preset in effectPresets) {
      include(preset.type, preset.options);
    }
    final config = BenchmarkConfig(
      suite: 'smoke',
      effects: ['Baseline'],
      effectConfigs: variants,
      mediaCases: ['photo-photo'],
      warmups: 0,
      repeats: 1,
      grids: [100],
      backends: ['canvas'],
      captureFrames: false,
      productionPhotoInputs: true,
    );
    final plan = buildPlan(config);
    final mapping = <Map<String, Object?>>[];
    for (final test in plan) {
      final effect = test.effectiveEffect;
      mapping.add({
        ...test.toJson(),
        'family_default':
            effect != null &&
            effect.options == defaultEffectOptions(effect.type),
        'presets': [
          for (final preset in effectPresets)
            if (effect?.type == preset.type &&
                effect?.options == preset.options.withDuration(0))
              preset.id.name,
        ],
      });
    }

    expect(catalogEffectTypes, hasLength(37));
    expect(effectPresets, hasLength(82));
    expect(variants.keys.toSet(), catalogEffectTypes.toSet());
    expect(plan.map((test) => test.id).toSet(), hasLength(plan.length));
    expect(plan.every((test) => test.media.name == 'photo-photo'), isTrue);
    expect(plan.any((test) => test.injectStall), isFalse);
    expect(
      mapping.where((row) => row['family_default'] == true),
      hasLength(37),
    );
    expect(
      mapping.expand((row) => row['presets'] as List<String>).toSet(),
      effectPresets.map((preset) => preset.id.name).toSet(),
    );
    expect(BenchmarkConfig.fromJson(config.toJson()), config);

    final output = Directory('build/effect-screening')
      ..createSync(recursive: true);
    const encoder = JsonEncoder.withIndent('  ');
    File('${output.path}/screening.json')
        .writeAsStringSync('${encoder.convert(config.toJson())}\n');
    File('${output.path}/catalog.json').writeAsStringSync(
      '${encoder.convert({'families': catalogEffectTypes.length, 'presets': effectPresets.length, 'unique_cases_including_baseline': plan.length, 'cases': mapping})}\n',
    );
    // ignore: avoid_print
    print(
      'Screening: ${plan.length} unique cases, 37 families, 82 presets; ${output.path}',
    );
  });
}
