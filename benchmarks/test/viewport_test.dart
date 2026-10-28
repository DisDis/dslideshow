import 'dart:io';
import 'dart:ui' as ui;

import 'package:benchmarks/src/blur_probes.dart';
import 'package:benchmarks/src/composition_probes.dart';
import 'package:benchmarks/src/config.dart';
import 'package:benchmarks/src/driver.dart';
import 'package:benchmarks/src/experimental/retained_transform_effects.dart';
import 'package:benchmarks/src/media.dart';
import 'package:benchmarks/src/mosaic_probes.dart';
import 'package:benchmarks/src/plan.dart';
import 'package:benchmarks/src/viewport.dart';
import 'package:dslideshow_flutter/effect.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/widgets/image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Future<T> _withFrames<T>(WidgetTester tester, Future<T> work) async {
  T? result;
  Object? failure;
  StackTrace? failureStack;
  var finished = false;
  work.then(
    (value) {
      result = value;
      finished = true;
    },
    onError: (Object error, StackTrace stack) {
      failure = error;
      failureStack = stack;
      finished = true;
    },
  );
  final timeout = Stopwatch()..start();
  while (!finished) {
    if (timeout.elapsed > const Duration(seconds: 20)) {
      fail('Viewport operation did not finish');
    }
    // Photo decoding and file IO run outside the fake clock; layout still
    // needs explicit test frames to complete the viewport's endOfFrame waits.
    await tester.runAsync(
      () => Future<void>.delayed(const Duration(milliseconds: 5)),
    );
    await tester.pump();
  }
  if (failure != null) Error.throwWithStackTrace(failure!, failureStack!);
  return result as T;
}

class _PreparedProbeEffect extends MediaSliderItemEffect {
  bool prepared = false;

  @override
  Future<void> prepare() async => prepared = true;

  @override
  Widget transform(
    BuildContext context,
    Widget page,
    bool isCurrentPage,
    double pageDelta,
    double screenW,
    double screenH,
  ) => page;
}

