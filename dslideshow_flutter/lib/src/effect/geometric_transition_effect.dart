import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'media_slider_item_effect.dart';

enum GeometricTransitionKind { clockWipe, split, panelWipe, stretch, starWipe }

/// Geometric transitions retain live media views; no frame capture, decoder or
/// bitmap allocation is needed. Split shares its outgoing media between halves.
class GeometricTransitionEffect extends MediaSliderItemEffect {
  final GeometricTransitionKind kind;
  final int panelCount;

  GeometricTransitionEffect(this.kind, {this.panelCount = 8})
    : assert(panelCount > 0);

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
    final from = ColoredBox(color: Colors.black, child: currentWidget);
    final to = ColoredBox(color: Colors.black, child: nextWidget);
    return ClipRect(
      child: switch (kind) {
        GeometricTransitionKind.clockWipe ||
        GeometricTransitionKind.panelWipe ||
        GeometricTransitionKind.starWipe => Stack(
          fit: StackFit.expand,
          children: [
            from,
            ClipPath(clipper: _RevealClipper(kind, t, panelCount), child: to),
          ],
        ),
        GeometricTransitionKind.split => Stack(
          fit: StackFit.expand,
          children: [
            to,
            for (final right in [false, true])
              Positioned(
                left: right ? screenW / 2 : 0,
                top: 0,
                width: screenW / 2,
                height: screenH,
                child: Transform.translate(
                  offset: Offset((right ? 1 : -1) * screenW / 2 * motion, 0),
                  child: ClipRect(
                    child: OverflowBox(
                      alignment: Alignment.topLeft,
                      minWidth: screenW,
                      maxWidth: screenW,
                      minHeight: screenH,
                      maxHeight: screenH,
                      child: Transform.translate(
                        offset: Offset(right ? -screenW / 2 : 0, 0),
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
            Transform.scale(scaleX: 1 + 2 * motion, child: from),
            Opacity(
              opacity: motion,
              child: ClipRect(
                child: Transform.scale(scaleX: 1 + 2 * (1 - motion), child: to),
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

  _RevealClipper(this.kind, this.progress, this.panelCount);

  @override
  Path getClip(Size size) {
    final path = Path();
    if (progress <= 0 || size.isEmpty) return path;
    if (progress >= 1) return path..addRect(Offset.zero & size);
    final center = size.center(Offset.zero);
    final radius =
        math.sqrt(size.width * size.width + size.height * size.height) / 2;
    switch (kind) {
      case GeometricTransitionKind.clockWipe:
        path
          ..moveTo(center.dx, center.dy)
          ..arcTo(
            Rect.fromCircle(center: center, radius: radius + 1),
            -math.pi / 2,
            math.pi * 2 * progress,
            false,
          )
          ..close();
      case GeometricTransitionKind.starWipe:
        const innerRatio = .42;
        final outer =
            (radius + 1) / innerRatio * Curves.easeIn.transform(progress);
        path.addPolygon([
          for (var i = 0; i < 10; i++)
            center +
                Offset(
                      math.cos(-math.pi / 2 + i * math.pi / 5),
                      math.sin(-math.pi / 2 + i * math.pi / 5),
                    ) *
                    outer *
                    (i.isEven ? 1 : innerRatio),
        ], true);
      case GeometricTransitionKind.panelWipe:
        for (var i = 0; i < panelCount; i++) {
          final start = panelCount == 1 ? 0.0 : .28 * i / (panelCount - 1);
          final panel = Curves.easeInOut.transform(
            ((progress - start) / .72).clamp(0.0, 1.0),
          );
          final top = size.height * i / panelCount;
          final bottom = size.height * (i + 1) / panelCount;
          final width = size.width * panel;
          path.addRect(
            Rect.fromLTWH(
              i.isEven ? 0 : size.width - width,
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
      panelCount != oldClipper.panelCount;
}
