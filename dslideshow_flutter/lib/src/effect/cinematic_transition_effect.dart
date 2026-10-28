import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import 'media_slider_item_effect.dart';
import 'effect_geometry.dart';

import 'package:dslideshow_common/effects.dart';

enum CinematicTransitionKind { lightLeak, filmRoll, crossZoom, whip }

/// Camera-like transitions over live layers. No frame capture or extra player
/// is required; the existing transition clock owns all motion and lighting.
class CinematicTransitionEffect extends MediaSliderItemEffect {
  final CinematicTransitionKind kind;

  final ZoomOverEffectOptions zoom;
  final LightLeakEffectOptions light;
  CinematicTransitionEffect(
    this.kind, {
    this.zoom = const ZoomOverEffectOptions(
      mode: ZoomMode.cross,
      startScale: 1.6,
      outgoingScale: 1.6,
      blurFraction: .012,
    ),
    this.light = const LightLeakEffectOptions(),
  });

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
    Widget currentWidget,
    Widget nextWidget,
    Animation<double> controller,
    double screenW,
    double screenH,
  ) {
    final t = controller.value.clamp(0.0, 1.0);
    final motion = Curves.easeInOutCubic.transform(t);
    final envelope = t <= 0 || t >= 1 ? 0.0 : math.sin(math.pi * t);
    final unit = math.min(screenW, screenH);
    final from = ColoredBox(color: Colors.black, child: currentWidget);
    final to = ColoredBox(color: Colors.black, child: nextWidget);
    final Widget scene;
    final double sigmaX, sigmaY;
    switch (kind) {
      case CinematicTransitionKind.lightLeak:
        sigmaX = sigmaY = 0;
        scene = Stack(
          fit: StackFit.expand,
          children: [
            from,
            Opacity(opacity: motion, child: to),
          ],
        );
      case CinematicTransitionKind.crossZoom:
        sigmaX = sigmaY = unit * zoom.blurFraction * envelope;
        scene = Stack(
          fit: StackFit.expand,
          children: [
            Transform.scale(
              alignment: effectOrigin(zoom.origin),
              scale: 1 + (zoom.outgoingScale - 1) * motion,
              child: from,
            ),
            Opacity(
              opacity: motion,
              child: ClipRect(
                child: Transform.scale(
                  alignment: effectOrigin(zoom.origin),
                  scale: 1 + (zoom.startScale - 1) * (1 - motion),
                  child: to,
                ),
              ),
            ),
          ],
        );
      case CinematicTransitionKind.whip:
        sigmaX = unit * .045 * envelope;
        sigmaY = 0;
        scene = Stack(
          fit: StackFit.expand,
          children: [
            Transform.translate(
              offset: Offset(-screenW * motion, 0),
              child: from,
            ),
            Transform.translate(
              offset: Offset(screenW * (1 - motion), 0),
              child: to,
            ),
          ],
        );
      case CinematicTransitionKind.filmRoll:
        sigmaX = 0;
        sigmaY = unit * .018 * envelope;
        scene = Stack(
          fit: StackFit.expand,
          children: [
            Transform.translate(
              offset: Offset(0, -screenH * motion),
              child: from,
            ),
            Transform.translate(
              offset: Offset(0, screenH * (1 - motion)),
              child: to,
            ),
          ],
        );
    }
    return ClipRect(
      child: CustomPaint(
        foregroundPainter: switch (kind) {
          CinematicTransitionKind.lightLeak => _LightLeak(t, envelope, light),
          CinematicTransitionKind.filmRoll => _FilmEdges(t, envelope),
          _ => null,
        },
        child: ImageFiltered(
          enabled: sigmaX > 0 || sigmaY > 0,
          imageFilter: ui.ImageFilter.blur(
            sigmaX: sigmaX,
            sigmaY: sigmaY,
            tileMode: TileMode.clamp,
          ),
          // Bound the blur surface and its enlarged/translated descendants.
          child: ClipRect(child: scene),
        ),
      ),
    );
  }
}

class _LightLeak extends CustomPainter {
  final double progress, envelope;

  final LightLeakEffectOptions options;
  _LightLeak(this.progress, this.envelope, this.options);

  @override
  void paint(Canvas canvas, Size size) {
    if (size.isEmpty || envelope <= 0) return;
    final center = Offset(
      size.width * (-.25 + progress * 1.5),
      size.height * .3,
    );
    final radius = math.max(size.width, size.height) * options.radius;
    final shader = ui.Gradient.radial(
      center,
      radius,
      [
        Colors.white.withValues(
          alpha: (.8 * envelope * options.strength).clamp(0, 1),
        ),
        Color(options.warmColor).withValues(
          alpha:
              (.65 * envelope * options.strength * Color(options.warmColor).a)
                  .clamp(0, 1),
        ),
        const Color(0xffff5722)
            .withValues(alpha: (.22 * envelope * options.strength).clamp(0, 1)),
        const Color(0x00ff5722),
      ],
      const [0, .22, .55, 1],
    );
    canvas.drawRect(Offset.zero & size, Paint()..shader = shader);
    shader.dispose();
  }

  @override
  bool shouldRepaint(_LightLeak oldDelegate) =>
      progress != oldDelegate.progress ||
      envelope != oldDelegate.envelope ||
      options != oldDelegate.options;
}

class _FilmEdges extends CustomPainter {
  final double progress, envelope;

  _FilmEdges(this.progress, this.envelope);

  @override
  void paint(Canvas canvas, Size size) {
    if (size.isEmpty || envelope <= 0) return;
    final band = math.min(size.width, size.height) * .055;
    final pitch = band * 2.2;
    final paint = Paint()
      ..color = Colors.black.withValues(alpha: envelope * .8);
    canvas.drawRect(Rect.fromLTWH(0, 0, band, size.height), paint);
    canvas.drawRect(
      Rect.fromLTWH(size.width - band, 0, band, size.height),
      paint,
    );
    paint.color = const Color(0xffeadac0).withValues(alpha: envelope * .8);
    final scroll = (progress * size.height * 2) % pitch;
    for (var y = -pitch - scroll; y < size.height; y += pitch) {
      for (final x in [band * .25, size.width - band * .75]) {
        canvas.drawRRect(
          RRect.fromRectAndRadius(
            Rect.fromLTWH(x, y, band * .5, band * 1.1),
            Radius.circular(band * .1),
          ),
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(_FilmEdges oldDelegate) =>
      progress != oldDelegate.progress || envelope != oldDelegate.envelope;
}
