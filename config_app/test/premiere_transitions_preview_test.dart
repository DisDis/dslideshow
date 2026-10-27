import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:config_app/features/config/presentation/wigdgets/slideshow_preview.dart';
import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_flutter/effect.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/widgets/fixed_animation_controller.dart';
import 'package:dslideshow_i18n/i18n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

final _effects = [
  Effect.softWipeEffect,
  (const Effect(
    EffectType.softWipe,
    options: SoftWipeEffectOptions(style: SoftWipeStyle.lightSweep),
  )),
  Effect.sliceEffect,
  Effect.lumaFadeEffect,
  Effect.pagePeelEffect,
  Effect.lightLeakEffect,
  Effect.filmRollEffect,
  Effect.crossZoomEffect,
  Effect.whipEffect,
  Effect.glassEffect,
  Effect.clockWipeEffect,
  Effect.splitEffect,
  Effect.panelWipeEffect,
  Effect.stretchEffect,
  Effect.starWipeEffect,
  Effect.filmDissolveEffect,
  Effect.frameEffect,
  Effect.louverEffect,
  Effect.mirrorEffect,
  (const Effect(
    EffectType.softWipe,
    options: SoftWipeEffectOptions(style: SoftWipeStyle.neon),
  )),
  Effect.burnAlphaEffect,
  Effect.foldMotionEffect,
  Effect.glowEffect,
  Effect.kaleidoscopeEffect,
  Effect.tvPowerEffect,
  Effect.springMotionEffect,
  Effect.shapeDissolveEffect,
  Effect.vhsDamageEffect,
  Effect.radialBlurEffect,
  Effect.phosphorEffect,
];

Widget _app(Widget child, Locale locale) => MaterialApp(
  locale: locale,
  supportedLocales: AppLocalizations.supportedLocales,
  localizationsDelegates: AppLocalizations.localizationsDelegates,
  home: child,
);

void main() {
  for (final locale in [const Locale('en'), const Locale('ru')]) {
    test(
      'new transitions use canonical types and typed settings (${locale.languageCode})',
      () {
        for (final effect in _effects) {
          expect(Effect.values.map((e) => e.type), contains(effect.type));
          final entry = EffectConfig.fromJson(effect.toConfig().toJson());
          expect(entry.validate(), isEmpty);
          expect(Effect.fromConfig(entry), effect);
        }
      },
    );

    testWidgets(
      'preview plays all thirty and changes safely (${locale.languageCode})',
      (tester) async {
        final recorder = ui.PictureRecorder();
        Canvas(recorder).drawColor(Colors.orange, BlendMode.src);
        final picture = recorder.endRecording();
        final image = picture.toImageSync(16, 10);
        picture.dispose();
        final data = (await tester.runAsync(
          () => image.toByteData(format: ui.ImageByteFormat.png),
        ))!;
        image.dispose();
        final provider = MemoryImage(
          Uint8List.fromList(data.buffer.asUint8List()),
        );
        final key = GlobalKey<SlideshowPreviewState>();
        final config = SlideShowConfig.fromJson({
          'effects': {'defaultDurationMs': 100},
          'displayTimeMs': 60000,
          'photoMotion': {'mode': 'kenBurns'},
        });
        await tester.pumpWidget(
          _app(
            Scaffold(
              body: SingleChildScrollView(
                child: SlideshowPreview(
                  key: key,
                  config: config,
                  images: [provider],
                ),
              ),
            ),
            locale,
          ),
        );
        await tester.runAsync(
          () => precacheImage(provider, key.currentContext!),
        );
        Future<void> finish() async {
          for (var i = 0; i < 30; i++) {
            await tester.runAsync(
              () => Future<void>.delayed(const Duration(milliseconds: 5)),
            );
            await tester.pump(const Duration(milliseconds: 16));
          }
        }

        await finish();
        for (final effect in _effects) {
          final field = tester.widget<DropdownButtonFormField<Effect>>(
            find.byKey(const ValueKey('preview-effect')),
          );
          final dropdown = tester.widget<DropdownButton<Effect>>(
            find.descendant(
              of: find.byKey(const ValueKey('preview-effect')),
              matching: find.byType(DropdownButton<Effect>),
            ),
          );
          expect(
            dropdown.items!.map((e) => e.value!.type),
            contains(effect.type),
          );
          field.onChanged!(effect);
          await finish();
          expect(key.currentState!.currentEffect, effect);
          final clock = tester
              .widgetList<AnimatedBuilder>(find.byType(AnimatedBuilder))
              .map((e) => e.animation)
              .whereType<FixedAnimationController>()
              .where(
                (clock) => clock.duration == const Duration(milliseconds: 100),
              )
              .toSet()
              .single;
          expect(clock.status, AnimationStatus.completed);
          expect(clock.duration, const Duration(milliseconds: 100));
          expect(find.byKey(const ValueKey('preview-error')), findsNothing);
          expect(find.byType(RawImage), findsWidgets);
          expect(tester.takeException(), isNull);
        }
        for (final effect in _effects) {
          key.currentState!.onChanged(effect);
        }
        await tester.pumpWidget(const SizedBox());
        await tester.runAsync(
          () => Future<void>.delayed(const Duration(milliseconds: 30)),
        );
        await tester.pump();
        expect(tester.takeException(), isNull);
      },
    );
  }
}
