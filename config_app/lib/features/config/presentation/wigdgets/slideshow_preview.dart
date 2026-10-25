import 'dart:async';
import 'dart:ui' as ui;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:config_app/features/theme/presentation/extensions/build_context_ext.dart';
import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_backend/storage.dart';
import 'package:dslideshow_flutter/effect.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/widgets/fixed_animation_controller.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/widgets/video_widget.dart';
import 'package:flutter/material.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/widgets/photo_motion.dart';
import 'package:logging/logging.dart';

class SlideshowPreview extends StatefulWidget {
  final SlideShowConfig config;
  final List<ImageProvider>? images;
  const SlideshowPreview({super.key, required this.config, this.images});
  @override
  State<SlideshowPreview> createState() => SlideshowPreviewState();
}

class SlideshowPreviewState extends State<SlideshowPreview>
    with TickerProviderStateMixin {
  static final _log = Logger('SlideshowPreview');
  static final List<ImageProvider> _samples = [
    for (final id in [1, 6, 2])
      CachedNetworkImageProvider(
        'https://yavuzceliker.github.io/sample-images/image-$id.jpg',
      ),
  ];
  late final FixedAnimationController _controller;
  final _videoUrl = TextEditingController();
  Timer? _hold;
  Effect currentEffect = Effect.fadeEffect;
  late MediaSliderItemEffect _effect;
  Widget _current = const ColoredBox(color: Colors.black);
  Widget _next = const ColoredBox(color: Colors.black);
  VideoSession? _currentVideo;
  VideoSession? _nextVideo;
  ui.Image? _currentPhoto, _nextPhoto;
  PhotoMotionSession? _currentMotion, _nextMotion;
  late (PhotoMotionMode, double) _motionConfig;
  Size _previewSize = Size.zero;
  bool _transitioning = false;
  bool _loading = false;
  String? _error;
  int _index = 0;
  int _generation = 0;
  double _aspect = 16 / 9;

  Duration get _transitionTime =>
      Duration(milliseconds: widget.config.transitionTimeMs.clamp(1, 3600000));
  Duration get _displayTime =>
      Duration(milliseconds: widget.config.displayTimeMs.clamp(1, 3600000));

  @override
  void initState() {
    super.initState();
    _motionConfig = (
      widget.config.photoMotion.mode,
      widget.config.photoMotion.maxZoom,
    );
    _effect = currentEffect.createEffect(seed: 42);
    _controller = FixedAnimationController(
      vsync: this,
      duration: _transitionTime,
      animationBehavior: AnimationBehavior.preserve,
    )..addStatusListener(_onStatus);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _loadNext();
    });
  }

  @override
  void didUpdateWidget(covariant SlideshowPreview oldWidget) {
    super.didUpdateWidget(oldWidget);
    _controller.duration = _transitionTime;
    final motion = (
      widget.config.photoMotion.mode,
      widget.config.photoMotion.maxZoom,
    );
    if (motion != _motionConfig) {
      _motionConfig = motion;
      _loadNext();
    } else if (!_loading && !_transitioning) {
      _scheduleNext();
    }
  }

  void _release(VideoSession? session) {
    if (session != null) {
      unawaited(
        session.dispose().catchError((Object e, StackTrace st) {
          _log.warning('Preview video disposal failed', e, st);
        }),
      );
    }
  }

  void _onStatus(AnimationStatus status) {
    if (status != AnimationStatus.completed || !mounted) return;
    final old = _currentVideo;
    final oldPhoto = _currentPhoto, oldMotion = _currentMotion;
    setState(() {
      _current = _next;
      _currentVideo = _nextVideo;
      _nextVideo = null;
      _currentPhoto = _nextPhoto;
      _nextPhoto = null;
      _currentMotion = _nextMotion;
      _nextMotion = null;
      _currentMotion?.setPlaying(true);
      _transitioning = false;
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _release(old);
      oldPhoto?.dispose();
      oldMotion?.dispose();
    });
    _scheduleNext();
  }

  void _scheduleNext() {
    _hold?.cancel();
    _hold = Timer(_displayTime, _loadNext);
  }

  Future<ui.Image> _resolvePhoto(ImageProvider provider) async {
    final result = Completer<ui.Image>();
    final stream = provider.resolve(createLocalImageConfiguration(context));
    final listener = ImageStreamListener(
      (info, synchronousCall) {
        if (!result.isCompleted) result.complete(info.image.clone());
        info.dispose();
      },
      onError: (Object error, StackTrace? stack) {
        if (!result.isCompleted) result.completeError(error, stack);
      },
    );
    stream.addListener(listener);
    try {
      return await result.future.timeout(const Duration(seconds: 30));
    } finally {
      stream.removeListener(listener);
    }
  }

  Future<void> _loadNext() async {
    final generation = ++_generation;
    _hold?.cancel();
    _controller.stop();
    _currentMotion?.setPlaying(false);
    final discardedVideo = _nextVideo;
    final discardedPhoto = _nextPhoto;
    final discardedMotion = _nextMotion;
    _nextVideo = null;
    _nextPhoto = null;
    _nextMotion = null;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _release(discardedVideo);
      discardedPhoto?.dispose();
      discardedMotion?.dispose();
    });
    setState(() {
      _loading = true;
      _error = null;
      _transitioning = false;
    });
    VideoSession? video;
    ui.Image? photo;
    try {
      final url = _videoUrl.text.trim();
      final index = _index++;
      Widget next;
      if (currentEffect != Effect.waterRefractionEffect &&
          url.isNotEmpty &&
          index.isOdd) {
        final uri = Uri.tryParse(url);
        if (uri == null ||
            !['http', 'https'].contains(uri.scheme) ||
            uri.host.isEmpty) {
          throw const FormatException('Enter an HTTP(S) video URL');
        }
        video = VideoSession.network(uri);
        await video.prepare();
        next = VideoWidget(MediaItem('preview-video', uri), session: video);
      } else {
        final images = widget.images ?? _samples;
        if (images.isEmpty) throw StateError('No preview images');
        final provider = images[index % images.length];
        photo = await _resolvePhoto(provider);
        next = RawImage(
          image: photo,
          fit: BoxFit.contain,
          filterQuality: FilterQuality.high,
        );
      }
      if (!mounted || generation != _generation) {
        _release(video);
        photo?.dispose();
        return;
      }
      final descriptor =
          currentEffect.supportsMedia(
            _currentPhoto != null
                ? TransitionMedia.photo
                : TransitionMedia.special,
            photo != null ? TransitionMedia.photo : TransitionMedia.video,
          )
          ? currentEffect
          : Effect.fadeEffect;
      final effect = descriptor.createEffect(seed: 42);
      await effect.prepare();
      if (!mounted || generation != _generation) {
        _release(video);
        photo?.dispose();
        return;
      }
      if (effect is WaterRefractionEffect) {
        effect.bindPhotos(
          _currentPhoto!,
          photo!,
          fromCamera: _currentMotion?.path.transform(
            _previewSize,
            _currentMotion!.progress,
          ),
        );
      }
      final motion =
          photo != null &&
              widget.config.photoMotion.mode == PhotoMotionMode.kenBurns
          ? PhotoMotionSession(
              vsync: this,
              duration: _displayTime,
              config: widget.config.photoMotion,
              seed: index,
            )
          : null;
      if (video != null) await video.setPlaying(true);
      if (!mounted || generation != _generation) {
        _release(video);
        photo?.dispose();
        motion?.dispose();
        return;
      }
      _nextVideo = video;
      _nextPhoto = photo;
      _nextMotion = motion;
      // Ownership has moved to the mounted pending slide.
      photo = null;
      setState(() {
        _next = SizedBox.expand(child: motion?.view(next) ?? next);
        _effect = effect;
        _loading = false;
        _transitioning = true;
      });
      _controller.forward(from: 0);
    } catch (e) {
      photo?.dispose();
      _release(video);
      if (!mounted || generation != _generation) return;
      _nextVideo = null;
      setState(() {
        _loading = false;
        _error = e.toString();
      });
      _currentMotion?.setPlaying(true);
      _scheduleNext();
    }
  }

  void onChanged(Effect? effect) {
    if (effect == null) return;
    _hold?.cancel();
    _controller.stop();
    setState(() {
      currentEffect = effect;
      _effect = effect.createEffect(seed: 42);
    });
    // Start a fresh pair immediately, including when the old pair completed.
    _loadNext();
  }

  @override
  void dispose() {
    ++_generation;
    _hold?.cancel();
    _controller.dispose();
    _currentPhoto?.dispose();
    _nextPhoto?.dispose();
    _currentMotion?.dispose();
    _nextMotion?.dispose();
    _release(_currentVideo);
    _release(_nextVideo);
    _videoUrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Column(
    children: [
      Expanded(
        child: Center(
          child: AspectRatio(
            aspectRatio: _aspect,
            child: ClipRect(
              child: ColoredBox(
                color: Colors.black,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    _previewSize = constraints.biggest;
                    return AnimatedBuilder(
                      animation: _controller,
                      builder: (context, child) => _transitioning
                          ? _effect.createTransformWidget(
                              context,
                              _current,
                              _next,
                              _controller,
                              constraints.maxWidth,
                              constraints.maxHeight,
                            )
                          : _current,
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
      Wrap(
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 12,
        children: [
          SizedBox(
            width: 240,
            child: DropdownButton<Effect>(
              key: const ValueKey('preview-effect'),
              isExpanded: true,
              value: currentEffect,
              onChanged: onChanged,
              items: [
                for (final effect in Effect.values)
                  DropdownMenuItem(
                    value: effect,
                    child: Text(
                      effect == Effect.noiseDissolveEffect
                          ? context.localizations.effect_noise_dissolve
                          : effect == Effect.rippleRevealEffect
                          ? context.localizations.effect_ripple_reveal
                          : effect == Effect.waterRefractionEffect
                          ? context.localizations.effect_water_refraction
                          : effect.name,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
              ],
            ),
          ),
          DropdownButton<double>(
            key: const ValueKey('preview-aspect'),
            value: _aspect,
            onChanged: (value) {
              if (value != null && value != _aspect) {
                ++_generation;
                _hold?.cancel();
                _controller.stop();
                _currentMotion?.setPlaying(false);
                setState(() {
                  _aspect = value;
                  _transitioning = false;
                });
                // Bind the frozen camera to the new viewport after layout.
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (mounted) _loadNext();
                });
              }
            },
            items: [
              for (final entry in {
                '16:9': 16 / 9,
                '9:16': 9 / 16,
                '1:1': 1.0,
              }.entries)
                DropdownMenuItem(value: entry.value, child: Text(entry.key)),
            ],
          ),
        ],
      ),
      Row(
        children: [
          Expanded(
            child: TextField(
              controller: _videoUrl,
              key: const ValueKey('preview-video-url'),
              enabled: currentEffect != Effect.waterRefractionEffect,
              decoration: InputDecoration(
                labelText: context.localizations.preview_video_url,
                isDense: true,
              ),
              onSubmitted: (_) => _loadNext(),
            ),
          ),
          IconButton(
            tooltip: context.localizations.preview_play,
            onPressed: _loadNext,
            icon: const Icon(Icons.play_arrow),
          ),
        ],
      ),
      if (currentEffect == Effect.waterRefractionEffect)
        Text(context.localizations.water_photo_only),
      if (_loading) const LinearProgressIndicator(),
      if (_error != null)
        Text(_error!, maxLines: 1, overflow: TextOverflow.ellipsis),
      Text(
        context.localizations.transition_display_times(
          widget.config.transitionTimeMs,
          widget.config.displayTimeMs,
        ),
      ),
    ],
  );
}
