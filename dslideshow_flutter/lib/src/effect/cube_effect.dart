import 'dart:math';
import 'package:dslideshow_flutter/src/effect/media_slider_item_effect.dart';
import 'package:flutter/material.dart';

// --- Кубический 3D эффект ---
class CubeEffect2 extends MediaSliderItemEffect {
  
  @override
  Widget transform(BuildContext context, Widget page, bool isCurrentPage,
      double pageDelta, double screenW, double screenH) {
    return page; // Не используем базовый трансформ
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
    final double value = controller.value;
    
    // Угол поворота: полный переход это 90 градусов (pi/2)
    final double angle = value * (pi / 2);

    return Stack(
      children: [
        // СТРАНИЦА A (Current): Уходит влево, вращаясь
        // Поворачивается от 0 до -90 градусов
        Transform(
          alignment: Alignment.centerRight, // Вращаем вокруг правого края
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.0015) // Перспектива (чем меньше число, тем слабее 3D)
            ..rotateY(-angle), // Минус, чтобы вращалось "вглубь" влево
          child: currentWidget,
        ),

        // СТРАНИЦА B (Next): Приходит справа
        // Поворачивается от 90 до 0 градусов
        Transform(
          alignment: Alignment.centerLeft, // Вращаем вокруг левого края
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.0015) // Та же перспектива
            ..rotateY((pi / 2) - angle), // Начинаем с 90 градусов
          child: nextWidget,
        ),
      ],
    );
  }
}