import 'dart:math' as math;

import 'package:flutter/material.dart';

class UsageBar extends StatefulWidget {
  final int? usagePercent;

  const UsageBar({Key? key, required this.usagePercent}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _UsageBarState();
}

class UsageBarPainter extends CustomPainter {
  final Color _usedColorStart = Colors.red;
  final Color _usedColoEnd = Colors.red;

  final Color _freeColorStart = Colors.lightGreenAccent;
  final Color _freeColoEnd = Colors.lightGreenAccent;

  final int usagePercent;

  UsageBarPainter(this.usagePercent);

  @override
  void paint(Canvas canvas, Size size) {
    const transitionWidth = 8.0;
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
        ? (usedRect.topRight - const Offset(transitionWidth, 0) & Size(transitionWidth, usedRect.height))
        : Rect.zero;

    final Paint transitionPaint = Paint()
      ..shader = LinearGradient(
        colors: [
          _usedColoEnd,
          _freeColorStart,
        ],
      ).createShader(transitionRect);

    canvas
      ..drawRect(usedRect, usedPaint)
      ..drawRect(freeRect, freePaint)
      ..drawRect(transitionRect, transitionPaint);
  }

  @override
  bool shouldRepaint(UsageBarPainter oldDelegate) => oldDelegate.usagePercent != usagePercent;
}

class _UsageBarState extends State<UsageBar> with SingleTickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(vsync: this, duration: const Duration(milliseconds: 500));

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return CustomPaint(
      size: Size(size.width, 8),
      painter: UsageBarPainter((widget.usagePercent! * _controller.value).toInt()),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller
      ..addListener(() => setState(() {}))
      ..forward();
  }
}
