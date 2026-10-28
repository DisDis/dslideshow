import 'dart:ui' as ui;
import 'dart:typed_data';

import 'package:dslideshow_flutter/features/slideshow/presentation/widgets/fixed_animation_controller.dart';
import 'package:dslideshow_flutter/src/effect/cube_effect.dart';
import 'package:dslideshow_flutter/src/effect/depth_effect.dart';
import 'package:dslideshow_flutter/src/effect/effect.dart';
import 'package:dslideshow_flutter/src/effect/fade_effect.dart';
import 'package:dslideshow_flutter/src/effect/media_slider_item_effect.dart';
import 'package:dslideshow_flutter/src/effect/mosaic_fade_effect.dart';
import 'package:dslideshow_flutter/src/effect/mosaic_mask.dart';
import 'package:dslideshow_flutter/src/effect/mosaic_transition_effect.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';

const white = SizedBox.expand(child: ColoredBox(color: Colors.white));
const black = SizedBox.expand(child: ColoredBox(color: Colors.black));

Widget frame(
  MediaSliderItemEffect effect,
  double progress, {
  Widget current = white,
  Widget next = black,
  Key? capture,
  PreparedPhoto? photo,
}) => RepaintBoundary(
  key: capture,
  child: Directionality(
    textDirection: TextDirection.ltr,
    child: SizedBox(
      width: 160,
      height: 90,
      child: ColoredBox(
        color: Colors.black,
        child: Builder(
          builder: (context) => effect.createTransformWidget(
            context,
            EffectSlideInput(view: current, photo: photo),
            EffectSlideInput(view: next, photo: photo),
            AlwaysStoppedAnimation(progress),
            160,
            90,
          ),
        ),
      ),
    ),
  ),
);

Future<Uint8List> snapshot(WidgetTester tester, Widget content) async {
  final key = GlobalKey();
  await tester.pumpWidget(
    Center(
      child: RepaintBoundary(
        key: key,
        child: SizedBox(width: 160, height: 90, child: content),
      ),
    ),
  );
  return (await tester.runAsync(() async {
    final boundary =
        key.currentContext!.findRenderObject()! as RenderRepaintBoundary;
    final image = await boundary.toImage();
    try {
      final bytes = await image.toByteData(format: ui.ImageByteFormat.rawRgba);
      return Uint8List.fromList(bytes!.buffer.asUint8List());
    } finally {
      image.dispose();
    }
  }))!;
}

Future<List<int>> pixel(
  WidgetTester tester,
  Widget content, {
  int x = 40,
  int y = 30,
}) async {
  final bytes = await snapshot(tester, content);
  return bytes.sublist((y * 160 + x) * 4, (y * 160 + x) * 4 + 4);
}

class MountProbe extends StatefulWidget {
  final VoidCallback onMount;
  const MountProbe({super.key, required this.onMount});
  @override
  State<MountProbe> createState() => _MountProbeState();
}

class _MountProbeState extends State<MountProbe> {
  @override
  void initState() {
    super.initState();
    widget.onMount();
  }

  @override
  Widget build(BuildContext context) => white;
}

