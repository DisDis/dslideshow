// Explicit visual regression pass; all benchmark code remains outside the app.
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:benchmarks/src/visual_audit.dart';
import 'package:dslideshow_flutter/effect.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';

const slideA = DecoratedBox(
  decoration: BoxDecoration(
    gradient: LinearGradient(colors: [Color(0xffff4000), Color(0xff902060)]),
  ),
);
const slideB = DecoratedBox(
  decoration: BoxDecoration(
    gradient: LinearGradient(colors: [Color(0xff20d040), Color(0xff2060e0)]),
  ),
);

void main() {
  testWidgets(
    'Every effect has correct endpoints and evolving control frames',
    (tester) async {
      final results = <Map<String, Object?>>[];
      Future<Uint8List> snapshot(Widget child) async {
        final key = GlobalKey();
        await tester.pumpWidget(
          Directionality(
            textDirection: TextDirection.ltr,
            child: Center(
              child: SizedBox(
                width: 160,
                height: 100,
                child: RepaintBoundary(
                  key: key,
                  child: ColoredBox(
                    color: Colors.black,
                    child: ClipRect(child: child),
                  ),
                ),
              ),
            ),
          ),
        );
        await tester.pump();
        return (await tester.runAsync(() async {
          final image =
              await (key.currentContext!.findRenderObject()!
                      as RenderRepaintBoundary)
                  .toImage();
          try {
            final bytes = await image.toByteData(
              format: ui.ImageByteFormat.rawRgba,
            );
            return Uint8List.fromList(bytes!.buffer.asUint8List());
          } finally {
            image.dispose();
          }
        }))!;
      }

      final from = await snapshot(slideA), to = await snapshot(slideB);
      for (final size in [const Size(160, 100), const Size(2560, 1600)]) {
        for (final descriptor in Effect.values) {
          final effect = descriptor.createEffect(seed: 42);
          await tester.runAsync(effect.prepare);
          final frames = <Uint8List>[];
          for (var i = 0; i <= 20; i++) {
            frames.add(
              await snapshot(
                FittedBox(
                  child: SizedBox(
                    width: size.width,
                    height: size.height,
                    child: Builder(
                      builder: (context) => effect.createTransformWidget(
                        context,
                        slideA,
                        slideB,
                        AlwaysStoppedAnimation(i / 20),
                        size.width,
                        size.height,
                      ),
                    ),
                  ),
                ),
              ),
            );
            // At a native 2560px viewport fixed pixel perspective used to put
            // vertices behind the camera, clipping a rectangle into polygons.
            for (final transform in tester.widgetList<Transform>(
              find.byType(Transform),
            )) {
              final matrix = transform.transform;
              final origin = (transform.alignment ?? Alignment.topLeft)
                  .resolve(TextDirection.ltr)
                  .alongSize(size);
              for (final x in [-origin.dx, size.width - origin.dx]) {
                for (final y in [-origin.dy, size.height - origin.dy]) {
                  final w =
                      matrix.entry(3, 0) * x +
                      matrix.entry(3, 1) * y +
                      matrix.entry(3, 3);
                  expect(
                    w,
                    greaterThan(0),
                    reason: '${descriptor.name} camera plane at $size',
                  );
                }
              }
            }
          }
          results.add({
            'effect': descriptor.name,
            'size': size.toString(),
            ...assessVisualFrames(frames, from, to),
          });
          expect(tester.takeException(), isNull, reason: descriptor.name);
        }
      }
      await tester.runAsync(() async {
        await Directory('build/effects').create(recursive: true);
        await File('build/effects/visual-audit.json')
            .writeAsString(const JsonEncoder.withIndent('  ').convert(results));
      });
      final failed = results.where((r) => r['status'] != 'passed').toList();
      expect(failed, isEmpty, reason: jsonEncode(failed));
    },
  );
}
