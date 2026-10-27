import 'dart:async';

import 'package:config_app/features/gallery/presentation/widgets/video_unavailable.dart';
import 'package:config_app/features/theme/presentation/extensions/build_context_ext.dart';
import 'package:config_app/src/video_playback_support.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:video_player/video_player.dart';

class VideoGridItem extends StatefulWidget {
  final String url;
  final String title;
  final VideoPlayerController Function(Uri)? controllerFactory;
  final Duration initializationTimeout;
  final bool active;
  final Widget? poster;

  const VideoGridItem({
    super.key,
    required this.url,
    required this.title,
    this.controllerFactory,
    this.initializationTimeout = const Duration(seconds: 15),
    this.active = true,
    this.poster,
  }) : assert(initializationTimeout > Duration.zero);

  @override
  State<VideoGridItem> createState() => _VideoGridItemState();
}

class _VideoGridItemState extends State<VideoGridItem> {
  static final Logger _log = Logger('_VideoGridItemState');

  VideoPlayerController? _controller;
  int _generation = 0;
  bool _isInitialized = false;
  bool _isPlaying = false;
  bool _busy = false;
  bool _hasError = false;
  bool _resumeWhenVisible = false;
  int _visibilityGeneration = 0;
  Future<void> _visibilityOperation = Future<void>.value();

  bool _isCurrent(VideoPlayerController controller, int generation) =>
      mounted &&
      generation == _generation &&
      identical(controller, _controller);

  void _releaseController() {
    final controller = _controller;
    _controller = null;
    controller?.removeListener(_onControllerChanged);
    if (controller != null) unawaited(_disposeController(controller));
  }

  Future<void> _disposeController(VideoPlayerController controller) async {
    // An error can arrive while the controller is notifying its listeners.
    // Detach immediately, then dispose after that notification completes.
    await Future<void>.value();
    try {
      await controller.dispose();
    } catch (_) {
      // Plugin errors can include a signed media URL or credentials.
      _log.warning('Video controller cleanup failed.');
    }
  }

