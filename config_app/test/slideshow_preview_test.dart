import 'dart:async';
import 'dart:ui' as ui;

import 'package:config_app/features/config/presentation/sessions/preview_photo.dart';
import 'package:config_app/features/config/presentation/wigdgets/preview_editor_layout.dart';
import 'package:config_app/features/config/presentation/wigdgets/slideshow_preview.dart';
import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_flutter/effect.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/widgets/photo_motion.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/widgets/fixed_animation_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'support/controlled_preview_asset_bundle.dart';
import 'support/slideshow_preview_harness.dart';

Future<ControlledPreviewAssetBundle> _bundle(
  WidgetTester tester, {
  List<Color> colors = const [Colors.red, Colors.blue, Colors.green],
  bool patterned = false,
  Size sourceSize = const Size(40, 25),
}) async => (await tester.runAsync(
  () => ControlledPreviewAssetBundle.create(
    colors: colors,
    patterned: patterned,
    sourceSize: sourceSize,
  ),
))!;

SlideShowConfig _config({int duration = 1000, bool motion = false}) =>
    SlideShowConfig.fromJson({
      'effects': {'defaultDurationMs': duration},
      'displayTimeMs': 60000,
      'isBlurredBackground': false,
      'photoMotion': {'mode': motion ? 'kenBurns' : 'off'},
    });

