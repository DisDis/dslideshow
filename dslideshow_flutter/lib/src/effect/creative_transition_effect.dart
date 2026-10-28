import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import 'media_slider_item_effect.dart';
import 'effect_geometry.dart';

import 'package:dslideshow_common/effects.dart';

enum CreativeTransitionKind {
  burnAlpha,
  foldMotion,
  glow,
  kaleidoscope,
  tvPower,
  springMotion,
  shapeDissolve,
  vhsDamage,
  radialBlur,
  phosphor,
}

/// Live-layer transitions. Repeated views borrow the prepared media/session;
/// neither video frame capture nor a second decoder is needed.
class CreativeTransitionEffect extends MediaSliderItemEffect {
  final CreativeTransitionKind kind;

  final EffectOptions? options;
  CreativeTransitionEffect(this.kind, {this.options});
  T _settings<T extends EffectOptions>(T fallback) =>
      options is T ? options as T : fallback;

  // These filters depend on immutable settings, not on animation progress.
  late final Color _trailColor = Color(
    _settings(const PhosphorEffectOptions()).trailColor,
  );
  late final ColorFilter _glowFilter = _createGlowFilter();
  ColorFilter _createGlowFilter() {
    final o = _settings(const GlowEffectOptions());
    return ColorFilter.matrix([
      o.gain,
      0,
      0,
      0,
      0,
      0,
      o.gain,
      0,
      0,
      0,
      0,
      0,
      o.gain,
      0,
      0,
      0,
      0,
      0,
      1,
      0,
    ]);
  }

  late final ColorFilter _trailFilter = _createPhosphorFilter();
  ColorFilter _createPhosphorFilter() {
    return ColorFilter.matrix([
      0,
      0,
      0,
      0,
      _trailColor.r * 255,
      0,
      0,
      0,
      0,
      _trailColor.g * 255,
      0,
      0,
      0,
      0,
      _trailColor.b * 255,
      .2126,
      .7152,
      .0722,
      0,
      0,
    ]);
  }

  @override
  Widget transform(
    BuildContext context,
    Widget page,
    bool isCurrentPage,
    double pageDelta,
    double screenW,
    double screenH,
  ) => page;

  Widget _blend(Widget from, Widget to, double t) => Stack(
    fit: StackFit.expand,
    children: [
      from,
      Opacity(opacity: t, child: to),
    ],
  );

  Widget _blur(Widget child, double sigma) => ImageFiltered(
    imageFilter: ui.ImageFilter.blur(
      sigmaX: sigma,
      sigmaY: sigma,
      tileMode: ui.TileMode.clamp,
    ),
    enabled: sigma > 0,
    child: child,
  );

