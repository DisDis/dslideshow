import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import 'media_slider_item_effect.dart';

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

  CreativeTransitionEffect(this.kind);

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
                        ..setEntry(3, 2, 1 / math.max(1, w * 3))
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
        scene = Stack(
          fit: StackFit.expand,
          children: [
            from,
            CustomPaint(
              foregroundPainter: _BurnEdge(t, e),
              child: ClipPath(clipper: _BurnClipper(t), child: to),
            ),
          ],
        );
      case CreativeTransitionKind.foldMotion:
        scene = _fold(from, to, motion, screenW, screenH);
      case CreativeTransitionKind.glow:
        scene = Stack(
          fit: StackFit.expand,
          children: [
            _blend(from, to, motion),
            Opacity(
              opacity: .7 * e,
              child: _blur(
                ColorFiltered(
                  colorFilter: const ColorFilter.matrix([
                    2.4,
                    0,
                    0,
                    0,
                    0,
                    0,
                    2.4,
                    0,
                    0,
                    0,
                    0,
                    0,
                    2.4,
                    0,
                    0,
                    0,
                    0,
                    0,
                    1,
                    0,
                  ]),
                  child: _blend(from, to, motion),
                ),
                unit * .045 * e,
              ),
            ),
          ],
        );
      case CreativeTransitionKind.kaleidoscope:
        scene = Stack(
          fit: StackFit.expand,
          children: [
            _blend(from, to, motion),
            Opacity(
              opacity: e * e,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  for (var i = 0; i < 6; i++)
                    ClipPath(
                      clipper: _SectorClipper(i),
                      child: Transform.rotate(
                        angle: i * math.pi / 3 + e * math.pi * .3,
                        child: Transform.scale(
                          // Cover the viewport even when a portrait is rotated.
                          scale:
                              math.sqrt(screenW * screenW + screenH * screenH) /
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
        final scale = math.pow((2 * t - 1).abs(), 2).toDouble();
        scene = ColoredBox(
          color: Colors.black,
          child: CustomPaint(
            foregroundPainter: _TelevisionLight(e, scale),
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
        final spring = Curves.elasticOut.transform(t);
        scene = _blend(
          from,
          Transform.translate(
            offset: Offset(screenW * (1 - spring), 0),
            child: Transform.scale(scale: .85 + .15 * spring, child: to),
          ),
          Curves.easeOutCubic.transform(t),
        );
      case CreativeTransitionKind.shapeDissolve:
        scene = Stack(
          fit: StackFit.expand,
          children: [
            from,
            ClipPath(clipper: _ShapesClipper(t), child: to),
          ],
        );
      case CreativeTransitionKind.vhsDamage:
        final shift = screenW * .035 * e;
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
                      shift * (i == 0 ? -2 : 3) * math.sin(t * 29 + i),
                      0,
                    ),
                    child: _blend(from, to, motion),
                  ),
                ),
              ),
            CustomPaint(painter: _TapeNoise(t, e)),
          ],
        );
      case CreativeTransitionKind.radialBlur:
        scene = Stack(
          fit: StackFit.expand,
          children: [
            // Source-over weights 1, 1/2, ... 1/9 average all nine samples.
            // A small isotropic scale covers the rotated corners.
            for (var i = 0; i < 9; i++)
              Opacity(
                opacity: 1 / (i + 1),
                child: Transform.rotate(
                  angle: (i - 4) / 4 * .20 * e,
                  child: Transform.scale(
                    scale:
                        1 +
                        .22 *
                            e *
                            math.max(screenW, screenH) /
                            math.max(1, unit),
                    child: _blend(from, to, motion),
                  ),
                ),
              ),
          ],
        );
      case CreativeTransitionKind.phosphor:
        scene = Stack(
          fit: StackFit.expand,
          children: [
            // The outgoing layer drifts; three delayed positions form a glow
            // trail. These are live views, not a history of captured frames.
            to,
            Opacity(
              opacity: 1 - motion,
              child: Transform.translate(
                offset: Offset(-screenW * .32 * motion, 0),
                child: from,
              ),
            ),
            for (var i = 3; i >= 1; i--)
              Opacity(
                opacity: e * (1 - motion) * (4 - i) * .18,
                child: Transform.translate(
                  offset: Offset(
                    -screenW * .32 * math.max(0, motion - i * .09),
                    0,
                  ),
                  child: _blur(
                    ColorFiltered(
                      colorFilter: const ColorFilter.matrix([
                        0,
                        0,
                        0,
                        0,
                        80,
                        0,
                        0,
                        0,
                        0,
                        255,
                        0,
                        0,
                        0,
                        0,
                        200,
                        .2126,
                        .7152,
                        .0722,
                        0,
                        0,
                      ]),
                      child: from,
                    ),
                    unit * .012 * i,
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
double _burnX(double y, Size size, double t) {
  final roughness = size.width * .065;
  return size.width * (-.16 + 1.32 * t) +
      roughness *
          (math.sin(y / math.max(1, size.height) * 23 + .4) +
              .45 * math.sin(y / math.max(1, size.height) * 67));
}

Path _burnFront(Size size, double t) {
  final path = Path()..moveTo(_burnX(0, size, t), 0);
  for (var i = 1; i <= 100; i++) {
    final y = size.height * i / 100;
    path.lineTo(_burnX(y, size, t), y);
  }
  return path;
}

class _BurnClipper extends CustomClipper<Path> {
  final double t;
  _BurnClipper(this.t);
  @override
  Path getClip(Size size) {
    if (t <= 0 || size.isEmpty) return Path();
    if (t >= 1) return Path()..addRect(Offset.zero & size);
    return _burnFront(size, t)
      ..lineTo(0, size.height)
      ..lineTo(0, 0)
      ..close();
  }

  @override
  bool shouldReclip(_BurnClipper oldClipper) => t != oldClipper.t;
}

class _BurnEdge extends CustomPainter {
  final double t, envelope;
  _BurnEdge(this.t, this.envelope);
  @override
  void paint(Canvas canvas, Size size) {
    if (size.isEmpty || envelope <= 0) return;
    final path = _burnFront(size, t);
    final unit = math.min(size.width, size.height);
    canvas.drawPath(
      path,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = unit * .065
        ..color = const Color(0xffff4b00).withValues(alpha: .85 * envelope)
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, unit * .018),
    );
    canvas.drawPath(
      path,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = math.max(1, unit * .013)
        ..color = const Color(0xffffed95).withValues(alpha: envelope),
    );
  }

  @override
  bool shouldRepaint(_BurnEdge oldDelegate) =>
      t != oldDelegate.t || envelope != oldDelegate.envelope;
}

class _FoldShade extends CustomPainter {
  final double fold;
  final bool right;
  _FoldShade(this.fold, this.right);
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
            Colors.black.withValues(alpha: .65 * fold.clamp(0, 1)),
            Colors.transparent,
          ],
        ).createShader(Offset.zero & size),
    );
  }

  @override
  bool shouldRepaint(_FoldShade oldDelegate) =>
      fold != oldDelegate.fold || right != oldDelegate.right;
}

class _SectorClipper extends CustomClipper<Path> {
  final int index;
  _SectorClipper(this.index);
  @override
  Path getClip(Size size) {
    final center = size.center(Offset.zero);
    final radius = math.sqrt(
      size.width * size.width + size.height * size.height,
    );
    return Path()
      ..moveTo(center.dx, center.dy)
      ..arcTo(
        Rect.fromCircle(center: center, radius: radius),
        index * math.pi / 3,
        math.pi / 3,
        false,
      )
      ..close();
  }

  @override
  bool shouldReclip(_SectorClipper oldClipper) => index != oldClipper.index;
}

class _TelevisionLight extends CustomPainter {
  final double envelope, scale;
  _TelevisionLight(this.envelope, this.scale);
  @override
  void paint(Canvas canvas, Size size) {
    if (size.isEmpty || envelope <= 0) return;
    final strength = math.pow(envelope, 8).toDouble();
    final half = size.width * (.08 + .42 * math.sqrt(scale));
    final center = size.center(Offset.zero);
    for (final glow in [true, false]) {
      canvas.drawLine(
        center - Offset(half, 0),
        center + Offset(half, 0),
        Paint()
          ..color = (glow ? const Color(0xff80edff) : Colors.white).withValues(
            alpha: strength,
          )
          ..strokeWidth = glow ? 5 : 1.5
          ..maskFilter = glow
              ? const MaskFilter.blur(BlurStyle.normal, 4)
              : null,
      );
    }
  }

  @override
  bool shouldRepaint(_TelevisionLight oldDelegate) =>
      envelope != oldDelegate.envelope || scale != oldDelegate.scale;
}

class _ShapesClipper extends CustomClipper<Path> {
  final double t;
  _ShapesClipper(this.t);
  @override
  Path getClip(Size size) {
    final path = Path();
    if (t <= 0 || size.isEmpty) return path;
    if (t >= 1) return path..addRect(Offset.zero & size);
    // Growing staggered hexagons, not square pixels or a reduced photo.
    final cell = math.max(size.width, size.height) / 12;
    final stepY = cell * math.sqrt(3) / 2;
    for (var row = -1; row <= (size.height / stepY).ceil(); row++) {
      for (var col = -1; col <= (size.width / cell).ceil(); col++) {
        final delay = ((row * 37 + col * 19) % 17) / 17 * .28;
        final radius = cell * .72 * ((t - delay) / .60).clamp(0.0, 1.0);
        final center = Offset((col + (row.isOdd ? .5 : 0)) * cell, row * stepY);
        path.addPolygon([
          for (var i = 0; i < 6; i++)
            center +
                Offset(
                      math.cos(math.pi / 6 + i * math.pi / 3),
                      math.sin(math.pi / 6 + i * math.pi / 3),
                    ) *
                    radius,
        ], true);
      }
    }
    return path;
  }

  @override
  bool shouldReclip(_ShapesClipper oldClipper) => t != oldClipper.t;
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
  _TapeNoise(this.t, this.envelope);
  @override
  void paint(Canvas canvas, Size size) {
    if (size.isEmpty || envelope <= 0) return;
    final paint = Paint()
      ..color = Colors.black.withValues(alpha: .28 * envelope);
    final step = math.max(2.0, size.height / 120);
    for (var y = 0.0; y < size.height; y += step) {
      canvas.drawRect(Rect.fromLTWH(0, y, size.width, step * .35), paint);
    }
    paint.color = Colors.white.withValues(alpha: .5 * envelope);
    for (var i = 0; i < 40; i++) {
      final x = ((i * 73 + (t * 230).floor() * 17) % 211) / 211 * size.width;
      final y = ((i * 41 + (t * 170).floor() * 29) % 127) / 127 * size.height;
      canvas.drawRect(Rect.fromLTWH(x, y, size.width * .012, step * .5), paint);
    }
  }

  @override
  bool shouldRepaint(_TapeNoise oldDelegate) =>
      t != oldDelegate.t || envelope != oldDelegate.envelope;
}
