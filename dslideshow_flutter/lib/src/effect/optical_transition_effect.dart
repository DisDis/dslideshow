import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'media_slider_item_effect.dart';

enum OpticalTransitionKind { filmDissolve, frame, louver, mirror }

/// Optical transitions over live media. Repeated faces borrow the same prepared
/// images and video sessions; no snapshots or extra decoders are created.
class OpticalTransitionEffect extends MediaSliderItemEffect {
  final OpticalTransitionKind kind;
  final int slatCount;

  OpticalTransitionEffect(this.kind, {this.slatCount = 8})
    : assert(slatCount > 0);

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

  Widget _slat(Widget child, int index, double width, double height) =>
      ClipRect(
        child: OverflowBox(
          alignment: Alignment.topLeft,
          minWidth: width,
          maxWidth: width,
          minHeight: height,
          maxHeight: height,
          child: Transform.translate(
            offset: Offset(-width * index / slatCount, 0),
            child: child,
          ),
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
    final envelope = t <= 0 || t >= 1 ? 0.0 : math.sin(math.pi * t);
    final from = ColoredBox(color: Colors.black, child: currentWidget);
    final to = ColoredBox(color: Colors.black, child: nextWidget);
    final Widget scene;
    switch (kind) {
      case OpticalTransitionKind.filmDissolve:
        const identity = ColorFilter.mode(Colors.white, BlendMode.modulate);
        final active = t > 0 && t < 1;
        scene = ColorFiltered(
          colorFilter: active
              ? const ColorFilter.linearToSrgbGamma()
              : identity,
          child: _blend(
            ColorFiltered(
              colorFilter: active
                  ? const ColorFilter.srgbToLinearGamma()
                  : identity,
              child: from,
            ),
            ColorFiltered(
              colorFilter: active
                  ? const ColorFilter.srgbToLinearGamma()
                  : identity,
              child: to,
            ),
            t,
          ),
        );
      case OpticalTransitionKind.frame:
        scene = Stack(
          fit: StackFit.expand,
          children: [
            from,
            CustomPaint(
              painter: _FrameDecoration(motion, envelope, shadow: true),
              foregroundPainter: _FrameDecoration(
                motion,
                envelope,
                shadow: false,
              ),
              child: ClipRect(clipper: _FrameClipper(motion), child: to),
            ),
          ],
        );
      case OpticalTransitionKind.mirror:
        scene = Stack(
          fit: StackFit.expand,
          children: [
            _blend(from, to, motion),
            ClipRect(
              clipper: _MirrorClipper(envelope),
              child: Transform.flip(
                flipX: true,
                child: _blend(from, to, motion),
              ),
            ),
          ],
        );
      case OpticalTransitionKind.louver:
        scene = ColoredBox(
          color: Colors.black,
          child: Stack(
            fit: StackFit.expand,
            children: [
              for (var i = 0; i < slatCount; i++)
                Builder(
                  builder: (context) {
                    final start = slatCount == 1
                        ? 0.0
                        : .25 * i / (slatCount - 1);
                    final phase = ((t - start) / .75).clamp(0.0, 1.0);
                    final angle = math.pi * phase;
                    return Positioned(
                      left: screenW * i / slatCount,
                      top: 0,
                      bottom: 0,
                      width:
                          screenW * (i + 1) / slatCount -
                          screenW * i / slatCount,
                      child: Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.identity()
                          ..setEntry(
                            3,
                            2,
                            1 / math.max(1.0, screenW / slatCount * 3.5),
                          )
                          ..rotateY(angle),
                        child: CustomPaint(
                          foregroundPainter: _SlatShade(phase),
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              Opacity(
                                opacity: phase < .5 ? 1 : 0,
                                child: _slat(from, i, screenW, screenH),
                              ),
                              Transform(
                                alignment: Alignment.center,
                                transform: Matrix4.rotationY(math.pi),
                                child: Opacity(
                                  opacity: phase >= .5 ? 1 : 0,
                                  child: _slat(to, i, screenW, screenH),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
            ],
          ),
        );
    }
    return ClipRect(child: scene);
  }
}

class _FrameClipper extends CustomClipper<Rect> {
  final double progress;
  _FrameClipper(this.progress);

  @override
  Rect getClip(Size size) => Rect.fromCenter(
    center: size.center(Offset.zero),
    width: size.width * progress,
    height: size.height * progress,
  );

  @override
  bool shouldReclip(_FrameClipper oldClipper) =>
      progress != oldClipper.progress;
}

class _MirrorClipper extends CustomClipper<Rect> {
  final double envelope;
  _MirrorClipper(this.envelope);

  @override
  Rect getClip(Size size) =>
      Rect.fromLTWH(0, 0, size.width * .5 * envelope, size.height);

  @override
  bool shouldReclip(_MirrorClipper oldClipper) =>
      envelope != oldClipper.envelope;
}

class _FrameDecoration extends CustomPainter {
  final double progress, envelope;
  final bool shadow;
  _FrameDecoration(this.progress, this.envelope, {required this.shadow});

  @override
  void paint(Canvas canvas, Size size) {
    if (size.isEmpty || envelope <= 0) return;
    final rect = Rect.fromCenter(
      center: size.center(Offset.zero),
      width: size.width * progress,
      height: size.height * progress,
    );
    final unit = math.min(size.width, size.height);
    if (shadow) {
      canvas.drawShadow(
        Path()..addRect(rect),
        Colors.black.withValues(alpha: envelope * .8),
        unit * .012,
        false,
      );
    } else {
      canvas.drawRect(
        rect,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = math.max(1, unit * .004)
          ..color = const Color(0xfffff4dc).withValues(alpha: envelope),
      );
    }
  }

  @override
  bool shouldRepaint(_FrameDecoration oldDelegate) =>
      progress != oldDelegate.progress ||
      envelope != oldDelegate.envelope ||
      shadow != oldDelegate.shadow;
}

class _SlatShade extends CustomPainter {
  final double progress;
  _SlatShade(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    if (size.isEmpty || progress <= 0 || progress >= 1) return;
    canvas.drawRect(
      Offset.zero & size,
      Paint()
        ..color = Colors.black.withValues(
          alpha: .35 * math.sin(math.pi * progress),
        ),
    );
  }

  @override
  bool shouldRepaint(_SlatShade oldDelegate) =>
      progress != oldDelegate.progress;
}
