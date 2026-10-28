import 'dart:io';
import 'dart:ui' as ui;

import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_backend/storage.dart';
import 'package:dslideshow_flutter/effect.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/widgets/image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';

Future<List<int>> _capture(WidgetTester tester, GlobalKey key) async =>
    (await tester.runAsync(() async {
      final boundary =
          key.currentContext!.findRenderObject()! as RenderRepaintBoundary;
      final image = await boundary.toImage();
      try {
        final data = await image.toByteData(format: ui.ImageByteFormat.rawRgba);
        return data!.buffer.asUint8List().toList();
      } finally {
        image.dispose();
      }
    }))!;

void main() {
  testWidgets(
    'Prepared photos retain pixels at display resolution without PNG re-encoding',
    (tester) async {
      final dir = (await tester.runAsync(
        () => Directory.systemTemp.createTemp('dslideshow-photo-'),
      ))!;
      ImageWidget? slide;
      try {
        final recorder = ui.PictureRecorder();
        Canvas(recorder).drawColor(Colors.red, BlendMode.src);
        final picture = recorder.endRecording();
        final source = await tester.runAsync(() => picture.toImage(8, 8));
        final bytes = await tester.runAsync(
          () => source!.toByteData(format: ui.ImageByteFormat.png),
        );
        final file = File('${dir.path}/photo.png');
        await tester.runAsync(
          () => file.writeAsBytes(bytes!.buffer.asUint8List()),
        );
        source!.dispose();
        picture.dispose();
        final config = SlideShowConfig.fromJson({
          'isBlurredBackground': false,
          'backgroundColor': 'ff000000',
        });
        slide = ImageWidget(
          MediaItem('photo', file.uri),
          config,
          const Size(160, 90),
          pixelRatio: 2,
        );
        await tester.pumpWidget(
          Directionality(
            textDirection: TextDirection.ltr,
            child: Builder(
              builder: (context) {
                return const SizedBox();
              },
            ),
          ),
        );
        final context = tester.element(find.byType(SizedBox).first);
        await tester.runAsync(() => slide!.precache(context));
        await tester.pumpWidget(
          Directionality(
            textDirection: TextDirection.ltr,
            child: SizedBox(width: 160, height: 90, child: slide),
          ),
        );
        final raw = tester.widget<RawImage>(find.byType(RawImage));
        expect(raw.image!.width, 320);
        expect(raw.image!.height, 180);
        expect(raw.scale, 2);
        final rgba = await tester.runAsync(
          () => raw.image!.toByteData(format: ui.ImageByteFormat.rawRgba),
        );
        final pixels = rgba!.buffer.asUint8List();
        expect(pixels.sublist((90 * 320 + 160) * 4, (90 * 320 + 160) * 4 + 4), [
          244,
          67,
          54,
          255,
        ]);
        expect(pixels.sublist(0, 4), [0, 0, 0, 255]);
        expect(raw.filterQuality, FilterQuality.high);

        final progress = ValueNotifier(0.0);
        final captureKey = GlobalKey();
        final effect = Effect.burnAlphaEffect.createEffect();
        Widget scene(Widget image) => Directionality(
          textDirection: TextDirection.ltr,
          child: Center(
            child: RepaintBoundary(
              key: captureKey,
              child: SizedBox(
                width: 160,
                height: 90,
                child: ValueListenableBuilder<double>(
                  valueListenable: progress,
                  child: image,
                  builder: (context, t, child) => ClipRect(
                    child: effect.createTransformWidget(
                      context,
                      const ColoredBox(color: Colors.blue),
                      Transform.scale(scale: 1.1 + t * .1, child: child),
                      AlwaysStoppedAnimation(t),
                      160,
                      90,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
        final prepared = slide.preparedBitmap!;
        await tester.pumpWidget(scene(slide));
        final cacheFinder = find.descendant(
          of: find.byWidget(slide),
          matching: find.byType(RepaintBoundary),
        );
        expect(cacheFinder, findsOneWidget);
        final retained = tester.renderObject<RenderRepaintBoundary>(
          cacheFinder,
        );
        final phases = [0.0, .13, .25, .5, .75, .95, 1.0];
        final cachedFrames = <List<int>>[];
        for (final t in phases) {
          progress.value = t;
          await tester.pump();
          cachedFrames.add(await _capture(tester, captureKey));
          expect(
            tester.renderObject<RenderRepaintBoundary>(cacheFinder),
            same(retained),
          );
          expect(slide.preparedBitmap, same(prepared));
          expect(prepared.debugDisposed, isFalse);
        }
        await tester.pumpWidget(const SizedBox());
        expect(retained.attached, isFalse);
        expect(prepared.debugDisposed, isFalse);
        // Compare the retained photo against the original direct RawImage
        // composition through the same moving mask, scaling and opacity.
        await tester.pumpWidget(scene(raw));
        for (var i = 0; i < phases.length; i++) {
          progress.value = phases[i];
          await tester.pump();
          expect(await _capture(tester, captureKey), cachedFrames[i]);
        }
        await tester.pumpWidget(const SizedBox());
        progress.dispose();
        slide.dispose();
        slide.dispose();
        expect(slide.preparedBitmap, isNull);
        expect(prepared.debugDisposed, isTrue);
      } finally {
        await tester.pumpWidget(const SizedBox());
        slide?.dispose();
        await tester.runAsync(() => dir.delete(recursive: true));
      }
    },
  );

  testWidgets('GIF retains its live Image subtree and advances frames', (
    tester,
  ) async {
    final dir = (await tester.runAsync(
      () => Directory.systemTemp.createTemp('dslideshow-gif-'),
    ))!;
    ImageWidget? slide;
    try {
      // Two 1x1 frames (red, blue), 100 ms each, looping indefinitely.
      final bytes = <int>[
        ...'GIF89a'.codeUnits,
        1,
        0,
        1,
        0,
        0x80,
        0,
        0,
        255,
        0,
        0,
        0,
        0,
        255,
        0x21,
        0xff,
        11,
        ...'NETSCAPE2.0'.codeUnits,
        3,
        1,
        0,
        0,
        0,
        for (final pixelCode in [0x44, 0x4c]) ...[
          0x21,
          0xf9,
          4,
          0,
          10,
          0,
          0,
          0,
          0x2c,
          0,
          0,
          0,
          0,
          1,
          0,
          1,
          0,
          0,
          2,
          2,
          pixelCode,
          1,
          0,
        ],
        0x3b,
      ];
      final file = File('${dir.path}/animation.gif');
      await tester.runAsync(() => file.writeAsBytes(bytes));
      slide = ImageWidget(
        MediaItem('gif', file.uri),
        SlideShowConfig.fromJson({}),
        const Size(160, 90),
      );
      await tester.pumpWidget(
        const Directionality(
          textDirection: TextDirection.ltr,
          child: SizedBox(),
        ),
      );
      final context = tester.element(find.byType(SizedBox));
      // Empty and disposed states continue to be leaf placeholders.
      expect(slide.build(context), isA<SizedBox>());
      var prepared = false;
      final preparation = slide.precache(context).then((_) => prepared = true);
      final prepareWatch = Stopwatch()..start();
      while (!prepared && prepareWatch.elapsed < const Duration(seconds: 5)) {
        // Animated image streams deliver their first decoded frame on vsync.
        await tester.runAsync(
          () => Future<void>.delayed(const Duration(milliseconds: 10)),
        );
        await tester.pump(const Duration(milliseconds: 16));
      }
      expect(prepared, isTrue);
      await preparation;
      await tester.pumpWidget(
        Directionality(textDirection: TextDirection.ltr, child: slide),
      );
      expect(slide.preparedBitmap, isNull);
      final directChildren = <Widget>[];
      tester
          .element(find.byWidget(slide))
          .visitChildElements((child) => directChildren.add(child.widget));
      expect(directChildren.single, isA<Image>());
      await tester.pump();
      Future<List<int>> displayedPixel() async {
        final image = tester
            .widget<RawImage>(find.byType(RawImage))
            .image!
            .clone();
        try {
          final rgba = await tester.runAsync(
            () => image.toByteData(format: ui.ImageByteFormat.rawRgba),
          );
          return rgba!.buffer.asUint8List().sublist(0, 4);
        } finally {
          image.dispose();
        }
      }

      final first = await displayedPixel();
      expect(
        first,
        anyOf(orderedEquals([255, 0, 0, 255]), orderedEquals([0, 0, 255, 255])),
      );
      var second = first;
      final animationWatch = Stopwatch()..start();
      while (second[0] == first[0] &&
          animationWatch.elapsed < const Duration(seconds: 5)) {
        // The fake animation clock and asynchronous codec worker advance
        // independently. Observe rendered pixels instead of assuming that a
        // particular wall-clock delay has decoded and displayed frame two.
        await tester.runAsync(
          () => Future<void>.delayed(const Duration(milliseconds: 10)),
        );
        await tester.pump(const Duration(milliseconds: 16));
        second = await displayedPixel();
      }
      expect(
        second,
        isNot(orderedEquals(first)),
        reason:
            'The live GIF must display both palette colors within 5 seconds',
      );
      expect(
        second,
        anyOf(orderedEquals([255, 0, 0, 255]), orderedEquals([0, 0, 255, 255])),
      );
      final provider = tester.widget<Image>(find.byType(Image)).image;
      await tester.pumpWidget(const SizedBox());
      slide.dispose();
      await tester.runAsync(() => Future<void>.delayed(Duration.zero));
      expect(
        PaintingBinding.instance.imageCache.containsKey(provider),
        isFalse,
      );
      expect(slide.build(context), isA<SizedBox>());
    } finally {
      await tester.pumpWidget(const SizedBox());
      slide?.dispose();
      await tester.runAsync(() => dir.delete(recursive: true));
    }
  });
}
