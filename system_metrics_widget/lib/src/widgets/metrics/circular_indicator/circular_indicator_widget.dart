import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:system_metrics_widget/src/environment/settings.dart';

class CircularArcPainter extends CustomPainter {
  final double percent;
  final Color? backgroundColor;
  final Color startColor;
  final Color endColor;
  final double width;

  const CircularArcPainter({
    required this.percent,
    required this.startColor,
    required this.endColor,
    required this.width,
    this.backgroundColor,
  }) : super();

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0.0, 0.0, size.width, size.height);
    final gradient = SweepGradient(
      startAngle: 3 * math.pi / 2,
      endAngle: 7 * math.pi / 2,
      tileMode: TileMode.repeated,
      colors: [startColor, endColor],
    );

    final backgroundPaint = Paint()
      ..color = backgroundColor!
      ..strokeCap = StrokeCap.butt // StrokeCap.round is not recommended.
      ..style = PaintingStyle.stroke
      ..strokeWidth = width + 2;

    final paint = Paint()
      ..shader = gradient.createShader(rect)
      ..strokeCap = StrokeCap.butt // StrokeCap.round is not recommended.
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width / 2, size.height / 2) - (width / 2);
    const startAngle = -math.pi / 2;
    final sweepAngle = 2 * math.pi * percent;

    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), startAngle, 2 * math.pi, false, backgroundPaint);
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), startAngle, sweepAngle, false, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class CircularIndicatorWidget extends StatefulWidget {
  final String title;
  final double percent;
  final Color endColor = Colors.red;
  final Color startColor = Colors.lightGreenAccent;
  final Color backgroundColor;

  CircularIndicatorWidget({
    Key? key,
    required this.percent,
    String? titleI,
    this.backgroundColor = Colors.white70,
  })  : title = titleI ?? '${(percent * 100).round()}%',
        super(key: key);

  @override
  State<StatefulWidget> createState() => _CircularIndicatorWidgetState();
}

class _CircularIndicatorWidgetState extends State<CircularIndicatorWidget> with SingleTickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(vsync: this, duration: const Duration(milliseconds: 500));

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      child: Center(
        child: Text(
          widget.title,
          style: Settings.loadAverageDetailsTextStyle,
        ),
      ),
      painter: CircularArcPainter(
        percent: widget.percent * _controller.value,
        width: 10,
        endColor: widget.endColor,
        startColor: widget.startColor,
        backgroundColor: widget.backgroundColor,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _controller
      ..addListener(() => setState(() {}))
      ..forward();
  }
}
