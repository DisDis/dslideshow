import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:dslideshow_flutter/src/effect/blure_fade_effect.dart';
import 'package:dslideshow_flutter/src/effect/media_slider_item_effect.dart';
import 'package:dslideshow_flutter/src/effect/zoom_over_effect.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';

// Keep the previous composition as a pixel reference, including the original
// high-quality bitmap sampling and transparent/overlapping content.
Widget reference(
  Widget from,
  Widget to,
  double t, {
  required bool blur,
  double parameter = 10,
}) => blur
    ? Stack(
        fit: StackFit.expand,
        children: [
          to,
          Opacity(
            opacity: 1 - t,
            child: ImageFiltered(
              imageFilter: ui.ImageFilter.blur(
                sigmaX: t * parameter,
                sigmaY: t * parameter,
              ),
              enabled: t > 0 && parameter > 0,
              child: from,
            ),
          ),
        ],
      )
    : Stack(
        fit: StackFit.expand,
        children: [
          Transform.scale(scale: 1 - .1 * t, child: from),
          Opacity(
            opacity: Curves.easeIn.transform(t),
            child: Transform.scale(
              scale: parameter - (parameter - 1) * t,
              child: to,
            ),
          ),
        ],
      );

Future<Uint8List> capture(
  WidgetTester tester,
  Widget Function(BuildContext) scene, {
  Size size = const Size(160, 100),
}) async {
  final key = GlobalKey();
  await tester.pumpWidget(
    Directionality(
      textDirection: TextDirection.ltr,
      child: Center(
        child: RepaintBoundary(
          key: key,
          child: SizedBox.fromSize(
            size: size,
            child: ColoredBox(
              color: Colors.black,
              child: ClipRect(child: Builder(builder: scene)),
            ),
          ),
        ),
      ),
    ),
  );
  return (await tester.runAsync(() async {
    final boundary =
        key.currentContext!.findRenderObject()! as RenderRepaintBoundary;
    final image = await boundary.toImage();
    try {
      final data = await image.toByteData(format: ui.ImageByteFormat.rawRgba);
      return Uint8List.fromList(data!.buffer.asUint8List());
    } finally {
      image.dispose();
    }
  }))!;
}

ui.Image bitmap(bool alternate, {Size size = const Size(160, 100)}) {
  final recorder = ui.PictureRecorder();
  final canvas = Canvas(recorder)..scale(size.width / 160, size.height / 100);
  for (var y = 0; y < 100; y += 4) {
    for (var x = 0; x < 160; x += 4) {
      canvas.drawRect(
        Rect.fromLTWH(x.toDouble(), y.toDouble(), 4, 4),
        Paint()
          ..color = Color.fromARGB(
            alternate ? 170 : 255,
            (x * 3 + y) % 256,
            (y * 5 + 20) % 256,
            (x * 7 + y * 2) % 256,
          ),
      );
    }
  }
  final picture = recorder.endRecording();
  try {
    return picture.toImageSync(size.width.toInt(), size.height.toInt());
  } finally {
    picture.dispose();
  }
}

Widget slide(ui.Image image) => RepaintBoundary(
  child: Stack(
    fit: StackFit.expand,
    children: [
      RawImage(image: image, filterQuality: FilterQuality.high),
      const Align(
        alignment: Alignment.centerRight,
        child: SizedBox(
          width: 41,
          height: 33,
          child: ColoredBox(color: Color(0x8060c040)),
        ),
      ),
    ],
  ),
);

void main() {
  for (final blur in [true, false]) {
    testWidgets(
      '${blur ? 'BlurFade' : 'ZoomOver'} preserves reference pixels',
      (tester) async {
        final a = bitmap(false), b = bitmap(true);
        try {
          for (final parameter in blur ? [0.0, 2.5, 10.0] : [1.0, 1.5, 2.0]) {
            final MediaSliderItemEffect effect = blur
                ? BlurFadeEffect(maxSigma: parameter)
                : ZoomOverEffect(startScale: parameter);
            for (final t in [0.0, .05, .13, .25, .5, .75, .95, 1.0]) {
              final expected = await capture(
                tester,
                (_) => reference(
                  slide(a),
                  slide(b),
                  t,
                  blur: blur,
                  parameter: parameter,
                ),
              );
              final actual = await capture(
                tester,
                (context) => effect.createTransformWidget(
                  context,
                  slide(a),
                  slide(b),
                  AlwaysStoppedAnimation(t),
                  160,
                  100,
                ),
              );
              var sum = 0, max = 0;
              for (var i = 0; i < expected.length; i++) {
                final delta = (expected[i] - actual[i]).abs();
                sum += delta;
                if (delta > max) max = delta;
              }
              final mean = sum / expected.length;
              expect(
                mean,
                0,
                reason: 'mean at parameter=$parameter t=$t (max=$max)',
              );
              expect(
                max,
                0,
                reason: 'max at parameter=$parameter t=$t (mean=$mean)',
              );
            }
          }
        } finally {
          await tester.pumpWidget(const SizedBox.shrink());
          a.dispose();
          b.dispose();
        }
      },
    );
  }

  testWidgets(
    'Both effects preserve full-resolution pixels on the RaPi5 viewport',
    (tester) async {
      const size = Size(2560, 1600);
      tester.view.devicePixelRatio = 1;
      tester.view.physicalSize = size;
      addTearDown(tester.view.resetDevicePixelRatio);
      addTearDown(tester.view.resetPhysicalSize);
      final a = bitmap(false, size: size), b = bitmap(true, size: size);
      try {
        for (final blur in [true, false]) {
          final MediaSliderItemEffect effect = blur
              ? BlurFadeEffect()
              : ZoomOverEffect();
          for (final t in [.25, .75]) {
            final expected = await capture(
              tester,
              (_) => reference(
                slide(a),
                slide(b),
                t,
                blur: blur,
                parameter: blur ? 10 : 1.5,
              ),
              size: size,
            );
            final actual = await capture(
              tester,
              (context) => effect.createTransformWidget(
                context,
                slide(a),
                slide(b),
                AlwaysStoppedAnimation(t),
                size.width,
                size.height,
              ),
              size: size,
            );
            var max = 0;
            for (var i = 0; i < expected.length; i++) {
              final delta = (expected[i] - actual[i]).abs();
              if (delta > max) max = delta;
            }
            expect(max, 0, reason: 'blur=$blur t=$t at $size');
          }
        }
      } finally {
        await tester.pumpWidget(const SizedBox.shrink());
        a.dispose();
        b.dispose();
      }
    },
  );
}