void main() {
  testWidgets('invalid global durations keep preview usable for repair', (
    tester,
  ) async {
    final bundle = await _bundle(tester);
    for (final duration in [-1, 0, 3600001]) {
      await tester.pumpWidget(
        previewApp(
          bundle,
          TickerMode(
            enabled: false,
            child: SlideshowPreview(config: _config(duration: duration)),
          ),
        ),
      );
      expect(previewClock(tester).duration, const Duration(milliseconds: 1000));
      expect(tester.takeException(), isNull);
      await tester.pumpWidget(const SizedBox());
    }
  });

  testWidgets('loading preserves preview height and control positions', (
    tester,
  ) async {
    final bundle = await _bundle(tester);
    final gate = Completer<void>();
    bundle.gates[PreviewPhoto.mountainLake] = gate;
    await tester.pumpWidget(
      previewApp(
        bundle,
        SlideshowPreview(
          config: SlideShowConfig.fromJson({'displayTimeMs': 9999}),
        ),
      ),
    );
    await waitForPreview(tester, () => bundle.requests.isNotEmpty);
    expect(find.byType(LinearProgressIndicator), findsOneWidget);
    final loadingSize = tester.getSize(find.byType(SlideshowPreview));
    final summary = find.textContaining('9999');
    final loadingPosition = tester.getTopLeft(summary);
    gate.complete();
    await preparePreview(tester);
    expect(tester.getSize(find.byType(SlideshowPreview)), loadingSize);
    expect(tester.getTopLeft(summary), loadingPosition);
    final photos = previewPhotos(tester);
    await tester.pumpWidget(const SizedBox());
    for (final photo in photos) {
      expectPhotoReleased(photo);
    }
    expect(tester.takeException(), isNull);
  });

  testWidgets(
    'editor starts between full-size photos and repeats the same pair',
    (tester) async {
      final bundle = await _bundle(tester);
      final config = _config();
      await tester.pumpWidget(
        previewApp(
          bundle,
          SlideshowPreview(config: config, selectedEffect: Effect.fadeEffect),
        ),
      );
      await preparePreview(tester);
      final initial = previewPhotos(tester);
      expect(initial, hasLength(2));
      expect(
        initial.every((photo) => photo.width == 2560 && photo.height == 1600),
        true,
      );
      expect(await previewColors(tester), [
        [244, 67, 54, 255],
        [33, 150, 243, 255],
      ]);
      final clock = previewClock(tester)..stop();
      clock.value = 1;
      await tester.pump();
      expectPhotoReleased(initial.first);
      expect(initial.last.debugDisposed, false);
      expect(await previewColors(tester), [
        [33, 150, 243, 255],
      ]);
      await tester.ensureVisible(find.byKey(const ValueKey('preview-repeat')));
      expect(find.text('Repeat'), findsOneWidget);
      final before = config.toJson();
      await tester.tap(find.byKey(const ValueKey('preview-repeat')));
      await preparePreview(tester);
      expect(clock.value, 0);
      for (final photo in initial) {
        expectPhotoReleased(photo);
      }
      expect(await previewColors(tester), [
        [244, 67, 54, 255],
        [33, 150, 243, 255],
      ]);
      expect(bundle.requests.take(2), [
        PreviewPhoto.mountainLake,
        PreviewPhoto.forestTrail,
      ]);
      final repeated = previewPhotos(tester);
      expect(config.toJson(), before);
      await tester.pumpWidget(const SizedBox());
      for (final photo in repeated) {
        expectPhotoReleased(photo);
      }
      expect(config.toJson(), before);
      expect(tester.takeException(), isNull);
    },
  );

  for (final descriptor in [
    Effect.radialBlurEffect,
    Effect.glassEffect,
    const Effect(
      EffectType.glass,
      options: GlassEffectOptions(axis: EffectAxis.horizontal),
    ),
    Effect.filmDissolveEffect.canonical,
  ]) {
    testWidgets(
      '${descriptor.name}/${descriptor.options.toJson()} borrows pixels and freezes outgoing motion',
      (tester) async {
        final bundle = await _bundle(tester);
        final key = GlobalKey<SlideshowPreviewState>();
        await tester.pumpWidget(
          previewApp(
            bundle,
            SlideshowPreview(
              key: key,
              config: _config(motion: true),
              selectedEffect: descriptor,
            ),
          ),
        );
        await preparePreview(tester);
        expect(find.byKey(const ValueKey('preview-error')), findsNothing);
        final outgoing = previewPhotos(tester).single;
        expect(outgoing.width, 2560);
        expect(outgoing.height, 1600);
        final clock = previewClock(tester)..stop();
        clock.value = .5;
        await tester.pump();
        expect(find.byType(RawImage), findsNothing);
        expect(outgoing.debugDisposed, false);
        clock.value = 1;
        await tester.pump();
        final incoming = previewPhotos(tester).single;
        expectPhotoReleased(outgoing);
        expect(incoming.debugDisposed, false);
        // Advance virtual time until the actual fixed-step motion leaves zero.
        var frames = 0;
        while (tester
                    .widget<PhotoMotionFrame>(find.byType(PhotoMotionFrame))
                    .progress ==
                0 &&
            frames++ < 100) {
          await tester.pump(const Duration(milliseconds: 16));
        }
        final camera = tester
            .widget<PhotoMotionFrame>(find.byType(PhotoMotionFrame))
            .progress;
        expect(camera, greaterThan(0));
        key.currentState!.onChanged(descriptor);
        await preparePreview(tester);
        clock.stop();
        expect(
          tester
              .widget<PhotoMotionFrame>(find.byType(PhotoMotionFrame))
              .progress,
          camera,
        );
        clock.value = .5;
        await tester.pump(const Duration(milliseconds: 16));
        expect(find.byType(RawImage), findsNothing);
        clock.value = 0;
        await tester.pump();
        expect(
          tester
              .widget<PhotoMotionFrame>(find.byType(PhotoMotionFrame))
              .progress,
          camera,
        );
        key.currentState!.onChanged(Effect.waterRefractionEffect);
        key.currentState!.onChanged(descriptor);
        await tester.pumpWidget(const SizedBox());
        await tester.runAsync(() => Future<void>(() {}));
        await tester.pump();
        expectPhotoReleased(incoming);
        expect(tester.takeException(), isNull);
      },
    );
  }

  testWidgets(
    'fallback duration is captured before asynchronous asset preparation',
    (tester) async {
      final bundle = await _bundle(tester);
      final gate = Completer<void>();
      for (final photo in PreviewPhoto.values) {
        bundle.gates[photo] = gate;
      }
      final key = GlobalKey<SlideshowPreviewState>();
      final config = _config(duration: 900);
      Widget app() =>
          previewApp(bundle, SlideshowPreview(key: key, config: config));
      await tester.pumpWidget(app());
      key.currentState!.onChanged(
        const Effect(
          EffectType.waterRefraction,
          options: WaterRefractionEffectOptions(durationMs: 2500),
        ),
      );
      await tester.pump();
      config.effects = config.effects.copyWith(defaultDurationMs: 1200);
      await tester.pumpWidget(app());
      gate.complete();
      await preparePreview(tester);
      expect(previewClock(tester).duration, const Duration(milliseconds: 900));
      await tester.pumpWidget(const SizedBox());
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets(
    'prepared photo applies draft background and blurred layer opacity',
    (tester) async {
      final bundle = await _bundle(
        tester,
        colors: const [Colors.white],
        sourceSize: const Size(10, 10),
      );
      final key = GlobalKey<SlideshowPreviewState>();
      final config = _config(duration: 10)..backgroundColor = 0xffff0000;
      Widget app() =>
          previewApp(bundle, SlideshowPreview(key: key, config: config));
      Future<List<int>> corner() async {
        final photo = previewPhotos(tester).last;
        final data = (await tester.runAsync(
          () => photo.toByteData(format: ui.ImageByteFormat.rawRgba),
        ))!;
        return data.buffer.asUint8List().take(4).toList();
      }

      await tester.pumpWidget(app());
      await finishPreview(tester);
      expect(await corner(), [255, 0, 0, 255]);
      config.backgroundColor = 0xff0000ff;
      config.isBlurredBackground = true;
      config.backgroundBlurSigma = 0;
      config.backgroundOpacity = .5;
      await tester.pumpWidget(app());
      await tester.pump(const Duration(milliseconds: 150));
      await finishPreview(tester);
      final blended = await corner();
      expect(blended[0], closeTo(128, 1));
      expect(blended[1], closeTo(128, 1));
      expect(blended[2], 255);
      expect(config.backgroundOpacity, .5);
      await tester.pumpWidget(const SizedBox());
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets(
    'effect and duration changes keep the current transition snapshot',
    (tester) async {
      final bundle = await _bundle(tester);
      final key = GlobalKey<SlideshowPreviewState>();
      final config = _config()..displayTimeMs = 9123;
      Widget app() =>
          previewApp(bundle, SlideshowPreview(key: key, config: config));
      await tester.pumpWidget(app());
      await preparePreview(tester);
      const descriptor = Effect(
        EffectType.revealMask,
        options: RevealMaskEffectOptions(direction: EffectDirection.left),
      );
      key.currentState!.onChanged(descriptor);
      await preparePreview(tester);
      expect(key.currentState!.currentEffect, descriptor);
      expect(find.byType(ClipPath), findsOneWidget);
      final clock = previewClock(tester)..stop();
      expect(clock.duration, const Duration(milliseconds: 1000));
      config.effects = config.effects.copyWith(defaultDurationMs: 2300);
      await tester.pumpWidget(app());
      expect(clock.duration, const Duration(milliseconds: 1000));
      await tester.pump(const Duration(milliseconds: 150));
      await waitForPreview(
        tester,
        () =>
            clock.duration == const Duration(milliseconds: 2300) &&
            find.byType(LinearProgressIndicator).evaluate().isEmpty,
      );
      expect(find.textContaining('9123'), findsOneWidget);
      await tester.pumpWidget(const SizedBox());
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets('wave selection and aspect changes use only bundled photos', (
    tester,
  ) async {
    final bundle = await _bundle(tester);
    final key = GlobalKey<SlideshowPreviewState>();
    await tester.pumpWidget(
      previewApp(
        bundle,
        SlideshowPreview(key: key, config: _config(duration: 100)),
      ),
    );
    await finishPreview(tester);
    for (final descriptor in [
      Effect.rippleRevealEffect,
      Effect.waterRefractionEffect,
    ]) {
      key.currentState!.onChanged(descriptor);
      await finishPreview(tester);
    }
    expect(find.byKey(const ValueKey('preview-video-url')), findsNothing);
    expect(
      find.byKey(const ValueKey('preview-video-unavailable')),
      findsNothing,
    );
    tester
        .widget<DropdownButtonFormField<PreviewAspectRatio>>(
          find.byKey(const ValueKey('preview-aspect')),
        )
        .onChanged!(PreviewAspectRatio.square);
    await finishPreview(tester);
    final current = previewPhotos(tester).single;
    expect(current.width, 2560);
    expect(current.height, 2560);
    expect(bundle.requests.every(PreviewPhoto.values.contains), true);
    key.currentState!.onChanged(Effect.noiseDissolveEffect);
    key.currentState!.onChanged(Effect.waterRefractionEffect);
    await tester.pumpWidget(const SizedBox());
    expectPhotoReleased(current);
    expect(tester.takeException(), isNull);
  });

  for (final fails in [false, true]) {
    testWidgets(
      'late cancelled asset ${fails ? "failure" : "success"} cannot replace the new frame',
      (tester) async {
        final bundle = await _bundle(tester);
        final gate = Completer<void>();
        bundle.gates[PreviewPhoto.mountainLake] = gate;
        final key = GlobalKey<SlideshowPreviewState>();
        await tester.pumpWidget(
          previewApp(bundle, SlideshowPreview(key: key, config: _config())),
        );
        await waitForPreview(tester, () => bundle.requests.isNotEmpty);
        key.currentState!.onChanged(Effect.fadeEffect);
        await preparePreview(tester);
        previewClock(tester).stop();
        expect(await previewColors(tester), [
          [33, 150, 243, 255],
        ]);
        if (fails) {
          bundle.failures[PreviewPhoto.mountainLake] = StateError(
            'private asset failure',
          );
        }
        gate.complete();
        await waitForPreview(
          tester,
          () => bundle.settled.contains(PreviewPhoto.mountainLake),
        );
        await tester.runAsync(() => Future<void>(() {}));
        await tester.pump();
        expect(await previewColors(tester), [
          [33, 150, 243, 255],
        ]);
        expect(find.byKey(const ValueKey('preview-error')), findsNothing);
        expect(tester.takeException(), isNull);
        final photos = previewPhotos(tester);
        await tester.pumpWidget(const SizedBox());
        for (final photo in photos) {
          expectPhotoReleased(photo);
        }
      },
    );
  }

  for (final fails in [false, true]) {
    testWidgets(
      'unmount cancels asset owner before late ${fails ? "failure" : "success"}',
      (tester) async {
        final bundle = await _bundle(tester);
        final gate = Completer<void>();
        bundle.gates[PreviewPhoto.mountainLake] = gate;
        await tester.pumpWidget(
          previewApp(bundle, SlideshowPreview(config: _config())),
        );
        await waitForPreview(tester, () => bundle.requests.isNotEmpty);
        await tester.pumpWidget(const SizedBox());
        if (fails) {
          bundle.failures[PreviewPhoto.mountainLake] = StateError(
            'late closed asset',
          );
        }
        gate.complete();
        await waitForPreview(
          tester,
          () => bundle.settled.contains(PreviewPhoto.mountainLake),
        );
        await tester.runAsync(() => Future<void>(() {}));
        await tester.pump();
        expect(bundle.requests, [PreviewPhoto.mountainLake]);
        expect(find.byType(SlideshowPreview), findsNothing);
        expect(tester.takeException(), isNull);
      },
    );
  }

  testWidgets(
    'pause cancels pending asset and preserves the current photo and motion pose',
    (tester) async {
      final bundle = await _bundle(tester);
      final key = GlobalKey<SlideshowPreviewState>();
      await tester.pumpWidget(
        previewApp(
          bundle,
          SlideshowPreview(
            key: key,
            config: _config(duration: 100, motion: true),
            selectedEffect: Effect.fadeEffect,
          ),
        ),
      );
      await finishPreview(tester);
      await tester.pump(const Duration(milliseconds: 16));
      final current = previewPhotos(tester).single;
      final gate = Completer<void>();
      bundle.gates[PreviewPhoto.coastalCliffs] = gate;
      key.currentState!.onChanged(Effect.fadeEffect);
      await waitForPreview(
        tester,
        () => bundle.requests.contains(PreviewPhoto.coastalCliffs),
      );
      final pose = tester
          .widget<PhotoMotionFrame>(find.byType(PhotoMotionFrame))
          .progress;
      await tester.ensureVisible(find.byKey(const ValueKey('preview-pause')));
      await tester.tap(find.byKey(const ValueKey('preview-pause')));
      await tester.pump();
      gate.complete();
      await waitForPreview(
        tester,
        () => bundle.settled.contains(PreviewPhoto.coastalCliffs),
      );
      await tester.pump(const Duration(seconds: 61));
      expect(previewPhotos(tester).single, same(current));
      expect(current.debugDisposed, false);
      expect(
        tester.widget<PhotoMotionFrame>(find.byType(PhotoMotionFrame)).progress,
        pose,
      );
      expect(find.byType(LinearProgressIndicator), findsNothing);
      expect(bundle.requests, [
        PreviewPhoto.mountainLake,
        PreviewPhoto.forestTrail,
        PreviewPhoto.coastalCliffs,
      ]);
      await tester.tap(find.byKey(const ValueKey('preview-pause')));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 16));
      expect(
        tester.widget<PhotoMotionFrame>(find.byType(PhotoMotionFrame)).progress,
        greaterThan(pose),
      );
      await tester.pumpWidget(const SizedBox());
      expectPhotoReleased(current);
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets(
    'unmount in promotion frame releases current, incoming and retired owners',
    (tester) async {
      final bundle = await _bundle(tester);
      final visible = ValueNotifier(true);
      addTearDown(visible.dispose);
      await tester.pumpWidget(
        previewApp(
          bundle,
          ValueListenableBuilder(
            valueListenable: visible,
            builder: (_, show, _) => show
                ? SlideshowPreview(
                    config: _config(motion: true),
                    selectedEffect: Effect.fadeEffect,
                  )
                : const SizedBox(),
          ),
        ),
      );
      await preparePreview(tester);
      final photos = previewPhotos(tester);
      expect(photos, hasLength(2));
      final clock = previewClock(tester)..stop();
      clock.addStatusListener((status) {
        if (status == AnimationStatus.completed) visible.value = false;
      });
      clock.value = 1;
      await tester.pump();
      expect(find.byType(SlideshowPreview), findsNothing);
      for (final photo in photos) {
        expectPhotoReleased(photo);
      }
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets('Repeat reproduces the same procedural frame and pair', (
    tester,
  ) async {
    final bundle = await _bundle(tester, patterned: true);
    final key = GlobalKey<SlideshowPreviewState>();
    final capture = GlobalKey();
    final config = _config(motion: true);
    await tester.pumpWidget(
      previewApp(
        bundle,
        RepaintBoundary(
          key: capture,
          child: SlideshowPreview(
            key: key,
            config: config,
            selectedEffect: Effect.noiseDissolveEffect,
          ),
        ),
      ),
    );
    await preparePreview(tester);
    final clock = previewClock(tester)..stop();
    clock.value = .37;
    await tester.pump();
    final before = await previewViewportPixels(
      tester,
      capture,
      find.byType(DevicePreviewViewport),
    );
    clock.value = 1;
    await tester.pump();
    FixedAnimationController motionClock() => tester
        .widgetList<AnimatedBuilder>(find.byType(AnimatedBuilder))
        .where((builder) => builder.child != null)
        .map((builder) => builder.animation)
        .whereType<FixedAnimationController>()
        .single;
    Future<void> setMotionPose() async {
      motionClock().stop();
      motionClock().value = .5;
      await tester.pump();
      final camera = tester
          .widget<Transform>(
            find
                .descendant(
                  of: find.byType(PhotoMotionFrame),
                  matching: find.byType(Transform),
                )
                .first,
          )
          .transform;
      // The pair's incoming photo keeps sequence index 1: negative X/Y motion.
      // At t=.5, maxZoom=1.06 gives scale=1.03 in the 2560x1600 viewport.
      expect(camera.storage[0], closeTo(1.03, 1e-12));
      expect(camera.storage[5], closeTo(1.03, 1e-12));
      expect(camera.storage[12], closeTo(-26.88, 1e-9));
      expect(camera.storage[13], closeTo(-10.8, 1e-9));
    }

    await setMotionPose();
    final motionBefore = await previewViewportPixels(
      tester,
      capture,
      find.byType(DevicePreviewViewport),
    );
    await tester.ensureVisible(find.byKey(const ValueKey('preview-repeat')));
    await tester.tap(find.byKey(const ValueKey('preview-repeat')));
    await preparePreview(tester);
    clock.stop();
    clock.value = .37;
    await tester.pump();
    final after = await previewViewportPixels(
      tester,
      capture,
      find.byType(DevicePreviewViewport),
    );
    expect(after, before);
    clock.value = 1;
    await tester.pump();
    await setMotionPose();
    final motionAfter = await previewViewportPixels(
      tester,
      capture,
      find.byType(DevicePreviewViewport),
    );
    expect(motionAfter, motionBefore);
    expect(
      bundle.requests.toSet(),
      containsAll([PreviewPhoto.mountainLake, PreviewPhoto.forestTrail]),
    );
    await tester.pumpWidget(const SizedBox());
    expect(tester.takeException(), isNull);
  });
}
