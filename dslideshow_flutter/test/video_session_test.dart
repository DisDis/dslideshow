import 'dart:async';
import 'dart:io';

import 'package:dslideshow_backend/storage.dart';
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
