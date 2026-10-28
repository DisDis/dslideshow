import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'media_slider_item_effect.dart';

import 'package:dslideshow_common/effects.dart';

import 'effect_geometry.dart';

enum GeometricTransitionKind { clockWipe, split, panelWipe, stretch, starWipe }

/// Geometric transitions retain live media views; no frame capture, decoder or
/// bitmap allocation is needed. Split shares its outgoing media between halves.
class GeometricTransitionEffect extends MediaSliderItemEffect {
  final GeometricTransitionKind kind;
  final int panelCount;
  final RevealMaskEffectOptions revealOptions;
  final SplitEffectOptions splitOptions;
  final StretchEffectOptions stretchOptions;
  final double staggerFraction;
  final StripPattern pattern;

  GeometricTransitionEffect(
    this.kind, {
    this.panelCount = 8,
    this.revealOptions = const RevealMaskEffectOptions(
      origin: EffectOrigin.center,
    ),
    this.splitOptions = const SplitEffectOptions(),
    this.stretchOptions = const StretchEffectOptions(),
    this.staggerFraction = .28,
    this.pattern = StripPattern.alternating,
  }) : assert(panelCount > 0);

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
    final motion = Curves.easeInOutCubic.transform(t);
    final from = ColoredBox(color: Colors.black, child: current.view);
    final to = ColoredBox(color: Colors.black, child: next.view);
    return ClipRect(
      child: switch (kind) {
        GeometricTransitionKind.clockWipe ||
        GeometricTransitionKind.panelWipe ||
        GeometricTransitionKind.starWipe => Stack(
          fit: StackFit.expand,
          children: [
            from,
            ClipPath(
              clipper: _RevealClipper(
                kind,
                t,
                panelCount,
                revealOptions,
                staggerFraction,
                pattern,
              ),
              child: to,
            ),
          ],
        ),
        GeometricTransitionKind.split => Stack(
          fit: StackFit.expand,
          children: [
            to,
            for (final right in [false, true])
              Positioned(
                left: right ? screenW * splitOptions.splitPosition : 0,
                top: 0,
                width:
                    screenW *
                    (right
                        ? 1 - splitOptions.splitPosition
                        : splitOptions.splitPosition),
                height: screenH,
                child: Transform.translate(
                  offset: Offset(
                    (right
                            ? 1 - splitOptions.splitPosition
                            : -splitOptions.splitPosition) *
                        screenW *
                        motion,
                    0,
                  ),
                  child: ClipRect(
                    child: OverflowBox(
                      alignment: Alignment.topLeft,
                      minWidth: screenW,
                      maxWidth: screenW,
                      minHeight: screenH,
                      maxHeight: screenH,
                      child: Transform.translate(
                        offset: Offset(
                          right ? -screenW * splitOptions.splitPosition : 0,
                          0,
                        ),
                        child: from,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
        GeometricTransitionKind.stretch => Stack(
          fit: StackFit.expand,
          children: [
            Transform.scale(
              scaleX: 1 + (stretchOptions.maxScale - 1) * motion,
              filterQuality: FilterQuality.high,
              child: from,
            ),
            Opacity(
              opacity: motion,
              child: ClipRect(
                child: Transform.scale(
                  scaleX: 1 + (stretchOptions.maxScale - 1) * (1 - motion),
                  filterQuality: FilterQuality.high,
                  child: to,
                ),
              ),
            ),
          ],
        ),
      },
    );
  }
}

class _RevealClipper extends CustomClipper<Path> {
  final GeometricTransitionKind kind;
  final double progress;
  final int panelCount;
  final RevealMaskEffectOptions options;
  final double staggerFraction;
  final StripPattern pattern;

  _RevealClipper(
    this.kind,
    this.progress,
    this.panelCount,
    this.options,
    this.staggerFraction,
    this.pattern,
  );

  @override
  Path getClip(Size size) {
    final path = Path();
    if (progress <= 0 || size.isEmpty) return path;
    if (progress >= 1) return path..addRect(Offset.zero & size);
    final center = effectOrigin(options.origin).alongSize(size);
    final radius = math.sqrt(
      math.pow(math.max(center.dx, size.width - center.dx), 2) +
          math.pow(math.max(center.dy, size.height - center.dy), 2),
    );
    switch (kind) {
      case GeometricTransitionKind.clockWipe:
        path
          ..moveTo(center.dx, center.dy)
          ..arcTo(
            Rect.fromCircle(center: center, radius: radius + 1),
            -math.pi / 2 + options.startAngleDegrees * math.pi / 180,
            (options.circularDirection == CircularDirection.clockwise
                    ? 1
                    : -1) *
                math.pi *
                2 *
                progress,
            false,
          )
          ..close();
      case GeometricTransitionKind.starWipe:
        final innerRatio = options.innerRadiusRatio;
        final outer =
            (radius + 1) / innerRatio * Curves.easeIn.transform(progress);
        path.addPolygon([
          for (var i = 0; i < options.pointCount * 2; i++)
            center +
                Offset(
                      math.cos(
                        -math.pi / 2 +
                            options.rotationDegrees * math.pi / 180 +
                            i * math.pi / options.pointCount,
                      ),
                      math.sin(
                        -math.pi / 2 +
                            options.rotationDegrees * math.pi / 180 +
                            i * math.pi / options.pointCount,
                      ),
                    ) *
                    outer *
                    (i.isEven ? 1 : innerRatio),
        ], true);
      case GeometricTransitionKind.panelWipe:
        for (var i = 0; i < panelCount; i++) {
          final start = panelCount == 1
              ? 0.0
              : staggerFraction * i / (panelCount - 1);
          final panel = Curves.easeInOut.transform(
            ((progress - start) / (1 - staggerFraction)).clamp(0.0, 1.0),
          );
          final top = size.height * i / panelCount;
          final bottom = size.height * (i + 1) / panelCount;
          final width = size.width * panel;
          path.addRect(
            Rect.fromLTWH(
              (pattern == StripPattern.sameDirection || i.isEven)
                  ? 0
                  : size.width - width,
              top,
              width,
              bottom - top,
            ),
          );
        }
      case GeometricTransitionKind.split:
      case GeometricTransitionKind.stretch:
        throw StateError('Only reveal transitions use a clipping mask.');
    }
    return path;
  }

  @override
  bool shouldReclip(_RevealClipper oldClipper) =>
      kind != oldClipper.kind ||
      progress != oldClipper.progress ||
      panelCount != oldClipper.panelCount ||
      options != oldClipper.options ||
      staggerFraction != oldClipper.staggerFraction ||
      pattern != oldClipper.pattern;
}
