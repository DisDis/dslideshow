import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:math' as math;

class UsageBar extends StatelessWidget {
  final int usagePercent;

  UsageBar({@required this.usagePercent});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return CustomPaint(
      size: Size(size.width, 8),
      painter: UsageBarPainter(usagePercent),
    );
  }
}

class UsageBarPainter extends CustomPainter {
  final Color _usedColorStart = Colors.red.withAlpha(100);
  final Color _usedColoEnd = Colors.red;

  final Color _freeColorStart = Colors.lightGreenAccent;
  final Color _freeColoEnd = Colors.lightGreenAccent.withAlpha(100);

  final int usagePercent;

  UsageBarPainter(this.usagePercent);

  @override
  void paint(Canvas canvas, Size size) {
    final transitionWidth = 8.0;
    final usageEndPosition = size.width * usagePercent / 100;
    final hasTransition = math.min(usageEndPosition, size.width - usageEndPosition) > 10;

    final usedRect = Offset.zero & Size(usageEndPosition, size.height);
    final freeRect = usedRect.topRight & Size(size.width - usageEndPosition, size.height);

    final Paint usedPaint = Paint()
      ..shader = LinearGradient(
        colors: [
          _usedColorStart,
          _usedColoEnd,
        ],
      ).createShader(usedRect);

    final Paint freePaint = Paint()
      ..shader = LinearGradient(
        colors: [
          _freeColorStart,
          _freeColoEnd,
        ],
      ).createShader(freeRect);

    final transitionRect = hasTransition
        ? (usedRect.topRight - Offset(transitionWidth, 0) &
            Size(transitionWidth, usedRect.height))
        : Rect.zero;

    final Paint transitionPaint = Paint()
      ..shader = LinearGradient(
        colors: [
          _usedColoEnd,
          _freeColorStart,
        ],
      ).createShader(transitionRect);

    canvas..drawRect(usedRect, usedPaint)..drawRect(freeRect, freePaint)..drawRect(transitionRect, transitionPaint);
  }

  @override
  bool shouldRepaint(UsageBarPainter oldDelegate) => oldDelegate.usagePercent != usagePercent;
}
