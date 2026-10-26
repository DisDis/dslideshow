import 'dart:async';

import 'package:config_app/src/linux_video_player.dart';
import 'package:config_app/src/linux_video_session.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:video_player/video_player.dart';
import 'package:video_player_platform_interface/video_player_platform_interface.dart';

enum _Command { play, pause, loop, volume, rate, seek }

class _Session implements LinuxVideoSession {
  _Session({
    this.opening,
    this.openError,
    this.disposeError,
    this.commandError,
  }) {
    sourceEvents = StreamController<VideoEvent>(
      onListen: () => subscriptions++,
      onCancel: () {
        subscriptions--;
        if (cancelError) throw StateError('cancel failed');
      },
    );
  }

  final Completer<void>? opening;
  final Object? openError;
  final Object? disposeError;
  final _Command? commandError;
  late final StreamController<VideoEvent> sourceEvents;
  final commands = <(_Command, Object?)>[];
  DataSource? source;
  int subscriptions = 0;
  int disposals = 0;
  bool cancelError = false;

  @override
  Stream<VideoEvent> get events => sourceEvents.stream;

  @override
  Duration get position => const Duration(seconds: 3);

  @override
  Future<void> open(DataSource source) async {
    this.source = source;
    if (openError case final error?) throw error;
    await opening?.future;
  }

  @override
  Future<void> dispose() async {
    disposals++;
    if (disposeError case final error?) throw error;
  }

  Future<void> _command(_Command command, [Object? value]) async {
    commands.add((command, value));
    if (commandError == command) throw StateError('command failed');
  }

  @override
  Future<void> play() => _command(_Command.play);

  @override
  Future<void> pause() => _command(_Command.pause);

  @override
  Future<void> setLooping(bool looping) => _command(_Command.loop, looping);

  @override
  Future<void> setVolume(double volume) => _command(_Command.volume, volume);

  @override
  Future<void> setPlaybackSpeed(double speed) => _command(_Command.rate, speed);

  @override
  Future<void> seekTo(Duration position) => _command(_Command.seek, position);

  @override
  Widget buildView() => const SizedBox(key: ValueKey('native-video'));
}

DataSource _source() => DataSource(
  sourceType: DataSourceType.network,
  uri: 'http://localhost/video.mp4',
  httpHeaders: const {'Authorization': 'test'},
);

