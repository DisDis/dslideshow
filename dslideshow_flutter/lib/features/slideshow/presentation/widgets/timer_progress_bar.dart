import 'package:flutter/material.dart';

class TimerProgressBarPainter extends CustomPainter {
  final double progress;
  final Paint _paint = Paint()..color = Colors.red;
  TimerProgressBarPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(Rect.fromPoints(const Offset(0, 0), Offset(size.width * progress / 100, size.height)), _paint);
  }

  @override
  bool shouldRepaint(TimerProgressBarPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
