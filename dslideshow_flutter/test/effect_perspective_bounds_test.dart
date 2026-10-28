import 'package:dslideshow_flutter/effect.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
    'extreme 3D settings keep every local corner in front of the camera',
    (tester) async {
      final effects = <Effect>[
        for (final direction in EffectDirection.values) ...[
          Effect(
            EffectType.cube,
            options: CubeEffectOptions(
              direction: direction,
              perspectiveStrength: 1.25,
            ),
          ),
          Effect(
            EffectType.tablet,
            options: TabletEffectOptions(
              direction: direction,
              tiltDegrees: 70,
              perspectiveStrength: 1.25,
            ),
          ),
        ],
        for (final axis in EffectAxis.values) ...[
          Effect(
            EffectType.flip,
            options: FlipEffectOptions(
              axis: axis,
              perspectiveStrength: 1.25,
              rotationSense: RotationSense.backward,
            ),
          ),
          Effect(
            EffectType.foldMotion,
            options: FoldMotionEffectOptions(
              axis: axis,
              perspectiveStrength: 1.25,
            ),
          ),
          Effect(
            EffectType.louver,
            options: LouverEffectOptions(
              axis: axis,
              slatCount: 32,
              staggerFraction: .8,
              rotationSense: RotationSense.backward,
            ),
          ),
        ],
      ];
      for (final size in [
        const Size(160, 100),
        const Size(2560, 1600),
        const Size(1600, 2560),
      ]) {
        for (final descriptor in effects) {
          final effect = descriptor.createEffect();
          for (var phase = 0; phase <= 20; phase++) {
            await tester.pumpWidget(
              Directionality(
                textDirection: TextDirection.ltr,
                child: Center(
                  child: FittedBox(
                    child: SizedBox(
                      width: size.width,
                      height: size.height,
                      child: Builder(
                        builder: (context) => effect.createTransformWidget(
                          context,
                          EffectSlideInput(
                            view: const ColoredBox(color: Colors.orange),
                          ),
                          EffectSlideInput(
                            view: const ColoredBox(color: Colors.blue),
                          ),
                          AlwaysStoppedAnimation(phase / 20),
                          size.width,
                          size.height,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
            expect(
              tester.takeException(),
              isNull,
              reason: '${descriptor.type} $size phase $phase',
            );
            for (final element in find.byType(Transform).evaluate()) {
              final widget = element.widget as Transform;
              final render = element.renderObject! as RenderTransform;
              final extent = render.child!.size;
              final origin =
                  (widget.alignment ?? Alignment.topLeft)
                      .resolve(TextDirection.ltr)
                      .alongSize(extent) +
                  (widget.origin ?? Offset.zero);
              final m = widget.transform;
              for (final x in [-origin.dx, extent.width - origin.dx]) {
                for (final y in [-origin.dy, extent.height - origin.dy]) {
                  final w =
                      m.entry(3, 0) * x + m.entry(3, 1) * y + m.entry(3, 3);
                  expect(
                    w,
                    greaterThan(0),
                    reason:
                        '${descriptor.type} $size phase $phase extent $extent',
                  );
                }
              }
            }
          }
        }
      }
      await tester.pumpWidget(const SizedBox());
    },
  );
}