  Widget _fold(Widget from, Widget to, double t, double w, double h) =>
      ColoredBox(
        color: Colors.black,
        child: Stack(
          fit: StackFit.expand,
          children: [
            for (final incoming in [false, true])
              for (final right in [false, true])
                Positioned(
                  left: right ? w / 2 : 0,
                  top: 0,
                  width: w / 2,
                  height: h,
                  child: Opacity(
                    opacity: incoming ? (t >= .5 ? 1 : 0) : (t < .5 ? 1 : 0),
                    child: Transform(
                      alignment: right
                          ? Alignment.centerLeft
                          : Alignment.centerRight,
                      transform: Matrix4.identity()
                        ..setEntry(
                          3,
                          2,
                          _settings(const FoldMotionEffectOptions())
                                  .perspectiveStrength /
                              math.max(1, w * 3),
                        )
                        ..rotateY(
                          (right ? -1 : 1) *
                              math.pi /
                              2 *
                              (incoming ? 2 * (1 - t) : 2 * t),
                        ),
                      child: CustomPaint(
                        foregroundPainter: _FoldShade(
                          incoming ? 2 * (1 - t) : 2 * t,
                          right,
                          _settings(const FoldMotionEffectOptions())
                              .shadowIntensity,
                        ),
                        child: ClipRect(
                          child: OverflowBox(
                            alignment: Alignment.topLeft,
                            minWidth: w,
                            maxWidth: w,
                            minHeight: h,
                            maxHeight: h,
                            child: Transform.translate(
                              offset: Offset(right ? -w / 2 : 0, 0),
                              child: incoming ? to : from,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
          ],
        ),
      );

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
    final e = t <= 0 || t >= 1 ? 0.0 : math.sin(math.pi * t);
    final unit = math.min(screenW, screenH);
    final from = ColoredBox(color: Colors.black, child: currentWidget);
    final to = ColoredBox(color: Colors.black, child: nextWidget);
    final Widget scene;
    switch (kind) {
      case CreativeTransitionKind.burnAlpha:
        final o = _settings(const BurnAlphaEffectOptions());
        scene = Stack(
          fit: StackFit.expand,
          children: [
            from,
            CustomPaint(
              foregroundPainter: _BurnEdge(t, e, o),
              child: ClipPath(clipper: _BurnClipper(t, o.roughness), child: to),
            ),
          ],
        );
      case CreativeTransitionKind.foldMotion:
        scene = _fold(from, to, motion, screenW, screenH);
      case CreativeTransitionKind.glow:
        final o = _settings(const GlowEffectOptions());
        scene = Stack(
          fit: StackFit.expand,
          children: [
            _blend(from, to, motion),
            Opacity(
              opacity: o.strength * e,
              child: _blur(
                ColorFiltered(
                  colorFilter: _glowFilter,
                  child: _blend(from, to, motion),
                ),
                unit * o.radius * e,
              ),
            ),
          ],
        );
      case CreativeTransitionKind.kaleidoscope:
        final o = _settings(const KaleidoscopeEffectOptions());
        scene = Stack(
          fit: StackFit.expand,
          children: [
            _blend(from, to, motion),
            Opacity(
              opacity: e * e,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  for (var i = 0; i < o.sectorCount; i++)
                    ClipPath(
                      clipper: _SectorClipper(i, o.sectorCount, o.origin),
                      child: Transform.rotate(
                        alignment: effectOrigin(o.origin),
                        angle:
                            i * math.pi * 2 / o.sectorCount +
                            e * math.pi * o.rotationDegrees / 180,
                        child: Transform.scale(
                          // Scale about the image centre so rotation about a
                          // corner also has source pixels beyond that corner.
                          scale:
                              (o.origin == EffectOrigin.center ? 0 : 1) +
                              (o.origin == EffectOrigin.center ? 1 : 2) *
                                  math.sqrt(
                                    screenW * screenW + screenH * screenH,
                                  ) /
                                  math.max(1, unit),
                          child: Transform.flip(
                            flipX: i.isOdd,
                            child: _blend(from, to, motion),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        );
      case CreativeTransitionKind.tvPower:
        final o = _settings(const TvPowerEffectOptions());
        final scale = math.pow((2 * t - 1).abs(), 2).toDouble();
        scene = ColoredBox(
          color: Colors.black,
          child: CustomPaint(
            foregroundPainter: _TelevisionLight(
              e,
              scale,
              o.glowStrength,
              Color(o.glowColor),
            ),
            child: Transform.scale(
              scaleX: .25 + .75 * math.sqrt(scale),
              scaleY: scale,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Opacity(opacity: t < .5 ? 1 : 0, child: from),
                  Opacity(opacity: t >= .5 ? 1 : 0, child: to),
                ],
              ),
            ),
          ),
        );
      case CreativeTransitionKind.springMotion:
        final o = _settings(const SpringMotionEffectOptions());
        final smooth = Curves.easeOutCubic.transform(t);
        final spring =
            smooth +
            o.springStrength * (Curves.elasticOut.transform(t) - smooth);
        scene = _blend(
          from,
          Transform.translate(
            offset: Offset(screenW * (1 - spring), 0),
            child: Transform.scale(
              scale: o.startScale + (1 - o.startScale) * spring,
              child: to,
            ),
          ),
          Curves.easeOutCubic.transform(t),
        );
      case CreativeTransitionKind.shapeDissolve:
        final o = _settings(const ShapeDissolveEffectOptions());
        scene = Stack(
          fit: StackFit.expand,
          children: [
            from,
            ClipPath(clipper: _ShapesClipper(t, o), child: to),
          ],
        );
      case CreativeTransitionKind.vhsDamage:
        final o = _settings(const VhsDamageEffectOptions());
        final shift = screenW * o.colorShiftFraction * e;
        scene = Stack(
          fit: StackFit.expand,
          children: [
            _blend(from, to, motion),
            Opacity(
              opacity: .35 * e,
              child: Transform.translate(
                offset: Offset(shift, 0),
                child: ColorFiltered(
                  colorFilter: const ColorFilter.mode(
                    Color(0xffff4060),
                    BlendMode.modulate,
                  ),
                  child: _blend(from, to, motion),
                ),
              ),
            ),
            for (var i = 0; i < 2; i++)
              Opacity(
                opacity: e,
                child: ClipRect(
                  clipper: _TrackingClipper(t, i),
                  child: Transform.translate(
                    offset: Offset(
                      o.trackingStrength *
                          shift *
                          (i == 0 ? -2 : 3) *
                          math.sin(t * 29 + i),
                      0,
                    ),
                    child: _blend(from, to, motion),
                  ),
                ),
              ),
            CustomPaint(painter: _TapeNoise(t, e, o.noiseStrength)),
          ],
        );
      case CreativeTransitionKind.radialBlur:
        final o = _settings(const RadialBlurEffectOptions());
        final scale = o.origin == EffectOrigin.center
            ? 1 +
                  .22 *
                      (o.angleDegrees / (0.2 * 180 / math.pi)) *
                      e *
                      math.max(screenW, screenH) /
                      math.max(1, unit)
            : 1 +
                  4 *
                      math.sin(o.angleDegrees * math.pi / 360 * e).abs() *
                      math.sqrt(screenW * screenW + screenH * screenH) /
                      math.max(1, unit);
        scene = Stack(
          fit: StackFit.expand,
          children: [
            // Source-over weights 1, 1/2, ... 1/9 average all nine samples.
            // A small isotropic scale covers the rotated corners.
            for (var i = 0; i < 9; i++)
              Opacity(
                opacity: 1 / (i + 1),
                // Keep each averaging surface within the final viewport.
                // The rotated/scaled scene can have much larger paint bounds.
                child: ClipRect(
                  child: Transform.rotate(
                    alignment: effectOrigin(o.origin),
                    angle: (i - 4) / 4 * (o.angleDegrees * math.pi / 180) * e,
                    child: Transform.scale(
                      // Inverse rotation moves a point by at most
                      // 2*sin(angle/2)*diagonal; centred scaling covers it.
                      scale: scale,
                      child: _blend(from, to, motion),
                    ),
                  ),
                ),
              ),
          ],
        );
      case CreativeTransitionKind.phosphor:
        final o = _settings(const PhosphorEffectOptions());
        scene = Stack(
          fit: StackFit.expand,
          children: [
            // The outgoing layer drifts; three delayed positions form a glow
            // trail. These are live views, not a history of captured frames.
            to,
            Opacity(
              opacity: 1 - motion,
              child: Transform.translate(
                offset: Offset(-screenW * o.driftFraction * motion, 0),
                child: from,
              ),
            ),
            for (var i = o.trailCount; i >= 1; i--)
              Transform.translate(
                offset: Offset(
                  -screenW * o.driftFraction * math.max(0, motion - i * .09),
                  0,
                ),
                child: Opacity(
                  opacity:
                      (e *
                              (1 - motion) *
                              (o.trailCount == 3
                                  ? (4 - i)
                                  : (o.trailCount + 1 - i) *
                                        12 /
                                        (o.trailCount * (o.trailCount + 1))) *
                              .18 *
                              o.trailStrength *
                              _trailColor.a)
                          .clamp(0, 1),
                  // Alpha now sees stable filter children, before translation
                  // changes their position in the parent composition.
                  child: RepaintBoundary(
                    child: _blur(
                      ColorFiltered(colorFilter: _trailFilter, child: from),
                      unit * .012 * i,
                    ),
                  ),
                ),
              ),
          ],
        );
    }
    return ClipRect(child: scene);
  }
}

// A continuous, irregular burn front. The same geometry drives mask and ember.
double _burnX(double y, Size size, double t, double roughnessFraction) {
  final roughness = size.width * roughnessFraction;
  return size.width * (-.16 + 1.32 * t) +
      roughness *
          (math.sin(y / math.max(1, size.height) * 23 + .4) +
              .45 * math.sin(y / math.max(1, size.height) * 67));
}

Path _burnFront(Size size, double t, double roughness) {
  final path = Path()..moveTo(_burnX(0, size, t, roughness), 0);
  for (var i = 1; i <= 100; i++) {
    final y = size.height * i / 100;
    path.lineTo(_burnX(y, size, t, roughness), y);
  }
  return path;
}

class _BurnClipper extends CustomClipper<Path> {
  final double t;
  final double roughness;
  _BurnClipper(this.t, this.roughness);
  @override
  Path getClip(Size size) {
    if (t <= 0 || size.isEmpty) return Path();
    if (t >= 1) return Path()..addRect(Offset.zero & size);
    return _burnFront(size, t, roughness)
      ..lineTo(0, size.height)
      ..lineTo(0, 0)
      ..close();
  }

  @override
  bool shouldReclip(_BurnClipper oldClipper) =>
      t != oldClipper.t || roughness != oldClipper.roughness;
}

class _BurnEdge extends CustomPainter {
  final double t, envelope;
  final BurnAlphaEffectOptions options;
  _BurnEdge(this.t, this.envelope, this.options);
  @override
  void paint(Canvas canvas, Size size) {
    if (size.isEmpty || envelope <= 0) return;
    final path = _burnFront(size, t, options.roughness);
    final unit = math.min(size.width, size.height);
    canvas.drawPath(
      path,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = unit * options.edgeWidth
        ..color = Color(options.emberColor)
            .withValues(alpha: Color(options.emberColor).a * .85 * envelope)
        ..maskFilter = MaskFilter.blur(
          BlurStyle.normal,
          unit * .018 * options.edgeWidth / .065,
        ),
    );
    canvas.drawPath(
      path,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = math.max(1, unit * .013 * options.edgeWidth / .065)
        ..color = const Color(0xffffed95).withValues(alpha: envelope),
    );
  }

  @override
  bool shouldRepaint(_BurnEdge oldDelegate) =>
      t != oldDelegate.t ||
      envelope != oldDelegate.envelope ||
      options != oldDelegate.options;
}

class _FoldShade extends CustomPainter {
  final double fold;
  final bool right;
  final double intensity;
  _FoldShade(this.fold, this.right, this.intensity);
  @override
  void paint(Canvas canvas, Size size) {
    if (size.isEmpty || fold <= 0) return;
    canvas.drawRect(
      Offset.zero & size,
      Paint()
        ..shader = LinearGradient(
          begin: right ? Alignment.centerLeft : Alignment.centerRight,
          end: right ? Alignment.centerRight : Alignment.centerLeft,
          colors: [
            Colors.black.withValues(alpha: intensity * fold.clamp(0, 1)),
            Colors.transparent,
          ],
        ).createShader(Offset.zero & size),
    );
  }

  @override
  bool shouldRepaint(_FoldShade oldDelegate) =>
      fold != oldDelegate.fold ||
      right != oldDelegate.right ||
      intensity != oldDelegate.intensity;
}

class _SectorClipper extends CustomClipper<Path> {
  final int index;
  final int count;
  final EffectOrigin origin;
  _SectorClipper(this.index, this.count, this.origin);
  @override
  Path getClip(Size size) {
    final center = effectOrigin(origin).alongSize(size);
    final radius = math.sqrt(
      size.width * size.width + size.height * size.height,
    );
    return Path()
      ..moveTo(center.dx, center.dy)
      ..arcTo(
        Rect.fromCircle(center: center, radius: radius),
        index * math.pi * 2 / count,
        math.pi * 2 / count,
        false,
      )
      ..close();
  }

  @override
  bool shouldReclip(_SectorClipper oldClipper) =>
      index != oldClipper.index ||
      count != oldClipper.count ||
      origin != oldClipper.origin;
}

class _TelevisionLight extends CustomPainter {
  final double envelope, scale;
  final double intensity;
  final Color color;
  _TelevisionLight(this.envelope, this.scale, this.intensity, this.color);
  @override
  void paint(Canvas canvas, Size size) {
    if (size.isEmpty || envelope <= 0) return;
    final strength = (math.pow(envelope, 8).toDouble() * intensity * color.a)
        .clamp(0.0, 1.0);
    final half = size.width * (.08 + .42 * math.sqrt(scale));
    final center = size.center(Offset.zero);
    for (final glow in [true, false]) {
      canvas.drawLine(
        center - Offset(half, 0),
        center + Offset(half, 0),
        Paint()
          ..color = (glow ? color : Colors.white).withValues(alpha: strength)
          ..strokeWidth = glow ? 5 : 1.5
          ..maskFilter = glow
              ? const MaskFilter.blur(BlurStyle.normal, 4)
              : null,
      );
    }
  }

  @override
  bool shouldRepaint(_TelevisionLight oldDelegate) =>
      envelope != oldDelegate.envelope ||
      scale != oldDelegate.scale ||
      intensity != oldDelegate.intensity ||
      color != oldDelegate.color;
}

class _ShapesClipper extends CustomClipper<Path> {
  final double t;
  final ShapeDissolveEffectOptions options;
  _ShapesClipper(this.t, this.options);
  @override
  Path getClip(Size size) {
    final path = Path();
    if (t <= 0 || size.isEmpty) return path;
    if (t >= 1) return path..addRect(Offset.zero & size);
    // Growing staggered hexagons, not square pixels or a reduced photo.
    final cell = math.max(size.width, size.height) / options.cellsAcross;
    final stepY = cell * math.sqrt(3) / 2;
    for (var row = -1; row <= (size.height / stepY).ceil(); row++) {
      for (var col = -1; col <= (size.width / cell).ceil(); col++) {
        final delay =
            ((row * 37 + col * 19) % 17) / 17 * options.staggerFraction;
        final radius =
            cell *
            .72 *
            ((t - delay) / (.60 * (1 - options.staggerFraction) / .72)).clamp(
              0.0,
              1.0,
            );
        final center = Offset((col + (row.isOdd ? .5 : 0)) * cell, row * stepY);
        switch (options.shape) {
          case CellShape.hexagon:
            path.addPolygon([
              for (var i = 0; i < 6; i++)
                center +
                    Offset(
                          math.cos(math.pi / 6 + i * math.pi / 3),
                          math.sin(math.pi / 6 + i * math.pi / 3),
                        ) *
                        radius,
            ], true);
          case CellShape.circle:
            path.addOval(Rect.fromCircle(center: center, radius: radius));
          case CellShape.square:
            path.addRect(
              Rect.fromCenter(
                center: center,
                width: radius * 2,
                height: radius * 2,
              ),
            );
          case CellShape.diamond:
            path.addPolygon([
              center + Offset(0, -radius * 1.5),
              center + Offset(radius * 1.5, 0),
              center + Offset(0, radius * 1.5),
              center + Offset(-radius * 1.5, 0),
            ], true);
        }
      }
    }
    return path;
  }

  @override
  bool shouldReclip(_ShapesClipper oldClipper) =>
      t != oldClipper.t || options != oldClipper.options;
}

class _TrackingClipper extends CustomClipper<Rect> {
  final double t;
  final int index;
  _TrackingClipper(this.t, this.index);
  @override
  Rect getClip(Size size) => Rect.fromLTWH(
    0,
    size.height * (.25 + .4 * index + .06 * math.sin(t * 19 + index)),
    size.width,
    size.height * .065,
  );
  @override
  bool shouldReclip(_TrackingClipper oldClipper) =>
      t != oldClipper.t || index != oldClipper.index;
}

class _TapeNoise extends CustomPainter {
  final double t, envelope;
  final double intensity;
  _TapeNoise(this.t, this.envelope, this.intensity);
  @override
  void paint(Canvas canvas, Size size) {
    if (size.isEmpty || envelope <= 0) return;
    final paint = Paint()
      ..color = Colors.black.withValues(
        alpha: (.28 * envelope * intensity).clamp(0, 1),
      );
    final step = math.max(2.0, size.height / 120);
    for (var y = 0.0; y < size.height; y += step) {
      canvas.drawRect(Rect.fromLTWH(0, y, size.width, step * .35), paint);
    }
    paint.color = Colors.white.withValues(
      alpha: (.5 * envelope * intensity).clamp(0, 1),
    );
    for (var i = 0; i < 40; i++) {
      final x = ((i * 73 + (t * 230).floor() * 17) % 211) / 211 * size.width;
      final y = ((i * 41 + (t * 170).floor() * 29) % 127) / 127 * size.height;
      canvas.drawRect(Rect.fromLTWH(x, y, size.width * .012, step * .5), paint);
    }
  }

  @override
  bool shouldRepaint(_TapeNoise oldDelegate) =>
      t != oldDelegate.t ||
      envelope != oldDelegate.envelope ||
      intensity != oldDelegate.intensity;
}
