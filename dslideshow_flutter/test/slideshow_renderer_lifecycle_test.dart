import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_backend/storage.dart';
import 'package:dslideshow_common/rpc.dart';
import 'package:dslideshow_flutter/effect.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/bloc/slideshow_event.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/bloc/slideshow_slide.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/bloc/slideshow_state.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/pages/slideshow_page.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/sessions/slide_session_factory.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/widgets/fixed_animation_controller.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/widgets/image_widget.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/widgets/photo_motion.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/widgets/video_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart' as path;

import 'support/fake_video_controller.dart';
import 'support/slideshow_frontend.dart';
import 'support/slideshow_renderer_harness.dart';

class _MediaFrontend extends TestFrontend {
  final Uri Function(int) uriFor;
  _MediaFrontend(this.uriFor);
  @override
  Future<MediaItem> getStorageCurrentItem() async => MediaItem('media-$loads', uriFor(loads));
}

Future<Directory> _photoFolder(WidgetTester tester) async {
  final folder = (await tester.runAsync(() => Directory.systemTemp.createTemp('photo-renderer-lifecycle-')))!;
  await tester.runAsync(() async {
    final bytes = base64Decode(
      'iVBORw0KGgoAAAANSUhEUgAAAAIAAAACCAYAAABytg0kAAAAEUlEQVR4nGP4z8DwH4QZYAwAR8oH+WdZbrcAAAAASUVORK5CYII=',
    );
    await File('${folder.path}/1.png').writeAsBytes(bytes);
    await File('${folder.path}/2.png').writeAsBytes(bytes);
  });
  addTearDown(() => folder.delete(recursive: true));
  return folder;
}

AppConfig _movingPhotosConfig() => AppConfig.fromJson({
  'slideshow': {
    'effects': {
      'defaultDurationMs': 100,
      'items': {
        'fade': {'enabled': true},
      },
    },
    'displayTimeMs': 100000,
    'photoMotion': {'mode': 'kenBurns'},
  },
});

