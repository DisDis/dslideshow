import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:config_app/features/config/presentation/pages/slideshow_editor_page.dart';
import 'package:config_app/features/config/presentation/wigdgets/settings_section.dart';
import 'package:config_app/features/config/presentation/wigdgets/slideshow_preview.dart';
import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_flutter/effect.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/widgets/fixed_animation_controller.dart';
import 'package:dslideshow_i18n/i18n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

final _effects = [
  Effect.softWipeEffect,
  Effect.lightSweepEffect,
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
  Effect.neonWipeEffect,
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
    testWidgets(
      'new transitions are selectable and saved (${locale.languageCode})',
      (tester) async {
        final config = SlideShowConfig.fromJson({});
        // The inactive preview does not request external sample images.
        await tester.pumpWidget(
          _app(
            TickerMode(
              enabled: false,
              child: SlideshowEditorPage(config: config),
            ),
            locale,
          ),
        );
        final selector = tester.widget<SettingsMultiSelect<Effect>>(
          find.byType(SettingsMultiSelect<Effect>),
        );
        expect(selector.allItems, containsAll(_effects));
        final labels = _effects.map(selector.itemLabelBuilder!).toList();
        expect(
          labels,
          locale.languageCode == 'ru'
              ? [
                  'Мягкое раскрытие',
                  'Световой проход',
                  'Сдвиг полос',
                  'Растворение по яркости',
                  'Загиб страницы',
                  'Световая засветка',
                  'Прокрутка плёнки',
                  'Встречный зум',
                  'Резкая панорама',
                  'Стекло',
                  'Часовое раскрытие',
                  'Раздвижение половин',
                  'Раскрытие панелями',
                  'Растяжение',
                  'Раскрытие звездой',
                  'Кинематографическое растворение',
                  'Рамка',
                  'Поворотные жалюзи',
                  'Зеркало',
                  'Неоновое раскрытие',
                  'Выгорание',
                  'Складывание',
                  'Свечение',
                  'Калейдоскоп',
                  'Выключение телевизора',
                  'Пружина',
                  'Растворение фигурами',
                  'Видеокассета',
                  'Радиальное размытие',
                  'Послесвечение',
                ]
              : [
                  'Soft Wipe',
                  'Light Sweep',
                  'Slice',
                  'Luma Fade',
                  'Page Peel',
                  'Light Leak',
                  'Film Roll',
                  'Cross Zoom',
                  'Whip',
                  'Glass',
                  'Clock Wipe',
                  'Split',
                  'Panel Wipe',
                  'Stretch',
                  'Star Wipe',
                  'Film Dissolve',
                  'Frame',
                  'Louver',
                  'Mirror',
                  'Neon Wipe',
                  'Burn Alpha',
                  'Fold Motion',
                  'Glow',
                  'Kaleidoscope',
                  'TV Power',
                  'Spring Motion',
                  'Shape Dissolve',
                  'VHS Damage',
                  'Radial Blur',
                  'Phosphor',
                ],
        );
        selector.onChanged(_effects);
        await tester.pump();
        expect(config.allowedEffects, _effects.map((e) => e.name).toList());
        final reloaded = SlideShowConfig.fromJson(config.toJson());
        expect(reloaded.allowedEffects.map(Effect.parse), _effects);
        await tester.pumpWidget(const SizedBox());
        expect(tester.takeException(), isNull);
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
          'transitionTimeMs': 100,
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
          expect(dropdown.items!.map((e) => e.value), contains(effect));
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
