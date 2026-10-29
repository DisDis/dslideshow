import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'media_slider_item_effect.dart';

import 'package:dslideshow_common/effects.dart';

import 'effect_geometry.dart';

enum OpticalTransitionKind { filmDissolve, frame, louver, mirror }

/// Optical transitions over live media. Repeated faces borrow the same prepared
/// images and video sessions; no snapshots or extra decoders are created.
class OpticalTransitionEffect extends MediaSliderItemEffect {
  final OpticalTransitionKind kind;
  final int slatCount;
  final LouverEffectOptions louver;
  final MirrorEffectOptions mirror;
  final RevealMaskEffectOptions frame;

  OpticalTransitionEffect(
    this.kind, {
    this.slatCount = 8,
    this.louver = const LouverEffectOptions(),
    this.mirror = const MirrorEffectOptions(),
    this.frame = const RevealMaskEffectOptions(origin: EffectOrigin.center),
  }) : assert(slatCount > 0);

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

  Widget _slat(
    Widget child,
    int index,
    double width,
    double height, {
    required bool rotating,
  }) => ClipRect(
    // Isolate the full-size live media before the narrow slat is projected.
    // Near edge-on, composited descendants can otherwise escape the clip.
    // Flat endpoints keep hard edges so fractional slats meet without seams.
    clipBehavior: rotating ? Clip.antiAliasWithSaveLayer : Clip.hardEdge,
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
    EffectSlideInput current,
    EffectSlideInput next,
    Animation<double> controller,
    double screenW,
    double screenH,
  ) {
    final t = controller.value.clamp(0.0, 1.0);
    final motion = Curves.easeInOutCubic.transform(t);
    final envelope = t <= 0 || t >= 1 ? 0.0 : math.sin(math.pi * t);
    final from = ColoredBox(color: Colors.black, child: current.view);
    final to = ColoredBox(color: Colors.black, child: next.view);
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
              painter: _FrameDecoration(motion, envelope, frame, shadow: true),
              foregroundPainter: _FrameDecoration(
                motion,
                envelope,
                frame,
                shadow: false,
              ),
              child: ClipRect(
                clipper: _FrameClipper(motion, frame.origin),
                child: to,
              ),
            ),
          ],
        );
      case OpticalTransitionKind.mirror:
        scene = Stack(
          fit: StackFit.expand,
          children: [
            _blend(from, to, motion),
            ClipRect(
              clipper: _MirrorClipper(envelope, mirror.side),
              child: Opacity(
                opacity: mirror.strength,
                child: Transform.flip(
                  flipX: true,
                  child: _blend(from, to, motion),
                ),
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
                        : louver.staggerFraction * i / (slatCount - 1);
                    final phase = ((t - start) / (1 - louver.staggerFraction))
                        .clamp(0.0, 1.0);
                    final angle =
                        (louver.rotationSense == RotationSense.forward
                            ? 1
                            : -1) *
                        math.pi *
                        phase;
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
                          foregroundPainter: _SlatShade(
                            phase,
                            louver.shadowIntensity,
                          ),
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              Opacity(
                                opacity: phase < .5 ? 1 : 0,
                                child: _slat(
                                  from,
                                  i,
                                  screenW,
                                  screenH,
                                  rotating: phase > 0 && phase < 1,
                                ),
                              ),
                              Transform(
                                alignment: Alignment.center,
                                transform: Matrix4.rotationY(math.pi),
                                child: Opacity(
                                  opacity: phase >= .5 ? 1 : 0,
                                  child: _slat(
                                    to,
                                    i,
                                    screenW,
                                    screenH,
                                    rotating: phase > 0 && phase < 1,
                                  ),
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
  final EffectOrigin origin;
  _FrameClipper(this.progress, this.origin);

  @override
  Rect getClip(Size size) => Rect.fromCenter(
    center: Offset.lerp(
      effectOrigin(origin).alongSize(size),
      size.center(Offset.zero),
      progress,
    )!,
    width: size.width * progress,
    height: size.height * progress,
  );

  @override
  bool shouldReclip(_FrameClipper oldClipper) =>
      progress != oldClipper.progress || origin != oldClipper.origin;
}

class _MirrorClipper extends CustomClipper<Rect> {
  final double envelope;
  final MirrorSide side;
  _MirrorClipper(this.envelope, this.side);

  @override
  Rect getClip(Size size) => Rect.fromLTWH(
    side == MirrorSide.leading ? 0 : size.width * (1 - .5 * envelope),
    0,
    size.width * .5 * envelope,
    size.height,
  );

  @override
  bool shouldReclip(_MirrorClipper oldClipper) =>
      envelope != oldClipper.envelope || side != oldClipper.side;
}

class _FrameDecoration extends CustomPainter {
  final double progress, envelope;
  final bool shadow;
  final RevealMaskEffectOptions options;
  _FrameDecoration(
    this.progress,
    this.envelope,
    this.options, {
    required this.shadow,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (size.isEmpty || envelope <= 0) return;
    final rect = Rect.fromCenter(
      center: Offset.lerp(
        effectOrigin(options.origin).alongSize(size),
        size.center(Offset.zero),
        progress,
      )!,
      width: size.width * progress,
      height: size.height * progress,
    );
    final unit = math.min(size.width, size.height);
    if (shadow) {
      canvas.drawShadow(
        Path()..addRect(rect),
        Colors.black.withValues(alpha: envelope * options.shadowStrength),
        unit * .012,
        false,
      );
    } else if (options.borderWidth > 0) {
      canvas.drawRect(
        rect,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = math.max(1, unit * options.borderWidth)
          ..color = Color(options.borderColor)
              .withValues(alpha: Color(options.borderColor).a * envelope),
      );
    }
  }

  @override
  bool shouldRepaint(_FrameDecoration oldDelegate) =>
      progress != oldDelegate.progress ||
      envelope != oldDelegate.envelope ||
      shadow != oldDelegate.shadow ||
      options != oldDelegate.options;
}

class _SlatShade extends CustomPainter {
  final double progress;
  final double intensity;
  _SlatShade(this.progress, this.intensity);

  @override
  void paint(Canvas canvas, Size size) {
    if (size.isEmpty || progress <= 0 || progress >= 1) return;
    canvas.drawRect(
      Offset.zero & size,
      Paint()
        ..color = Colors.black.withValues(
          alpha: intensity * math.sin(math.pi * progress),
        ),
    );
  }

  @override
  bool shouldRepaint(_SlatShade oldDelegate) =>
      progress != oldDelegate.progress || intensity != oldDelegate.intensity;
}
