import 'dart:convert';
import 'dart:io';

import 'package:benchmarks/src/config.dart';
import 'package:benchmarks/src/plan.dart';
import 'package:dslideshow_flutter/effect.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('native diagnostics cover six slow photo effects and two controls', () {
    final config = BenchmarkConfig.fromJson(
      jsonDecode(File('config/native-pipeline-photo.json').readAsStringSync())
          as Map<String, dynamic>,
    );
    final plan = buildPlan(config);
    expect(
      plan.map((test) => test.effect?.canonical.type),
      unorderedEquals([
        null,
        EffectType.fade,
        EffectType.glass,
        EffectType.radialBlur,
        EffectType.zoomOver,
        EffectType.kaleidoscope,
        EffectType.vhsDamage,
        EffectType.glow,
      ]),
    );
    final cross = plan.singleWhere(
      (test) => test.effect?.canonical.type == EffectType.zoomOver,
    );
    expect(
      cross.effect!.canonical.options,
      Effect.crossZoomEffect.canonical.options,
    );
    expect(plan.every((test) => test.media.name == 'photo-photo'), isTrue);
    expect(config.productionPhotoInputs, isTrue);
    expect(config.captureFrames, isFalse);
    expect(config.visualAudit, isFalse);
    expect(config.warmups, 1);
    expect(config.repeats, 2);
  });
}
