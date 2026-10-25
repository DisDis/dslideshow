// Run explicitly: flutter test --no-pub tool/render_effect_gallery_test.dart
import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/services.dart';
import 'package:dslideshow_flutter/effect.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';

Widget slide(String label, List<Color> colors) => DecoratedBox(
  decoration: BoxDecoration(gradient: LinearGradient(colors: colors)),
  child: Center(
    child: Text(
      label,
      style: const TextStyle(
        fontFamily: 'GalleryFont',
        color: Colors.white,
        fontSize: 32,
      ),
    ),
  ),
);

void main() {
  testWidgets('Render deterministic control frames for visual review', (
    tester,
  ) async {
    await tester.runAsync(() async {
      final bytes = await File('../config_app/assets/fonts/Roboto-Regular.ttf')
          .readAsBytes();
      await (FontLoader(
        'GalleryFont',
      )..addFont(Future.value(ByteData.sublistView(bytes)))).load();
    });
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(1000, 1300);
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.view.resetPhysicalSize);
    final sourceKey = GlobalKey(), targetKey = GlobalKey();
    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: Row(
          children: [
            RepaintBoundary(
              key: sourceKey,
              child: SizedBox(
                width: 160,
                height: 96,
                child: slide('A', [Colors.orange, Colors.deepPurple]),
              ),
            ),
            RepaintBoundary(
              key: targetKey,
              child: SizedBox(
                width: 160,
                height: 96,
                child: slide('B', [Colors.cyan, Colors.indigo]),
              ),
            ),
          ],
        ),
      ),
    );
    final from = (await tester.runAsync(
      () =>
          (sourceKey.currentContext!.findRenderObject()!
                  as RenderRepaintBoundary)
              .toImage(),
    ))!;
    final to = (await tester.runAsync(
      () =>
          (targetKey.currentContext!.findRenderObject()!
                  as RenderRepaintBoundary)
              .toImage(),
    ))!;
    addTearDown(from.dispose);
    addTearDown(to.dispose);
    final prepared = <Effect, MediaSliderItemEffect>{};
    for (final descriptor in Effect.values) {
      final effect = descriptor.createEffect(seed: 42);
      await tester.runAsync(effect.prepare);
      if (effect is WaterRefractionEffect) effect.bindPhotos(from, to);
      prepared[descriptor] = effect;
    }
    final all = Effect.values.toList();
    for (var offset = 0; offset < all.length; offset += 12) {
      final key = GlobalKey();
      final effects = all.skip(offset).take(12).toList();
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Center(
            child: RepaintBoundary(
              key: key,
              child: ColoredBox(
                color: Colors.black,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'progress: 0 / 0.25 / 0.5 / 0.75 / 1 — seed 42 — Canvas 100×100',
                      style: TextStyle(
                        fontFamily: 'GalleryFont',
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                    for (final descriptor in effects)
                      Builder(
                        builder: (context) {
                          final effect = prepared[descriptor]!;
                          return Row(
                            children: [
                              SizedBox(
                                width: 180,
                                child: Text(
                                  descriptor.name,
                                  style: const TextStyle(
                                    fontFamily: 'GalleryFont',
                                    color: Colors.white,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                              for (final t in [0.0, .25, .5, .75, 1.0])
                                SizedBox(
                                  width: 160,
                                  height: 96,
                                  child: ClipRect(
                                    child: effect.createTransformWidget(
                                      context,
                                      slide('A', [
                                        Colors.orange,
                                        Colors.deepPurple,
                                      ]),
                                      slide('B', [Colors.cyan, Colors.indigo]),
                                      AlwaysStoppedAnimation(t),
                                      160,
                                      96,
                                    ),
                                  ),
                                ),
                            ],
                          );
                        },
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
      await tester.runAsync(() async {
        final boundary =
            key.currentContext!.findRenderObject()! as RenderRepaintBoundary;
        final image = await boundary.toImage();
        try {
          final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
          final folder = Directory('build/effects');
          await folder.create(recursive: true);
          await File('${folder.path}/gallery-${offset ~/ 12 + 1}.png')
              .writeAsBytes(bytes!.buffer.asUint8List());
        } finally {
          image.dispose();
        }
      });
      expect(tester.takeException(), isNull);
    }
    await tester.pumpWidget(const SizedBox());
  });
}