void main() {
  testWidgets('storage error keeps the visible session until a new load succeeds', (tester) async {
    final frontend = _MediaFrontend(
      (index) => path.toUri(path.join(Directory.systemTemp.path, 'storage-recovery-$index.mp4')),
    );
    final players = <FakeVideoController>[];
    final f = SlideshowRendererHarness(
      frontend: frontend,
      sessionFactory: SlideSessionFactory(
        createVideo: (file) {
          final player = FakeVideoController();
          players.add(player);
          return VideoSession(file, controller: player, supported: true);
        },
      ),
    );
    await f.mount(tester);
    await f.until(tester, () => f.bloc.state.phase == SlideshowPhase.display);
    final visible = tester.widget<VideoWidget>(find.byType(VideoWidget));
    final outgoing = players.single;
    frontend.onStorageNext = () =>
        Future.error(RpcErrorResultException(const ErrorResult(id: 1, error: 'storage unavailable')));
    f.bloc.add(const SlideshowLoadNextEvent());
    await tester.pump();
    expect(f.bloc.state.phase, SlideshowPhase.error);
    expect(tester.widget<VideoWidget>(find.byType(VideoWidget)), same(visible));
    expect(players.length, 1);
    expect(outgoing.disposals, 0);
    final advances = frontend.loads;
    frontend.onStorageNext = null;
    await tester.pump(const Duration(seconds: 31));
    expect(frontend.loads, advances);
    expect(outgoing.disposals, 0);
    expect(players.length, 1);
    expect(tester.widget<VideoWidget>(find.byType(VideoWidget)), same(visible));
    f.bloc.add(const SlideshowLoadNextEvent());
    await f.until(tester, () => f.bloc.state.phase == SlideshowPhase.transition);
    expect(frontend.loads, advances + 1);
    expect(players.length, 2);
    expect(outgoing.disposals, 0);
    await f.until(tester, () => f.bloc.state.phase == SlideshowPhase.display);
    expect(outgoing.disposals, 1);
    expect(tester.takeException(), isNull);
    await f.close(tester);
  });

  for (final fails in [false, true]) {
    testWidgets('page close releases a preparing video before late ${fails ? "failure" : "success"}', (tester) async {
      final initialized = Completer<void>();
      final player = FakeVideoController(gate: initialized);
      final f = SlideshowRendererHarness(
        frontend: _MediaFrontend((_) => Uri.file('/tmp/pending-video.mp4')),
        sessionFactory: SlideSessionFactory(
          createVideo: (file) => VideoSession(file, controller: player, supported: true),
        ),
      );
      await f.mount(tester);
      await f.until(tester, () => player.initializations == 1);
      final pendingState = f.bloc.state;
      f.visible.value = false;
      await tester.pump();
      expect(player.disposals, 1);
      if (fails) {
        initialized.completeError(StateError('late initialization failure'));
      } else {
        initialized.complete();
      }
      await tester.pump();
      expect(player.plays, 0);
      expect(player.disposals, 1);
      expect(f.bloc.state, same(pendingState));
      expect(tester.takeException(), isNull);
      await f.close(tester);
    });
  }

  testWidgets('renderer pauses video and releases outgoing player after detach', (tester) async {
    final players = <FakeVideoController>[];
    final f = SlideshowRendererHarness(
      frontend: _MediaFrontend((index) => Uri.file('/tmp/video-$index.mp4')),
      sessionFactory: SlideSessionFactory(
        createVideo: (file) {
          final player = FakeVideoController();
          players.add(player);
          return VideoSession(file, controller: player, supported: true);
        },
      ),
    );
    await f.mount(tester);
    await f.until(tester, () => f.bloc.state.phase == SlideshowPhase.display);
    final outgoing = players.single;
    expect(outgoing.plays, greaterThan(0));
    f.bloc.add(const SlideshowTogglePauseEvent(true));
    await tester.pump();
    final pausedPlays = outgoing.plays;
    expect(outgoing.pauses, greaterThan(0));
    await tester.pump(const Duration(seconds: 1));
    expect(outgoing.plays, pausedPlays);
    f.frontend.screens.add(false);
    await tester.pump();
    f.frontend.screens.add(true);
    await tester.pump();
    expect(outgoing.plays, pausedPlays);
    f.bloc.add(const SlideshowTogglePauseEvent(false));
    await tester.pump();
    expect(outgoing.plays, greaterThan(pausedPlays));
    f.bloc.add(const SlideshowLoadNextEvent());
    await f.until(tester, () => f.bloc.state.phase == SlideshowPhase.transition);
    final incoming = players.last;
    expect(incoming, isNot(same(outgoing)));
    expect(outgoing.disposals, 0);
    expect(incoming.disposals, 0);
    expect(incoming.plays, greaterThan(0));
    await f.until(tester, () => f.bloc.state.phase == SlideshowPhase.display);
    expect(outgoing.disposals, 1);
    expect(incoming.disposals, 0);
    expect(tester.takeException(), isNull);
    await f.close(tester);
    expect(incoming.disposals, 1);
  });

  testWidgets('media preparation error shows loader and keeps the queue usable', (tester) async {
    final f = SlideshowRendererHarness(
      frontend: _MediaFrontend((index) => Uri.file('/missing/slideshow/photo-$index.png')),
    );
    await f.mount(tester);
    await f.until(tester, () => f.bloc.state.phase == SlideshowPhase.display);
    expect(find.byKey(const Key('loader')), findsOneWidget);
    expect((f.bloc.state.currentSlide as MediaSlide).item.id, 'media-1');
    f.bloc.add(const SlideshowLoadNextEvent());
    await f.until(
      tester,
      () =>
          f.bloc.state.phase == SlideshowPhase.display &&
          (f.bloc.state.currentSlide as MediaSlide).item.id == 'media-2',
    );
    expect((f.bloc.state.currentSlide as MediaSlide).item.id, 'media-2');
    expect(f.frontend.loads, 2);
    expect(find.byKey(const Key('loader')), findsOneWidget);
    expect(tester.takeException(), isNull);
    await f.close(tester);
  });

  testWidgets('unsupported prepared Water inputs use Fade with the default duration', (tester) async {
    final folder = await _photoFolder(tester);
    const water = Effect(EffectType.waterRefraction, options: WaterRefractionEffectOptions(durationMs: 1400));
    final f = SlideshowRendererHarness(
      frontend: _MediaFrontend(
        (index) => index == 1 ? Uri.file('${folder.path}/missing.png') : Uri.file('${folder.path}/2.png'),
      ),
      config: AppConfig.fromJson({
        'slideshow': {
          'effects': {
            'defaultDurationMs': 100,
            'items': {'waterRefraction': water.toConfig().toJson()},
          },
          'displayTimeMs': 100000,
        },
      }),
    );
    await f.mount(tester);
    await f.until(tester, () => f.bloc.state.phase == SlideshowPhase.display);
    expect(find.byKey(const Key('loader')), findsOneWidget);
    f.bloc.add(const SlideshowLoadNextEvent());
    await f.until(tester, () => f.bloc.state.phase == SlideshowPhase.transition);
    expect(f.bloc.state.effect.type, EffectType.waterRefraction);
    expect(f.bloc.state.effect.options.durationMs, 1400);
    final animation =
        tester
                .widget<AnimatedBuilder>(
                  find.byWidgetPredicate(
                    (view) =>
                        view is AnimatedBuilder && view.child == null && view.animation is FixedAnimationController,
                  ),
                )
                .animation
            as FixedAnimationController;
    expect(animation.duration, const Duration(milliseconds: 100));
    await f.until(tester, () => f.bloc.state.phase == SlideshowPhase.display);
    expect((f.bloc.state.currentSlide as MediaSlide).item.id, 'media-2');
    expect(find.byType(ImageWidget), findsOneWidget);
    expect(find.byKey(const Key('loader')), findsNothing);
    expect(tester.takeException(), isNull);
    await f.close(tester);
  });

  testWidgets('asynchronous video disposal failure preserves photo motion and cleanup', (tester) async {
    final folder = await _photoFolder(tester);
    final disposalError = StateError('video disposal failed');
    final player = FakeVideoController(disposalError: disposalError);
    final failures = <LogRecord>[];
    final subscription = Logger.root.onRecord.listen((record) {
      if (identical(record.error, disposalError)) failures.add(record);
    });
    addTearDown(subscription.cancel);
    final f = SlideshowRendererHarness(
      frontend: _MediaFrontend(
        (index) => index == 1 ? Uri.file('/tmp/disposal-failure.mp4') : Uri.file('${folder.path}/2.png'),
      ),
      config: _movingPhotosConfig(),
      sessionFactory: SlideSessionFactory(
        createVideo: (file) => VideoSession(file, controller: player, supported: true),
      ),
    );
    await f.mount(tester);
    await f.until(tester, () => f.bloc.state.phase == SlideshowPhase.display);
    f.bloc.add(const SlideshowLoadNextEvent());
    await f.until(
      tester,
      () =>
          f.bloc.state.phase == SlideshowPhase.display &&
          (f.bloc.state.currentSlide as MediaSlide).item.id == 'media-2',
    );
    await f.until(tester, () => failures.isNotEmpty);
    expect(player.disposals, 1);
    final image = tester.widget<ImageWidget>(find.byType(ImageWidget));
    final bitmap = image.preparedBitmap!;
    final before = tester.widget<PhotoMotionFrame>(find.byType(PhotoMotionFrame)).progress;
    await tester.pump(const Duration(milliseconds: 16));
    expect(tester.widget<PhotoMotionFrame>(find.byType(PhotoMotionFrame)).progress, greaterThan(before));
    expect(bitmap.debugDisposed, false);
    expect(tester.takeException(), isNull);
    await f.close(tester);
    expect(bitmap.debugDisposed, true);
    expect(
      bitmap.debugGetOpenHandleStackTraces(),
      isEmpty,
      reason: 'Video disposal failure cannot retain borrowed photo handles',
    );
    expect(image.preparedBitmap, isNull);
    expect(tester.takeException(), isNull);
  });

  testWidgets('unmount in completion frame disposes both moving photo owners', (tester) async {
    final folder = await _photoFolder(tester);
    final f = SlideshowRendererHarness(
      frontend: _MediaFrontend((index) => Uri.file('${folder.path}/$index.png')),
      config: _movingPhotosConfig(),
    );
    await f.mount(tester);
    await f.until(tester, () => f.bloc.state.phase == SlideshowPhase.display);
    f.bloc.add(const SlideshowLoadNextEvent());
    await f.until(tester, () => f.bloc.state.phase == SlideshowPhase.transition);
    final pixels = tester.widgetList<ImageWidget>(find.byType(ImageWidget)).map((view) => view.preparedBitmap!).toSet();
    expect(pixels, hasLength(2));
    final transition = tester.widget<AnimatedBuilder>(
      find.byWidgetPredicate(
        (view) => view is AnimatedBuilder && view.child == null && view.animation is FixedAnimationController,
      ),
    );
    (transition.animation as Animation<double>).addStatusListener((status) {
      if (status == AnimationStatus.completed) f.visible.value = false;
    });
    await f.until(tester, () => !f.visible.value);
    expect(find.byType(SlideShowPage), findsNothing);
    for (final image in pixels) {
      expect(image.debugDisposed, true);
      expect(
        image.debugGetOpenHandleStackTraces(),
        isEmpty,
        reason: 'Completion-frame unmount releases every borrowed photo handle',
      );
    }
    expect(tester.takeException(), isNull);
    await f.close(tester);
  });
}
