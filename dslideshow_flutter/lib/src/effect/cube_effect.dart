import 'dart:math';
import 'package:dslideshow_flutter/src/effect/media_slider_item_effect.dart';
import 'package:flutter/material.dart';

class CubeEffect2 extends MediaSliderItemEffect {
  
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
    final double progress = controller.value;
    final double angle = progress * (pi / 2); // Поворот на 90 градусов

    // НАСТРОЙКА ТЕНЕЙ
    // Максимальная чернота тени (0.0 - нет тени, 1.0 - черная дыра)
    // 0.3 достаточно для объема, 0.6 выглядит как грязь.
    const double maxShadowOpacity = 0.3; 

    return Stack(
      children: [
        // --- СТРАНИЦА A (Текущая) ---
        // Поворачивается как левая грань куба (от нас)
        Stack(
          children: [
            Transform(
              alignment: Alignment.centerRight, // "Петля" справа
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.0015) // Перспектива
                ..rotateY(-angle),       // Вращаем от 0 до -90
              child: ClipRect(child: currentWidget), // ClipRect убирает артефакты на краях
            ),
            
            // Тень Current:
            // Используем easeIn, чтобы тень появлялась медленно в начале 
            // и быстрее в конце. Это убирает эффект "резкого потемнения".
            Positioned.fill(
              child: Opacity(
                opacity: Curves.easeIn.transform(progress) * maxShadowOpacity,
                child: Container(color: Colors.black),
              ),
            ),
          ],
        ),

        // --- СТРАНИЦА B (Следующая) ---
        // Поворачивается как правая грань куба (к нам)
        Stack(
          children: [
            Transform(
              alignment: Alignment.centerLeft, // "Петля" слева
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.0015)
                ..rotateY((pi / 2) - angle), // Вращаем от 90 до 0
              child: ClipRect(child: nextWidget),
            ),

            // Тень Next:
            // Самое важное место! 
            // Используем easeIn на (1 - progress).
            // Это значит, что когда progress = 0 (старт), тень макс, 
            // но благодаря easeIn кривая спадает ОЧЕНЬ быстро.
            // + Мы добавили ClipRect выше, чтобы торец не мелькал.
            Positioned.fill(
              child: Opacity(
                opacity: Curves.easeIn.transform(1.0 - progress) * maxShadowOpacity,
                child: Container(color: Colors.black),
              ),
            ),
          ],
        ),
      ],
    );
  }
}