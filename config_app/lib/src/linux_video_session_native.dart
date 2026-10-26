import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:media_kit/media_kit.dart' as media;
import 'package:media_kit_video/media_kit_video.dart' as rendering;
import 'package:video_player_platform_interface/video_player_platform_interface.dart';

import 'linux_video_session.dart';

/// Translates public media_kit streams without retaining callbacks waiting for
/// a first frame. In particular, opening errors are delivered immediately.
class NativeLinuxVideoSession implements LinuxVideoSession {
  final _events = StreamController<VideoEvent>();
  final _subscriptions = <StreamSubscription<dynamic>>[];
  media.Player? _player;
  rendering.VideoController? _controller;
  Future<void>? _disposeFuture;
  bool _closed = false;
  bool _initialized = false;

  @override
  Stream<VideoEvent> get events => _events.stream;

  @override
  Duration get position => _player?.state.position ?? Duration.zero;

  void _emit(VideoEvent event) {
    if (!_closed) _events.add(event);
  }

  void _tryInitialize() {
    if (_closed || _initialized) return;
    final state = _player!.state;
    final width = state.videoParams.dw ?? 0;
    final height = state.videoParams.dh ?? 0;
    if (width <= 0 || height <= 0 || state.duration <= Duration.zero) return;
    final rotated = switch (state.videoParams.rotate) {
      90 || 270 => true,
      _ => false,
    };
    _initialized = true;
    _emit(
      VideoEvent(
        eventType: VideoEventType.initialized,
        duration: state.duration,
        size: Size(
          (rotated ? height : width).toDouble(),
          (rotated ? width : height).toDouble(),
        ),
      ),
    );
  }

  @override
  Future<void> open(DataSource source) async {
    if (_closed) return;
    final resource = _resourceFor(source);
    final player = _player = media.Player();
    final controller = _controller = rendering.VideoController(player);
    _subscriptions.addAll([
      player.stream.duration.listen((_) => _tryInitialize()),
      player.stream.videoParams.listen((_) => _tryInitialize()),
      player.stream.playing.listen(
        (playing) => _emit(
          VideoEvent(
            eventType: VideoEventType.isPlayingStateUpdate,
            isPlaying: playing,
          ),
        ),
      ),
      player.stream.completed.listen((completed) {
        if (completed) _emit(VideoEvent(eventType: VideoEventType.completed));
      }),
      player.stream.buffering.listen(
        (buffering) => _emit(
          VideoEvent(
            eventType: buffering
                ? VideoEventType.bufferingStart
                : VideoEventType.bufferingEnd,
          ),
        ),
      ),
      player.stream.buffer.listen(
        (buffer) => _emit(
          VideoEvent(
            eventType: VideoEventType.bufferingUpdate,
            buffered: [DurationRange(Duration.zero, buffer)],
          ),
        ),
      ),
      player.stream.error.listen((_) {
        if (!_closed) {
          _events.addError(
            PlatformException(
              code: 'linux_video',
              message: 'Video playback failed',
            ),
          );
        }
      }),
    ]);
    // Attach an error handler to controller initialization immediately. Closing
    // while it is pending never starts a media request after it finishes.
    await controller.platform.future;
    if (_closed) return;
    await player.open(
      media.Media(resource, httpHeaders: source.httpHeaders),
      play: false,
    );
  }

  @override
  Future<void> dispose() => _disposeFuture ??= _dispose();

  Future<void> _dispose() async {
    _closed = true;
    final player = _player;
    _player = null;
    try {
      await Future.wait(
        _subscriptions.map((subscription) => subscription.cancel()),
      );
    } finally {
      _subscriptions.clear();
      unawaited(_events.close());
      _controller = null;
      await player?.dispose();
    }
  }

  @override
  Future<void> play() async => _closed ? null : _player?.play();

  @override
  Future<void> pause() async => _closed ? null : _player?.pause();

  @override
  Future<void> setLooping(bool looping) async => _closed
      ? null
      : _player?.setPlaylistMode(
          looping ? media.PlaylistMode.single : media.PlaylistMode.none,
        );

  @override
  Future<void> setVolume(double volume) async =>
      _closed ? null : _player?.setVolume(volume.clamp(0, 1) * 100);

  @override
  Future<void> setPlaybackSpeed(double speed) async =>
      _closed ? null : _player?.setRate(speed);

  @override
  Future<void> seekTo(Duration position) async =>
      _closed ? null : _player?.seek(position);

  @override
  Widget buildView() {
    final controller = _controller;
    return controller == null || _closed
        ? const SizedBox.shrink()
        : rendering.Video(
            key: ObjectKey(controller),
            controller: controller,
            controls: rendering.NoVideoControls,
            wakelock: false,
            pauseUponEnteringBackgroundMode: false,
            resumeUponEnteringForegroundMode: false,
            fill: const Color(0x00000000),
          );
  }
}

String _resourceFor(DataSource source) {
  switch (source.sourceType) {
    case DataSourceType.asset:
      final asset = source.asset;
      if (asset == null) throw ArgumentError('Missing asset');
      final prefix = source.package == null
          ? ''
          : 'packages/${source.package}/';
      return 'asset:///$prefix$asset';
    case DataSourceType.network:
    case DataSourceType.file:
    case DataSourceType.contentUri:
      return source.uri ?? (throw ArgumentError('Missing media URI'));
  }
}
