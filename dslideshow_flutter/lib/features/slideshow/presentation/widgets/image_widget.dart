import 'dart:io';
import 'dart:ui' as ui;

import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_backend/storage.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;

import 'item_widget.dart';

/// A prepared slide. Its owner releases the bitmap after all transition views
/// have detached, just as it releases a shared video session.
// ignore: must_be_immutable
class ImageWidget extends StatelessWidget implements ItemWidget {
  @override
  final MediaItem item;
  final SlideShowConfig _config;
  final Size size;
  final double pixelRatio;
  Widget? _image;
  ui.Image? _bitmap;
  MemoryImage? _gifProvider;
  Future<void>? _preparation;
  bool _disposed = false;

  bool get isGif => path.extension(item.uri!.path).toLowerCase() == '.gif';

  /// Borrowed prepared pixels for static-photo effects. The owner keeps them
  /// alive until every transition view has detached, then calls dispose().
  ui.Image? get preparedBitmap => _bitmap;

  ImageWidget(this.item, this._config, this.size, {this.pixelRatio = 1})
    : assert(pixelRatio > 0),
      super(key: ValueKey('img:${item.uri!.toFilePath()}'));

  @override
  Widget build(BuildContext context) {
    final image = _image;
    if (image == null) return const SizedBox.shrink();
    // Keep prepared photo paint commands independent of changing transition
    // masks and transforms. GIFs retain their existing live Image subtree.
    return _bitmap == null ? image : RepaintBoundary(child: image);
  }

  Future<void> precache(BuildContext context) =>
      _preparation ??= _prepare(context);

  Future<void> _prepare(BuildContext context) async {
    final bytes = await File(item.uri!.toFilePath()).readAsBytes();
    if (_disposed) return;
    if (isGif) {
      final provider = MemoryImage(bytes);
      _gifProvider = provider;
      if (!context.mounted) return;
      await precacheImage(provider, context);
      if (_disposed) return;
      _image = Image(
        image: provider,
        fit: BoxFit.contain,
        filterQuality: FilterQuality.high,
        errorBuilder: (context, error, stack) => const SizedBox.shrink(),
      );
      return;
    }

    final codec = await ui.instantiateImageCodec(bytes);
    ui.Image? source;
    ui.Picture? picture;
    try {
      source = (await codec.getNextFrame()).image;
      if (_disposed) return;
      final recorder = ui.PictureRecorder();
      final canvas = Canvas(recorder)..scale(pixelRatio, pixelRatio);
      canvas.drawColor(Color(_config.backgroundColor), BlendMode.src);
      if (_config.isBlurredBackground) {
        final paint = Paint()
          ..color = Colors.white.withValues(alpha: _config.backgroundOpacity)
          ..filterQuality = FilterQuality.high
          ..isAntiAlias = true;
        if (_config.backgroundBlurSigma > 0) {
          paint.imageFilter = ui.ImageFilter.blur(
            sigmaX: _config.backgroundBlurSigma.toDouble(),
            sigmaY: _config.backgroundBlurSigma.toDouble(),
          );
        }
        _drawFitted(canvas, source, BoxFit.cover, paint);
      }
      _drawFitted(
        canvas,
        source,
        BoxFit.contain,
        Paint()
          ..filterQuality = FilterQuality.high
          ..isAntiAlias = true,
      );
      picture = recorder.endRecording();
      final bitmap = await picture.toImage(
        (size.width * pixelRatio).round(),
        (size.height * pixelRatio).round(),
      );
      if (_disposed) {
        bitmap.dispose();
        return;
      }
      _bitmap = bitmap;
      // Keep the prepared pixels: no PNG encoding or second image decode.
      _image = RawImage(
        image: bitmap,
        scale: pixelRatio,
        filterQuality: FilterQuality.high,
      );
    } finally {
      picture?.dispose();
      source?.dispose();
      codec.dispose();
    }
  }

  void _drawFitted(Canvas canvas, ui.Image image, BoxFit fit, Paint paint) {
    final sourceSize = Size(image.width.toDouble(), image.height.toDouble());
    final fitted = applyBoxFit(fit, sourceSize, size);
    canvas.drawImageRect(
      image,
      Alignment.center.inscribe(fitted.source, Offset.zero & sourceSize),
      Alignment.center.inscribe(fitted.destination, Offset.zero & size),
      paint,
    );
  }

  void dispose() {
    if (_disposed) return;
    _disposed = true;
    _image = null;
    _bitmap?.dispose();
    _bitmap = null;
    final provider = _gifProvider;
    if (provider != null) provider.evict();
  }
}
