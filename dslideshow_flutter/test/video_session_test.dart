import 'dart:async';
import 'dart:io';

import 'package:dslideshow_backend/storage.dart';
import 'package:dslideshow_flutter/effect.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/widgets/video_widget.dart';
import 'package:dslideshow_flutter/src/effect/blinds_effect.dart';
import 'package:dslideshow_flutter/src/effect/cube_effect.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:video_player/video_player.dart';

class FakeVideoController extends VideoPlayerController {
  final Completer<void>? gate;
  int initializations = 0;
  int disposals = 0;
  int plays = 0;
  int pauses = 0;
  bool dead = false;
  FakeVideoController({this.gate}) : super.file(File('/tmp/session-test.mp4'));
  @override
  Future<void> initialize() async {
    initializations++;
    await gate?.future;
    if (dead) return;
    value = value.copyWith(
      isInitialized: true,
      duration: const Duration(seconds: 30),
      size: const Size(320, 240),
    );
  }

  @override
  Future<void> setLooping(bool looping) async {}
  @override
  Future<void> play() async {
    plays++;
  }

  @override
  Future<void> pause() async {
    pauses++;
  }

  @override
  Future<void> dispose() async {
    disposals++;
    dead = true;
    await super.dispose();
  }
}

void main() {
  testWidgets(
    'new transitions share live players and leave disposal to owners',
    (tester) async {
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
        final from = FakeVideoController(), to = FakeVideoController();
        VideoSession session(FakeVideoController player) => VideoSession(
          File('/tmp/session-test.mp4'),
          controller: player,
          supported: true,
        );
        final fromSession = session(from), toSession = session(to);
        await fromSession.prepare();
        await toSession.prepare();
        await fromSession.setPlaying(true);
        await toSession.setPlaying(true);
        final current = VideoWidget(
          MediaItem('from', Uri.file('/tmp/from.mp4')),
          session: fromSession,
        );
        final next = VideoWidget(
          MediaItem('to', Uri.file('/tmp/to.mp4')),
          session: toSession,
        );
        for (final t in [0.0, .35, .65, 1.0, .5]) {
          await tester.pumpWidget(
            Directionality(
              textDirection: TextDirection.ltr,
              child: Center(
                child: SizedBox(
                  width: 320,
                  height: 240,
                  child: Builder(
                    builder: (context) =>
                        effect.createEffect().createTransformWidget(
                          context,
                          current,
                          next,
                          AlwaysStoppedAnimation(t),
                          320,
                          240,
                        ),
                  ),
                ),
              ),
            ),
          );
          from.value = from.value.copyWith(
            position: const Duration(seconds: 7),
          );
          to.value = to.value.copyWith(position: const Duration(seconds: 3));
          await tester.pump();
          expect(
            find.byType(VideoWidget),
            findsNWidgets(
              <Effect, int>{
                    Effect.foldMotionEffect: 4,
                    Effect.glowEffect: 4,
                    Effect.kaleidoscopeEffect: 14,
                    Effect.vhsDamageEffect: 8,
                    Effect.radialBlurEffect: 18,
                    Effect.phosphorEffect: 5,
                  }[effect] ??
                  (effect == Effect.glassEffect || effect == Effect.louverEffect
                      ? 16
                      : effect == Effect.mirrorEffect
                      ? 4
                      : effect == Effect.sliceEffect
                      ? 9
                      : effect == Effect.splitEffect
                      ? 3
                      : 2),
            ),
          );
          for (final player in [from, to]) {
            expect(player.initializations, 1);
            expect(player.disposals, 0);
            expect(player.plays, 1);
          }
          expect(from.value.position, const Duration(seconds: 7));
          expect(to.value.position, const Duration(seconds: 3));
          expect(tester.takeException(), isNull);
        }
        await tester.pumpWidget(const SizedBox());
        expect(from.disposals, 0);
        expect(to.disposals, 0);
        await fromSession.dispose();
        await toSession.dispose();
        expect(from.disposals, 1);
        expect(to.disposals, 1);
      }
    },
  );

  test(
    'Preparation is shared; pause during initialization overrides play',
    () async {
      final gate = Completer<void>();
      final player = FakeVideoController(gate: gate);
      final session = VideoSession(
        File('/tmp/session-test.mp4'),
        controller: player,
        supported: true,
      );
      final first = session.setPlaying(true);
      final second = session.setPlaying(false);
      gate.complete();
      await Future.wait([first, second, session.prepare()]);
      expect(player.initializations, 1);
      expect(player.plays, 0);
      expect(player.pauses, greaterThan(0));
      await session.dispose();
      await session.dispose();
      expect(player.disposals, 1);
    },
  );

  test('Disposal during initialization prevents late playback', () async {
    final gate = Completer<void>();
    final player = FakeVideoController(gate: gate);
    final session = VideoSession(
      File('/tmp/session-test.mp4'),
      controller: player,
      supported: true,
    );
    final play = session.setPlaying(true);
    await session.dispose();
    gate.complete();
    await play;
    expect(player.plays, 0);
    expect(player.disposals, 1);
  });

  testWidgets(
    'Blinds and phase/face changes keep one prepared player and its position',
    (tester) async {
      final player = FakeVideoController();
      final session = VideoSession(
        File('/tmp/session-test.mp4'),
        controller: player,
        supported: true,
      );
      await session.prepare();
      await session.setPlaying(true);
      player.value = player.value.copyWith(
        position: const Duration(seconds: 7),
      );
      final item = MediaItem('test', Uri.file('/tmp/session-test.mp4'));
      final view = SizedBox.expand(child: VideoWidget(item, session: session));
      Widget shell(Widget child) => Directionality(
        textDirection: TextDirection.ltr,
        child: Center(child: SizedBox(width: 320, height: 240, child: child)),
      );
      Widget effect(bool cube, double progress) => shell(
        Builder(
          builder: (context) =>
              (cube ? CubeEffect() : BlindsEffect()).createTransformWidget(
                context,
                view,
                const SizedBox.expand(),
                AlwaysStoppedAnimation(progress),
                320,
                240,
              ),
        ),
      );
      await tester.pumpWidget(shell(view));
      await tester.pumpWidget(effect(false, 0));
      expect(find.byType(VideoWidget), findsNWidgets(10));
      await tester.pumpWidget(effect(false, 0.6));
      await tester.pumpWidget(effect(true, 0.49));
      await tester.pumpWidget(effect(true, 0.51));
      await tester.pumpWidget(shell(view));
      expect(player.initializations, 1);
      expect(player.disposals, 0);
      expect(player.value.position, const Duration(seconds: 7));
      expect(tester.takeException(), isNull);
      await tester.pumpWidget(const SizedBox());
      await session.dispose();
      expect(player.disposals, 1);
    },
  );
}
