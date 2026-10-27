import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import 'media_slider_item_effect.dart';

/// Peels the top-right corner towards the bottom-left. The plain paper back
/// and shaded fold are painted independently of the single live media view.
class PagePeelEffect extends MediaSliderItemEffect {
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
  ) => ClipRect(
    child: CustomPaint(
      foregroundPainter: _PaperBack(controller.value),
      child: Stack(
        fit: StackFit.expand,
        children: [
          ColoredBox(color: Colors.black, child: nextWidget),
          ClipPath(
            clipper: _PageClipper(controller.value),
            child: ColoredBox(color: Colors.black, child: currentWidget),
          ),
        ],
      ),
    ),
  );
}

/// Intersect the page with one side of the moving diagonal x - y = crease.
List<Offset> _pagePolygon(Size size, double crease, {required bool peeled}) {
  final corners = [
    Offset.zero,
    Offset(size.width, 0),
    Offset(size.width, size.height),
    Offset(0, size.height),
  ];
  final result = <Offset>[];
  for (var i = 0; i < corners.length; i++) {
    final a = corners[i], b = corners[(i + 1) % corners.length];
    final da = a.dx - a.dy - crease, db = b.dx - b.dy - crease;
    final insideA = peeled ? da >= 0 : da <= 0;
    final insideB = peeled ? db >= 0 : db <= 0;
    if (insideA) result.add(a);
    if (insideA != insideB) result.add(Offset.lerp(a, b, da / (da - db))!);
  }
  return result;
}

Path _polygonPath(List<Offset> points) => Path()..addPolygon(points, true);

class _PageClipper extends CustomClipper<Path> {
  final double progress;

  _PageClipper(this.progress);

  @override
  Path getClip(Size size) {
    if (progress <= 0) return Path()..addRect(Offset.zero & size);
    if (progress >= 1) return Path();
    return _polygonPath(
      _pagePolygon(
        size,
        size.width - (size.width + size.height) * progress,
        peeled: false,
      ),
    );
  }

  @override
  bool shouldReclip(_PageClipper oldClipper) => progress != oldClipper.progress;
}

class _PaperBack extends CustomPainter {
  final double progress;

  _PaperBack(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    if (size.isEmpty || progress <= 0 || progress >= 1) return;
    final crease = size.width - (size.width + size.height) * progress;
    final peeled = _pagePolygon(size, crease, peeled: true);
    // Reflect the lifted portion across its crease to form the paper back.
    final back = _polygonPath([
      for (final p in peeled) Offset(p.dy + crease, p.dx - crease),
    ]);
    final foldWidth = math.min(size.width, size.height) * .12;
    final normal = Offset(1 / math.sqrt(2), -1 / math.sqrt(2));
    final onCrease = Offset(crease / 2, -crease / 2);
    canvas.drawShadow(back, Colors.black.withValues(alpha: .55), 6, false);
    final shader = ui.Gradient.linear(
      onCrease,
      onCrease - normal * foldWidth,
      const [Color(0xff96918a), Color(0xfffffdf5), Color(0xffe6e1d5)],
      const [0, .35, 1],
    );
    canvas.drawPath(back, Paint()..shader = shader);
    shader.dispose();
  }

  @override
  bool shouldRepaint(_PaperBack oldDelegate) =>
      progress != oldDelegate.progress;
}
