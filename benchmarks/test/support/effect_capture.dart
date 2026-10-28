import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:dslideshow_flutter/effect.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';

Future<Uint8List> captureEffect(
  WidgetTester tester,
  MediaSliderItemEffect effect,
  GlobalKey key,
  double phase,
  ui.Image from,
  ui.Image to, {
  Size size = const Size(160, 100),
  Matrix4? camera,
  Widget? current,
  Widget? next,
  PreparedPhoto? fromPhoto,
  PreparedPhoto? toPhoto,
}) async {
  await tester.pumpWidget(
    Directionality(
      textDirection: TextDirection.ltr,
      child: Center(
        child: RepaintBoundary(
          key: key,
          child: SizedBox.fromSize(
            size: size,
            child: Builder(
              builder: (context) => effect.createTransformWidget(
                context,
                EffectSlideInput(
                  photo: fromPhoto,
                  view:
                      current ??
                      ClipRect(
                        child: Transform(
                          alignment: Alignment.center,
                          transform: camera ?? Matrix4.identity(),
                          child: RawImage(
                            image: from,
                            fit: BoxFit.contain,
                            filterQuality: FilterQuality.high,
                          ),
                        ),
                      ),
                ),
                EffectSlideInput(
                  photo: toPhoto,
                  view:
                      next ??
                      RawImage(
                        image: to,
                        fit: BoxFit.contain,
                        filterQuality: FilterQuality.high,
                      ),
                ),
                AlwaysStoppedAnimation(phase),
                size.width,
                size.height,
              ),
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
      final bytes = (await image.toByteData(
        format: ui.ImageByteFormat.rawRgba,
      ))!;
      return Uint8List.fromList(
        bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes),
      );
    } finally {
      image.dispose();
    }
  }))!;
}
