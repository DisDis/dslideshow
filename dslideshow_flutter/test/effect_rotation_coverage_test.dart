import 'dart:ui' as ui;

import 'package:dslideshow_flutter/effect.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
    'every rotated sample covers the viewport for center and corner origins',
    (tester) async {
      final recorder = ui.PictureRecorder();
      Canvas(recorder).drawColor(Colors.green, BlendMode.src);
      final picture = recorder.endRecording();
      final bitmap = picture.toImageSync(16, 10);
      picture.dispose();
      addTearDown(bitmap.dispose);
      for (final size in [const Size(160, 100), const Size(97, 163)]) {
        for (final origin in EffectOrigin.values) {
          for (final type in [EffectType.radialBlur, EffectType.kaleidoscope]) {
            final options = type == EffectType.radialBlur
                ? RadialBlurEffectOptions(origin: origin, angleDegrees: 20)
                : KaleidoscopeEffectOptions(
                    origin: origin,
                    sectorCount: 12,
                    rotationDegrees: 180,
                  );
            final effect = Effect(type, options: options).createEffect();
            for (final t in [.25, .5, .75]) {
              final key = GlobalKey();
              await tester.pumpWidget(
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: Center(
                    child: SizedBox(
                      width: size.width,
                      height: size.height,
                      child: RepaintBoundary(
                        key: key,
                        child: Builder(
                          builder: (context) => effect.createTransformWidget(
                            context,
                            RawImage(image: bitmap, fit: BoxFit.fill),
                            RawImage(image: bitmap, fit: BoxFit.fill),
                            AlwaysStoppedAnimation(t),
                            size.width,
                            size.height,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
              final viewport =
                  key.currentContext!.findRenderObject()! as RenderBox;
              for (final element in find.byType(RawImage).evaluate()) {
                final image = element.renderObject! as RenderImage;
                final inverse = Matrix4.inverted(
                  image.getTransformTo(viewport),
                );
                for (final corner in [
                  Offset.zero,
                  Offset(size.width, 0),
                  Offset(0, size.height),
                  Offset(size.width, size.height),
                ]) {
                  final local = MatrixUtils.transformPoint(inverse, corner);
                  expect(
                    local.dx,
                    inInclusiveRange(-.0001, image.size.width + .0001),
                    reason: '$type $origin $size phase $t x',
                  );
                  expect(
                    local.dy,
                    inInclusiveRange(-.0001, image.size.height + .0001),
                    reason: '$type $origin $size phase $t y',
                  );
                }
              }
              expect(tester.takeException(), isNull);
            }
          }
        }
      }
      await tester.pumpWidget(const SizedBox());
    },
  );
}
