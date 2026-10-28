import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:dslideshow_flutter/effect.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'zoom_blur_effect_test.dart' as pixels;

void main() {
  testWidgets(
    'Water and Ripple reveal from each origin through the opposite corner',
    (tester) async {
      for (final size in [const Size(160, 100), const Size(97, 163)]) {
        Future<ui.Image> photo(bool next) async {
          final recorder = ui.PictureRecorder();
          Canvas(recorder).drawRect(
            Offset.zero & size,
            Paint()
              ..shader = ui.Gradient.linear(
                Offset.zero,
                Offset(size.width, size.height),
                next
                    ? [Colors.blue, Colors.green]
                    : [Colors.orange, Colors.purple],
              ),
          );
          final picture = recorder.endRecording();
          final image = (await tester.runAsync(
            () => picture.toImage(size.width.toInt(), size.height.toInt()),
          ))!;
          picture.dispose();
          return image;
        }

        final a = await photo(false), b = await photo(true);
        final from = RawImage(image: a, fit: BoxFit.fill),
            to = RawImage(image: b, fit: BoxFit.fill);
        final original = await pixels.capture(tester, (_) => from, size: size);
        final target = await pixels.capture(tester, (_) => to, size: size);
        List<int> point(Uint8List bytes, double x, double y) {
          final px = (x * (size.width - 8) + 4).round(),
              py = (y * (size.height - 8) + 4).round();
          final index = (py * size.width.toInt() + px) * 4;
          return bytes.sublist(index, index + 4);
        }

        for (final origin in EffectOrigin.values) {
          final location = switch (origin) {
            EffectOrigin.center => const Offset(.5, .5),
            EffectOrigin.topLeft => Offset.zero,
            EffectOrigin.topRight => const Offset(1, 0),
            EffectOrigin.bottomLeft => const Offset(0, 1),
            EffectOrigin.bottomRight => const Offset(1, 1),
          };
          final opposite = origin == EffectOrigin.center
              ? Offset.zero
              : Offset(1 - location.dx, 1 - location.dy);
          for (final type in [
            EffectType.rippleReveal,
            EffectType.waterRefraction,
          ]) {
            final options = type == EffectType.waterRefraction
                ? WaterRefractionEffectOptions(origin: origin)
                : RippleRevealEffectOptions(origin: origin);
            final effect = Effect(
              type,
              options: options,
            ).createEffect(seed: 42);
            final prepared = !effect.supportsInputs(
              EffectSlideInput(view: from),
              EffectSlideInput(view: to),
            );
            await tester.runAsync(effect.prepare);
            Future<Uint8List> frame(double t) => pixels.capture(
              tester,
              (context) => effect.createTransformWidget(
                context,
                EffectSlideInput(
                  view: from,
                  photo: prepared ? PreparedPhoto(bitmap: a) : null,
                ),
                EffectSlideInput(
                  view: to,
                  photo: prepared ? PreparedPhoto(bitmap: b) : null,
                ),
                AlwaysStoppedAnimation(t),
                size.width,
                size.height,
              ),
              size: size,
            );
            final middle = await frame(.4);
            expect(
              point(middle, location.dx, location.dy),
              point(target, location.dx, location.dy),
              reason: '$type $origin origin at $size',
            );
            expect(
              point(middle, opposite.dx, opposite.dy),
              point(original, opposite.dx, opposite.dy),
              reason: '$type $origin far corner at $size',
            );
            expect(await frame(0), original);
            expect(await frame(1), target);
          }
        }
        await tester.pumpWidget(const SizedBox());
        a.dispose();
        b.dispose();
      }
      expect(tester.takeException(), isNull);
    },
  );
}
