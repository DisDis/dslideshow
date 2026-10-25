import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:dslideshow_flutter/effect.dart';
import 'package:dslideshow_flutter/src/effect/mosaic_mask.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';

import 'support/atlas_reference_mask.dart' as original;
import 'zoom_blur_effect_test.dart' as pixels;

Widget scene(
  MosaicSchedule schedule,
  double t,
  Widget source,
  Widget next, {
  required bool reference,
}) => Stack(
  fit: StackFit.expand,
  children: [
    next,
    if (reference)
      original.AtlasReferenceMask(
        schedule: schedule,
        progress: t,
        child: source,
      )
    else
      MosaicMask(schedule: schedule, progress: t, child: source),
  ],
);

void exact(Uint8List expected, Uint8List actual, String reason) {
  expect(actual.length, expected.length, reason: reason);
  var max = 0;
  for (var i = 0; i < expected.length; i++) {
    final d = (expected[i] - actual[i]).abs();
    if (d > max) max = d;
  }
  expect(max, 0, reason: reason);
}

void main() {
  test('Canvas order is immutable, complete and reused across mask views', () {
    for (final direction in MosaicDirection.values) {
      for (final fade in [0.0, .3, 1.0]) {
        final schedule = MosaicSchedule(
          gridSize: 200,
          fadeFraction: fade,
          direction: direction,
          seed: 42,
        );
        final order = schedule.prepareCanvasOrder();
        expect(identical(order, schedule.prepareCanvasOrder()), true);
        expect(order.toSet().length, 40000);
        expect(order.every((i) => i >= 0 && i < 40000), true);
        expect(() => order[0] = -1, throwsUnsupportedError);
        var monotone = true;
        for (var i = 1; i < order.length; i++) {
          if (schedule.startTimes[order[i]] <
              schedule.startTimes[order[i - 1]]) {
            monotone = false;
          }
        }
        expect(monotone, true);
      }
    }
  });
  testWidgets(
    'Canvas point groups preserve atlas pixels, ties and reverse progress',
    (tester) async {
      final a = pixels.bitmap(false), b = pixels.bitmap(true);
      try {
        for (final grid in [1, 100, 150, 200]) {
          for (final direction in MosaicDirection.values) {
            for (final fade in [0.0, .3, 1.0]) {
              final schedule = MosaicSchedule(
                gridSize: grid,
                fadeFraction: fade,
                direction: direction,
                seed: 42,
              );
              final start =
                  schedule.startTimes[schedule.startTimes.length ~/ 2];
              final times = {
                0.0,
                .01,
                .23,
                .51,
                .87,
                1.0,
                start,
                (start + fade * (127.5 / 255)).clamp(0.0, 1.0),
                .13,
              };
              for (final t in times) {
                Future<Uint8List> draw(bool reference) => pixels.capture(
                  tester,
                  (_) => scene(
                    schedule,
                    t,
                    pixels.slide(a),
                    pixels.slide(b),
                    reference: reference,
                  ),
                );
                exact(
                  await draw(true),
                  await draw(false),
                  '$grid $direction fade=$fade t=$t',
                );
              }
            }
          }
        }
      } finally {
        await tester.pumpWidget(const SizedBox.shrink());
        a.dispose();
        b.dispose();
      }
    },
  );

  testWidgets('Canvas point groups preserve native-resolution atlas frames', (
    tester,
  ) async {
    const size = Size(2560, 1600);
    tester.view.physicalSize = size;
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final a = pixels.bitmap(false, size: size),
        b = pixels.bitmap(true, size: size);
    try {
      for (final grid in [100, 150, 200]) {
        for (final fade in [0.0, .3]) {
          final schedule = MosaicSchedule(
            gridSize: grid,
            fadeFraction: fade,
            seed: 42,
          );
          for (final t in [.13, .5, .87]) {
            Future<Uint8List> draw(bool reference) => pixels.capture(
              tester,
              (_) => scene(
                schedule,
                t,
                pixels.slide(a),
                pixels.slide(b),
                reference: reference,
              ),
              size: size,
            );
            exact(
              await draw(true),
              await draw(false),
              'native $grid fade=$fade t=$t',
            );
          }
        }
      }
    } finally {
      await tester.pumpWidget(const SizedBox.shrink());
      a.dispose();
      b.dispose();
    }
  });

  testWidgets('Retained masks survive schedule, size and backend replacement', (
    tester,
  ) async {
    final program = await tester.runAsync(loadMosaicProgram);
    final oldKey = GlobalKey(), newKey = GlobalKey();
    Future<Uint8List> read(GlobalKey key) async =>
        (await tester.runAsync(() async {
          final image =
              await (key.currentContext!.findRenderObject()!
                      as RenderRepaintBoundary)
                  .toImage();
          try {
            final data = await image.toByteData(
              format: ui.ImageByteFormat.rawRgba,
            );
            return Uint8List.fromList(data!.buffer.asUint8List());
          } finally {
            image.dispose();
          }
        }))!;
    for (final gpu in [false, true, false]) {
      for (final grid in [1, 200, 100]) {
        final schedule = MosaicSchedule(
          gridSize: grid,
          fadeFraction: grid == 1 ? 1 : .3,
          seed: 19,
        );
        for (final size in [const Size(160, 100), const Size(213, 137)]) {
          for (final t in [0.0, .23, .87, .23, 1.0]) {
            final child = Stack(
              fit: StackFit.expand,
              children: const [
                ColoredBox(color: Colors.white),
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: 41,
                    height: 33,
                    child: ColoredBox(color: Color(0x8050a010)),
                  ),
                ),
              ],
            );
            await tester.pumpWidget(
              Directionality(
                textDirection: TextDirection.ltr,
                child: Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox.fromSize(
                        size: size,
                        child: RepaintBoundary(
                          key: oldKey,
                          child: ColoredBox(
                            color: Colors.black,
                            child: original.AtlasReferenceMask(
                              schedule: schedule,
                              progress: t,
                              program: gpu ? program : null,
                              child: child,
                            ),
                          ),
                        ),
                      ),
                      SizedBox.fromSize(
                        size: size,
                        child: RepaintBoundary(
                          key: newKey,
                          child: ColoredBox(
                            color: Colors.black,
                            child: MosaicMask(
                              schedule: schedule,
                              progress: t,
                              program: gpu ? program : null,
                              child: child,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
            exact(
              await read(oldKey),
              await read(newKey),
              'retained gpu=$gpu grid=$grid size=$size t=$t',
            );
          }
        }
      }
    }
    await tester.pumpWidget(const SizedBox.shrink());
    expect(tester.takeException(), isNull);
  });
}
