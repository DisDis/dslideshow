import 'package:dslideshow_common/effects.dart';
export 'package:dslideshow_common/effects.dart' show RevealShape;

import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'media_slider_item_effect.dart';

class RevealEffect extends MediaSliderItemEffect {
  final RevealShape shape;
  final AxisDirection direction;
  final Alignment origin;
  RevealEffect({
    this.shape = RevealShape.wipe,
    this.direction = AxisDirection.left,
    this.origin = Alignment.topLeft,
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
  ) => Stack(
    fit: StackFit.expand,
    children: [
      currentWidget,
      ClipPath(
        clipper: _RevealClipper(controller.value, shape, direction, origin),
        child: nextWidget,
      ),
    ],
  );
}

class _RevealClipper extends CustomClipper<Path> {
  final double progress;
  final RevealShape shape;
  final AxisDirection direction;
  final Alignment origin;
  _RevealClipper(this.progress, this.shape, this.direction, this.origin);

  @override
  Path getClip(Size size) {
    final path = Path();
    if (progress <= 0) return path;
    if (progress >= 1) return path..addRect(Offset.zero & size);
    final w = size.width;
    final h = size.height;
    switch (shape) {
      case RevealShape.wipe:
        path.addRect(switch (direction) {
          AxisDirection.left => Rect.fromLTWH(
            w * (1 - progress),
            0,
            w * progress,
            h,
          ),
          AxisDirection.right => Rect.fromLTWH(0, 0, w * progress, h),
          AxisDirection.up => Rect.fromLTWH(
            0,
            h * (1 - progress),
            w,
            h * progress,
          ),
          AxisDirection.down => Rect.fromLTWH(0, 0, w, h * progress),
        });
      case RevealShape.curtain:
        final horizontal = axisDirectionToAxis(direction) == Axis.horizontal;
        path.addRect(
          Rect.fromCenter(
            center: size.center(Offset.zero),
            width: horizontal ? w * progress : w,
            height: horizontal ? h : h * progress,
          ),
        );
      case RevealShape.diagonal:
        final p = progress * 2;
        path.moveTo(0, 0);
        if (p <= 1) {
          path
            ..lineTo(w * p, 0)
            ..lineTo(0, h * p);
        } else {
          path
            ..lineTo(w, 0)
            ..lineTo(w, h * (p - 1))
            ..lineTo(w * (p - 1), h)
            ..lineTo(0, h);
        }
        path.close();
        return path.transform(
          (Matrix4.identity()
                ..translateByDouble(
                  origin.x > 0 ? w : 0,
                  origin.y > 0 ? h : 0,
                  0,
                  1,
                )
                ..scaleByDouble(
                  origin.x > 0 ? -1 : 1,
                  origin.y > 0 ? -1 : 1,
                  1,
                  1,
                ))
              .storage,
        );
      case RevealShape.rectangle:
        final point = origin.alongSize(size);
        final growth = Curves.easeInOutCubic.transform(progress);
        path.addRect(
          Rect.fromCenter(
            center: Offset.lerp(point, size.center(Offset.zero), growth)!,
            width: w * growth,
            height: h * growth,
          ),
        );
      case RevealShape.star:
        final center = origin.alongSize(size);
        final radius = math.sqrt(
          math.pow(math.max(center.dx, w - center.dx), 2) +
              math.pow(math.max(center.dy, h - center.dy), 2),
        );
        final outer = (radius + 1) / .42 * Curves.easeIn.transform(progress);
        path.addPolygon([
          for (var i = 0; i < 10; i++)
            center +
                Offset(
                      math.cos(-math.pi / 2 + i * math.pi / 5),
                      math.sin(-math.pi / 2 + i * math.pi / 5),
                    ) *
                    outer *
                    (i.isEven ? 1 : .42),
        ], true);
      case RevealShape.clock:
        final center = origin.alongSize(size);
        final radius = math.sqrt(
          math.pow(math.max(center.dx, w - center.dx), 2) +
              math.pow(math.max(center.dy, h - center.dy), 2),
        );
        path
          ..moveTo(center.dx, center.dy)
          ..arcTo(
            Rect.fromCircle(center: center, radius: radius + 1),
            -math.pi / 2,
            math.pi * 2 * progress,
            false,
          )
          ..close();
      case RevealShape.iris:
        final center = origin.alongSize(size);
        final dx = math.max(center.dx, w - center.dx);
        final dy = math.max(center.dy, h - center.dy);
        path.addOval(
          Rect.fromCircle(
            center: center,
            radius: math.sqrt(dx * dx + dy * dy) * progress,
          ),
        );
    }
    return path;
  }

  @override
  bool shouldReclip(covariant _RevealClipper old) =>
      old.progress != progress ||
      old.shape != shape ||
      old.direction != direction ||
      old.origin != origin;
}
