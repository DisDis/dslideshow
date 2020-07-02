import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class UsageBar extends StatelessWidget {
  final int usagePercent;

  UsageBar({@required this.usagePercent});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return CustomPaint(
      size: Size(size.width, 6),
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
    final usageEndPosition = size.width * usagePercent / 100;
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

    canvas..drawRect(usedRect, usedPaint)..drawRect(freeRect, freePaint);
  }

  @override
  bool shouldRepaint(UsageBarPainter oldDelegate) => oldDelegate.usagePercent != usagePercent;
}