void main() {
  testWidgets(
    'Fixed controller preserves bounded progress under frame stalls',
    (tester) async {
      final controller = FixedAnimationController(
        vsync: tester,
        duration: const Duration(seconds: 1),
        animationBehavior: AnimationBehavior.preserve,
      );
      controller.forward();
      await tester.pump();
      for (var i = 0; i < 60; i++) {
        final previous = controller.value;
        await tester.pump(const Duration(microseconds: 16667));
        expect(controller.value - previous, lessThanOrEqualTo(0.010001));
      }
      expect(controller.value, closeTo(0.6, 0.001));
      final previous = controller.value;
      await tester.pump(const Duration(seconds: 2));
      expect(controller.value - previous, closeTo(0.01, 0.001));
      controller.stop();
      await tester.pump(const Duration(seconds: 2));
      expect(controller.value, closeTo(previous + 0.01, 0.001));
      controller.forward();
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 16));
      expect(controller.value - previous, lessThanOrEqualTo(0.020001));
      controller.dispose();
    },
  );

  testWidgets('Fade keeps identical opaque slides unchanged throughout', (
    tester,
  ) async {
    for (final t in [0.0, 0.25, 0.5, 0.75, 1.0]) {
      expect(await pixel(tester, frame(FadeEffect(), t, next: white)), [
        255,
        255,
        255,
        255,
      ]);
    }
  });

  testWidgets('Fade includes video letterboxing in its opaque slide', (
    tester,
  ) async {
    const letterboxed = Center(
      child: SizedBox(
        width: 40,
        height: 30,
        child: ColoredBox(color: Colors.white),
      ),
    );
    final mid = await pixel(
      tester,
      frame(FadeEffect(), .5, next: letterboxed),
      x: 5,
      y: 5,
    );
    expect(mid[0], closeTo(127, 1));
    expect(mid[3], 255);
    expect(
      await pixel(
        tester,
        frame(FadeEffect(), 1, next: letterboxed),
        x: 5,
        y: 5,
      ),
      [0, 0, 0, 255],
    );
  });

  testWidgets('Cube keeps both child states when changing draw order', (
    tester,
  ) async {
    var currentMounts = 0;
    var nextMounts = 0;
    final current = MountProbe(
      key: const ValueKey('current'),
      onMount: () => currentMounts++,
    );
    final next = MountProbe(
      key: const ValueKey('next'),
      onMount: () => nextMounts++,
    );
    final effect = CubeEffect();
    await tester.pumpWidget(frame(effect, 0.49, current: current, next: next));
    await tester.pumpWidget(frame(effect, 0.51, current: current, next: next));
    expect(currentMounts, 1);
    expect(nextMounts, 1);
  });

  testWidgets('Depth scales the outgoing slide about its center', (
    tester,
  ) async {
    await tester.pumpWidget(frame(DepthEffect(), 0.5));
    final transform = tester
        .widgetList<Transform>(find.byType(Transform))
        .first;
    expect(transform.transform.getTranslation().x, 0);
    expect(transform.transform.entry(0, 0), closeTo(0.75, 0.001));
  });

  test(
    'Mosaics retain 100x100 cells and deterministic schedules up to 200x200',
    () {
      expect(MosaicFadeEffect().gridSize, 100);
      expect(MosaicTransitionEffect().gridSize, 100);
      for (final grid in [100, 150, 200]) {
        for (final direction in MosaicDirection.values) {
          final a = MosaicFadeEffect(
            gridSize: grid,
            direction: direction,
            seed: 42,
          ).schedule;
          final b = MosaicFadeEffect(
            gridSize: grid,
            direction: direction,
            seed: 42,
          ).schedule;
          expect(a.startTimes.length, grid * grid);
          expect(a.startTimes, b.startTimes);
          expect(
            a.startTimes.every((t) => t.isFinite && t >= 0 && t <= 0.7),
            isTrue,
          );
          expect(a.alphaAt(0, 0), 255);
          expect(a.alphaAt(0, 1), 0);
        }
      }
    },
  );

  testWidgets(
    'MosaicFade masks composited children and has no cell-edge seams',
    (tester) async {
      final effect = MosaicFadeEffect(gridSize: 2, fadeFraction: 1, seed: 1);
      for (final child in [white, const RepaintBoundary(child: white)]) {
        for (final point in [(40, 30), (80, 45), (81, 46)]) {
          expect(
            await pixel(
              tester,
              frame(effect, 0.5, current: child),
              x: point.$1,
              y: point.$2,
            ),
            [128, 128, 128, 255],
          );
        }
      }
      expect(await pixel(tester, frame(effect, 0)), [255, 255, 255, 255]);
      expect(await pixel(tester, frame(effect, 1)), [0, 0, 0, 255]);
    },
  );

  testWidgets(
    'GPU and Canvas agree over dense full frames with the same schedule',
    (tester) async {
      for (final grid in [100, 150, 200]) {
        for (final binary in [false, true]) {
          final canvas = MosaicFadeEffect(
            gridSize: grid,
            fadeFraction: binary ? 0 : 0.3,
            seed: 19,
          );
          final gpu = MosaicFadeEffect(
            gridSize: grid,
            fadeFraction: binary ? 0 : 0.3,
            seed: 19,
            backend: MosaicBackend.shader,
          );
          await tester.runAsync(gpu.prepare);
          for (final t in [0.0, 0.23, 0.51, 0.87, 1.0]) {
            final expected = await snapshot(tester, frame(canvas, t));
            final actual = await snapshot(tester, frame(gpu, t));
            var largestDifference = 0;
            for (var i = 0; i < expected.length; i++) {
              final difference = (actual[i] - expected[i]).abs();
              if (difference > largestDifference) {
                largestDifference = difference;
              }
            }
            expect(
              largestDifference,
              lessThanOrEqualTo(1),
              reason: '$grid, binary=$binary, t=$t',
            );
          }
        }
      }
    },
  );

  testWidgets(
    'Retained mosaic layers update progress and replace GPU resources safely',
    (tester) async {
      final key = GlobalKey();
      for (final backend in MosaicBackend.values) {
        for (final grid in [100, 200]) {
          final effect = MosaicFadeEffect(
            gridSize: grid,
            seed: 37,
            backend: backend,
          );
          await tester.runAsync(effect.prepare);
          for (final t in [.23, .51, .87, .23]) {
            await tester.pumpWidget(
              Center(
                child: SizedBox(
                  width: 160,
                  height: 90,
                  child: frame(effect, t, capture: key),
                ),
              ),
            );
            final value = await tester.runAsync(() async {
              final image =
                  await (key.currentContext!.findRenderObject()!
                          as RenderRepaintBoundary)
                      .toImage();
              try {
                final bytes = await image.toByteData(
                  format: ui.ImageByteFormat.rawRgba,
                );
                return bytes!.buffer.asUint8List()[(30 * 160 + 40) * 4];
              } finally {
                image.dispose();
              }
            });
            final col = ((40.5 / 160) * grid + .0001).floor();
            final row = ((30.5 / 90) * grid + .0001).floor();
            expect(
              value,
              closeTo(effect.schedule.alphaAt(row * grid + col, t), 1),
              reason: '${backend.name}: $grid at $t',
            );
          }
        }
      }
      await tester.pumpWidget(const SizedBox());
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets(
    'New effects retain opaque endpoints and expose their intended midpoint',
    (tester) async {
      final descriptors = Effect.values.toList().skip(23);
      for (final descriptor in descriptors) {
        final effect = descriptor.createEffect(seed: 1);
        expect(await pixel(tester, frame(effect, 0)), [
          255,
          255,
          255,
          255,
        ], reason: descriptor.name);
        expect(await pixel(tester, frame(effect, 1)), [
          0,
          0,
          0,
          255,
        ], reason: descriptor.name);
      }
      expect(
        await pixel(
          tester,
          frame(
            (const Effect(
              EffectType.fadeThroughColor,
              options: FadeThroughColorEffectOptions(color: 0xFFFFFFFF),
            )).createEffect(),
            .5,
          ),
        ),
        [255, 255, 255, 255],
      );
      expect(
        await pixel(
          tester,
          frame(
            (const Effect(
              EffectType.fadeThroughColor,
              options: FadeThroughColorEffectOptions(),
            )).createEffect(),
            .5,
          ),
        ),
        [0, 0, 0, 255],
      );
    },
  );

  test('Canonical external names are unique and unknown names are errors', () {
    for (final effect in Effect.values) {
      expect(Effect.parse(effect.name), effect);
    }
    expect(() => Effect.parse('unknown'), throwsFormatException);
    expect(
      Effect.values.map((e) => e.name).toSet().length,
      Effect.values.length,
    );
  });

  testWidgets(
    'Every registered effect renders endpoints and intermediate frames',
    (tester) async {
      final recorder = ui.PictureRecorder();
      Canvas(recorder).drawColor(Colors.white, BlendMode.src);
      final picture = recorder.endRecording();
      final photo = picture.toImageSync(160, 90);
      picture.dispose();
      addTearDown(photo.dispose);
      for (final descriptor in Effect.values) {
        final effect = descriptor.createEffect();
        await tester.runAsync(effect.prepare);
        final prepared = !effect.supportsInputs(
          const EffectSlideInput(view: white),
          const EffectSlideInput(view: black),
        );
        for (final t in [0.0, 0.25, 0.5, 0.75, 1.0]) {
          await tester.pumpWidget(
            frame(
              effect,
              t,
              photo: prepared ? PreparedPhoto(bitmap: photo) : null,
            ),
          );
          expect(
            tester.takeException(),
            isNull,
            reason: '${descriptor.name} at $t',
          );
        }
      }
      expect(find.byType(MosaicMask), findsNothing);
    },
  );
}
