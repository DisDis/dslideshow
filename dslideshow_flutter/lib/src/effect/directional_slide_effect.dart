import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:dslideshow_common/effects.dart';
export 'package:dslideshow_common/effects.dart' show SlideMode;
import 'package:flutter/material.dart';

import 'effect_geometry.dart';
import 'media_slider_item_effect.dart';

class DirectionalSlideEffect extends MediaSliderItemEffect {
  final AxisDirection direction;
  final SlideMode mode;
  final BlendCurve motionCurve;
  final double blurFraction, edgeWidth, tiltDegrees, shadowStrength;
  final SlideDecoration decoration;
  DirectionalSlideEffect({
    this.direction = AxisDirection.left,
    this.mode = SlideMode.push,
    this.motionCurve = BlendCurve.linear,
    this.blurFraction = 0,
    this.edgeWidth = .055,
    this.tiltDegrees = 0,
    this.shadowStrength = 0,
    this.decoration = SlideDecoration.none,
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
    EffectSlideInput current,
    EffectSlideInput next,
    Animation<double> controller,
    double screenW,
    double screenH,
  ) {
    final t = controller.value.clamp(0.0, 1.0);
    final motion = effectCurve(motionCurve).transform(t);
    final envelope = t <= 0 || t >= 1 ? 0.0 : math.sin(math.pi * t);
    final vector = switch (direction) {
      AxisDirection.left => Offset(-screenW, 0),
      AxisDirection.right => Offset(screenW, 0),
      AxisDirection.up => Offset(0, -screenH),
      AxisDirection.down => Offset(0, screenH),
    };
    final cinematic = blurFraction > 0 || decoration != SlideDecoration.none;
    Widget from = cinematic
        ? ColoredBox(color: Colors.black, child: current.view)
        : current.view;
    Widget to = cinematic
        ? ColoredBox(color: Colors.black, child: next.view)
        : next.view;
    Widget upper(Widget child, double angle) {
      if (shadowStrength > 0) {
        child = DecoratedBox(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(
                  alpha: (shadowStrength * envelope).clamp(0, 1),
                ),
                blurRadius: math.min(screenW, screenH) * .02,
              ),
            ],
          ),
          child: child,
        );
      }
      return angle == 0
          ? child
          : Transform.rotate(angle: angle * math.pi / 180, child: child);
    }

    if (mode == SlideMode.cover) to = upper(to, tiltDegrees * envelope);
    if (mode == SlideMode.reveal) from = upper(from, tiltDegrees * envelope);
    final outgoing = Transform.translate(
      offset: mode == SlideMode.cover ? Offset.zero : vector * motion,
      child: from,
    );
    final incoming = Transform.translate(
      offset: mode == SlideMode.reveal ? Offset.zero : vector * (motion - 1),
      child: to,
    );
    Widget scene = Stack(
      fit: StackFit.expand,
      children: mode == SlideMode.reveal
          ? [incoming, outgoing]
          : [outgoing, incoming],
    );
    if (cinematic) {
      final sigma = math.min(screenW, screenH) * blurFraction * envelope;
      final horizontal = axisDirectionToAxis(direction) == Axis.horizontal;
      scene = ImageFiltered(
        enabled: sigma > 0,
        imageFilter: ui.ImageFilter.blur(
          sigmaX: horizontal ? sigma : 0,
          sigmaY: horizontal ? 0 : sigma,
          tileMode: TileMode.clamp,
        ),
        child: ClipRect(child: scene),
      );
    }
    if (decoration == SlideDecoration.filmPerforation) {
      scene = CustomPaint(
        foregroundPainter: _FilmEdges(t, envelope, edgeWidth),
        child: scene,
      );
    }
    return ClipRect(child: scene);
  }
}

class _FilmEdges extends CustomPainter {
  final double progress, envelope, edgeWidth;
  _FilmEdges(this.progress, this.envelope, this.edgeWidth);
  @override
  void paint(Canvas canvas, Size size) {
    if (size.isEmpty || envelope <= 0) return;
    final band = math.min(size.width, size.height) * edgeWidth;
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
  bool shouldRepaint(_FilmEdges old) =>
      progress != old.progress ||
      envelope != old.envelope ||
      edgeWidth != old.edgeWidth;
}
