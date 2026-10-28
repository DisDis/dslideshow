import 'dart:async';
import 'dart:ui' as ui;

import 'package:config_app/features/config/presentation/sessions/asset_photo_slide_session.dart';
import 'package:config_app/features/config/presentation/sessions/preview_photo.dart';
import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/sessions/slide_session.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/widgets/photo_motion.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'support/controlled_preview_asset_bundle.dart';

Future<void> _until(
  WidgetTester tester,
  bool Function() ready,
  String description,
) async {
  final watch = Stopwatch()..start();
  while (!ready()) {
    if (watch.elapsed >= const Duration(seconds: 10)) {
      fail('Timed out waiting for $description');
    }
    await tester.runAsync(() => Future<void>(() {}));
    await tester.pump();
  }
}

Future<BuildContext> _mount(
  WidgetTester tester,
  AssetBundle bundle, {
  Widget child = const SizedBox(),
}) async {
  late BuildContext context;
  await tester.pumpWidget(
    DefaultAssetBundle(
      bundle: bundle,
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Builder(
          builder: (value) {
            context = value;
            return Center(child: SizedBox.square(dimension: 120, child: child));
          },
        ),
      ),
    ),
  );
  return context;
}

void main() {
  tearDown(() {
    PaintingBinding.instance.imageCache.clear();
    PaintingBinding.instance.imageCache.clearLiveImages();
  });

  testWidgets('all catalog photos are bundled and include a portrait source', (
    tester,
  ) async {
    for (final photo in PreviewPhoto.values) {
      final data = (await tester.runAsync(
        () => rootBundle
            .load(photo.assetPath)
            .timeout(const Duration(seconds: 10)),
      ))!;
      final bytes = data.buffer.asUint8List(
        data.offsetInBytes,
        data.lengthInBytes,
      );
      expect(bytes.take(2), [0xff, 0xd8], reason: photo.assetPath);
      final codec = (await tester.runAsync(
        () => ui.instantiateImageCodec(bytes),
      ))!;
      try {
        final frame = (await tester.runAsync(codec.getNextFrame))!;
        try {
          expect(frame.image.width, greaterThanOrEqualTo(1024));
          expect(frame.image.height, greaterThanOrEqualTo(1024));
          expect(
            frame.image.height > frame.image.width,
            photo == PreviewPhoto.forestTrail,
            reason: 'The portrait source demonstrates contain/background',
          );
        } finally {
          frame.image.dispose();
        }
      } finally {
        codec.dispose();
      }
    }
  });

  testWidgets(
    'session snapshots config, commits motion once and owns borrowed pixels',
    (tester) async {
      final bundle = (await tester.runAsync(
        () => ControlledPreviewAssetBundle.create(
          colors: const [Color(0xffff0000)],
        ),
      ))!;
      final context = await _mount(tester, bundle);
      final config = SlideShowConfig.fromJson({
        'backgroundColor': 0xff123456,
        'isBlurredBackground': false,
        'displayTimeMs': 100,
        'photoMotion': {'mode': 'kenBurns', 'maxZoom': 1.04},
      });
      final session = AssetPhotoSlideSession(
        PreviewPhoto.mountainLake,
        sequenceIndex: 4,
        config: config,
        size: const Size.square(120),
        vsync: const TestVSync(),
      );
      addTearDown(() => tester.runAsync(session.dispose));
      config.backgroundColor = 0xff00ff00;
      config.isBlurredBackground = true;
      config.photoMotion.mode = PhotoMotionMode.off;
      config.photoMotion.maxZoom = 1.15;
      expect(
        await tester.runAsync(
          () => session.prepare(context).timeout(const Duration(seconds: 10)),
        ),
        isTrue,
      );
      final prepared = session.createEffectInput(session.size);
      final bitmap = prepared.photo!.bitmap;
      expect(prepared.photo!.camera.isIdentity, isTrue);
      final pixels = (await tester.runAsync(
        () => bitmap.toByteData(format: ui.ImageByteFormat.rawRgba),
      ))!;
      List<int> pixel(int x, int y) {
        final offset = (y * bitmap.width + x) * 4;
        return List.generate(4, (channel) => pixels.getUint8(offset + channel));
      }

      expect(pixel(5, 5), [0x12, 0x34, 0x56, 0xff]);
      expect(pixel(60, 60), [0xff, 0, 0, 0xff]);
      await _mount(tester, bundle, child: session.view);
      expect(find.byType(PhotoMotionFrame), findsNothing);
      session.commitPreparation();
      final committedView = session.view;
      session.commitPreparation();
      expect(identical(session.view, committedView), isTrue);
      await _mount(tester, bundle, child: session.view);
      expect(find.byType(PhotoMotionFrame), findsOneWidget);
      session.setActivity(
        role: SlideSessionRole.incoming,
        playing: true,
        screenOn: true,
      );
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 32));
      expect(
        session.createEffectInput(session.size).photo!.camera.isIdentity,
        isTrue,
      );
      session.setActivity(
        role: SlideSessionRole.current,
        playing: true,
        screenOn: true,
      );
      var waited = Duration.zero;
      while (session.createEffectInput(session.size).photo!.camera.isIdentity) {
        if (waited >= const Duration(seconds: 1)) {
          fail('Accepted current photo did not start its camera');
        }
        const frame = Duration(milliseconds: 16);
        await tester.pump(frame);
        waited += frame;
      }
      session.setActivity(
        role: SlideSessionRole.outgoing,
        playing: true,
        screenOn: true,
      );
      final frozen = session.createEffectInput(session.size);
      final frozenCamera = frozen.photo!.camera;
      await tester.pump(const Duration(milliseconds: 32));
      expect(
        session.createEffectInput(session.size).photo!.camera,
        frozenCamera,
      );
      session.setActivity(
        role: SlideSessionRole.current,
        playing: true,
        screenOn: true,
      );
      waited = Duration.zero;
      while (session.createEffectInput(session.size).photo!.camera.scale <
          1.04) {
        if (waited >= const Duration(seconds: 1)) {
          fail('Camera did not reach the captured zoom');
        }
        const frame = Duration(milliseconds: 16);
        await tester.pump(frame);
        waited += frame;
      }
      expect(session.createEffectInput(session.size).photo!.camera.scale, 1.04);
      expect(frozen.photo!.camera, frozenCamera);
      expect(bitmap.debugDisposed, isFalse);
      await tester.pumpWidget(const SizedBox());
      final disposal = tester.runAsync(session.dispose);
      expect(bitmap.debugDisposed, isTrue);
      expect(session.createEffectInput(session.size).photo, isNull);
      await disposal;
      await tester.runAsync(session.dispose);
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets(
    'cancelling pending asset finishes before a late load completes',
    (tester) async {
      final bundle = (await tester.runAsync(
        ControlledPreviewAssetBundle.create,
      ))!;
      final gate = Completer<void>();
      bundle.gates[PreviewPhoto.mountainLake] = gate;
      final context = await _mount(tester, bundle);
      final session = AssetPhotoSlideSession(
        PreviewPhoto.mountainLake,
        sequenceIndex: 0,
        config: SlideShowConfig.fromJson({}),
        size: const Size.square(120),
        vsync: const TestVSync(),
      );
      addTearDown(() => tester.runAsync(session.dispose));
      final pending = session.prepare(context);
      await _until(tester, () => bundle.requests.isNotEmpty, 'asset request');
      await tester.runAsync(session.dispose);
      expect(await pending, isFalse);
      gate.complete();
      await _until(
        tester,
        () => bundle.completed.isNotEmpty,
        'cancelled asset load to finish',
      );
      session.commitPreparation();
      expect(session.createEffectInput(session.size).photo, isNull);
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets('asset timeout surfaces once and cannot accept a late result', (
    tester,
  ) async {
    final bundle = (await tester.runAsync(
      ControlledPreviewAssetBundle.create,
    ))!;
    final gate = Completer<void>();
    bundle.gates[PreviewPhoto.mountainLake] = gate;
    final context = await _mount(tester, bundle);
    final session = AssetPhotoSlideSession(
      PreviewPhoto.mountainLake,
      sequenceIndex: 0,
      config: SlideShowConfig.fromJson({}),
      size: const Size.square(120),
      vsync: const TestVSync(),
    );
    addTearDown(() => tester.runAsync(session.dispose));
    final failure = expectLater(
      session.prepare(context),
      throwsA(isA<TimeoutException>()),
    );
    await _until(tester, () => bundle.requests.isNotEmpty, 'asset request');
    await tester.pump(const Duration(seconds: 30));
    await failure;
    await tester.runAsync(session.dispose);
    gate.complete();
    await _until(
      tester,
      () => bundle.completed.isNotEmpty,
      'timed out asset load to finish',
    );
    expect(session.createEffectInput(session.size).photo, isNull);
    expect(bundle.requests, [PreviewPhoto.mountainLake]);
    expect(tester.takeException(), isNull);
  });
}
