import 'dart:async';
import 'dart:ui' as ui;

import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_flutter/effect.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/sessions/slide_session.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/widgets/photo_motion.dart';
import 'package:flutter/material.dart';

import 'preview_photo.dart';

/// Owns one bundled photo's preparation, pixels, view and optional camera.
/// The preview registers this owner before calling [prepare].
class AssetPhotoSlideSession extends SlideSession {
  final PreviewPhoto photo;
  final int sequenceIndex;
  final Size size;
  final TickerProvider vsync;
  final Color _backgroundColor;
  final bool _blurredBackground;
  final double _backgroundOpacity;
  final double _backgroundBlurSigma;
  final PhotoMotionMode _motionMode;
  final double _motionZoom;
  final Duration _displayTime;
  ui.Image? _bitmap;
  PhotoMotionSession? _motion;
  Completer<ui.Image?>? _pending;
  Timer? _timeout;
  bool _aborted = false;
  bool _committed = false;
  Widget _view = const ColoredBox(color: Colors.black);

  AssetPhotoSlideSession(
    this.photo, {
    required this.sequenceIndex,
    required SlideShowConfig config,
    required this.size,
    required this.vsync,
  }) : _backgroundColor = Color(config.backgroundColor),
       _blurredBackground = config.isBlurredBackground,
       _backgroundOpacity = config.backgroundOpacity.clamp(0, 1),
       _backgroundBlurSigma = config.backgroundBlurSigma.toDouble(),
       _motionMode = config.photoMotion.mode,
       _motionZoom = config.photoMotion.maxZoom,
       _displayTime = Duration(
         milliseconds: config.displayTimeMs.clamp(1, 3600000),
       );

  @override
  Widget get view => _view;

  @override
  Future<bool> prepareContents(BuildContext context) async {
    // Capture the inherited bundle synchronously, before any await. Assets are
    // decoded directly, without a global ImageProvider/cache listener to retire.
    final bundle = DefaultAssetBundle.of(context);
    final result = Completer<ui.Image?>();
    _pending = result;
    _timeout = Timer(const Duration(seconds: 30), () {
      _aborted = true;
      if (!result.isCompleted) {
        result.completeError(TimeoutException('Preview asset image'));
      }
    });
    // The native decode/toImage future cannot be cancelled. Its continuation
    // always consumes late failures and releases any result after cancellation.
    unawaited(
      _loadAndCompose(bundle).then<void>(
        (bitmap) {
          if (result.isCompleted || disposed) {
            bitmap?.dispose();
          } else {
            result.complete(bitmap);
          }
        },
        onError: (Object error, StackTrace? stack) {
          if (!result.isCompleted) result.completeError(error, stack);
        },
      ),
    );
    try {
      final bitmap = await result.future;
      if (bitmap == null) return false;
      if (disposed) {
        bitmap.dispose();
        return false;
      }
      _bitmap = bitmap;
      _view = SizedBox.expand(child: _photoView(bitmap));
      return true;
    } finally {
      _timeout?.cancel();
      _timeout = null;
      _pending = null;
    }
  }

  Future<ui.Image?> _loadAndCompose(AssetBundle bundle) async {
    ui.Codec? codec;
    ui.Image? source;
    try {
      final data = await bundle.load(photo.assetPath);
      if (disposed || _aborted) return null;
      codec = await ui.instantiateImageCodec(
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes),
      );
      if (disposed || _aborted) return null;
      source = (await codec.getNextFrame()).image;
      if (disposed || _aborted) return null;
      final image = source;
      source = null; // _compose takes ownership even when rasterization fails.
      final bitmap = await _compose(image);
      if (disposed || _aborted) {
        bitmap.dispose();
        return null;
      }
      return bitmap;
    } finally {
      source?.dispose();
      codec?.dispose();
    }
  }

  Future<ui.Image> _compose(ui.Image source) async {
    ui.Picture? picture;
    try {
      final recorder = ui.PictureRecorder();
      final canvas = Canvas(recorder)
        ..drawColor(_backgroundColor, BlendMode.src);
      final sourceSize = Size(
        source.width.toDouble(),
        source.height.toDouble(),
      );
      void draw(BoxFit fit, Paint paint) {
        final fitted = applyBoxFit(fit, sourceSize, size);
        canvas.drawImageRect(
          source,
          Alignment.center.inscribe(fitted.source, Offset.zero & sourceSize),
          Alignment.center.inscribe(fitted.destination, Offset.zero & size),
          paint,
        );
      }

      if (_blurredBackground) {
        final paint = Paint()
          ..color = Colors.white.withValues(alpha: _backgroundOpacity)
          ..filterQuality = FilterQuality.high
          ..isAntiAlias = true;
        if (_backgroundBlurSigma > 0) {
          paint.imageFilter = ui.ImageFilter.blur(
            sigmaX: _backgroundBlurSigma,
            sigmaY: _backgroundBlurSigma,
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

  Widget _photoView(ui.Image bitmap) => RepaintBoundary(
    child: RawImage(
      image: bitmap,
      fit: BoxFit.contain,
      filterQuality: FilterQuality.high,
    ),
  );

  @override
  void commitPreparation() {
    final bitmap = _bitmap;
    if (disposed || bitmap == null || _committed) return;
    _committed = true;
    if (_motionMode == PhotoMotionMode.kenBurns) {
      _motion = PhotoMotionSession(
        vsync: vsync,
        duration: _displayTime,
        config: PhotoMotionConfig(mode: _motionMode, maxZoom: _motionZoom),
        seed: sequenceIndex,
      );
    }
    final image = _photoView(bitmap);
    _view = SizedBox.expand(child: _motion?.view(image) ?? image);
  }

  @override
  EffectSlideInput createEffectInput(Size size) => EffectSlideInput(
    view: view,
    photo: _bitmap == null
        ? null
        : PreparedPhoto(
            bitmap: _bitmap!,
            camera: PhotoCamera.fromMatrix(
              _motion?.path.transform(size, _motion!.progress),
            ),
          ),
  );

  @override
  void setActivity({
    required SlideSessionRole role,
    required bool playing,
    required bool screenOn,
  }) {
    if (disposed) return;
    _motion?.setPlaying(
      playing && screenOn && role == SlideSessionRole.current,
    );
  }

  @override
  void disposeResources() {
    _aborted = true;
    _timeout?.cancel();
    _timeout = null;
    final pending = _pending;
    _pending = null;
    if (pending != null && !pending.isCompleted) pending.complete(null);
    _motion?.dispose();
    _motion = null;
    _bitmap?.dispose();
    _bitmap = null;
    _view = const ColoredBox(color: Colors.black);
  }
}
