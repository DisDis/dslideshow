import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:system_metrics_widget/src/environment/settings.dart';

class CircularIndicatorWidget extends StatefulWidget {
  final String? title;
  final double percent; // 0.0 to 1.0 (или больше)
  
  const CircularIndicatorWidget({
    super.key,
    required this.percent,
    this.title,
  });

  @override
  State<StatefulWidget> createState() => _CircularIndicatorWidgetState();
}

class _CircularIndicatorWidgetState extends State<CircularIndicatorWidget> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this, 
    duration: const Duration(milliseconds: 1000), // Плавный старт
  );

  @override
  void initState() {
    super.initState();
    _controller.forward();
  }
  
  // Обновляем анимацию при смене данных
  @override
  void didUpdateWidget(CircularIndicatorWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.percent != widget.percent) {
       // _controller.forward(from: 0); // Раскомментировать, если хотим перезапуск анимации
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Color _getColor(double percent) {
    if (percent > 1.0) return Colors.redAccent; // Перегрузка > 100%
    if (percent > 0.8) return Colors.orangeAccent;
    return Colors.cyanAccent; // Стандартный "Tech" цвет
  }

  @override
  Widget build(BuildContext context) {
    final color = _getColor(widget.percent);
    
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final animatedPercent = widget.percent * _controller.value;
        return CustomPaint(
          painter: CircularArcPainter(
            percent: animatedPercent,
            color: color,
            strokeWidth: 4.0, // Тонкая линия для стиля HUD
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Значение (например 0.45)
                Text(
                  widget.percent.toStringAsFixed(2),
                  style: Settings.circularIndicatorValueTextStyle(color),
                ),
                // Подпись (если есть)
                if (widget.title != null)
                  Text(
                    widget.title!,
                    style: Settings.circularIndicatorTitleTextStyle,
                  )
              ],
            ),
          ),
        );
      },
    );
  }
}

class CircularArcPainter extends CustomPainter {
  final double percent;
  final Color color;
  final double strokeWidth;

  const CircularArcPainter({
    required this.percent,
    required this.color,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    // Радиус с учетом толщины линии, чтобы не обрезалось
    final radius = math.min(size.width / 2, size.height / 2) - (strokeWidth / 2);

    // 1. Рисуем фоновый трек (тусклое кольцо)
    final trackPaint = Paint()
      ..color = Colors.white10
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    canvas.drawCircle(center, radius, trackPaint);

    // 2. Рисуем активную дугу
    final activePaint = Paint()
      ..color = color
      ..strokeCap = StrokeCap.round // Красивые закругленные концы
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    // Начало сверху (-pi/2)
    const startAngle = -math.pi / 2;
    // Ограничиваем, чтобы круг не наматывался несколько раз визуально
    final sweepAngle = 2 * math.pi * percent.clamp(0.0, 1.0);

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      activePaint,
    );
  }

  @override
  bool shouldRepaint(CircularArcPainter oldDelegate) =>
      oldDelegate.percent != percent || oldDelegate.color != color;
}