import 'dart:io';
import 'dart:ui' as ui;

import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_backend/storage.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/widgets/image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

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
        await tester.pumpWidget(const SizedBox());
        slide.dispose();
        slide.dispose();
      } finally {
        slide?.dispose();
        await tester.runAsync(() => dir.delete(recursive: true));
      }
    },
  );
}
