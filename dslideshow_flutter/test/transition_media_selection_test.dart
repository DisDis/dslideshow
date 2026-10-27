import 'dart:async';

import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_backend/storage.dart';
import 'package:dslideshow_flutter/effect.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/bloc/slideshow_bloc.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/bloc/slideshow_event.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/bloc/slideshow_slide.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/bloc/status/slideshow_status_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import 'screen_transition_test.dart' show TestFrontend;

void main() {
  for (final effect in [
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
  ]) {
    testWidgets(
      '${effect.name} is selected from saved settings for photos/GIF/video',
      (tester) async {
        final frontend = TestFrontend();
        final config = SlideShowConfig.fromJson({
          'allowedEffects': [effect.name],
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
          expect(bloc.state.effect, effect, reason: path);
          bloc.add(const SlideshowImageReadyEvent());
          await tester.pump();
          bloc.add(const SlideshowTransitionCompleteEvent());
          await tester.pump();
        }
        await tester.runAsync(bloc.close);
      },
    );
  }

  testWidgets(
    'Water-only selection falls back for first/GIF/video, returns for a photo pair',
    (tester) async {
      final frontend = TestFrontend();
      final config = SlideShowConfig.fromJson({
        'allowedEffects': ['Water Refraction'],
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
        expect(bloc.state.effect, expected, reason: path);
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
