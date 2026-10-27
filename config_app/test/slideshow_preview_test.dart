import 'dart:ui' as ui;

import 'package:config_app/features/config/presentation/wigdgets/slideshow_preview.dart';
import 'package:config_app/features/config/presentation/wigdgets/preview_editor_layout.dart';
import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_flutter/effect.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/widgets/fixed_animation_controller.dart';
import 'package:dslideshow_i18n/i18n.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
    'loading indicator preserves preview height and control positions',
    (tester) async {
      final recorder = ui.PictureRecorder();
      Canvas(recorder).drawColor(Colors.white, BlendMode.src);
      final picture = recorder.endRecording();
      final image = (await tester.runAsync(() => picture.toImage(2, 2)))!;
      picture.dispose();
      final provider = _ControlledProvider();
      await tester.pumpWidget(
        MaterialApp(
          locale: const Locale('en'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(
            body: SingleChildScrollView(
              child: SlideshowPreview(
                config: SlideShowConfig.fromJson({'displayTimeMs': 9999}),
                images: [provider],
              ),
            ),
          ),
        ),
      );
      await tester.pump();
      expect(find.byType(LinearProgressIndicator), findsOneWidget);
      final loadingSize = tester.getSize(find.byType(SlideshowPreview));
      final summary = find.textContaining('9999');
      final loadingSummaryPosition = tester.getTopLeft(summary);
      provider.completer.complete(image);
      for (var i = 0; i < 30; i++) {
        await tester.runAsync(
          () => Future<void>.delayed(const Duration(milliseconds: 10)),
        );
        await tester.pump();
        if (find.byType(LinearProgressIndicator).evaluate().isEmpty) break;
      }
      expect(find.byType(LinearProgressIndicator), findsNothing);
      final readySize = tester.getSize(find.byType(SlideshowPreview));
      final readySummaryPosition = tester.getTopLeft(summary);
      await tester.pumpWidget(const SizedBox());
      expect(readySize, loadingSize);
      expect(readySummaryPosition, loadingSummaryPosition);
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets(
    'effects preview starts between photos and repeats the same pair',
    (tester) async {
      final providers = <ImageProvider>[];
      for (final color in [Colors.red, Colors.blue, Colors.green]) {
        final recorder = ui.PictureRecorder();
        Canvas(recorder).drawColor(color, BlendMode.src);
        final picture = recorder.endRecording();
        final image = (await tester.runAsync(() => picture.toImage(2, 2)))!;
        final bytes = (await tester.runAsync(
          () => image.toByteData(format: ui.ImageByteFormat.png),
        ))!;
        providers.add(
          MemoryImage(Uint8List.fromList(bytes.buffer.asUint8List())),
        );
        image.dispose();
        picture.dispose();
      }
      final config = SlideShowConfig.fromJson({
        'effects': {'defaultDurationMs': 1000},
        'displayTimeMs': 60000,
        'isBlurredBackground': false,
      });
      await tester.pumpWidget(
        MaterialApp(
          locale: const Locale('ru'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(
            body: SingleChildScrollView(
              child: SlideshowPreview(
                config: config,
                selectedEffect: Effect.fadeEffect,
                images: providers,
              ),
            ),
          ),
        ),
      );
      Future<void> prepared() async {
        for (var i = 0; i < 40; i++) {
          await tester.runAsync(
            () => Future<void>.delayed(const Duration(milliseconds: 10)),
          );
          await tester.pump();
          if (find.byType(LinearProgressIndicator).evaluate().isEmpty) return;
        }
        fail('Photo preparation did not finish');
      }

      Future<List<List<int>>> colors() async {
        final result = <List<int>>[];
        for (final widget in tester.widgetList<RawImage>(
          find.byType(RawImage),
        )) {
          final image = widget.image!;
          final data = (await tester.runAsync(
            () => image.toByteData(format: ui.ImageByteFormat.rawRgba),
          ))!;
          final offset =
              ((image.height ~/ 2) * image.width + image.width ~/ 2) * 4;
          result.add(data.buffer.asUint8List().sublist(offset, offset + 4));
        }
        return result;
      }

      await prepared();
      expect(await colors(), [
        [244, 67, 54, 255],
        [33, 150, 243, 255],
      ]);
      final clock = tester
          .widgetList<AnimatedBuilder>(find.byType(AnimatedBuilder))
          .map((w) => w.animation)
          .whereType<FixedAnimationController>()
          .single;
      clock.value = 1;
      await tester.pump();
      expect(await colors(), [
        [33, 150, 243, 255],
      ]);
      await tester.ensureVisible(find.byKey(const ValueKey('preview-repeat')));
      expect(find.text('Повторить'), findsOneWidget);
      await tester.tap(find.byKey(const ValueKey('preview-repeat')));
      await tester.pump();
      await prepared();
      expect(clock.value, 0);
      expect(await colors(), [
        [244, 67, 54, 255],
        [33, 150, 243, 255],
      ]);
      await tester.pumpWidget(const SizedBox());
      await tester.pump();
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets(
    'fallback duration is captured before asynchronous photo preparation',
    (tester) async {
      final recorder = ui.PictureRecorder();
      Canvas(recorder).drawColor(Colors.white, BlendMode.src);
      final picture = recorder.endRecording();
      final image = (await tester.runAsync(() => picture.toImage(2, 2)))!;
      picture.dispose();
      final provider = _ControlledProvider();
      final key = GlobalKey<SlideshowPreviewState>();
      final config = SlideShowConfig.fromJson({
        'effects': {'defaultDurationMs': 900},
      });
      Widget app() => MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: SingleChildScrollView(
            child: SlideshowPreview(
              key: key,
              config: config,
              images: [provider],
            ),
          ),
        ),
      );
      await tester.pumpWidget(app());
      key.currentState!.onChanged(
        const Effect(
          EffectType.waterRefraction,
          options: BasicEffectOptions(durationMs: 2500),
        ),
      );
      await tester.pump();
      config.effects = config.effects.copyWith(defaultDurationMs: 1200);
      await tester.pumpWidget(app());
      provider.completer.complete(image);
      for (var i = 0; i < 20; i++) {
        await tester.runAsync(
          () => Future<void>.delayed(const Duration(milliseconds: 10)),
        );
        await tester.pump();
        if (find.byType(LinearProgressIndicator).evaluate().isEmpty) break;
      }
      expect(find.byType(LinearProgressIndicator), findsNothing);
      final clock = tester
          .widgetList<AnimatedBuilder>(find.byType(AnimatedBuilder))
          .map((w) => w.animation)
          .whereType<FixedAnimationController>()
          .single;
      // The first photo has no outgoing photo, so Water Refraction uses Fade.
      expect(clock.duration, const Duration(milliseconds: 900));
      await tester.pumpWidget(const SizedBox());
      expect(tester.takeException(), isNull);
    },
  );

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
        'effects': {'defaultDurationMs': 10},
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
      await tester.pump(const Duration(milliseconds: 150));
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
        'effects': {'defaultDurationMs': 1000},
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
      key.currentState!.onChanged(
        (const Effect(
          EffectType.revealMask,
          options: RevealMaskEffectOptions(direction: EffectDirection.left),
        )),
      );
      await tester.pump();
      await tester.pump();
      expect(
        key.currentState!.currentEffect,
        (const Effect(
          EffectType.revealMask,
          options: RevealMaskEffectOptions(direction: EffectDirection.left),
        )),
      );
      expect(find.byType(ClipPath), findsOneWidget);
      final clock = tester
          .widgetList<AnimatedBuilder>(find.byType(AnimatedBuilder))
          .map((w) => w.animation)
          .whereType<FixedAnimationController>()
          .single;
      expect(clock.duration, const Duration(milliseconds: 1000));
      config.effects = config.effects.copyWith(defaultDurationMs: 2300);
      await tester.pumpWidget(app());
      // The current transition keeps its snapshot; the debounced next one takes
      // the new global duration after preparation.
      expect(clock.duration, const Duration(milliseconds: 1000));
      await tester.pump(const Duration(milliseconds: 150));
      for (var i = 0; i < 30 && clock.duration?.inMilliseconds != 2300; i++) {
        await tester.runAsync(
          () => Future<void>.delayed(const Duration(milliseconds: 10)),
        );
        await tester.pump(const Duration(milliseconds: 16));
      }
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
        'effects': {'defaultDurationMs': 100},
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

class _ControlledProvider extends ImageProvider<int> {
  late _ControlledImageCompleter completer;
  @override
  Future<int> obtainKey(ImageConfiguration configuration) =>
      SynchronousFuture(identityHashCode(this));
  @override
  void resolveStreamForKey(
    ImageConfiguration configuration,
    ImageStream stream,
    int key,
    ImageErrorListener handleError,
  ) {
    completer = _ControlledImageCompleter();
    stream.setCompleter(completer);
  }
}

class _ControlledImageCompleter extends ImageStreamCompleter {
  void complete(ui.Image image) => setImage(ImageInfo(image: image));
}
