import 'dart:convert';
import 'dart:io';

import 'package:benchmarks/src/config.dart';
import 'package:benchmarks/src/plan.dart';
import 'package:benchmarks/src/mosaic_probes.dart';
import 'package:dslideshow_flutter/effect.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('focused mosaic configs select bounded explicit matrices', () {
    for (final entry in {
      'diagnostics': 25,
      'confirm': 13,
      'visual': 6,
      'media': 15,
      'video': 8,
      'video-confirm': 10,
    }.entries) {
      final data = jsonDecode(
        File('config/mosaic-${entry.key}.json').readAsStringSync(),
      ) as Map<String, dynamic>;
      final config = BenchmarkConfig.fromJson(data);
      expect(config.suite, 'smoke');
      expect(buildPlan(config).length, entry.value, reason: entry.key);
      expect(config.soakSeconds, 0);
      expect(config.vulkanVideo, false);
    }
  });

  test(
    'mosaic probes are opt-in, named uniquely, and preserve requested grids',
    () {
      expect(
        buildPlan(BenchmarkConfig()).every((c) => c.mosaicProbe == null),
        true,
      );
      final names = [
        for (final mode in MosaicProbe.values)
          for (final effect in [
            (const Effect(
              EffectType.mosaic,
              options: MosaicEffectOptions(fadeFraction: 0),
            )),
            (const Effect(EffectType.mosaic, options: MosaicEffectOptions())),
          ])
            mode.effectName(effect),
      ];
      final plan = buildPlan(
        BenchmarkConfig(
          suite: 'smoke',
          effects: names,
          mediaCases: ['photo-photo'],
          grids: [100, 150, 200],
        ),
      );
      expect(plan.length, 12);
      expect(plan.map((c) => c.id).toSet().length, 12);
      expect(plan.map((c) => c.grid).toSet(), {100, 150, 200});
      expect(
        plan.every((c) => c.mosaicProbe != null && c.effect!.isMosaic),
        true,
      );
      expect(plan.every((c) => c.toJson()['mosaic_probe'] != null), true);
      expect(
        () => buildPlan(BenchmarkConfig(effects: ['MosaicProbe-typo-Mosaic'])),
        throwsArgumentError,
      );
    },
  );
  test('visual audit captures every dense grid; ordinary previews retain first grid', () {
    final config = BenchmarkConfig(grids: [100, 150, 200]);
    final audit = BenchmarkConfig(grids: [100, 150, 200], visualAudit: true);
    for (final grid in [100, 150, 200]) {
      final test = BenchmarkCase(
        (const Effect(EffectType.mosaic, options: MosaicEffectOptions())),
        mediaPairs.first,
        grid: grid,
      );
      expect(test.supportsCapture(config), grid == 100);
      expect(test.supportsCapture(audit), true);
    }
    expect(
      BenchmarkCase(
        (const Effect(
          EffectType.mosaic,
          options: MosaicEffectOptions(fadeFraction: 0),
        )),
        mediaPairs[1],
      ).supportsCapture(audit),
      false,
    );
    expect(
      BenchmarkCase(
        (const Effect(
          EffectType.mosaic,
          options: MosaicEffectOptions(fadeFraction: 0),
        )),
        mediaPairs.first,
        injectStall: true,
      ).supportsCapture(audit),
      false,
    );
  });
}
