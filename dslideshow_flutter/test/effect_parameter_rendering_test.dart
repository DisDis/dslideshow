import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:dslideshow_flutter/effect.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';

import 'effect_parameter_fixtures.dart';

void main() {
  testWidgets(
    'each active parameter changes the rendered image and keeps endpoints',
    (tester) async {
      tester.view.devicePixelRatio = 1;
      tester.view.physicalSize = const Size(180, 120);
      addTearDown(tester.view.resetDevicePixelRatio);
      addTearDown(tester.view.resetPhysicalSize);
      Future<ui.Image> photo(bool other) async {
        final recorder = ui.PictureRecorder();
        final canvas = Canvas(recorder);
        canvas.drawRect(
          const Rect.fromLTWH(0, 0, 160, 100),
          Paint()
            ..shader = ui.Gradient.linear(
              Offset.zero,
              const Offset(160, 100),
              other
                  ? [Colors.blue, Colors.green]
                  : [Colors.orange, Colors.purple],
            ),
        );
        for (var i = 0; i < 17; i++) {
          canvas.drawRect(
            Rect.fromLTWH(i * 11.0, i.isEven ? 14 : 49, 3, 21),
            Paint()..color = other ? Colors.yellow : Colors.cyan,
          );
        }
        final picture = recorder.endRecording();
        final image = await picture.toImage(160, 100);
        picture.dispose();
        return image;
      }

      final a = (await tester.runAsync(() => photo(false)))!,
          b = (await tester.runAsync(() => photo(true)))!;
      addTearDown(a.dispose);
      addTearDown(b.dispose);
      Future<Uint8List> capture(MediaSliderItemEffect? effect, double t) async {
        final key = GlobalKey();
        final from = RawImage(image: a, fit: BoxFit.contain),
            to = RawImage(image: b, fit: BoxFit.contain);
        await tester.pumpWidget(
          Directionality(
            textDirection: TextDirection.ltr,
            child: Center(
              child: SizedBox(
                width: 160,
                height: 100,
                child: RepaintBoundary(
                  key: key,
                  child: Builder(
                    builder: (context) =>
                        effect?.createTransformWidget(
                          context,
                          from,
                          to,
                          AlwaysStoppedAnimation(t),
                          160,
                          100,
                        ) ??
                        (t == 0 ? from : to),
                  ),
                ),
              ),
            ),
          ),
        );
        expect(tester.takeException(), isNull);
        return (await tester.runAsync(() async {
          final image =
              await (key.currentContext!.findRenderObject()!
                      as RenderRepaintBoundary)
                  .toImage();
          try {
            return (await image.toByteData(format: ui.ImageByteFormat.rawRgba))!
                .buffer
                .asUint8List();
          } finally {
            image.dispose();
          }
        }))!;
      }

      final initial = await capture(null, 0),
          finalFrame = await capture(null, 1);
      final unchanged = <String>[], badEndpoints = <String>[];
      for (final (name, type, low, high) in parameterProbes) {
        final variants = [
          Effect(type, options: low).createEffect(seed: 42),
          Effect(type, options: high).createEffect(seed: 42),
        ];
        for (final effect in variants) {
          if (effect is WaterRefractionEffect) effect.bindPhotos(a, b);
          await tester.runAsync(effect.prepare);
        }
        var differs = false;
        for (final t in [.37, .61]) {
          final x = await capture(variants.first, t),
              y = await capture(variants.last, t);
          if (!_same(x, y)) differs = true;
        }
        if (!differs) unchanged.add(name);
        for (final effect in variants) {
          if (!_same(await capture(effect, 0), initial) ||
              !_same(await capture(effect, 1), finalFrame)) {
            badEndpoints.add(name);
          }
        }
        await tester.pumpWidget(const SizedBox());
      }
      expect(
        unchanged,
        isEmpty,
        reason: 'An active setting must have an observable effect',
      );
      expect(
        badEndpoints,
        isEmpty,
        reason: 'Parameters must preserve clean start/end frames',
      );
    },
    timeout: const Timeout(Duration(minutes: 10)),
  );
}

bool _same(Uint8List a, Uint8List b) {
  if (a.length != b.length) return false;
  for (var i = 0; i < a.length; i++) {
    if (a[i] != b[i]) return false;
  }
  return true;
}
