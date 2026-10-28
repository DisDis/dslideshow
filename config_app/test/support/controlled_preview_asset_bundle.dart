import 'dart:async';
import 'dart:ui' as ui;

import 'package:config_app/features/config/presentation/sessions/preview_photo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Each bundle provides isolated preview bytes, gates and failures per test.
/// Non-preview assets, including framework manifests and fonts, remain real.
class ControlledPreviewAssetBundle extends CachingAssetBundle {
  final Map<PreviewPhoto, Uint8List> images;
  final Map<PreviewPhoto, Completer<void>> gates = {};
  final Map<PreviewPhoto, Object> failures = {};
  final requests = <PreviewPhoto>[];
  final completed = <PreviewPhoto>[];
  final settled = <PreviewPhoto>[];

  ControlledPreviewAssetBundle(this.images);

  static Future<ControlledPreviewAssetBundle> create({
    List<Color> colors = const [Colors.red, Colors.blue, Colors.green],
    bool patterned = false,
    Size sourceSize = const Size(40, 25),
  }) async {
    final images = <PreviewPhoto, Uint8List>{};
    for (final photo in PreviewPhoto.values) {
      final recorder = ui.PictureRecorder();
      final canvas = Canvas(recorder);
      canvas.drawColor(colors[photo.index % colors.length], BlendMode.src);
      if (patterned) {
        for (var index = 0; index < 7; index++) {
          canvas.drawRect(
            Rect.fromLTWH(index * 5, index * 2, 2, 12),
            Paint()..color = index.isEven ? Colors.white : Colors.black,
          );
        }
      }
      final picture = recorder.endRecording();
      final bitmap = picture.toImageSync(
        sourceSize.width.toInt(),
        sourceSize.height.toInt(),
      );
      try {
        final bytes = (await bitmap.toByteData(
          format: ui.ImageByteFormat.png,
        ))!;
        images[photo] = Uint8List.fromList(
          bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes),
        );
      } finally {
        bitmap.dispose();
        picture.dispose();
      }
    }
    return ControlledPreviewAssetBundle(images);
  }

  @override
  Future<ByteData> load(String key) async {
    PreviewPhoto? photo;
    for (final candidate in PreviewPhoto.values) {
      if (candidate.assetPath == key) {
        photo = candidate;
        break;
      }
    }
    if (photo == null) return rootBundle.load(key);
    requests.add(photo);
    try {
      await gates[photo]?.future;
      if (failures[photo] case final error?) throw error;
      completed.add(photo);
      return ByteData.sublistView(images[photo]!);
    } finally {
      settled.add(photo);
    }
  }
}
