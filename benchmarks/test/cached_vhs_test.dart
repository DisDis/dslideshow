import 'package:dslideshow_flutter/effect.dart';
import 'package:dslideshow_flutter/src/effect/creative_transition_effect.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'support/effect_capture.dart';
import 'support/test_photo.dart';

void main() {
  test('normal VHS factory keeps the configured options', () {
    const options = VhsDamageEffectOptions(
      durationMs: 1800,
      trackingStrength: 1.7,
    );
    final effect = const Effect(
      EffectType.vhsDamage,
      options: options,
    ).createEffect();
    expect(effect, isA<PhotoVhsDamageEffect>());
    expect((effect as PhotoVhsDamageEffect).options, same(options));
  });

  testWidgets('partial prepared inputs restore the live composition', (
    tester,
  ) async {
    final from = (await tester.runAsync(() => testPhoto(0)))!;
    final to = (await tester.runAsync(() => testPhoto(2)))!;
    final effect = PhotoVhsDamageEffect();
    var photosDisposed = false;
    final color = ValueNotifier<Color>(Colors.red);
    final live = ValueListenableBuilder<Color>(
      valueListenable: color,
      builder: (context, value, _) => ColoredBox(color: value),
    );
    try {
      final key = GlobalKey();
      await captureEffect(
        tester,
        effect,
        key,
        .5,
        from,
        to,
        fromPhoto: PreparedPhoto(bitmap: from),
        toPhoto: PreparedPhoto(bitmap: to),
      );
      final before = await captureEffect(
        tester,
        effect,
        key,
        .5,
        from,
        to,
        current: live,
        next: live,
        fromPhoto: PreparedPhoto(bitmap: from),
      );
      expect(from.debugDisposed, isFalse);
      expect(to.debugDisposed, isFalse);
      from.dispose();
      to.dispose();
      photosDisposed = true;
      color.value = Colors.green;
      final after = await captureEffect(
        tester,
        effect,
        key,
        .5,
        from,
        to,
        current: live,
        next: live,
        // A partial descriptor must remain on the live path and never sample
        // this caller-disposed handle.
        fromPhoto: PreparedPhoto(bitmap: from),
      );
      expect(after, isNot(orderedEquals(before)));
      final original = CreativeTransitionEffect(
        CreativeTransitionKind.vhsDamage,
      );
      final expected = await captureEffect(
        tester,
        original,
        GlobalKey(),
        .5,
        from,
        to,
        current: live,
        next: live,
      );
      expect(after, expected);
    } finally {
      await tester.pumpWidget(const SizedBox.shrink());
      color.dispose();
      if (!photosDisposed) {
        from.dispose();
        to.dispose();
      }
    }
  });

  testWidgets('stable VHS tint preserves tracking, noise, alpha and clipping', (
    tester,
  ) async {
    final from = (await tester.runAsync(() => testPhoto(0)))!;
    final to = (await tester.runAsync(() => testPhoto(2)))!;
    var worst = 0;
    try {
      for (final options in [
        const VhsDamageEffectOptions(),
        const VhsDamageEffectOptions(
          colorShiftFraction: .08,
          trackingStrength: 2,
          noiseStrength: 1.8,
        ),
      ]) {
        final reference = CreativeTransitionEffect(
          CreativeTransitionKind.vhsDamage,
          options: options,
        );
        final candidate = PhotoVhsDamageEffect(options: options);
        for (final phase in [0.0, .13, .5, .87, 1.0]) {
          final expected = await captureEffect(
            tester,
            reference,
            GlobalKey(),
            phase,
            from,
            to,
          );
          final actual = await captureEffect(
            tester,
            candidate,
            GlobalKey(),
            phase,
            from,
            to,
            fromPhoto: PreparedPhoto(bitmap: from),
            toPhoto: PreparedPhoto(bitmap: to),
          );
          var maximum = 0;
          for (var index = 0; index < actual.length; index++) {
            final delta = (expected[index] - actual[index]).abs();
            if (delta > maximum) maximum = delta;
          }
          if (maximum > worst) worst = maximum;
          expect(maximum, lessThanOrEqualTo(2), reason: '$options/$phase');
          if (phase == 0 || phase == 1) expect(actual, expected);
        }
      }
    } finally {
      await tester.pumpWidget(const SizedBox.shrink());
      from.dispose();
      to.dispose();
    }
    debugPrint('VHS cached tint max delta=$worst');
  });
}
