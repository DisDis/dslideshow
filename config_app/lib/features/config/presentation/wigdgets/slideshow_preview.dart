import 'dart:async';
import 'dart:convert';
import 'dart:ui' as ui;
import 'dart:typed_data';

import 'package:config_app/features/config/domain/effect_settings_validation.dart';
import 'package:dio/dio.dart';
import 'package:config_app/features/config/presentation/wigdgets/effect_label.dart';
import 'package:config_app/features/config/presentation/wigdgets/preview_editor_layout.dart';
import 'package:config_app/features/theme/presentation/extensions/build_context_ext.dart';
import 'package:config_app/src/video_playback_support.dart';
import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_backend/storage.dart';
import 'package:dslideshow_flutter/effect.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/widgets/fixed_animation_controller.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/widgets/photo_motion.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/widgets/video_widget.dart';
import 'package:flutter/material.dart';

class SlideshowPreview extends StatefulWidget {
  final SlideShowConfig config;
  final Effect? selectedEffect;
  final List<ImageProvider>? images;

  /// An injected client is owned and closed by this preview.
  final Dio? mediaClient;
  final VideoSession Function(Uri)? videoFactory;
  const SlideshowPreview({
    super.key,
    required this.config,
    this.selectedEffect,
    this.images,
    this.mediaClient,
    this.videoFactory,
  });
  @override
  State<SlideshowPreview> createState() => SlideshowPreviewState();
}

