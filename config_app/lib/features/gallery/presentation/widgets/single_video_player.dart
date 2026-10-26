import 'dart:async';

import 'package:config_app/features/gallery/presentation/widgets/video_unavailable.dart';
import 'package:config_app/features/theme/presentation/extensions/build_context_ext.dart';
import 'package:config_app/src/video_playback_support.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:video_player/video_player.dart';

enum _VideoPhase { unavailable, loading, ready, failed }

class SingleVideoPlayer extends StatefulWidget {
  final Uri uri;
  final VoidCallback onContentTap;
  final VideoPlayerController Function(Uri)? controllerFactory;
  final Duration initializationTimeout;

  const SingleVideoPlayer({
    super.key,
    required this.uri,
    required this.onContentTap,
    this.controllerFactory,
    this.initializationTimeout = const Duration(seconds: 15),
  }) : assert(initializationTimeout > Duration.zero);

  @override
  State<SingleVideoPlayer> createState() => _SingleVideoPlayerState();
}

class _SingleVideoPlayerState extends State<SingleVideoPlayer> {
  static final _log = Logger('SingleVideoPlayer');
  VideoPlayerController? _controller;
  VoidCallback? _controllerListener;
  _VideoPhase _phase = _VideoPhase.loading;
  int _generation = 0;
  bool _busy = false;
  double? _seekPosition;

  @override
  void initState() {
    super.initState();
    _start();
  }

