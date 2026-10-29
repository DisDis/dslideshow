import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:dslideshow_common/version.dart';
import 'package:dslideshow_flutter/features/ota/presentation/widgets/ota_ready_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'support/frame_app_harness.dart';

void main() {
  testWidgets('embedded ready page paints its large QR and red version', (
    tester,
  ) async {
    final boundaryKey = GlobalKey();
    await mountFrameOtaApp(tester, boundaryKey: boundaryKey);
    final readyRect = tester.getRect(find.byType(OtaReadyWidget));
    final qrRect = tester.getRect(find.byType(QrImageView));
    final codeRect = tester.getRect(find.text('83472'));
    final versionRect = tester.getRect(
      find.text('v${ApplicationInfo.frontendVersion}'),
    );
    final pixels = (await tester.runAsync(() async {
      final boundary =
          boundaryKey.currentContext!.findRenderObject()!
              as RenderRepaintBoundary;
      final image = await boundary.toImage();
      try {
        final bytes = await image.toByteData(
          format: ui.ImageByteFormat.rawRgba,
        );
        return Uint8List.fromList(bytes!.buffer.asUint8List());
      } finally {
        image.dispose();
      }
    }))!;
    var whitePixels = 0;
    for (var offset = 0; offset < pixels.length; offset += 4) {
      if (pixels[offset] > 248 &&
          pixels[offset + 1] > 248 &&
          pixels[offset + 2] > 248 &&
          pixels[offset + 3] > 248) {
        whitePixels++;
      }
    }
    var redVersionPixels = 0;
    for (
      var y = versionRect.top.ceil().clamp(0, 1600);
      y < versionRect.bottom.floor().clamp(0, 1600);
      y++
    ) {
      for (
        var x = versionRect.left.ceil().clamp(0, 2560);
        x < versionRect.right.floor().clamp(0, 2560);
        x++
      ) {
        final offset = (y * 2560 + x) * 4;
        if (pixels[offset] > 220 &&
            pixels[offset + 1] < 130 &&
            pixels[offset + 2] < 130 &&
            pixels[offset + 3] > 220) {
          redVersionPixels++;
        }
      }
    }
    var codePixels = 0;
    for (
      var y = codeRect.top.ceil().clamp(0, 1600);
      y < codeRect.bottom.floor().clamp(0, 1600);
      y++
    ) {
      for (
        var x = codeRect.left.ceil().clamp(0, 2560);
        x < codeRect.right.floor().clamp(0, 2560);
        x++
      ) {
        final offset = (y * 2560 + x) * 4;
        final red = pixels[offset];
        if (red > 170 &&
            (red - pixels[offset + 1]).abs() < 3 &&
            (red - pixels[offset + 2]).abs() < 3 &&
            pixels[offset + 3] > 220) {
          codePixels++;
        }
      }
    }
    // The QR quiet zone must remain white in the rendered image. This fixed
    // four-pixel sample is independent of the generated QR module pattern.
    var whiteQuietZonePixels = 0;
    for (var y = qrRect.top.ceil() + 1; y < qrRect.top.ceil() + 5; y++) {
      for (var x = qrRect.left.ceil() + 1; x < qrRect.left.ceil() + 5; x++) {
        if (x < 0 || x >= 2560 || y < 0 || y >= 1600) continue;
        final offset = (y * 2560 + x) * 4;
        if (pixels[offset] > 248 &&
            pixels[offset + 1] > 248 &&
            pixels[offset + 2] > 248 &&
            pixels[offset + 3] > 248) {
          whiteQuietZonePixels++;
        }
      }
    }
    final diagnostics =
        'ready=$readyRect, whitePixels=$whitePixels, '
        'QR=$qrRect, quietZone=$whiteQuietZonePixels, '
        'version=$versionRect, redVersionPixels=$redVersionPixels, '
        'code=$codeRect, codePixels=$codePixels';
    expect(readyRect.size, const Size(2560, 1600), reason: diagnostics);
    const screen = Rect.fromLTWH(0, 0, 2560, 1600);
    for (final rect in [qrRect, codeRect, versionRect]) {
      expect(rect.intersect(screen), rect, reason: diagnostics);
    }
    // White text or status icons cannot account for this much of the screen.
    expect(whitePixels, greaterThan(2560 * 1600 * .1), reason: diagnostics);
    expect(whiteQuietZonePixels, 16, reason: diagnostics);
    expect(redVersionPixels, greaterThan(1000), reason: diagnostics);
    expect(codePixels, greaterThan(5000), reason: diagnostics);
    expect(tester.takeException(), isNull);
  });
}
