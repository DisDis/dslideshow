import 'dart:ui' as ui;

import 'package:flutter/material.dart';

Future<ui.Image> testPhoto(int seed, {bool opaque = false}) async {
  final recorder = ui.PictureRecorder();
  final canvas = Canvas(recorder);
  if (opaque) canvas.drawColor(Colors.black, BlendMode.src);
  const colors = [
    Color(0xffff0033),
    Color(0xff0033ff),
    Color(0x8000ff00),
    Color(0x00ffffff),
    Color(0xffffffff),
    Color(0xff000000),
  ];
  for (var y = 0; y < 100; y += 5) {
    for (var x = 0; x < 160; x += 7) {
      canvas.drawRect(
        Rect.fromLTWH(x.toDouble(), y.toDouble(), 7, 5),
        Paint()..color = colors[(x ~/ 7 + y ~/ 5 * 3 + seed) % colors.length],
      );
    }
  }
  final picture = recorder.endRecording();
  try {
    return await picture.toImage(160, 100);
  } finally {
    picture.dispose();
  }
}
