import 'dart:math';
import 'package:dslideshow_flutter/src/effect/media_slider_item_effect.dart';
import 'package:flutter/material.dart';


class MosaicTransitionEffect extends MediaSliderItemEffect {
  final int gridSize;
  late final List<double> _thresholds;

  MosaicTransitionEffect({this.gridSize = 100}) {
    // Генерируем случайные пороги исчезновения один раз при создании эффекта.
    // Если вы хотите, чтобы рисунок менялся каждый раз, создавайте новый экземпляр
    // MosaicTransitionEffect при каждом переключении слайда.
    _thresholds = List.generate(
      gridSize * gridSize, 
      (_) => Random().nextDouble(),
    );
  }

  // Метод transform нам не нужен, так как мы полностью переопределяем
  // логику компоновки в createTransformWidget, но так как он abstract, 
  // мы обязаны его реализовать. Просто возвращаем виджет как есть.
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
    // Логика:
    // 1. Внизу лежит NextWidget (он статичен и просто ждет, пока его откроют).
    // 2. Сверху лежит CurrentWidget.
    // 3. Мы применяем ClipPath к CurrentWidget.
    // 4. По мере роста controller.value (от 0 до 1), клиппер "вырезает" 
    //    квадратики из CurrentWidget, открывая вид на NextWidget.

    return Stack(
      fit: StackFit.expand,
      children: [
        // Нижний слой (новый слайд)
        nextWidget,

        // Верхний слой (старый слайд, который рассыпается)
        ClipPath(
          clipper: _MosaicClipper(
            progress: controller.value,
            thresholds: _thresholds,
            gridSize: gridSize,
          ),
          child: currentWidget,
        ),
      ],
    );
  }
}

// === Клиппер (логика нарезки) ===

class _MosaicClipper extends CustomClipper<Path> {
  final double progress;
  final List<double> thresholds;
  final int gridSize;

  _MosaicClipper({
    required this.progress,
    required this.thresholds,
    required this.gridSize,
  });

  @override
  Path getClip(Size size) {
    final path = Path();
    
    // Вычисляем размер одной клетки
    // Используем ceilToDouble, чтобы избежать микро-щелей из-за дробных пикселей
    final width = size.width / gridSize;
    final height = size.height / gridSize;

    for (int i = 0; i < thresholds.length; i++) {
      // Ключевое условие:
      // Если текущий прогресс анимации МЕНЬШЕ порога этой клетки -> рисуем её.
      // Как только прогресс превышает порог -> клетка исчезает.
      if (progress < thresholds[i]) {
        final int col = i % gridSize;
        final int row = i ~/ gridSize;

        // Добавляем небольшой нахлест (+0.5), чтобы убрать линии стыков (anti-aliasing artifacts)
        final rect = Rect.fromLTWH(
          col * width,
          row * height,
          width + 0.5, 
          height + 0.5,
        );
        path.addRect(rect);
      }
    }
    return path;
  }

  @override
  bool shouldReclip(covariant _MosaicClipper oldClipper) {
    // Перерисовываем клиппер только если изменился прогресс анимации
    return oldClipper.progress != progress;
  }
}