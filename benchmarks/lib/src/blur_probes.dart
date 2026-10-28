import 'dart:ui' as ui;

import 'package:dslideshow_flutter/effect.dart';
import 'package:flutter/material.dart';

/// Opt-in diagnostics, never included in the normal effect matrix. The two
/// component probes intentionally change the picture and are not candidates.
enum BlurFadeProbe {
  reference,
  fadeOnly,
  blurOnly,
  composeDecal,
  opacityInside,
  noBoundary,
  directImage,
  directCompose,
  imageLayer;

  String get effectName => 'BlurProbe-$name';
  bool get needsBitmap =>
      this == directImage || this == directCompose || this == imageLayer;

  bool supports(String from, String to) =>
      !needsBitmap || (!from.endsWith('.gif') && !from.endsWith('.mp4'));

  static BlurFadeProbe? parseEffect(String name) {
    for (final probe in values) {
      if (probe.effectName == name) return probe;
    }
    return null;
  }
}

class BlurProbeEffect extends MediaSliderItemEffect {
  final BlurFadeProbe probe;
  final ui.Image? bitmap;
  BlurProbeEffect(this.probe, {this.bitmap})
    : assert(!probe.needsBitmap || bitmap != null);

  @override
  Widget transform(
    BuildContext context,
    Widget page,
    bool isCurrentPage,
    double pageDelta,
    double screenW,
    double screenH,
  ) => page;

  @override
  Widget createTransformWidget(
    BuildContext context,
    EffectSlideInput current,
    EffectSlideInput next,
    Animation<double> controller,
    double screenW,
    double screenH,
  ) {
    final t = controller.value;
    final blur = ui.ImageFilter.blur(
      sigmaX: t * 10,
      sigmaY: t * 10,
      tileMode: TileMode.decal,
    );
    final alpha = Colors.white.withValues(alpha: 1 - t);
    final Widget outgoing;
    switch (probe) {
      case BlurFadeProbe.fadeOnly:
        outgoing = Opacity(opacity: 1 - t, child: current.view);
      case BlurFadeProbe.blurOnly:
        outgoing = ImageFiltered(
          imageFilter: blur,
          enabled: t > 0,
          child: current.view,
        );
      case BlurFadeProbe.composeDecal:
        outgoing = ImageFiltered(
          imageFilter: ui.ImageFilter.compose(
            outer: ColorFilter.mode(alpha, BlendMode.modulate),
            inner: blur,
          ),
          child: current.view,
        );
      case BlurFadeProbe.opacityInside:
        outgoing = ImageFiltered(
          imageFilter: blur,
          enabled: t > 0,
          child: Opacity(opacity: 1 - t, child: current.view),
        );
      case BlurFadeProbe.reference:
      case BlurFadeProbe.noBoundary:
        outgoing = Opacity(
          opacity: 1 - t,
          child: ImageFiltered(
            imageFilter: blur,
            enabled: t > 0,
            child: current.view,
          ),
        );
      case BlurFadeProbe.directImage:
      case BlurFadeProbe.directCompose:
      case BlurFadeProbe.imageLayer:
        outgoing = Stack(
          fit: StackFit.expand,
          children: [
            // Keep source ownership and state alive while drawing its cloned
            // prepared pixels. No snapshots, decode or resampling in the window.
            Opacity(opacity: 0, child: current.view),
            CustomPaint(painter: _BitmapBlur(bitmap!, t, probe: probe)),
          ],
        );
    }
    return Stack(fit: StackFit.expand, children: [next.view, outgoing]);
  }
}

class _BitmapBlur extends CustomPainter {
  final ui.Image image;
  final double t;
  final BlurFadeProbe probe;
  _BitmapBlur(this.image, this.t, {required this.probe});

  @override
  void paint(Canvas canvas, Size size) {
    if (t == 1) return;
    final filter = t == 0
        ? null
        : ui.ImageFilter.blur(
            sigmaX: t * 10,
            sigmaY: t * 10,
            tileMode: TileMode.decal,
          );
    final paint = Paint()
      ..isAntiAlias = false
      ..filterQuality = FilterQuality.high
      ..color = Colors.white.withValues(alpha: 1 - t)
      ..imageFilter = filter;
    if (probe == BlurFadeProbe.directCompose && filter != null) {
      paint.imageFilter = ui.ImageFilter.compose(
        outer: ColorFilter.mode(paint.color, BlendMode.modulate),
        inner: filter,
      );
      paint.color = Colors.white;
    }
    final layer = probe == BlurFadeProbe.imageLayer;
    if (layer) {
      canvas.saveLayer(Offset.zero & size, paint);
      paint.color = Colors.white;
      paint.imageFilter = null;
    }
    canvas.drawImageRect(
      image,
      Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble()),
      Offset.zero & size,
      paint,
    );
    if (layer) canvas.restore();
  }

  @override
  bool shouldRepaint(_BitmapBlur oldDelegate) =>
      image != oldDelegate.image ||
      t != oldDelegate.t ||
      probe != oldDelegate.probe;
}
