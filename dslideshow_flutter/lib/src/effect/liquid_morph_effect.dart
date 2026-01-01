import 'dart:math';
import 'package:dslideshow_flutter/src/effect/media_slider_item_effect.dart';
import 'package:flutter/material.dart';

// --- Эффект Жидкого Морфинга ---
class LiquidMorphEffect extends MediaSliderItemEffect {
  final int waveCount; // Количество "волн" по окружности
  final double waveIntensity; // Насколько глубокие волны

  LiquidMorphEffect({
    this.waveCount = 12,
    this.waveIntensity = 15.0, 
  });

  @override
  Widget transform(BuildContext context, Widget page, bool isCurrentPage,
      double pageDelta, double screenW, double screenH) {
    return page;
  }

  @override
  Widget createTransformWidget(
    BuildContext context,
    Widget currentWidget,
    Widget nextWidget,
    AnimationController controller,
    double screenW,
    double screenH,
  ) {
    // ВАЖНО: В отличие от прошлых эффектов, здесь
    // currentWidget лежит ВНИЗУ, а nextWidget появляется СВЕРХУ.
    return Stack(
      fit: StackFit.expand,
      children: [
        // 1. Старое изображение на фоне.
        // Можно добавить легкий эффект отдаления для глубины.
        Transform.scale(
           scale: 1.0 + (0.1 * controller.value), // Немного увеличивается пока исчезает
           child: currentWidget
        ),

        // 2. Новое изображение, которое "вливается" через волнистую маску.
        ClipPath(
          clipper: _LiquidRevealClipper(
            progress: controller.value,
            waveCount: waveCount,
            waveIntensity: waveIntensity,
          ),
          child: nextWidget,
        ),
      ],
    );
  }
}

// --- Клиппер для создания волнистой круговой формы ---
class _LiquidRevealClipper extends CustomClipper<Path> {
  final double progress;
  final int waveCount;
  final double waveIntensity;

  _LiquidRevealClipper({
    required this.progress,
    required this.waveCount,
    required this.waveIntensity,
  });

  @override
  Path getClip(Size size) {
    final Path path = Path();
    final Offset center = Offset(size.width / 2, size.height / 2);

    // Максимальный радиус - это диагональ экрана (чтобы точно все покрыть)
    final double maxRadius = sqrt(size.width * size.width + size.height * size.height) / 1.8;
    
    // Текущий базовый радиус круга, который растет с прогрессом
    final double currentBaseRadius = maxRadius * progress;

    // Если прогресс 0, ничего не показываем
    if (progress <= 0.0) {
      return path; 
    }
    // Если прогресс 1, показываем все (простой прямоугольник быстрее сложного пути)
    if (progress >= 1.0) {
      path.addRect(Rect.fromLTWH(0, 0, size.width, size.height));
      return path;
    }

    // Рисуем волнистый круг по точкам
    path.moveTo(center.dx + currentBaseRadius, center.dy); // Начальная точка справа

    // Проходим по окружности (360 градусов = 2*pi радиан) с небольшим шагом
    for (double angle = 0.0; angle <= pi * 2.05; angle += 0.05) {
      // 1. Базовое искажение синусоидой для создания волн
      // waveCount определяет сколько горбов будет на круге.
      double waveOffset = sin(angle * waveCount);
      
      // 2. Добавляем "вращение" волн.
      // Сдвигаем фазу синусоиды в зависимости от прогресса анимации.
      // Умножаем progress на константу (напр. 4*pi), чтобы волны сделали пару оборотов за время перехода.
      double phaseShift = progress * pi * 4;
      waveOffset = sin((angle * waveCount) + phaseShift);

      // 3. Итоговая вариация радиуса в этой точке.
      // waveIntensity * (1.0 - progress) делает так, что в начале волны сильные, 
      // а к концу анимации, когда круг заполняет экран, волны сглаживаются в ровный край.
      final double currentIntensity = waveIntensity * (1.0 - progress);
      final double radiusVariation = waveOffset * currentIntensity;

      final double finalRadius = currentBaseRadius + radiusVariation;

      // Переводим полярные координаты (угол, радиус) в декартовы (x, y)
      final double x = center.dx + finalRadius * cos(angle);
      final double y = center.dy + finalRadius * sin(angle);

      path.lineTo(x, y);
    }

    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant _LiquidRevealClipper oldClipper) {
    return oldClipper.progress != progress;
  }
}