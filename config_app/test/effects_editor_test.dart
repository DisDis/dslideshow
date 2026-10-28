import 'package:config_app/features/config/domain/effect_settings_validation.dart';
import 'package:config_app/features/config/presentation/pages/effects_editor_page.dart';
import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_i18n/i18n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_test/flutter_test.dart';

Widget app(
  Widget child, {
  Locale locale = const Locale('en'),
  double scale = 1,
}) => MaterialApp(
  locale: locale,
  supportedLocales: AppLocalizations.supportedLocales,
  localizationsDelegates: AppLocalizations.localizationsDelegates,
  builder: (context, child) => MediaQuery(
    data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(scale)),
    child: child!,
  ),
  home: TickerMode(enabled: false, child: child),
);
Future<void> wide(
  WidgetTester tester,
  SlideShowConfig config, {
  VoidCallback Function(ValueGetter<bool>)? register,
}) async {
  tester.view.physicalSize = const Size(1500, 1100);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
  await tester.pumpWidget(
    app(EffectsEditorPage(config: config, registerDraft: register)),
  );
  await tester.pump();
}

Future<void> select(WidgetTester tester, String query, String type) async {
  await tester.enterText(find.byKey(const ValueKey('effects-search')), query);
  await tester.pump();
  await tester.tap(find.byKey(ValueKey('effect-row-$type')));
  await tester.pump();
}

Future<void> tapVisible(WidgetTester tester, Finder finder) async {
  await tester.ensureVisible(finder);
  await tester.tap(finder);
  await tester.pump();
}

