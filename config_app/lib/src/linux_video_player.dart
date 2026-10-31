import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:logging/logging.dart';
import 'package:video_player_platform_interface/video_player_platform_interface.dart';

import 'linux_video_session.dart';
import 'linux_video_session_native.dart';

/// The settings application's Linux adapter. A player ID exists before any
/// asynchronous native work, so even failed or cancelled startup is disposable.
class ConfigAppLinuxVideoPlayer extends VideoPlayerPlatform {
  ConfigAppLinuxVideoPlayer({
    LinuxVideoSession Function()? sessionFactory,
    this.initializationTimeout = const Duration(seconds: 15),
  }) : _sessionFactory = sessionFactory ?? NativeLinuxVideoSession.new,
       assert(initializationTimeout > Duration.zero);

  static void registerWith() {
    VideoPlayerPlatform.instance = ConfigAppLinuxVideoPlayer();
  }

  final LinuxVideoSession Function() _sessionFactory;
  final Duration initializationTimeout;
  final _players = <int, _VideoEntry>{};
  int _nextPlayerId = 1;

  @visibleForTesting
  int get activePlayerCount => _players.length;

  @override
  Future<void> init() async {
    final players = _players.values.toList();
    _players.clear();
    await Future.wait(players.map((entry) => entry.close()));
  }

  @override
  Future<int?> create(DataSource dataSource) => _create(dataSource);

  @override
  Future<int?> createWithOptions(VideoCreationOptions options) => _create(options.dataSource);

  Future<int> _create(DataSource source) async {
    final id = _nextPlayerId++;
    final entry = _VideoEntry(initializationTimeout);
    _players[id] = entry;
    // No factory/open failure may prevent video_player receiving its ID.
    scheduleMicrotask(() => entry.open(_sessionFactory, source));
    return id;
  }

  @override
  Stream<VideoEvent> videoEventsFor(int playerId) => _players[playerId]?.events.stream ?? const Stream.empty();

  @override
  Future<void> dispose(int playerId) async {
    await _players.remove(playerId)?.close();
  }

  @override
  Future<void> play(int playerId) => _command(playerId, (session) => session.play());

  @override
  Future<void> pause(int playerId) => _command(playerId, (session) => session.pause());

  @override
  Future<void> setLooping(int playerId, bool looping) => _command(playerId, (session) => session.setLooping(looping));

  @override
  Future<void> setVolume(int playerId, double volume) => _command(playerId, (session) => session.setVolume(volume));

  @override
  Future<void> setPlaybackSpeed(int playerId, double speed) =>
      _command(playerId, (session) => session.setPlaybackSpeed(speed));

  @override
  Future<void> seekTo(int playerId, Duration position) => _command(playerId, (session) => session.seekTo(position));

  Future<void> _command(int playerId, Future<void> Function(LinuxVideoSession session) action) async {
    final entry = _players[playerId];
    final session = entry?.session;
    if (entry == null || session == null) return;
    try {
      await action(session);
    } catch (error, stack) {
      // video_player also sends commands from event listeners without awaiting
      // their futures. Report failure through its error stream in every case.
      entry._fail(error, stack);
    }
  }

  @override
  Future<Duration> getPosition(int playerId) async => _players[playerId]?.session?.position ?? Duration.zero;

  @override
  Widget buildView(int playerId) => _players[playerId]?.session?.buildView() ?? const SizedBox.shrink();

  @override
  Widget buildViewWithOptions(VideoViewOptions options) => buildView(options.playerId);

  // Independent mpv players already mix their audio. Lifecycle and display-sleep
  // behavior remain owned by video_player / the application.
  @override
  Future<void> setMixWithOthers(bool mixWithOthers) async {}

  @override
  Future<void> setAllowBackgroundPlayback(bool allowBackgroundPlayback) async {}
}

class _VideoEntry {
  _VideoEntry(this.timeout);

  static final _log = Logger('ConfigAppLinuxVideoPlayer');
  final Duration timeout;
  final events = StreamController<VideoEvent>();
  LinuxVideoSession? _session;
  StreamSubscription<VideoEvent>? _subscription;
  Timer? _timer;
  Future<void>? _releaseFuture;
  Future<void>? _closeFuture;
  bool _closed = false;
  bool _failed = false;

  LinuxVideoSession? get session => _closed || _failed ? null : _session;

  Future<void> open(LinuxVideoSession Function() factory, DataSource source) async {
    if (_closed) return;
    try {
      _timer = Timer(timeout, () => _fail(TimeoutException('Video initialization timed out')));
      final session = _session = factory();
      _subscription = session.events.listen(
        (event) {
          if (_closed || _failed) return;
          if (event.eventType == VideoEventType.initialized) _timer?.cancel();
          events.add(event);
        },
        onError: (Object error, StackTrace stack) => _fail(error, stack),
        onDone: () {
          if (!_closed && !_failed) _fail(StateError('Video session closed'));
        },
      );
      await session.open(source);
    } catch (error, stack) {
      _fail(error, stack);
    }
  }

  void _fail(Object error, [StackTrace? stack]) {
    if (_closed || _failed) return;
    _failed = true;
    _timer?.cancel();
    _log.warning('Linux video playback failed', error, stack);
    events.addError(
      PlatformException(
        code: error is TimeoutException ? 'video_timeout' : 'video_playback',
        message: error is TimeoutException ? 'Video initialization timed out' : 'Video playback failed',
      ),
    );
    unawaited(_release());
  }

  Future<void> _release() => _releaseFuture ??= _releaseSession();

  Future<void> _releaseSession() async {
    try {
      await _subscription?.cancel();
    } catch (error, stack) {
      _log.warning('Linux video event cleanup failed: ${error.runtimeType}', error, stack);
    }
    _subscription = null;
    final session = _session;
    _session = null;
    try {
      await session?.dispose();
    } catch (error, stack) {
      _log.warning('Linux video cleanup failed: ${error.runtimeType}', error, stack);
    }
  }

  Future<void> close() => _closeFuture ??= _close();

  Future<void> _close() async {
    _closed = true;
    _timer?.cancel();
    // A controller may close before its events were ever listened to. Awaiting
    // a single-subscription stream's close in that case would wait forever.
    unawaited(events.close());
    await _release();
  }
}
