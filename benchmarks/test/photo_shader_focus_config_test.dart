import 'dart:convert';
import 'dart:io';

import 'package:benchmarks/src/config.dart';
import 'package:benchmarks/src/plan.dart';
import 'package:dslideshow_flutter/effect.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('focused configuration retains controls and only Glass and Film photo paths', () {
    final config = BenchmarkConfig.fromJson(
      jsonDecode(File('config/photo-shader-focus.json').readAsStringSync())
          as Map<String, dynamic>,
    );
    final plan = buildPlan(config);
    expect(plan, hasLength(4));
    expect(
      plan.map((test) => test.effect?.canonical.type),
      unorderedEquals([
        null,
        EffectType.glass,
        EffectType.fade,
        EffectType.fade,
      ]),
    );
    expect(config.warmups, 1);
    expect(config.repeats, 3);
    expect(config.productionPhotoInputs, isTrue);
    expect(plan.every((test) => test.media.name == 'photo-photo'), isTrue);
  });
}