void main() {
  testWidgets(
    'presets preserve timing and enabled state and replace invalid visual input',
    (tester) async {
      final config = SlideShowConfig.fromJson({
        'effects': {
          'items': {
            'fade': {
              'options': {'durationMs': 1700},
            },
          },
        },
      });
      ValueGetter<bool>? invalid;
      await wide(
        tester,
        config,
        register: (check) {
          invalid = check;
          return () {};
        },
      );
      Future<void> preset(EffectPresetId id) async {
        final dropdown = find.byType(DropdownButtonFormField<EffectPresetId>);
        await tester.ensureVisible(dropdown);
        tester
            .widget<DropdownButtonFormField<EffectPresetId>>(dropdown)
            .onChanged!(id);
        await tester.pump();
      }

      await preset(EffectPresetId.blurFade);
      final blur = config.effects.get(EffectType.fade);
      expect(blur.enabled, isFalse);
      expect(blur.options.durationMs, 1700);
      expect((blur.options as FadeEffectOptions).style, FadeStyle.blur);
      final sigma = find.byKey(const ValueKey('effect-fade-maxSigma'));
      await tester.enterText(sigma, 'invalid');
      await tester.pump();
      expect(invalid!(), isTrue);
      await preset(EffectPresetId.filmDissolve);
      expect(invalid!(), isFalse);
      expect(config.effects.get(EffectType.fade).options.durationMs, 1700);
      expect(
        (config.effects.get(EffectType.fade).options as FadeEffectOptions)
            .style,
        FadeStyle.linearLight,
      );
      expect(find.byKey(const ValueKey('effect-fade-maxSigma')), findsNothing);
      expect(EffectsConfig.fromJson(config.effects.toJson()), config.effects);
      await tester.pumpWidget(const SizedBox());
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets(
    'changing a centered mask to diagonal keeps an editable valid origin',
    (tester) async {
      final config = SlideShowConfig.fromJson({
        'effects': {
          'items': {
            'revealMask': {
              'options': {'shape': 'iris', 'origin': 'center'},
            },
          },
        },
      });
      await wide(tester, config);
      await select(tester, 'Reveal', 'revealMask');
      tester
          .widget<DropdownButtonFormField<RevealShape>>(
            find.byType(DropdownButtonFormField<RevealShape>),
          )
          .onChanged!(RevealShape.diagonal);
      await tester.pump();
      final options =
          config.effects.get(EffectType.revealMask).options
              as RevealMaskEffectOptions;
      expect(options.origin, EffectOrigin.topLeft);
      expect(config.effects.validate(), isEmpty);
      expect(
        find.byType(DropdownButtonFormField<EffectOrigin>),
        findsOneWidget,
      );
      await tester.pumpWidget(const SizedBox());
    },
  );

  testWidgets(
    'Water exposes exactly the five wave origins and keeps disabled editing',
    (tester) async {
      final config = SlideShowConfig.fromJson({});
      await wide(tester, config);
      await select(tester, 'Water', 'waterRefraction');
      final dropdown = find.byType(DropdownButtonFormField<EffectOrigin>);
      expect(
        tester
            .widget<DropdownButton<EffectOrigin>>(
              find.descendant(
                of: dropdown,
                matching: find.byType(DropdownButton<EffectOrigin>),
              ),
            )
            .items!
            .map((item) => item.value),
        EffectOrigin.values,
      );
      for (final origin in EffectOrigin.values) {
        tester
            .widget<DropdownButtonFormField<EffectOrigin>>(dropdown)
            .onChanged!(origin);
        await tester.pump();
        final entry = config.effects.get(EffectType.waterRefraction);
        expect((entry.options as WaterRefractionEffectOptions).origin, origin);
        expect(entry.enabled, isFalse);
      }
      expect(config.effects.validate(), isEmpty);
      await tester.pumpWidget(const SizedBox());
    },
  );

  testWidgets(
    'invalid stored options can be inspected and reset without crashing',
    (tester) async {
      for (final (type, options) in <(EffectType, Map<String, dynamic>)>[
        (EffectType.revealMask, {'shape': 'diagonal', 'origin': 'center'}),
        (EffectType.mosaic, {'gridSize': 99, 'fadeFraction': 1.1}),
        (EffectType.mosaic, {'direction': 'future'}),
        (EffectType.rotate, {'angleDegrees': double.infinity}),
        (EffectType.glass, {'paneCount': 0}),
      ]) {
        final config = SlideShowConfig.fromJson({
          'effects': {
            'items': {
              type.name: {'options': options, 'enabled': true},
            },
          },
        });
        ValueGetter<bool>? hasInvalid;
        await wide(
          tester,
          config,
          register: (check) {
            hasInvalid = check;
            return () {};
          },
        );
        expect(config.effects.items.keys.single, type);
        await select(tester, switch (type) {
          EffectType.revealMask => 'Reveal',
          EffectType.mosaic => 'Mosaic',
          EffectType.rotate => 'Rotate',
          _ => 'Glass',
        }, type.name);
        expect(tester.takeException(), isNull);
        expect(hasInvalid!(), isTrue);
        await tapVisible(tester, find.byKey(const ValueKey('effect-reset')));
        await tester.pump();
        expect(config.effects.validate(), isEmpty);
        expect(config.effects.items.values.single.enabled, isTrue);
        expect(hasInvalid!(), isFalse);
        await tester.pumpWidget(const SizedBox());
      }
    },
  );

  testWidgets(
    'color picker repairs invalid ARGB input and preserves effect timing',
    (tester) async {
      final config = SlideShowConfig.fromJson({
        'effects': {
          'items': {
            'fadeThroughColor': {
              'enabled': true,
              'options': {'durationMs': 1700, 'color': 0xff112233},
            },
          },
        },
      });
      ValueGetter<bool>? hasInvalid;
      await wide(
        tester,
        config,
        register: (check) {
          hasInvalid = check;
          return () {};
        },
      );
      await select(tester, 'Fade', 'fade');
      final field = find.byKey(const ValueKey('effect-fade-color'));
      await tester.enterText(field, 'invalid');
      await tester.pump();
      expect(hasInvalid!(), isTrue);
      final button = find.byTooltip('Choose color');
      await tapVisible(tester, button);
      await tester.pumpAndSettle();
      tester
          .widget<ColorPicker>(find.byType(ColorPicker))
          .onColorChanged(const Color(0x40887766));
      await tester.pump();
      await tester.tap(find.text('Apply'));
      await tester.pumpAndSettle();
      final entry = config.effects.get(EffectType.fade);
      expect((entry.options as FadeEffectOptions).color, 0x40887766);
      expect(entry.options.durationMs, 1700);
      expect(entry.enabled, isTrue);
      expect(hasInvalid!(), isFalse);
      expect(tester.widget<TextFormField>(field).controller!.text, '40887766');
      await tester.pumpWidget(const SizedBox());
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets(
    'global/custom duration, zero storage and disabling retain settings',
    (tester) async {
      final config = SlideShowConfig.fromJson({'effects': {}});
      await wide(tester, config);
      await select(tester, 'Mosaic', 'mosaic');
      expect(config.effects.get(EffectType.mosaic).options.durationMs, 0);
      expect(
        tester
            .widget<TextFormField>(
              find.byKey(const ValueKey('effects-global-duration')),
            )
            .controller!
            .text,
        '1000',
      );
      final mode = find.byKey(const ValueKey('effect-duration-mode'));
      final inheritedGap =
          tester
              .getTopLeft(
                find.byKey(const ValueKey('effect-inherited-mosaic-1000')),
              )
              .dy -
          tester.getBottomLeft(mode).dy;
      await tapVisible(tester, find.text('Custom'));
      final customGap =
          tester
              .getTopLeft(find.byKey(const ValueKey('effect-mosaic-duration')))
              .dy -
          tester.getBottomLeft(mode).dy;
      expect(inheritedGap, greaterThanOrEqualTo(8));
      expect(inheritedGap, closeTo(customGap, .01));
      expect(config.effects.get(EffectType.mosaic).options.durationMs, 1000);
      final durationField = tester.widget<TextFormField>(
        find.byKey(const ValueKey('effect-mosaic-duration')),
      );
      expect(durationField.controller!.text, '1000');
      expect(
        tester
            .widget<TextField>(
              find.descendant(
                of: find.byKey(const ValueKey('effect-mosaic-duration')),
                matching: find.byType(TextField),
              ),
            )
            .keyboardType,
        TextInputType.number,
      );
      await tester.enterText(
        find.byKey(const ValueKey('effect-mosaic-duration')),
        '2500',
      );
      await tester.pump();
      expect(config.effects.get(EffectType.mosaic).options.durationMs, 2500);
      expect(find.text('2500 ms'), findsOneWidget);
      await tester.tap(find.byKey(const ValueKey('effect-enabled-mosaic')));
      await tester.pump();
      expect(config.effects.get(EffectType.mosaic).enabled, true);
      await tester.tap(find.byKey(const ValueKey('effect-enabled-mosaic')));
      await tester.pump();
      expect(config.effects.get(EffectType.mosaic).enabled, false);
      expect(config.effects.get(EffectType.mosaic).options.durationMs, 2500);
      await tapVisible(tester, find.text('Global', skipOffstage: true).first);
      expect(config.effects.get(EffectType.mosaic).options.durationMs, 0);
      await tester.enterText(
        find.byKey(const ValueKey('effects-global-duration')),
        '1700',
      );
      await tester.pump();
      expect(config.effects.defaultDurationMs, 1700);
      final inherited = tester.widget<TextFormField>(
        find.byKey(const ValueKey('effect-inherited-mosaic-1700')),
      );
      expect(inherited.enabled, false);
      expect(inherited.initialValue, '1700');
      expect(find.text('Global · 1700 ms'), findsOneWidget);
      await tapVisible(tester, find.text('Custom'));
      expect(config.effects.get(EffectType.mosaic).options.durationMs, 2500);
      await tester.pumpWidget(const SizedBox());
      expect(tester.takeException(), isNull);
    },
  );
  testWidgets('duration inputs accept only positive integer milliseconds', (
    tester,
  ) async {
    final config = SlideShowConfig.fromJson({
      'effects': {
        'items': {
          'mosaic': {
            'options': {'durationMs': 2501},
          },
        },
      },
    });
    ValueGetter<bool>? hasInvalid;
    await wide(
      tester,
      config,
      register: (check) {
        hasInvalid = check;
        return () {};
      },
    );
    await select(tester, 'Mosaic', 'mosaic');
    Future<void> checkInput(
      Finder field,
      int Function() read,
      int initial,
    ) async {
      expect(tester.widget<TextFormField>(field).controller!.text, '$initial');
      for (final invalid in [
        '',
        '0',
        '-1',
        '3600001',
        '1.5',
        '1,5',
        '1e3',
        '0x10',
      ]) {
        await tester.enterText(field, invalid);
        await tester.pump();
        expect(hasInvalid!(), isTrue, reason: invalid);
        expect(read(), initial, reason: invalid);
      }
      for (final valid in [1, 3600000, initial]) {
        await tester.enterText(field, '$valid');
        await tester.pump();
        expect(hasInvalid!(), isFalse, reason: '$valid');
        expect(read(), valid);
      }
    }

    await checkInput(
      find.byKey(const ValueKey('effect-mosaic-duration')),
      () => config.effects.get(EffectType.mosaic).options.durationMs,
      2501,
    );
    await checkInput(
      find.byKey(const ValueKey('effects-global-duration')),
      () => config.effects.defaultDurationMs,
      1000,
    );
    await tester.pumpWidget(const SizedBox());
    expect(tester.takeException(), isNull);
  });

  testWidgets(
    'invalid custom input survives selection and global mode clears it explicitly',
    (tester) async {
      final config = SlideShowConfig.fromJson({'effects': {}});
      ValueGetter<bool>? hasInvalid;
      await wide(
        tester,
        config,
        register: (check) {
          hasInvalid = check;
          return () {};
        },
      );
      await select(tester, 'Mosaic', 'mosaic');
      await tapVisible(tester, find.text('Custom'));
      await tester.enterText(
        find.byKey(const ValueKey('effect-mosaic-duration')),
        'bad',
      );
      await tester.pump();
      expect(hasInvalid!(), true);
      await select(tester, 'Fade', 'fade');
      expect(hasInvalid!(), true);
      await select(tester, 'Mosaic', 'mosaic');
      expect(
        tester
            .widget<TextFormField>(
              find.byKey(const ValueKey('effect-mosaic-duration')),
            )
            .controller!
            .text,
        'bad',
      );
      await tapVisible(tester, find.text('Global').first);
      expect(config.effects.get(EffectType.mosaic).options.durationMs, 0);
      expect(hasInvalid!(), false);
      await tester.pumpWidget(const SizedBox());
    },
  );
  testWidgets(
    'reset restores options and inherited timing but keeps enabled flag',
    (tester) async {
      final config = SlideShowConfig.fromJson({
        'effects': {
          'items': {
            'mosaic': {
              'enabled': true,
              'options': {
                'durationMs': 2300,
                'gridSize': 200,
                'fadeFraction': .6,
                'direction': 'bottomRight',
              },
            },
          },
        },
      });
      await wide(tester, config);
      await select(tester, 'Mosaic', 'mosaic');
      await tapVisible(tester, find.byKey(const ValueKey('effect-reset')));
      final entry = config.effects.get(EffectType.mosaic);
      expect(entry.enabled, true);
      expect(entry.options, const MosaicEffectOptions());
      await tester.pumpWidget(const SizedBox());
      expect(tester.takeException(), isNull);
    },
  );
  testWidgets(
    'bulk actions include filtered-out entries and retain their options',
    (tester) async {
      final config = SlideShowConfig.fromJson({
        'effects': {
          'items': {
            'mosaic': {
              'options': {'durationMs': 1800, 'gridSize': 150},
            },
            'fade': {
              'options': {'durationMs': 800},
            },
          },
        },
      });
      await wide(tester, config);
      await select(tester, 'Mosaic', 'mosaic');
      // The generic popup's exact type is private to the editor; find its tooltip.
      Future<void> menuAction(String label) async {
        await tester.tap(find.byIcon(Icons.more_vert));
        await tester.pumpAndSettle();
        await tester.tap(find.text(label));
        await tester.pumpAndSettle();
      }

      await menuAction('Use global duration for all effects');
      expect(config.effects.get(EffectType.fade).options.durationMs, 0);
      expect(config.effects.get(EffectType.mosaic).options.durationMs, 0);
      expect(
        (config.effects.get(EffectType.mosaic).options as MosaicEffectOptions)
            .gridSize,
        150,
      );
      await tapVisible(tester, find.text('Custom'));
      expect(config.effects.get(EffectType.mosaic).options.durationMs, 1800);
      await menuAction('Enable all effects');
      expect(config.effects.playable.length, 37);
      await menuAction('Disable all effects');
      expect(config.effects.playable, isEmpty);
      expect(
        find.textContaining('No compatible effect selected'),
        findsOneWidget,
      );
      await tester.pumpWidget(const SizedBox());
      expect(tester.takeException(), isNull);
    },
  );

  const locale = Locale('en');
  testWidgets(
    'compact editor retains settings and fits large text (${locale.languageCode})',
    (tester) async {
      tester.view.physicalSize = const Size(390, 850);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      final config = SlideShowConfig.fromJson({'effects': {}});
      await tester.pumpWidget(
        app(EffectsEditorPage(config: config), locale: locale, scale: 1.5),
      );
      expect(find.text('Global duration, ms'), findsOneWidget);
      await select(tester, 'Mosaic', 'mosaic');
      await tester.pumpAndSettle();
      expect(find.textContaining('Duration, ms'), findsOneWidget);
      expect(
        tester
            .widget<TextFormField>(
              find.byKey(const ValueKey('effect-inherited-mosaic-1000')),
            )
            .initialValue,
        '1000',
      );
      expect(
        find.byKey(const ValueKey('effect-duration-mode')),
        findsOneWidget,
      );
      await tester.tap(find.byType(BackButton));
      await tester.pumpAndSettle();
      expect(find.byKey(const ValueKey('effects-search')), findsOneWidget);
      expect(tester.takeException(), isNull);
      await tester.pumpWidget(const SizedBox());
    },
  );
}
