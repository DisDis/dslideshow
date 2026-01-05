import 'package:flutter/material.dart';

class UsageBar extends StatefulWidget {
  final int usagePercent;
  final Color primaryColor; // Передаем цвет снаружи

  const UsageBar({
    super.key, 
    required this.usagePercent, 
    this.primaryColor = Colors.blue,
  });

  @override
  State<StatefulWidget> createState() => _UsageBarState();
}

class _UsageBarState extends State<UsageBar> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this, 
    duration: const Duration(milliseconds: 800) // Плавная анимация
  );

  @override
  void initState() {
    super.initState();
    _controller.forward();
  }
  
  // Обновляем анимацию при изменении данных
  @override
  void didUpdateWidget(UsageBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.usagePercent != widget.usagePercent) {
      // Можно перезапустить анимацию, если нужно, или просто перерисовать
      // _controller.forward(from: 0); 
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          size: Size.infinite,
          painter: UsageBarPainter(
            // Анимируем значение от 0 до текущего при старте
            percent: widget.usagePercent * _controller.value, 
            color: widget.primaryColor,
          ),
        );
      },
    );
  }
}

class UsageBarPainter extends CustomPainter {
  final double percent;
  final Color color;

  UsageBarPainter({required this.percent, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    // 1. Рисуем Background Track (темно-серый)
    final trackPaint = Paint()
      ..color = Colors.white10 // Очень тусклый белый (серый на темном фоне)
      ..style = PaintingStyle.fill;
    
    // RRect для скругленных краев полоски
    final trackRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      const Radius.circular(2),
    );
    canvas.drawRRect(trackRect, trackPaint);

    // 2. Рисуем заполненную часть (Progress)
    final fillWidth = (size.width * percent / 100).clamp(0.0, size.width);
    
    final progressPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final progressRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, fillWidth.toDouble(), size.height),
      const Radius.circular(2),
    );
    canvas.drawRRect(progressRect, progressPaint);
  }

  @override
  bool shouldRepaint(UsageBarPainter oldDelegate) => 
      oldDelegate.percent != percent || oldDelegate.color != color;
}