  @override
  void didUpdateWidget(covariant SingleVideoPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.uri != widget.uri ||
        oldWidget.controllerFactory != widget.controllerFactory) {
      _start();
    }
  }

  bool _current(VideoPlayerController controller, int generation) =>
      mounted &&
      generation == _generation &&
      identical(_controller, controller);

  void _start() {
    final generation = ++_generation;
    _release();
    _busy = false;
    _seekPosition = null;
    if (!supportsConfigAppVideo) {
      _phase = _VideoPhase.unavailable;
      return;
    }
    _phase = _VideoPhase.loading;
    try {
      final controller =
          widget.controllerFactory?.call(widget.uri) ??
          VideoPlayerController.networkUrl(widget.uri);
      _controller = controller;
      _controllerListener = () {
        if (!_current(controller, generation)) return;
        if (controller.value.hasError) {
          _fail(controller, generation);
        } else if (_phase == _VideoPhase.ready) {
          setState(() {});
        }
      };
      controller.addListener(_controllerListener!);
      unawaited(_initialize(controller, generation));
    } catch (_) {
      _release();
      _phase = _VideoPhase.failed;
      _log.warning('Video controller creation failed.');
    }
  }

  Future<void> _initialize(
    VideoPlayerController controller,
    int generation,
  ) async {
    try {
      await controller.initialize().timeout(widget.initializationTimeout);
      if (!_current(controller, generation)) return;
      await controller.setLooping(true);
      if (!_current(controller, generation)) return;
      await controller.play();
      if (!_current(controller, generation)) return;
      setState(() => _phase = _VideoPhase.ready);
    } catch (_) {
      _fail(controller, generation);
    }
  }

  void _fail(VideoPlayerController controller, int generation) {
    if (!_current(controller, generation)) return;
    ++_generation;
    _release();
    _log.warning('Video playback failed.');
    setState(() {
      _phase = _VideoPhase.failed;
      _busy = false;
      _seekPosition = null;
    });
  }

  void _release() {
    final controller = _controller;
    final listener = _controllerListener;
    _controller = null;
    _controllerListener = null;
    if (controller == null) return;
    if (listener != null) controller.removeListener(listener);
    unawaited(_disposeController(controller));
  }

  Future<void> _disposeController(VideoPlayerController controller) async {
    // A platform error may be delivered from a ChangeNotifier callback.
    await Future<void>.value();
    try {
      await controller.dispose();
    } catch (_) {
      _log.warning('Video controller cleanup failed.');
    }
  }

  void _retry() {
    _start();
    setState(() {});
  }

  @override
  void dispose() {
    ++_generation;
    _release();
    super.dispose();
  }

  Future<void> _togglePlay() async {
    final controller = _controller;
    if (controller == null || _busy || _phase != _VideoPhase.ready) return;
    final generation = _generation;
    setState(() {
      _busy = true;
      _seekPosition = null;
    });
    try {
      if (controller.value.isPlaying) {
        await controller.pause();
      } else {
        await controller.play();
      }
      if (_current(controller, generation)) setState(() => _busy = false);
    } catch (_) {
      _fail(controller, generation);
    }
  }

  Future<void> _seekTo(double milliseconds) async {
    final controller = _controller;
    if (controller == null || _busy || _phase != _VideoPhase.ready) return;
    final generation = _generation;
    setState(() {
      _busy = true;
      _seekPosition = milliseconds;
    });
    try {
      await controller.seekTo(Duration(milliseconds: milliseconds.round()));
      if (_current(controller, generation)) {
        setState(() {
          _busy = false;
          _seekPosition = null;
        });
      }
    } catch (_) {
      _fail(controller, generation);
    }
  }

  String _time(Duration position) {
    final seconds = position.isNegative ? 0 : position.inSeconds;
    final minutes = (seconds ~/ 60 % 60).toString().padLeft(2, '0');
    final remainder = (seconds % 60).toString().padLeft(2, '0');
    final hours = seconds ~/ 3600;
    return hours > 0 ? '$hours:$minutes:$remainder' : '$minutes:$remainder';
  }

  @override
  Widget build(BuildContext context) {
    if (_phase == _VideoPhase.unavailable) return const VideoUnavailable();
    if (_phase == _VideoPhase.failed) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline,
              color: Theme.of(context).colorScheme.error,
            ),
            Text(context.localizations.video_load_failed),
            TextButton(
              onPressed: _retry,
              child: Text(context.localizations.retry_button),
            ),
          ],
        ),
      );
    }
    final controller = _controller;
    if (_phase != _VideoPhase.ready || controller == null) {
      return const Center(child: CircularProgressIndicator());
    }
    final playing = controller.value.isPlaying;
    final duration = controller.value.duration;
    final durationMs = duration.inMilliseconds.toDouble();
    final maxPosition = durationMs > 0 ? durationMs : 1.0;
    final positionMs =
        (_seekPosition ?? controller.value.position.inMilliseconds.toDouble())
            .clamp(0.0, maxPosition);

    return AspectRatio(
      aspectRatio: controller.value.aspectRatio,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: widget.onContentTap,
            child: VideoPlayer(controller),
          ),

          if (!playing)
            Center(
              child: IconButton(
                iconSize: 64,
                tooltip: context.localizations.preview_resume,
                icon: Icon(
                  Icons.play_circle_fill,
                  color: Theme.of(context).colorScheme.primary,
                ),
                onPressed: _busy ? null : _togglePlay,
              ),
            ),

          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: ColoredBox(
              color: Theme.of(context).colorScheme.surface
                  .withValues(alpha: .9),
              child: Row(
                children: [
                  IconButton(
                    key: const ValueKey('single-video-toggle'),
                    onPressed: _busy ? null : _togglePlay,
                    tooltip: playing
                        ? context.localizations.preview_pause
                        : context.localizations.preview_resume,
                    icon: Icon(
                      playing
                          ? Icons.pause_circle_filled
                          : Icons.play_circle_fill,
                    ),
                  ),
                  Expanded(
                    child: Semantics(
                      label: context.localizations.video_seek,
                      child: Slider(
                        key: const ValueKey('single-video-seek'),
                        min: 0,
                        max: maxPosition,
                        value: positionMs,
                        semanticFormatterCallback: (value) =>
                            _time(Duration(milliseconds: value.round())),
                        onChanged: _busy || durationMs <= 0
                            ? null
                            : (value) => setState(() => _seekPosition = value),
                        onChangeEnd: _busy || durationMs <= 0 ? null : _seekTo,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: Text(
                      '${_time(Duration(milliseconds: positionMs.round()))} / ${_time(duration)}',
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
