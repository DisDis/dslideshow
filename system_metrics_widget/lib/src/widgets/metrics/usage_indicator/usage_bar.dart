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
  final int usagePercent;

  final Paint _usedPaint = Paint()..color = Colors.red;
  final Paint _freePaint = Paint()..color = Colors.lightGreen;

  UsageBarPainter(this.usagePercent);

  @override
  void paint(Canvas canvas, Size size) {
    final usageEndPosition = size.width * usagePercent / 100;
    canvas
      ..drawRect(Rect.fromPoints(Offset(0, 0), Offset(usageEndPosition, size.height)), _usedPaint)
      ..drawRect(Rect.fromPoints(Offset(usageEndPosition, 0), Offset(size.width, size.height)), _freePaint);
  }

  @override
  bool shouldRepaint(UsageBarPainter oldDelegate) => oldDelegate.usagePercent != usagePercent;
}
