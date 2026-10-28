import 'dart:async';

import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_backend/storage.dart';
import 'package:dslideshow_flutter/effect.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/bloc/slideshow_bloc.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/bloc/slideshow_event.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/bloc/slideshow_slide.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/bloc/status/slideshow_status_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import 'support/slideshow_frontend.dart';

void main() {
  for (final effect in [
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
  ]) {
    testWidgets(
      '${effect.name} is selected from saved settings for photos/GIF/video',
      (tester) async {
        final frontend = TestFrontend();
        final config = SlideShowConfig.fromJson({
          'effects': {
            'defaultDurationMs': 1000,
            'items': {effect.type.name: effect.toConfig().toJson()},
          },
          'displayTimeMs': 100000,
        });
        final status = SlideshowStatusBloc(
          frontendService: frontend,
          config: config,
        );
        final bloc = SlideshowBloc(
          frontendService: frontend,
          config: config,
          statusBloc: status,
        );
        addTearDown(() async {
          await bloc.close();
          await status.close();
          await frontend.close();
        });
        for (final (index, path) in [
          'a.jpg',
          'b.GIF',
          'c.mp4',
          'd.jpg',
        ].indexed) {
          frontend.media = Completer<MediaItem>()
            ..complete(MediaItem(path, Uri.file('/tmp/$path')));
          bloc.add(
            index == 0
                ? const SlideshowInitEvent()
                : const SlideshowLoadNextEvent(),
          );
          await tester.pump();
          expect(
            bloc.state.effect,
            effect.canonical.configured(
              effect.canonical.options.withDuration(1000),
            ),
            reason: path,
          );
          bloc.add(const SlideshowImageReadyEvent());
          await tester.pump();
          bloc.add(const SlideshowTransitionCompleteEvent());
          await tester.pump();
        }
        await tester.runAsync(bloc.close);
      },
    );
  }

  for (final (label, effects, expected) in <(String, EffectsConfig, Effect)>[
    (
      'missing config',
      parseEffectsConfig(null),
      const Effect(
        EffectType.fade,
        options: BasicEffectOptions(durationMs: 1000),
      ),
    ),
    (
      'personal',
      EffectsConfig(
        defaultDurationMs: 1200,
        items: {
          EffectType.mosaic: EffectConfig(
            enabled: true,
            options: const MosaicEffectOptions(
              durationMs: 1800,
              gridSize: 150,
              direction: MosaicDirection.bottomLeft,
            ),
          ),
        },
      ),
      const Effect(
        EffectType.mosaic,
        options: MosaicEffectOptions(
          durationMs: 1800,
          gridSize: 150,
          direction: MosaicDirection.bottomLeft,
        ),
      ),
    ),
    (
      'inherited',
      EffectsConfig(
        defaultDurationMs: 1200,
        items: {
          EffectType.fade: EffectConfig.defaults(EffectType.fade)
              .copyWith(enabled: true),
        },
      ),
      const Effect(
        EffectType.fade,
        options: BasicEffectOptions(durationMs: 1200),
      ),
    ),
    (
      'empty',
      EffectsConfig(defaultDurationMs: 1200),
      const Effect(
        EffectType.fade,
        options: BasicEffectOptions(durationMs: 1200),
      ),
    ),
    (
      'unsupported schema',
      EffectsConfig(
        schemaVersion: 2,
        defaultDurationMs: 1200,
        items: {
          EffectType.slide: EffectConfig.defaults(EffectType.slide)
              .copyWith(enabled: true),
        },
      ),
      const Effect(
        EffectType.fade,
        options: BasicEffectOptions(durationMs: 1200),
      ),
    ),
  ]) {
    testWidgets(
      '$label selection resolves timing and captures immutable parameters',
      (tester) async {
        final frontend = TestFrontend();
        final config = SlideShowConfig.fromJson({'displayTimeMs': 100000})
          ..effects = effects;
        final status = SlideshowStatusBloc(
          frontendService: frontend,
          config: config,
        );
        final bloc = SlideshowBloc(
          frontendService: frontend,
          config: config,
          statusBloc: status,
        );
        addTearDown(() async {
          await bloc.close();
          await status.close();
          await frontend.close();
        });
        frontend.media = Completer<MediaItem>()
          ..complete(MediaItem('a.jpg', Uri.file('/tmp/a.jpg')));
        bloc.add(const SlideshowInitEvent());
        await tester.pump();
        expect(bloc.state.effect, expected);
        config.effects = effects
            .copyWith(defaultDurationMs: 2200)
            .put(
              expected.type,
              EffectConfig(
                enabled: true,
                options: defaultEffectOptions(expected.type).withDuration(3000),
              ),
            );
        bloc.add(const SlideshowTogglePauseEvent(true));
        await tester.pump();
        expect(bloc.state.effect, expected);
        await tester.runAsync(bloc.close);
      },
    );
  }

  testWidgets('canonical types occur once per shuffled pass', (tester) async {
    final frontend = TestFrontend();
    final config = SlideShowConfig.fromJson({'displayTimeMs': 100000})
      ..effects = EffectsConfig(
        items: {
          EffectType.fade: EffectConfig.defaults(EffectType.fade)
              .copyWith(enabled: true),
          EffectType.slide: EffectConfig.defaults(EffectType.slide)
              .copyWith(enabled: true),
        },
      );
    final status = SlideshowStatusBloc(
      frontendService: frontend,
      config: config,
    );
    final bloc = SlideshowBloc(
      frontendService: frontend,
      config: config,
      statusBloc: status,
    );
    addTearDown(() async {
      await bloc.close();
      await status.close();
      await frontend.close();
    });
    for (var cycle = 0; cycle < 3; cycle++) {
      final seen = <EffectType>{};
      for (var i = 0; i < 2; i++) {
        frontend.media = Completer<MediaItem>()
          ..complete(MediaItem('a.jpg', Uri.file('/tmp/a.jpg')));
        bloc.add(
          cycle == 0 && i == 0
              ? const SlideshowInitEvent()
              : const SlideshowLoadNextEvent(),
        );
        await tester.pump();
        seen.add(bloc.state.effect.type);
        bloc.add(const SlideshowImageReadyEvent());
        await tester.pump();
        bloc.add(const SlideshowTransitionCompleteEvent());
        await tester.pump();
      }
      expect(seen, {EffectType.fade, EffectType.slide});
    }
    await tester.runAsync(bloc.close);
  });

  testWidgets(
    'Water-only selection falls back for first/GIF/video, returns for a photo pair',
    (tester) async {
      final frontend = TestFrontend();
      final config = SlideShowConfig.fromJson({
        'effects': {
          'defaultDurationMs': 1000,
          'items': {
            'waterRefraction': {'enabled': true},
          },
        },
        'displayTimeMs': 100000,
      });
      final status = SlideshowStatusBloc(
        frontendService: frontend,
        config: config,
      );
      final bloc = SlideshowBloc(
        frontendService: frontend,
        config: config,
        statusBloc: status,
      );
      addTearDown(() async {
        await bloc.close();
        await status.close();
        await frontend.close();
      });
      for (final (index, path, expected) in [
        (0, 'a.jpg', Effect.fadeEffect),
        (1, 'b.jpg', Effect.waterRefractionEffect),
        (2, 'c.GIF', Effect.fadeEffect),
        (3, 'd.jpg', Effect.fadeEffect),
        (4, 'e.mp4', Effect.fadeEffect),
        (5, 'f.jpg', Effect.fadeEffect),
        (6, 'g.jpg', Effect.waterRefractionEffect),
      ]) {
        frontend.media = Completer<MediaItem>()
          ..complete(MediaItem(path, Uri.file('/tmp/$path')));
        bloc.add(
          index == 0
              ? const SlideshowInitEvent()
              : const SlideshowLoadNextEvent(),
        );
        await tester.pump();
        expect(
          bloc.state.effect,
          expected.configured(expected.options.withDuration(1000)),
          reason: path,
        );
        expect(bloc.state.nextSlide, isA<MediaSlide>());
        bloc.add(const SlideshowImageReadyEvent());
        await tester.pump();
        bloc.add(const SlideshowTransitionCompleteEvent());
        await tester.pump();
      }
      await tester.runAsync(bloc.close);
    },
  );
}
