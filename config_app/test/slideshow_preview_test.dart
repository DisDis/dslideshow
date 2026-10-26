import 'dart:ui' as ui;
import 'dart:typed_data';

import 'package:config_app/features/config/presentation/wigdgets/slideshow_preview.dart';
import 'package:config_app/features/config/presentation/wigdgets/preview_editor_layout.dart';
import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_flutter/effect.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/widgets/fixed_animation_controller.dart';
import 'package:dslideshow_i18n/i18n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
    'photo preview applies draft background color and blurred layer opacity',
    (tester) async {
      final recorder = ui.PictureRecorder();
      Canvas(recorder).drawColor(Colors.white, BlendMode.src);
      final picture = recorder.endRecording();
      final source = (await tester.runAsync(() => picture.toImage(10, 10)))!;
      final png = (await tester.runAsync(
        () => source.toByteData(format: ui.ImageByteFormat.png),
      ))!;
      final provider = MemoryImage(
        Uint8List.fromList(png.buffer.asUint8List()),
      );
      source.dispose();
      picture.dispose();
      final config = SlideShowConfig.fromJson({
        'transitionTimeMs': 10,
        'displayTimeMs': 5000,
        'isBlurredBackground': false,
        'backgroundColor': 0xffff0000,
      });
      final images = <ImageProvider>[provider];
      final key = GlobalKey<SlideshowPreviewState>();
      Widget app() => MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: SingleChildScrollView(
            child: SlideshowPreview(key: key, config: config, images: images),
          ),
        ),
      );
      await tester.pumpWidget(app());
      await tester.runAsync(() => precacheImage(provider, key.currentContext!));
      Future<void> finish() async {
        for (var i = 0; i < 8; i++) {
          await tester.runAsync(
            () => Future<void>.delayed(const Duration(milliseconds: 20)),
          );
          await tester.pump(const Duration(milliseconds: 16));
        }
      }

      Future<List<int>> corner() async {
        final image = tester
            .widget<RawImage>(find.byType(RawImage).last)
            .image!;
        final data = (await tester.runAsync(
          () => image.toByteData(format: ui.ImageByteFormat.rawRgba),
        ))!;
        return data.buffer.asUint8List().take(4).toList();
      }

      await finish();
      expect(await corner(), [255, 0, 0, 255]);
      config.backgroundColor = 0xff0000ff;
      config.isBlurredBackground = true;
      config.backgroundBlurSigma = 0;
      config.backgroundOpacity = .5;
      await tester.pumpWidget(app());
      await finish();
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
    'Preview applies effects immediately and keeps configured timing and clock',
    (tester) async {
      final recorder = ui.PictureRecorder();
      Canvas(recorder).drawColor(Colors.white, BlendMode.src);
      final picture = recorder.endRecording();
      final bitmap = await tester.runAsync(() => picture.toImage(2, 2));
      final png = await tester.runAsync(
        () => bitmap!.toByteData(format: ui.ImageByteFormat.png),
      );
      final image = MemoryImage(Uint8List.fromList(png!.buffer.asUint8List()));
      bitmap!.dispose();
      picture.dispose();
      final config = SlideShowConfig.fromJson({
        'transitionTimeMs': 1000,
        'displayTimeMs': 9123,
      });
      final key = GlobalKey<SlideshowPreviewState>();
      Widget app() => MaterialApp(
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        home: Scaffold(
          body: SingleChildScrollView(
            child: SlideshowPreview(key: key, config: config, images: [image]),
          ),
        ),
      );
      await tester.pumpWidget(app());
      await tester.runAsync(() => precacheImage(image, key.currentContext!));
      await tester.pump();
      key.currentState!.onChanged(Effect.wipeLeftEffect);
      await tester.pump();
      await tester.pump();
      expect(key.currentState!.currentEffect, Effect.wipeLeftEffect);
      expect(find.byType(ClipPath), findsOneWidget);
      final clock = tester
          .widgetList<AnimatedBuilder>(find.byType(AnimatedBuilder))
          .map((w) => w.animation)
          .whereType<FixedAnimationController>()
          .single;
      expect(clock.duration, const Duration(milliseconds: 1000));
      config.transitionTimeMs = 2300;
      await tester.pumpWidget(app());
      expect(clock.duration, const Duration(milliseconds: 2300));
      expect(find.textContaining('9123'), findsOneWidget);
      expect(tester.takeException(), isNull);
      await tester.pumpWidget(const SizedBox());
    },
  );
  testWidgets(
    'preview renders both waves, camera and safely discards rapid selections',
    (tester) async {
      final recorder = ui.PictureRecorder();
      Canvas(recorder).drawColor(Colors.orange, BlendMode.src);
      final picture = recorder.endRecording();
      final bitmap = (await tester.runAsync(() => picture.toImage(160, 100)))!;
      final data = (await tester.runAsync(
        () => bitmap.toByteData(format: ui.ImageByteFormat.png),
      ))!;
      final image = MemoryImage(Uint8List.fromList(data.buffer.asUint8List()));
      bitmap.dispose();
      picture.dispose();
      final config = SlideShowConfig.fromJson({
        'transitionTimeMs': 100,
        'displayTimeMs': 5000,
        'photoMotion': {'mode': 'kenBurns'},
      });
      final key = GlobalKey<SlideshowPreviewState>();
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          home: Scaffold(
            body: SingleChildScrollView(
              child: SlideshowPreview(
                key: key,
                config: config,
                images: [image],
              ),
            ),
          ),
        ),
      );
      await tester.runAsync(() => precacheImage(image, key.currentContext!));
      Future<void> advance() async {
        await tester.runAsync(
          () => Future<void>.delayed(const Duration(milliseconds: 20)),
        );
        for (var i = 0; i < 25; i++) {
          await tester.pump(const Duration(milliseconds: 16));
        }
      }

      await advance();
      key.currentState!.onChanged(Effect.rippleRevealEffect);
      await advance();
      key.currentState!.onChanged(Effect.waterRefractionEffect);
      await advance();
      expect(find.textContaining('requires two static photos'), findsOneWidget);
      expect(
        tester
            .widget<TextField>(find.byKey(const ValueKey('preview-video-url')))
            .enabled,
        isFalse,
      );
      expect(find.byType(RawImage), findsWidgets);
      tester
          .widget<DropdownButtonFormField<PreviewAspectRatio>>(
            find.byKey(const ValueKey('preview-aspect')),
          )
          .onChanged!(PreviewAspectRatio.square);
      await tester.pump();
      await advance();
      expect(tester.takeException(), isNull);
      key.currentState!.onChanged(Effect.noiseDissolveEffect);
      key.currentState!.onChanged(Effect.waterRefractionEffect);
      await tester.pumpWidget(const SizedBox());
      await tester.runAsync(
        () => Future<void>.delayed(const Duration(milliseconds: 30)),
      );
      await tester.pump();
      expect(tester.takeException(), isNull);
    },
  );
}