void main() {
  testWidgets(
    'prepared-effect callback borrows only static photos after prepare',
    (tester) async {
      tester.view.physicalSize = const Size(160, 100);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      late BenchmarkDriver driver;
      final borrowed = <(bool, ui.Image?, ui.Image?)>[];
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: MediaQuery.fromView(
            view: tester.view,
            child: BenchmarkViewport(
              config: BenchmarkConfig(productionPhotoInputs: true),
              catalog: MediaCatalog(Directory('assets/media'), []),
              reportDirectory: Directory.systemTemp,
              onReady: (value) async => driver = value,
              effectFactory: (test, seed) => _PreparedProbeEffect(),
              onEffectPrepared: (effect, from, to) {
                borrowed.add((
                  (effect as _PreparedProbeEffect).prepared,
                  from,
                  to,
                ));
              },
            ),
          ),
        ),
      );
      for (final pair in [mediaPairs.first, mediaPairs[4], mediaPairs[5]]) {
        await _withFrames(
          tester,
          driver.prepare(BenchmarkCase(Effect.stretchEffect, pair)),
        );
        final (prepared, from, to) = borrowed.last;
        expect(prepared, isTrue);
        expect(from == null, pair.type(pair.from) != TransitionMedia.photo);
        expect(to == null, pair.type(pair.to) != TransitionMedia.photo);
        for (final bitmap in [from, to].nonNulls) {
          expect(bitmap.width, 160);
          expect(bitmap.height, 100);
          expect(bitmap.debugDisposed, isFalse);
          expect(
            tester
                .widgetList<ImageWidget>(find.byType(ImageWidget))
                .any((image) => identical(image.preparedBitmap, bitmap)),
            isTrue,
            reason: 'the callback borrows the existing image-owner handle',
          );
        }
        await _withFrames(tester, driver.release());
        expect(
          [from, to].nonNulls.every((bitmap) => bitmap.debugDisposed),
          isTrue,
        );
      }
      expect(borrowed, hasLength(3));
      await tester.pumpWidget(const SizedBox());
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets(
    'entrypoint factory substitutes ordinary effects and preserves diagnostic paths',
    (tester) async {
      tester.view.physicalSize = const Size(160, 100);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      late BenchmarkDriver driver;
      final substituted = <String>[];
      final seeds = <int>[];
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: MediaQuery.fromView(
            view: tester.view,
            child: BenchmarkViewport(
              config: BenchmarkConfig(productionPhotoInputs: true),
              catalog: MediaCatalog(Directory('assets/media'), []),
              reportDirectory: Directory.systemTemp,
              onReady: (value) async => driver = value,
              effectFactory: (test, seed) {
                seeds.add(seed);
                substituted.add(test.id);
                return test.effect == null
                    ? null
                    : createRetainedTransformExperiment(test.effect!);
              },
            ),
          ),
        ),
      );
      for (final effect in [Effect.stretchEffect, Effect.crossZoomEffect]) {
        final test = BenchmarkCase(effect, mediaPairs.first);
        await _withFrames(tester, driver.prepare(test));
        expect(substituted.last, test.id);
        expect(seeds.last, 42);
        final transforms = tester.widgetList<Transform>(find.byType(Transform));
        expect(transforms, hasLength(2));
        expect(
          transforms.map((widget) => widget.filterQuality),
          everyElement(FilterQuality.high),
        );
        await _withFrames(tester, driver.release());
      }
      final glass = BenchmarkCase(Effect.glassEffect, mediaPairs.first);
      await _withFrames(tester, driver.prepare(glass));
      expect(substituted.last, glass.id);
      expect(find.byType(ImageWidget), findsNWidgets(16));
      await _withFrames(tester, driver.release());
      final callsBeforeDiagnostic = substituted.length;
      await _withFrames(
        tester,
        driver.prepare(
          BenchmarkCase(
            Effect.accordionEffect,
            mediaPairs.first,
            compositionProbe: CompositionProbe.accordionReference,
          ),
        ),
      );
      expect(substituted, hasLength(callsBeforeDiagnostic));
      await _withFrames(tester, driver.release());
      await tester.pumpWidget(const SizedBox());
      expect(tester.takeException(), isNull);
    },
  );

  for (final productionInputs in [false, true]) {
    testWidgets(
      'photo inputs use ${productionInputs ? 'production' : 'legacy'} layers and release prepared pixels',
      (tester) async {
        tester.view.physicalSize = const Size(160, 100);
        tester.view.devicePixelRatio = 1;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);
        late BenchmarkDriver driver;
        await tester.pumpWidget(
          Directionality(
            textDirection: TextDirection.ltr,
            child: MediaQuery.fromView(
              view: tester.view,
              child: BenchmarkViewport(
                config: BenchmarkConfig(
                  productionPhotoInputs: productionInputs,
                ),
                catalog: MediaCatalog(Directory('assets/media'), []),
                reportDirectory: Directory.systemTemp,
                onReady: (value) async => driver = value,
              ),
            ),
          ),
        );
        final cases = <(BenchmarkCase, bool)>[
          (
            BenchmarkCase(Effect.zoomOverEffect, mediaPairs.first),
            productionInputs,
          ),
          for (final effect in [
            Effect.glassEffect,
            Effect.radialBlurEffect,
            Effect.phosphorEffect,
          ])
            (BenchmarkCase(effect, mediaPairs.first), productionInputs),
          if (productionInputs) ...[
            (
              BenchmarkCase(
                Effect.zoomOverEffect,
                mediaPairs.first,
                injectStall: true,
              ),
              false,
            ),
            (BenchmarkCase(null, mediaPairs.first, photoMotion: true), false),
            (
              BenchmarkCase(
                Effect.blurFadeEffect,
                mediaPairs.first,
                blurProbe: BlurFadeProbe.reference,
              ),
              false,
            ),
            (
              BenchmarkCase(
                Effect.blurFadeEffect,
                mediaPairs.first,
                blurProbe: BlurFadeProbe.directImage,
              ),
              false,
            ),
            (
              BenchmarkCase(
                Effect.mosaicEffect,
                mediaPairs.first,
                mosaicProbe: MosaicProbe.points,
              ),
              false,
            ),
            (
              BenchmarkCase(
                Effect.accordionEffect,
                mediaPairs.first,
                compositionProbe: CompositionProbe.accordionReference,
              ),
              false,
            ),
            (BenchmarkCase(Effect.zoomOverEffect, mediaPairs[5]), false),
          ],
        ];
        for (final (test, ordinaryPhotos) in cases) {
          await _withFrames(tester, driver.prepare(test));
          final images = tester
              .widgetList<ImageWidget>(find.byType(ImageWidget))
              .toList();
          expect(images, isNotEmpty);
          final expectedViews = switch (test.effect?.type) {
            EffectType.glass => (8, 8),
            EffectType.radialBlur => (9, 9),
            EffectType.phosphor => (4, 1),
            _ => null,
          };
          if (expectedViews case (final outgoing, final incoming)) {
            expect(
              images.where(
                (image) => image.item.uri!.path.endsWith('photo_a.jpg'),
              ),
              hasLength(outgoing),
              reason: '${test.name} must retain every outgoing view',
            );
            expect(
              images.where(
                (image) => image.item.uri!.path.endsWith('photo_b.jpg'),
              ),
              hasLength(incoming),
              reason: '${test.name} must retain every incoming view',
            );
          }
          for (final element in find.byType(ImageWidget).evaluate()) {
            final ancestors = <Widget>[];
            element.visitAncestorElements((ancestor) {
              ancestors.add(ancestor.widget);
              return true;
            });
            // Inspect only wrappers added by viewport.load(), before its
            // KeyedSubtree. ImageWidget may manage its own repaint boundary.
            final inputBoundaries = ancestors
                .takeWhile((widget) => widget is! KeyedSubtree)
                .whereType<RepaintBoundary>();
            final sourceKeys = ancestors.whereType<KeyedSubtree>().where(
              (widget) => widget.key is GlobalKey,
            );
            final bitmapDiagnosticSource =
                test.blurProbe?.needsBitmap == true &&
                (element.widget as ImageWidget).item.uri!.path.endsWith(
                  'photo_a.jpg',
                );
            expect(sourceKeys, hasLength(bitmapDiagnosticSource ? 1 : 0));
            if (ordinaryPhotos) {
              final input = ancestors.first as SizedBox;
              expect(input.width, 160);
              expect(input.height, 100);
              expect(inputBoundaries, isEmpty);
            } else {
              expect(ancestors.first, isA<ColoredBox>());
              expect(inputBoundaries, hasLength(1));
            }
          }
          for (final image in images.where((image) => !image.isGif)) {
            expect(image.preparedBitmap, isNotNull);
          }
          await _withFrames(tester, driver.release());
          expect(find.byType(ImageWidget), findsNothing);
          expect(images.every((image) => image.preparedBitmap == null), isTrue);
          expect(tester.takeException(), isNull);
        }
        await tester.pumpWidget(const SizedBox());
        expect(tester.takeException(), isNull);
      },
    );
  }

  testWidgets(
    'viewport starts automatically after layout without input controls',
    (tester) async {
      var starts = 0;
      tester.view.physicalSize = const Size(2560, 1600);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: MediaQuery.fromView(
            view: tester.view,
            child: BenchmarkViewport(
              config: BenchmarkConfig(),
              catalog: MediaCatalog(Directory.systemTemp, []),
              reportDirectory: Directory.systemTemp,
              onReady: (driver) async {
                starts++;
                expect(driver.display['physical_width'], 2560);
                expect(driver.display['physical_height'], 1600);
              },
            ),
          ),
        ),
      );
      await tester.pump();
      expect(starts, 1);
      expect(find.byType(TextButton), findsNothing);
      expect(find.byType(Slider), findsNothing);
      await tester.pumpWidget(const SizedBox());
      expect(tester.takeException(), isNull);
    },
  );
}
