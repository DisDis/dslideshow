import 'package:dslideshow_flutter/effect.dart';
import 'package:dslideshow_flutter/src/effect/mosaic_fade_effect.dart';
import 'package:dslideshow_flutter/src/effect/soft_wipe_effect.dart';
import 'package:dslideshow_flutter/src/effect/flip_horizontal_effect.dart';
import 'package:dslideshow_flutter/src/effect/flip_vertical_effect.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

import 'support/pixel_capture.dart';

void main() {
  test(
    'dense mosaic settings reach the implementation without lowering quality',
    () {
      for (final grid in [100, 150, 200]) {
        for (final fade in [0.0, .3, 1.0]) {
          for (final direction in MosaicDirection.values) {
            final effect = Effect(
              EffectType.mosaic,
              options: MosaicEffectOptions(
                gridSize: grid,
                fadeFraction: fade,
                direction: direction,
              ),
            ).createEffect(seed: 42) as MosaicFadeEffect;
            expect(effect.gridSize, grid);
            expect(effect.fadeFraction, fade);
            expect(effect.direction, direction);
            expect(effect.schedule.startTimes.length, grid * grid);
            expect(effect.backend, MosaicBackend.canvas);
          }
        }
      }
    },
  );
  test('slide modes and mask variants reach the shared renderers', () {
    for (final mode in SlideMode.values) {
      for (final direction in EffectDirection.values) {
        final effect =
            Effect(
                  EffectType.slide,
                  options: SlideEffectOptions(mode: mode, direction: direction),
                ).createEffect()
                as DirectionalSlideEffect;
        expect(effect.mode, mode);
        expect(effect.direction, switch (direction) {
          EffectDirection.left => AxisDirection.left,
          EffectDirection.right => AxisDirection.right,
          EffectDirection.up => AxisDirection.up,
          EffectDirection.down => AxisDirection.down,
        });
      }
    }
    for (final style in SoftWipeStyle.values) {
      expect(
        (Effect(
                  EffectType.softWipe,
                  options: SoftWipeEffectOptions(style: style),
                ).createEffect()
                as SoftWipeEffect)
            .style,
        style,
      );
    }
    expect(Effect(EffectType.flip).createEffect(), isA<FlipHorizontalEffect>());
    expect(
      const Effect(
        EffectType.flip,
        options: FlipEffectOptions(axis: EffectAxis.vertical),
      ).createEffect(),
      isA<FlipVerticalEffect>(),
    );
  });
  testWidgets(
    'direction, shape, color and style variants preserve endpoints and change pixels',
    (tester) async {
      final variants = <Effect>[
        for (final mode in SlideMode.values)
          for (final direction in EffectDirection.values)
            Effect(
              EffectType.slide,
              options: SlideEffectOptions(mode: mode, direction: direction),
            ),
        for (final direction in EffectDirection.values)
          Effect(
            EffectType.revealMask,
            options: RevealMaskEffectOptions(direction: direction),
          ),
        for (final axis in EffectAxis.values)
          Effect(
            EffectType.revealMask,
            options: RevealMaskEffectOptions(
              shape: RevealShape.curtain,
              axis: axis,
            ),
          ),
        for (final origin in EffectOrigin.values.where(
          (v) => v != EffectOrigin.center,
        ))
          Effect(
            EffectType.revealMask,
            options: RevealMaskEffectOptions(
              shape: RevealShape.diagonal,
              origin: origin,
            ),
          ),
        const Effect(
          EffectType.revealMask,
          options: RevealMaskEffectOptions(
            shape: RevealShape.iris,
            origin: EffectOrigin.center,
          ),
        ),
        for (final color in [0xFF000000, 0xFFFFFFFF])
          Effect(
            EffectType.fadeThroughColor,
            options: FadeThroughColorEffectOptions(color: color),
          ),
        for (final style in SoftWipeStyle.values)
          Effect(
            EffectType.softWipe,
            options: SoftWipeEffectOptions(style: style),
          ),
        for (final axis in EffectAxis.values)
          Effect(EffectType.flip, options: FlipEffectOptions(axis: axis)),
        for (final edge in RotationEdge.values)
          Effect(EffectType.rotate, options: RotateEffectOptions(edge: edge)),
      ];
      Future<Uint8List> frame(MediaSliderItemEffect? effect, double progress) =>
          capture(tester, (context) {
            const from = ColoredBox(color: Colors.red);
            const to = ColoredBox(color: Colors.blue);
            return effect?.createTransformWidget(
                  context,
                  from,
                  to,
                  AlwaysStoppedAnimation(progress),
                  160,
                  100,
                ) ??
                (progress == 0 ? from : to);
          });
      final initial = await frame(null, 0);
      final last = await frame(null, 1);
      for (final descriptor in variants) {
        final effect = descriptor.createEffect();
        final reason = descriptor.toConfig().toJson().toString();
        expect(
          listEquals(await frame(effect, 0), initial),
          isTrue,
          reason: '$reason must start with the outgoing slide',
        );
        final middle = await frame(effect, .37);
        expect(
          listEquals(middle, initial),
          isFalse,
          reason: '$reason must leave the initial frame',
        );
        expect(
          listEquals(middle, last),
          isFalse,
          reason: '$reason must render an intermediate frame',
        );
        expect(
          listEquals(await frame(effect, 1), last),
          isTrue,
          reason: '$reason must end with the incoming slide',
        );
        expect(tester.takeException(), isNull, reason: reason);
      }
      await tester.pumpWidget(const SizedBox());
    },
  );
}