Future<void> _flush() => Future<void>.delayed(Duration.zero);

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test(
    'ID and error stream exist even when native construction throws',
    () async {
      final backend = ConfigAppLinuxVideoPlayer(
        sessionFactory: () => throw StateError('factory failed'),
      );
      final id = (await backend.create(_source()))!;
      expect(backend.activePlayerCount, 1);
      await expectLater(
        backend.videoEventsFor(id),
        emitsError(isA<PlatformException>()),
      );
      await backend.dispose(id);
      expect(backend.activePlayerCount, 0);
    },
  );

  test('open failure is delivered before any initialized event', () async {
    final session = _Session(openError: StateError('open failed'));
    final backend = ConfigAppLinuxVideoPlayer(sessionFactory: () => session);
    final id = (await backend.createWithOptions(
      VideoCreationOptions(
        dataSource: _source(),
        viewType: VideoViewType.textureView,
      ),
    ))!;
    await expectLater(
      backend.videoEventsFor(id),
      emitsError(isA<PlatformException>()),
    );
    await backend.dispose(id);
    expect(session.disposals, 1);
    expect(session.subscriptions, 0);
    expect(backend.activePlayerCount, 0);
    expect(session.source!.httpHeaders['Authorization'], 'test');
  });

  test(
    'error stream releases a decoder while opening is still pending',
    () async {
      final opening = Completer<void>();
      final session = _Session(opening: opening);
      final backend = ConfigAppLinuxVideoPlayer(sessionFactory: () => session);
      final id = (await backend.create(_source()))!;
      final errors = <Object>[];
      final subscription = backend
          .videoEventsFor(id)
          .listen(
            (_) => fail('An error must not become an initialized event'),
            onError: errors.add,
          );
      session.sourceEvents.addError(StateError('unreachable URL'));
      await _flush();
      expect(errors.single, isA<PlatformException>());
      expect(session.disposals, 1);
      expect(session.subscriptions, 0);
      await backend.dispose(id);
      opening.completeError(StateError('late opening failure'));
      await _flush();
      expect(session.disposals, 1);
      expect(backend.activePlayerCount, 0);
      await subscription.cancel();
    },
  );

  test('early close does not wait for open or for an event listener', () async {
    final opening = Completer<void>();
    final session = _Session(opening: opening);
    final backend = ConfigAppLinuxVideoPlayer(sessionFactory: () => session);
    final id = (await backend.create(_source()))!;
    await backend.dispose(id).timeout(const Duration(seconds: 1));
    expect(session.disposals, 1);
    expect(session.subscriptions, 0);
    expect(backend.activePlayerCount, 0);
    opening.complete();
    session.sourceEvents.add(VideoEvent(eventType: VideoEventType.initialized));
    await _flush();
    expect(session.disposals, 1);
  });

  test(
    'initialization timeout releases a pending decoder exactly once',
    () async {
      final opening = Completer<void>();
      final session = _Session(opening: opening);
      final backend = ConfigAppLinuxVideoPlayer(
        sessionFactory: () => session,
        initializationTimeout: const Duration(milliseconds: 30),
      );
      final id = (await backend.create(_source()))!;
      final errors = <Object>[];
      final subscription = backend
          .videoEventsFor(id)
          .listen((_) {}, onError: errors.add);
      await Future<void>.delayed(const Duration(milliseconds: 40));
      expect(errors.single, isA<PlatformException>());
      expect((errors.single as PlatformException).code, 'video_timeout');
      expect(session.disposals, 1);
      expect(session.subscriptions, 0);
      opening.complete();
      await backend.dispose(id);
      await subscription.cancel();
      expect(backend.activePlayerCount, 0);
    },
  );

  test(
    'initialized event cancels timeout and commands reach its decoder',
    () async {
      final session = _Session();
      final backend = ConfigAppLinuxVideoPlayer(
        sessionFactory: () => session,
        initializationTimeout: const Duration(milliseconds: 30),
      );
      final id = (await backend.create(_source()))!;
      final events = <VideoEvent>[];
      final subscription = backend.videoEventsFor(id).listen(events.add);
      final initialized = VideoEvent(
        eventType: VideoEventType.initialized,
        duration: const Duration(seconds: 10),
        size: const Size(640, 360),
      );
      session.sourceEvents.add(initialized);
      await _flush();
      await Future<void>.delayed(const Duration(milliseconds: 40));
      expect(events, [initialized]);
      await backend.play(id);
      await backend.pause(id);
      await backend.setLooping(id, true);
      await backend.setVolume(id, .5);
      await backend.setPlaybackSpeed(id, 1.5);
      await backend.seekTo(id, const Duration(seconds: 2));
      expect(session.commands, [
        (_Command.play, null),
        (_Command.pause, null),
        (_Command.loop, true),
        (_Command.volume, .5),
        (_Command.rate, 1.5),
        (_Command.seek, const Duration(seconds: 2)),
      ]);
      expect(await backend.getPosition(id), const Duration(seconds: 3));
      expect(
        backend.buildViewWithOptions(VideoViewOptions(playerId: id)).key,
        const ValueKey('native-video'),
      );
      await backend.dispose(id);
      await backend.play(id);
      expect(session.commands.length, 6);
      await subscription.cancel();
    },
  );

  test(
    'init closes all independent decoders and clears the registry',
    () async {
      final sessions = [_Session(), _Session()];
      var index = 0;
      final backend = ConfigAppLinuxVideoPlayer(
        sessionFactory: () => sessions[index++],
      );
      final first = await backend.create(_source());
      final second = await backend.create(_source());
      expect(first, isNot(second));
      expect(backend.activePlayerCount, 2);
      await backend.init();
      expect(backend.activePlayerCount, 0);
      expect(sessions.map((session) => session.disposals), [1, 1]);
      expect(sessions.map((session) => session.subscriptions), [0, 0]);
    },
  );

  test('event cancellation failure does not skip decoder cleanup', () async {
    final session = _Session()..cancelError = true;
    final backend = ConfigAppLinuxVideoPlayer(sessionFactory: () => session);
    final id = (await backend.create(_source()))!;
    await backend.dispose(id);
    expect(session.disposals, 1);
    expect(backend.activePlayerCount, 0);
  });

  test(
    'decoder cleanup failure is contained and registry is still cleared',
    () async {
      final session = _Session(disposeError: StateError('cleanup failed'));
      final backend = ConfigAppLinuxVideoPlayer(sessionFactory: () => session);
      final id = (await backend.create(_source()))!;
      await backend.dispose(id);
      await backend.dispose(id);
      expect(session.disposals, 1);
      expect(backend.activePlayerCount, 0);
    },
  );

  test(
    'real video_player controller can dispose after construction failure',
    () async {
      final previous = VideoPlayerPlatform.instance;
      addTearDown(() => VideoPlayerPlatform.instance = previous);
      final backend = ConfigAppLinuxVideoPlayer(
        sessionFactory: () => throw StateError('factory failed'),
      );
      VideoPlayerPlatform.instance = backend;
      final controller = VideoPlayerController.networkUrl(
        Uri.parse('http://localhost/video.mp4'),
      );
      await expectLater(
        controller.initialize(),
        throwsA(isA<PlatformException>()),
      );
      await controller.dispose().timeout(const Duration(seconds: 1));
      expect(backend.activePlayerCount, 0);
    },
  );

  for (final command in [_Command.loop, _Command.volume, _Command.pause]) {
    test(
      'video_player automatic ${command.name} failure is caught and released',
      () async {
        final previous = VideoPlayerPlatform.instance;
        addTearDown(() => VideoPlayerPlatform.instance = previous);
        final session = _Session(commandError: command);
        final backend = ConfigAppLinuxVideoPlayer(
          sessionFactory: () => session,
        );
        VideoPlayerPlatform.instance = backend;
        final controller = VideoPlayerController.networkUrl(
          Uri.parse('http://localhost/video.mp4'),
        );
        final initialization = controller.initialize();
        await _flush();
        session.sourceEvents.add(
          VideoEvent(
            eventType: VideoEventType.initialized,
            duration: const Duration(seconds: 10),
            size: const Size(640, 360),
          ),
        );
        await initialization;
        await _flush();
        expect(controller.value.hasError, isTrue);
        expect(session.disposals, 1);
        await controller.dispose();
        expect(backend.activePlayerCount, 0);
      },
    );
  }
}