class SlideshowPreviewState extends State<SlideshowPreview>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  static final _sampleUrls = [
    for (final id in [1, 6, 2])
      'https://yavuzceliker.github.io/sample-images/image-$id.jpg',
  ];
  late final Dio _mediaClient;
  CancelToken? _photoRequest;
  late final FixedAnimationController _controller;
  final _videoUrl = TextEditingController();
  Timer? _hold;
  Timer? _updateDebounce;
  VoidCallback? _cancelImage;
  Effect currentEffect = Effect.fadeEffect;
  late MediaSliderItemEffect _effect;
  Widget _current = const ColoredBox(color: Colors.black);
  Widget _next = const ColoredBox(color: Colors.black);
  VideoSession? _currentVideo, _nextVideo, _preparingVideo;
  final _videoListeners = <VideoSession, VoidCallback>{};
  ui.Image? _currentPhoto, _nextPhoto;
  PhotoMotionSession? _currentMotion, _nextMotion;
  late String _configSignature;
  bool _transitioning = false, _loading = false, _failed = false;
  bool _active = false, _routeActive = true, _resumed = true, _paused = false;
  int _index = 0, _generation = 0;
  int? _currentPhotoIndex, _nextPhotoIndex;
  int? _repeatFromIndex, _repeatToIndex;
  PreviewAspectRatio _aspect = PreviewAspectRatio.frame;
  bool get _supportsVideo =>
      supportsConfigAppVideo || widget.videoFactory != null;
  Size get _deviceSize => Size(2560, 2560 / _aspect.ratio);
  Duration get _transitionTime => Duration(
    milliseconds:
        (currentEffect.options.durationMs == 0
                ? widget.config.effects.safeDefaultDurationMs
                : currentEffect.options.durationMs)
            .clamp(1, 3600000),
  );
  Duration get _displayTime =>
      Duration(milliseconds: widget.config.displayTimeMs.clamp(1, 3600000));

  @override
  void initState() {
    super.initState();
    _mediaClient =
        widget.mediaClient ??
        Dio(
          BaseOptions(
            connectTimeout: const Duration(seconds: 30),
            receiveTimeout: const Duration(seconds: 30),
          ),
        );
    currentEffect = widget.selectedEffect?.canonical ?? currentEffect;
    _configSignature = jsonEncode(widget.config.toJson());
    _effect = currentEffect.createEffect(seed: 42);
    _controller = FixedAnimationController(
      vsync: this,
      duration: _transitionTime,
      animationBehavior: AnimationBehavior.preserve,
    )..addStatusListener(_onStatus);
    WidgetsBinding.instance.addObserver(this);
    _resumed =
        WidgetsBinding.instance.lifecycleState == null ||
        WidgetsBinding.instance.lifecycleState == AppLifecycleState.resumed;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _routeActive = TickerMode.valuesOf(context).enabled;
    _syncActivity();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _resumed = state == AppLifecycleState.resumed;
    _syncActivity();
  }

  void _syncActivity() {
    final next = _resumed && _routeActive;
    if (next == _active) return;
    _active = next;
    if (!next) {
      // Lifecycle suspension may prevent another frame. Send pause intent now,
      // before deferring disposal until mounted video views have detached.
      for (final session in [_currentVideo, _nextVideo, _preparingVideo]) {
        if (session != null) {
          unawaited(session.setPlaying(false).catchError((Object _) {}));
        }
      }
      _cancelPending();
      final video = _currentVideo,
          photo = _currentPhoto,
          motion = _currentMotion;
      _currentVideo = null;
      _currentPhoto = null;
      _currentPhotoIndex = null;
      _repeatFromIndex = _repeatToIndex = null;
      _currentMotion = null;
      setState(() => _current = const ColoredBox(color: Colors.black));
      _afterFrame(() {
        _release(video);
        photo?.dispose();
        motion?.dispose();
      });
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted && _active && !_paused) _loadNext();
      });
    }
  }

  @override
  void didUpdateWidget(covariant SlideshowPreview oldWidget) {
    super.didUpdateWidget(oldWidget);
    currentEffect = widget.selectedEffect?.canonical ?? currentEffect;
    final signature = jsonEncode(widget.config.toJson());
    if (signature != _configSignature ||
        oldWidget.images != widget.images ||
        oldWidget.selectedEffect != widget.selectedEffect) {
      _configSignature = signature;
      _updateDebounce?.cancel();
      _updateDebounce = Timer(const Duration(milliseconds: 150), () {
        if (mounted && _active && !_paused) _loadNext();
      });
    }
  }

  void _afterFrame(VoidCallback callback) =>
      WidgetsBinding.instance.addPostFrameCallback((_) => callback());
  void _release(VideoSession? session) {
    if (session == null) return;
    final listener = _videoListeners.remove(session);
    if (listener != null) session.controller?.removeListener(listener);
    unawaited(_disposeVideo(session));
  }

  Future<void> _disposeVideo(VideoSession session) async {
    // Error notifications may arrive inside a controller listener.
    await Future<void>.value();
    try {
      await session.dispose();
    } catch (_) {}
  }

  bool _ownsVideo(VideoSession session) =>
      identical(session, _currentVideo) ||
      identical(session, _nextVideo) ||
      identical(session, _preparingVideo);

  void _watchVideo(VideoSession session) {
    final controller = session.controller;
    if (controller == null) return;
    void listener() {
      if (!mounted || !_active || !_ownsVideo(session)) return;
      if (!controller.value.hasError) return;
      final currentFailed = identical(session, _currentVideo);
      // This invalidates all pending preparation/transition generations and
      // cancels automatic advancement of the failing sequence.
      _cancelPending();
      if (currentFailed) _currentVideo = null;
      setState(() {
        if (currentFailed) _current = const ColoredBox(color: Colors.black);
        _failed = true;
      });
      if (currentFailed) _afterFrame(() => _release(session));
      if (!_paused) _currentMotion?.setPlaying(true);
    }

    _videoListeners[session] = listener;
    controller.addListener(listener);
    listener();
  }

  void _cancelPending() {
    ++_generation;
    _hold?.cancel();
    _hold = null;
    _cancelImage?.call();
    _cancelImage = null;
    _photoRequest?.cancel();
    _photoRequest = null;
    _controller.stop();
    _release(_preparingVideo);
    _preparingVideo = null;
    _currentMotion?.setPlaying(false);
    final video = _nextVideo, photo = _nextPhoto, motion = _nextMotion;
    _nextVideo = null;
    _nextPhoto = null;
    _nextPhotoIndex = null;
    _nextMotion = null;
    _afterFrame(() {
      _release(video);
      photo?.dispose();
      motion?.dispose();
    });
    _loading = false;
    _transitioning = false;
  }

  void _onStatus(AnimationStatus status) {
    if (status != AnimationStatus.completed ||
        !mounted ||
        !_active ||
        _paused) {
      return;
    }
    final video = _currentVideo, photo = _currentPhoto, motion = _currentMotion;
    setState(() {
      _current = _next;
      _currentVideo = _nextVideo;
      _nextVideo = null;
      _currentPhoto = _nextPhoto;
      _currentPhotoIndex = _nextPhotoIndex;
      _nextPhotoIndex = null;
      _nextPhoto = null;
      _currentMotion = _nextMotion;
      _nextMotion = null;
      _currentMotion?.setPlaying(true);
      _transitioning = false;
    });
    _afterFrame(() {
      _release(video);
      photo?.dispose();
      motion?.dispose();
    });
    _scheduleNext();
  }

  void _scheduleNext() {
    _hold?.cancel();
    if (_active && !_paused) _hold = Timer(_displayTime, _loadNext);
  }

  Future<ui.Image> _resolvePhoto(ImageProvider provider) async {
    final result = Completer<ui.Image>();
    final stream = provider.resolve(createLocalImageConfiguration(context));
    late ImageStreamListener listener;
    Timer? timeout;
    void cancel() {
      stream.removeListener(listener);
      timeout?.cancel();
      if (!result.isCompleted) result.completeError(const _PreviewCancelled());
    }

    listener = ImageStreamListener(
      (info, _) {
        if (!result.isCompleted) result.complete(info.image.clone());
        info.dispose();
      },
      onError: (Object error, StackTrace? stack) {
        if (!result.isCompleted) result.completeError(error, stack);
      },
    );
    _cancelImage = cancel;
    stream.addListener(listener);
    timeout = Timer(const Duration(seconds: 30), () {
      if (!result.isCompleted) {
        result.completeError(TimeoutException('Preview image'));
      }
    });
    try {
      return await result.future;
    } finally {
      timeout.cancel();
      stream.removeListener(listener);
      if (identical(_cancelImage, cancel)) _cancelImage = null;
    }
  }

  /// Mirrors ImageWidget's production photo composition. ImageWidget itself
  /// reads dart:io files and cannot consume browser/network ImageProviders.
  Future<ui.Image> _preparePhoto(
    ImageProvider provider, {
    bool evict = false,
  }) async {
    try {
      return await _composePhoto(await _resolvePhoto(provider));
    } finally {
      if (evict) unawaited(provider.evict());
    }
  }

  Future<ui.Image> _composePhoto(ui.Image source) async {
    ui.Picture? picture;
    try {
      final size = _deviceSize;
      final config = widget.config;
      final recorder = ui.PictureRecorder();
      final canvas = Canvas(recorder)
        ..drawColor(Color(config.backgroundColor), BlendMode.src);
      void draw(BoxFit fit, Paint paint) {
        final sourceSize = Size(
          source.width.toDouble(),
          source.height.toDouble(),
        );
        final fitted = applyBoxFit(fit, sourceSize, size);
        canvas.drawImageRect(
          source,
          Alignment.center.inscribe(fitted.source, Offset.zero & sourceSize),
          Alignment.center.inscribe(fitted.destination, Offset.zero & size),
          paint,
        );
      }

      if (config.isBlurredBackground) {
        final paint = Paint()
          ..color = Colors.white.withValues(
            alpha: config.backgroundOpacity.clamp(0, 1),
          )
          ..filterQuality = FilterQuality.high
          ..isAntiAlias = true;
        if (config.backgroundBlurSigma > 0) {
          paint.imageFilter = ui.ImageFilter.blur(
            sigmaX: config.backgroundBlurSigma.toDouble(),
            sigmaY: config.backgroundBlurSigma.toDouble(),
          );
        }
        draw(BoxFit.cover, paint);
      }
      draw(
        BoxFit.contain,
        Paint()
          ..filterQuality = FilterQuality.high
          ..isAntiAlias = true,
      );
      picture = recorder.endRecording();
      return await picture.toImage(size.width.round(), size.height.round());
    } finally {
      picture?.dispose();
      source.dispose();
    }
  }

  Future<ui.Image> _photoAt(int index, bool Function() stale) async {
    final images = widget.images;
    if (images != null) {
      if (images.isEmpty) throw StateError('No preview images');
      return _preparePhoto(images[index % images.length]);
    }
    final cancellation = CancelToken();
    _photoRequest = cancellation;
    try {
      final response = await _mediaClient.get<List<int>>(
        _sampleUrls[index % _sampleUrls.length],
        options: Options(responseType: ResponseType.bytes),
        cancelToken: cancellation,
      );
      if (stale()) throw const _PreviewCancelled();
      final bytes = response.data;
      if (bytes == null || bytes.isEmpty) throw const FormatException();
      return await _preparePhoto(
        MemoryImage(Uint8List.fromList(bytes)),
        evict: true,
      );
    } finally {
      if (identical(_photoRequest, cancellation)) _photoRequest = null;
    }
  }

  PhotoMotionSession? _photoMotion(int index) =>
      widget.config.photoMotion.mode == PhotoMotionMode.kenBurns
      ? PhotoMotionSession(
          vsync: this,
          duration: _displayTime,
          config: widget.config.photoMotion,
          seed: index,
        )
      : null;

  void _repeat() {
    _updateDebounce?.cancel();
    _loadNext(fromPhotoIndex: _repeatFromIndex, targetIndex: _repeatToIndex);
  }

  Future<void> _loadNext({int? fromPhotoIndex, int? targetIndex}) async {
    if (!mounted || !_active || _paused) return;
    _cancelPending();
    final generation = _generation;
    final selectedEffect = currentEffect;
    final selectedDuration = _transitionTime;
    final fallbackDuration = Duration(
      milliseconds: widget.config.effects.safeDefaultDurationMs,
    );
    setState(() {
      _loading = true;
      _failed = false;
    });
    VideoSession? video;
    ui.Image? photo;
    PhotoMotionSession? motion;
    bool stale() =>
        !mounted || generation != _generation || !_active || _paused;
    try {
      // The effects editor starts with a prepared photo, so even the first
      // transition demonstrates the selected effect between two real images.
      if (fromPhotoIndex != null ||
          (widget.selectedEffect != null &&
              _currentPhoto == null &&
              _currentVideo == null)) {
        final sourceIndex = fromPhotoIndex ?? _index++;
        photo = await _photoAt(sourceIndex, stale);
        if (stale()) {
          photo.dispose();
          return;
        }
        final oldPhoto = _currentPhoto;
        final oldVideo = _currentVideo;
        final oldMotion = _currentMotion;
        final source = RawImage(
          image: photo,
          fit: BoxFit.contain,
          filterQuality: FilterQuality.high,
        );
        _currentPhoto = photo;
        _currentPhotoIndex = sourceIndex;
        _currentVideo = null;
        _currentMotion = _photoMotion(sourceIndex);
        photo = null;
        setState(
          () => _current = SizedBox.expand(
            child: _currentMotion?.view(source) ?? source,
          ),
        );
        _afterFrame(() {
          oldPhoto?.dispose();
          oldMotion?.dispose();
          _release(oldVideo);
        });
      }
      final url = _videoUrl.text.trim();
      final index = targetIndex ?? _index++;
      Widget next;
      if (_supportsVideo &&
          selectedEffect.type != EffectType.waterRefraction &&
          url.isNotEmpty &&
          index.isOdd) {
        final uri = Uri.tryParse(url);
        if (uri == null ||
            !['http', 'https'].contains(uri.scheme) ||
            uri.host.isEmpty) {
          throw const FormatException();
        }
        video = widget.videoFactory?.call(uri) ?? VideoSession.network(uri);
        _preparingVideo = video;
        _watchVideo(video);
        if (stale()) return;
        await video.prepare().timeout(const Duration(seconds: 15));
        next = VideoWidget(MediaItem('preview-video', uri), session: video);
      } else {
        photo = await _photoAt(index, stale);
        next = RawImage(
          image: photo,
          fit: BoxFit.contain,
          filterQuality: FilterQuality.high,
        );
      }
      if (stale()) {
        _release(video);
        photo?.dispose();
        return;
      }
      final descriptor =
          selectedEffect.supportsMedia(
            _currentPhoto != null
                ? TransitionMedia.photo
                : TransitionMedia.special,
            photo != null ? TransitionMedia.photo : TransitionMedia.video,
          )
          ? selectedEffect
          : Effect.fadeEffect;
      final effect = descriptor.createEffect(seed: 42);
      await effect.prepare();
      if (stale()) {
        _release(video);
        photo?.dispose();
        return;
      }
      if (effect is WaterRefractionEffect) {
        effect.bindPhotos(
          _currentPhoto!,
          photo!,
          fromCamera: _currentMotion?.path.transform(
            _deviceSize,
            _currentMotion!.progress,
          ),
        );
      }
      motion = photo == null ? null : _photoMotion(index);
      if (video != null) await video.setPlaying(true);
      if (stale()) {
        _release(video);
        photo?.dispose();
        motion?.dispose();
        return;
      }
      if (identical(_preparingVideo, video)) _preparingVideo = null;
      _repeatFromIndex = _currentPhoto != null && photo != null
          ? _currentPhotoIndex
          : null;
      _repeatToIndex = _repeatFromIndex == null ? null : index;
      _nextPhotoIndex = photo == null ? null : index;
      _nextVideo = video;
      _nextPhoto = photo;
      _nextMotion = motion;
      photo = null;
      video = null;
      motion = null;
      setState(() {
        _next = SizedBox.expand(child: _nextMotion?.view(next) ?? next);
        _effect = effect;
        _loading = false;
        _transitioning = true;
      });
      _controller.duration = descriptor.type == selectedEffect.type
          ? selectedDuration
          : fallbackDuration;
      _controller.forward(from: 0);
    } catch (e) {
      photo?.dispose();
      if (identical(_preparingVideo, video)) _preparingVideo = null;
      _release(video);
      motion?.dispose();
      if (stale() || e is _PreviewCancelled) return;
      setState(() {
        _loading = false;
        _failed = true;
      });
      _currentMotion?.setPlaying(true);
      // Retry is explicit; a broken URL must not trigger an endless request loop.
    }
  }

  void onChanged(Effect? effect) {
    if (effect == null) return;
    setState(() => currentEffect = effect.canonical);
    _loadNext();
  }

  void _togglePause() {
    setState(() {
      _paused = !_paused;
      if (_paused) {
        _cancelPending();
        final video = _currentVideo;
        if (video != null) {
          unawaited(video.setPlaying(false).catchError((Object _) {}));
        }
      } else {
        final video = _currentVideo;
        if (video != null) {
          unawaited(video.setPlaying(true).catchError((Object _) {}));
        }
        _currentMotion?.setPlaying(true);
        if (_currentPhoto == null && video == null) {
          _loadNext();
        } else {
          _scheduleNext();
        }
      }
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    ++_generation;
    _hold?.cancel();
    _updateDebounce?.cancel();
    _cancelImage?.call();
    _photoRequest?.cancel();
    _mediaClient.close(force: true);
    _controller.dispose();
    _currentPhoto?.dispose();
    _nextPhoto?.dispose();
    _currentMotion?.dispose();
    _nextMotion?.dispose();
    _release(_currentVideo);
    _release(_nextVideo);
    _release(_preparingVideo);
    _videoUrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = context.localizations;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        DevicePreviewViewport(
          aspectRatio: _aspect.ratio,
          child: ColoredBox(
            color: Colors.black,
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, _) => _transitioning
                  ? _effect.createTransformWidget(
                      context,
                      _current,
                      _next,
                      _controller,
                      _deviceSize.width,
                      _deviceSize.height,
                    )
                  : _current,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          l.preview_local_controls,
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const SizedBox(height: 12),
        if (widget.selectedEffect == null)
          DropdownButtonFormField<Effect>(
            key: const ValueKey('preview-effect'),
            initialValue: Effect(currentEffect.type),
            isExpanded: true,
            decoration: InputDecoration(labelText: l.preview_effect),
            onChanged: onChanged,
            items: [
              for (final effect in Effect.values)
                DropdownMenuItem(
                  value: effect,
                  child: Text(
                    effectLabel(context, effect),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
            ],
          ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: DropdownButtonFormField<PreviewAspectRatio>(
                key: const ValueKey('preview-aspect'),
                initialValue: _aspect,
                isExpanded: true,
                decoration: InputDecoration(labelText: l.preview_aspect),
                onChanged: (value) {
                  if (value == null || value == _aspect) return;
                  setState(() => _aspect = value);
                  _loadNext();
                },
                items: [
                  for (final aspect in PreviewAspectRatio.values)
                    DropdownMenuItem(value: aspect, child: Text(aspect.label)),
                ],
              ),
            ),
            const SizedBox(width: 12),
            IconButton(
              key: const ValueKey('preview-pause'),
              tooltip: _paused ? l.preview_resume : l.preview_pause,
              onPressed: _togglePause,
              icon: Icon(_paused ? Icons.play_arrow : Icons.pause),
            ),
          ],
        ),
        const SizedBox(height: 12),
        OutlinedButton.icon(
          key: const ValueKey('preview-repeat'),
          onPressed: _paused || _loading ? null : _repeat,
          icon: const Icon(Icons.replay),
          label: Text(l.preview_repeat),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _videoUrl,
                key: const ValueKey('preview-video-url'),
                enabled:
                    _supportsVideo &&
                    currentEffect.type != EffectType.waterRefraction,
                decoration: InputDecoration(labelText: l.preview_video_url),
                onSubmitted: (_) => _loadNext(),
              ),
            ),
            IconButton(
              tooltip: l.preview_play,
              onPressed: _paused ? null : _loadNext,
              icon: const Icon(Icons.replay),
            ),
          ],
        ),
        if (!_supportsVideo)
          Text(
            l.video_platform_unavailable,
            key: const ValueKey('preview-video-unavailable'),
          )
        else if (currentEffect.type == EffectType.waterRefraction)
          Text(l.water_photo_only),
        SizedBox(
          height: 4,
          child: _loading ? const LinearProgressIndicator(minHeight: 4) : null,
        ),
        if (_failed)
          Text(
            l.preview_failed,
            key: const ValueKey('preview-error'),
            style: TextStyle(color: Theme.of(context).colorScheme.error),
          ),
        const SizedBox(height: 8),
        Text(
          l.transition_display_times(
            _transitionTime.inMilliseconds,
            widget.config.displayTimeMs,
          ),
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}

class _PreviewCancelled implements Exception {
  const _PreviewCancelled();
}
