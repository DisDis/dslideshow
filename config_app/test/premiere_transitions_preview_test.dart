import 'package:config_app/features/config/presentation/wigdgets/slideshow_preview.dart';
import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_flutter/effect.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/widgets/fixed_animation_controller.dart';
import 'package:dslideshow_i18n/i18n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'support/controlled_preview_asset_bundle.dart';
import 'support/slideshow_preview_harness.dart';

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
  const locale = Locale('en');
  testWidgets(
    'preview plays all thirty and changes safely (${locale.languageCode})',
    (tester) async {
      final bundle = (await tester.runAsync(
        ControlledPreviewAssetBundle.create,
      ))!;
      final key = GlobalKey<SlideshowPreviewState>();
      final config = SlideShowConfig.fromJson({
        'effects': {'defaultDurationMs': 100},
        'displayTimeMs': 60000,
      });
      await tester.pumpWidget(
        DefaultAssetBundle(
          bundle: bundle,
          child: _app(
            Scaffold(
              body: SingleChildScrollView(
                child: SlideshowPreview(key: key, config: config),
              ),
            ),
            locale,
          ),
        ),
      );
      FixedAnimationController clock() => tester
          .widgetList<AnimatedBuilder>(find.byType(AnimatedBuilder))
          .map((widget) => widget.animation)
          .whereType<FixedAnimationController>()
          .where((clock) => clock.duration == const Duration(milliseconds: 100))
          .toSet()
          .single;

      Future<void> finish() => finishPreview(tester);

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
          contains(effect.canonical.type),
        );
        field.onChanged!(effect);
        await finish();
        expect(key.currentState!.currentEffect, effect.canonical);
        expect(clock().duration, const Duration(milliseconds: 100));
        expect(find.byKey(const ValueKey('preview-error')), findsNothing);
        expect(find.byType(RawImage), findsWidgets);
        expect(tester.takeException(), isNull);
      }
      for (final effect in _effects) {
        key.currentState!.onChanged(effect);
      }
      await tester.pumpWidget(const SizedBox());
      await tester.pump();
      expect(tester.takeException(), isNull);
    },
  );
}