  @override
  void didUpdateWidget(VideoGridItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.url != widget.url ||
        oldWidget.controllerFactory != widget.controllerFactory) {
      _generation++;
      _releaseController();
      _isInitialized = false;
      _isPlaying = false;
      _busy = false;
      _hasError = false;
      _resumeWhenVisible = false;
      ++_visibilityGeneration;
      _visibilityOperation = Future<void>.value();
    } else if (oldWidget.active != widget.active) {
      final controller = _controller;
      if (controller != null && _isInitialized) {
        if (!widget.active) {
          _resumeWhenVisible = controller.value.isPlaying;
          unawaited(_setRoutePlayback(controller, false, _generation));
        } else if (_resumeWhenVisible) {
          _resumeWhenVisible = false;
          unawaited(_setRoutePlayback(controller, true, _generation));
        }
      }
    }
  }

  Future<void> _setRoutePlayback(
    VideoPlayerController controller,
    bool play,
    int generation,
  ) async {
    final visibilityGeneration = ++_visibilityGeneration;
    final previous = _visibilityOperation;
    final operation = _applyRoutePlayback(
      previous,
      controller,
      play,
      generation,
      visibilityGeneration,
    );
    _visibilityOperation = operation;
    await operation;
  }

  Future<void> _applyRoutePlayback(
    Future<void> previous,
    VideoPlayerController controller,
    bool play,
    int generation,
    int visibilityGeneration,
  ) async {
    try {
      await previous;
      if (!_isCurrent(controller, generation) ||
          visibilityGeneration != _visibilityGeneration) {
        return;
      }
      if (play) {
        await controller.play();
      } else {
        await controller.pause();
      }
      if (_isCurrent(controller, generation) &&
          visibilityGeneration == _visibilityGeneration) {
        setState(() => _isPlaying = controller.value.isPlaying);
      }
    } catch (_) {
      _fail(generation);
    }
  }

  @override
  void dispose() {
    _generation++;
    _releaseController();
    super.dispose();
  }

  void _onControllerChanged() {
    final controller = _controller;
    if (!mounted || controller == null) return;
    if (controller.value.hasError) {
      _fail(_generation);
    } else if (_isInitialized && _isPlaying != controller.value.isPlaying) {
      setState(() => _isPlaying = controller.value.isPlaying);
    }
  }

  void _fail(int generation) {
    if (!mounted || generation != _generation) return;
    _generation++;
    _releaseController();
    _log.warning('Video playback failed.');
    setState(() {
      _isInitialized = false;
      _isPlaying = false;
      _busy = false;
      _hasError = true;
    });
  }

  Future<void> _initializeVideo() async {
    if (!widget.active ||
        !supportsConfigAppVideo ||
        _controller != null ||
        _busy ||
        _hasError) {
      return;
    }
    final generation = ++_generation;
    setState(() => _busy = true);
    try {
      final controller =
          widget.controllerFactory?.call(Uri.parse(widget.url)) ??
          VideoPlayerController.networkUrl(Uri.parse(widget.url));
      _controller = controller;
      controller.addListener(_onControllerChanged);
      await controller.initialize().timeout(widget.initializationTimeout);
      if (!_isCurrent(controller, generation)) return;
      await controller.setLooping(true);
      if (!_isCurrent(controller, generation)) return;
      // Visibility can change while native play/pause is pending, before the
      // controller is exposed as initialized. Reconcile the latest demand in
      // this same serial startup operation before publishing readiness.
      while (_isCurrent(controller, generation)) {
        final active = widget.active;
        if (active) {
          await controller.play();
        } else {
          await controller.pause();
        }
        if (!_isCurrent(controller, generation)) return;
        if (widget.active == active) {
          _resumeWhenVisible = !active;
          break;
        }
      }
      if (!_isCurrent(controller, generation)) return;
      setState(() {
        _isInitialized = true;
        _isPlaying = controller.value.isPlaying;
        _busy = false;
      });
    } catch (_) {
      _fail(generation);
    }
  }

  Future<void> _playPause() async {
    final controller = _controller;
    if (controller == null || !_isInitialized || _busy || !widget.active) {
      return;
    }
    final generation = _generation;
    setState(() => _busy = true);
    try {
      if (controller.value.isPlaying) {
        await controller.pause();
      } else {
        await controller.play();
      }
      if (!_isCurrent(controller, generation)) return;
      setState(() {
        _isPlaying = controller.value.isPlaying;
        _busy = false;
      });
    } catch (_) {
      _fail(generation);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!supportsConfigAppVideo) {
      return widget.poster ?? VideoUnavailable(title: widget.title);
    }

    final theme = Theme.of(context);
    if (_hasError) {
      return ColoredBox(
        color: theme.colorScheme.errorContainer,
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.error_outline,
                  color: theme.colorScheme.onErrorContainer,
                ),
                Text(
                  widget.title,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onErrorContainer,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  context.localizations.video_load_failed,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onErrorContainer,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      );
    }

    final controller = _controller;
    if (_isInitialized && controller != null) {
      return Stack(
        fit: StackFit.expand,
        children: [
          Tooltip(
            message: widget.title,
            child: FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                width: controller.value.size.width,
                height: controller.value.size.height,
                child: VideoPlayer(controller),
              ),
            ),
          ),
          GestureDetector(
            key: const ValueKey('video-grid-toggle'),
            onTap: _busy ? null : _playPause,
            behavior: HitTestBehavior.translucent,
          ),
          if (!_isPlaying)
            Center(
              child: IconButton(
                onPressed: _busy ? null : _playPause,
                tooltip: context.localizations.preview_resume,
                icon: Icon(
                  Icons.play_circle_fill,
                  size: 50,
                  color: theme.colorScheme.primary,
                ),
              ),
            ),
        ],
      );
    }

    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned.fill(
          child:
              widget.poster ??
              ColoredBox(color: theme.colorScheme.surfaceContainerHighest),
        ),
        if (_busy)
          const CircularProgressIndicator()
        else
          IconButton(
            onPressed: _initializeVideo,
            tooltip: context.localizations.video_load,
            icon: Icon(
              Icons.play_circle_outline,
              size: 40,
              color: theme.colorScheme.primary,
            ),
          ),
        Positioned(
          left: 8,
          right: 8,
          bottom: 10,
          child: Column(
            children: [
              Text(
                widget.title,
                style: theme.textTheme.bodySmall,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              if (!_busy)
                Text(
                  context.localizations.video_tap_to_play,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
