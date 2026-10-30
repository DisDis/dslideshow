import 'dart:ui' as ui;

import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'support/config_harness.dart';
import 'support/ota_frontend.dart';

void main() {
  configWidgetTest(
    'ready page paints large QR and readable access code within the display',
    (tester, h) async {
      await h.mount(tester);
      h.frontend.starts.single.complete('83472');
      h.frontend.systems.single.complete(otaSystemInfo());
      await tester.pump();
      final qr = tester.getRect(find.byType(QrImageView));
      final code = tester.getRect(find.byKey(const Key('config-access-code')));
      final screen = const Rect.fromLTWH(0, 0, 2560, 1600);
      expect(qr.intersect(screen), qr);
      expect(code.intersect(screen), code);
      expect(qr.width, greaterThan(1000));
      final bytes = (await tester.runAsync(() async {
        final image =
            await (h.boundaryKey.currentContext!.findRenderObject()!
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
      int count(Rect rect, bool Function(int r, int g, int b) test) {
        var found = 0;
        for (var y = rect.top.ceil(); y < rect.bottom.floor(); y++) {
          for (var x = rect.left.ceil(); x < rect.right.floor(); x++) {
            final offset = (y * 2560 + x) * 4;
            if (test(bytes[offset], bytes[offset + 1], bytes[offset + 2])) {
              found++;
            }
          }
        }
        return found;
      }

      expect(
        count(qr, (r, g, b) => r > 248 && g > 248 && b > 248),
        greaterThan(qr.width * qr.height * .3),
      );
      expect(
        count(qr, (r, g, b) => r < 8 && g < 8 && b < 8),
        greaterThan(qr.width * qr.height * .3),
      );
      expect(
        count(
          code,
          (r, g, b) => r > 170 && (r - g).abs() < 3 && (r - b).abs() < 3,
        ),
        greaterThan(5000),
      );
      expect(
        find.byKey(const Key('config-return')).hitTestable(),
        findsOneWidget,
      );
      expect(tester.takeException(), isNull);
    },
  );
}
