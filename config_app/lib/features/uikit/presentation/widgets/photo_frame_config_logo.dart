import 'dart:math' as math;
import 'package:config_app/features/theme/presentation/theme.dart';
import 'package:flutter/material.dart';

/// Виджет логотипа приложения "Конфигуратор Фоторамки".
///
/// Рисуется векторно через [CustomPainter], поэтому идеально масштабируется.
/// По умолчанию имеет размер 24x24, если не указан [size].
class PhotoFrameConfigLogo extends StatelessWidget {
  /// Размер квадратной области, в которую будет вписан логотип.
  final double? size;

  /// Основной цвет рамки (если не задан, используются цвета по умолчанию).
  /// Можно использовать для адаптации к темной/светлой теме.
  final Color? color;

  const PhotoFrameConfigLogo({
    super.key,
    this.size,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final double iconSize = size ?? 24.0;

    return SizedBox(
      width: iconSize,
      height: iconSize,
      child: CustomPaint(
        painter: _LogoPainter(
          baseColor: color,
        ),
      ),
    );
  }
}

class _LogoPainter extends CustomPainter {
  final Color? baseColor;

  _LogoPainter({this.baseColor});

  @override
  void paint(Canvas canvas, Size size) {
    // Базовые размеры и отступы для масштабирования
    final w = size.width;
    final h = size.height;
    final shortestSide = math.min(w, h);
    
    // Параметры рамки
    final frameThickness = shortestSide * 0.08;
    final cornerRadius = shortestSide * 0.12;
    final frameRect = Rect.fromLTWH(0, 0, w, h);

    // 1. Рисуем внешнюю рамку (корпус устройства)
    final framePaint = Paint()
      ..color = baseColor ?? AppColors.logoFrameDefault
      ..style = PaintingStyle.fill;

    canvas.drawRRect(
      RRect.fromRectAndRadius(frameRect, Radius.circular(cornerRadius)),
      framePaint,
    );

    // Область экрана внутри рамки
    final screenRect = frameRect.deflate(frameThickness);
    final screenClipRRect = RRect.fromRectAndRadius(
      screenRect, 
      Radius.circular(cornerRadius * 0.7)
    );

    // 2. Рисуем "Экран" и его содержимое.
    // Используем clipRRect, чтобы контент не вылезал за пределы скругленного экрана.
    canvas.save();
    canvas.clipRRect(screenClipRRect);

    // а) Фон экрана (легкий градиент)
    final screenBgPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          AppColors.logoScreenStart.withAlpha((255.0 * 0.1).round()),
          AppColors.logoScreenEnd.withAlpha((255.0 * 0.3).round()),
        ],
      ).createShader(screenRect);
    canvas.drawRect(screenRect, screenBgPaint);


    // б) Абстрактная форма "Горы/Изображения" (нижняя часть)
    final mountainPath = Path();
    mountainPath.moveTo(screenRect.left, screenRect.bottom * 0.7);
    // Кривая вверх к пику
    mountainPath.quadraticBezierTo(
      screenRect.width * 0.4, screenRect.top * 0.4, // Контрольная точка
      screenRect.width * 0.6, screenRect.top * 0.55 // Конечная точка пика
    );
    // Кривая вниз к правому краю
    mountainPath.quadraticBezierTo(
      screenRect.width * 0.85, screenRect.top * 0.7, // Контрольная точка
      screenRect.right, screenRect.bottom * 0.5 // Конечная точка справа
    );
    // Замыкаем путь по низу
    mountainPath.lineTo(screenRect.right, screenRect.bottom);
    mountainPath.lineTo(screenRect.left, screenRect.bottom);
    mountainPath.close();

    final mountainPaint = Paint()
      ..shader = const LinearGradient(
         begin: Alignment.topCenter,
         end: Alignment.bottomCenter,
         colors: [AppColors.logoScreenStart, AppColors.logoScreenEnd],
      ).createShader(screenRect);

    canvas.drawPath(mountainPath, mountainPaint);


    // в) Акцентный элемент "Настройка/Солнце" (верхняя часть)
    // Рисуем круг, который символизирует фокус или элемент управления.
    final accentCenter = Offset(screenRect.width * 0.7, screenRect.height * 0.35);
    final accentRadius = shortestSide * 0.12;

    final accentPaint = Paint()
      ..color = AppColors.logoAccentColor
      ..style = PaintingStyle.fill
      // Добавляем легкое свечение
      ..maskFilter = const MaskFilter.blur(BlurStyle.solid, 2);

    canvas.drawCircle(accentCenter, accentRadius, accentPaint);
    
    // Добавляем белый ободок для контраста акцента
    final accentBorderPaint = Paint()
      ..color = AppColors.whiteOpacity40
      ..style = PaintingStyle.stroke
      ..strokeWidth = shortestSide * 0.02;
      
    canvas.drawCircle(accentCenter, accentRadius, accentBorderPaint);

    canvas.restore(); // Завершаем клиппинг экрана
  }

  @override
  bool shouldRepaint(covariant _LogoPainter oldDelegate) {
    return oldDelegate.baseColor != baseColor;
  }
}