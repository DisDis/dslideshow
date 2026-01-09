import 'dart:math';
import 'package:dslideshow_flutter/src/effect/media_slider_item_effect.dart';
import 'package:flutter/material.dart';

class CubeEffect extends MediaSliderItemEffect {
  final double shadowIntensity; 
  
  CubeEffect({this.shadowIntensity = 0.6}); // Чуть темнее для реализма

  @override
  Widget transform(
    BuildContext context, 
    Widget page, 
    bool isCurrentPage,
    double pageDelta, 
    double screenW, 
    double screenH
  ) {
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
    final double angle = progress * (pi / 2); // 90 градусов

    // --- 1. Current Widget (Уходит влево) ---
    // Логика:
    // 1. Вращаем вокруг ПРАВОГО края (петля).
    // 2. Сдвигаем влево на ширину прокрутки.
    // Результат: Правый край (петля) движется от правого края экрана к центру и далее влево.
    Widget buildCurrent() {
      return Transform.translate(
        offset: Offset(-screenW * progress, 0), // Линейный сдвиг влево
        child: Transform(
          alignment: Alignment.centerRight, // Петля справа
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.0015) 
            ..rotateY(-angle), // Вращаем внутрь
          child: ClipRect(child: currentWidget),
        ),
      );
    }
    
    // Тень для Current (накладываем отдельно, чтобы не вращалась вместе с контентом некорректно)
    Widget buildCurrentShadow() {
       return Positioned.fill(
         child: Opacity(
            opacity: Curves.easeIn.transform(progress) * shadowIntensity,
            child: const ColoredBox(color: Colors.black),
         ),
       );
    }

    // --- 2. Next Widget (Приходит справа) ---
    // Логика:
    // 1. Вращаем вокруг ЛЕВОГО края (петля).
    // 2. Сдвигаем так, чтобы левый край касался правого края Current.
    // Результат: Левый край (петля) приклеен к петле Current.
    Widget buildNext() {
      return Transform.translate(
        offset: Offset(screenW * (1 - progress), 0), // Линейный сдвиг справа налево
        child: Transform(
          alignment: Alignment.centerLeft, // Петля слева
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.0015)
            ..rotateY((pi / 2) - angle), // Вращаем из глубины
          child: ClipRect(child: nextWidget),
        ),
      );
    }

    Widget buildNextShadow() {
       return Positioned.fill(
         child: Opacity(
            opacity: Curves.easeIn.transform(1.0 - progress) * shadowIntensity,
            child: const ColoredBox(color: Colors.black),
         ),
       );
    }

    // --- СБОРКА СЦЕНЫ ---
    // Мы комбинируем трансформации и тени.
    // Z-Order: Если progress < 0.5, мы видим переднюю грань (Current).
    // Если > 0.5, мы видим боковую грань (Next).
    
    if (progress < 0.5) {
      return Stack(
        fit: StackFit.expand,
        children: [
          // Снизу (Next)
          Stack(
            fit: StackFit.expand,
            children: [buildNext(), buildNextShadow()],
          ),
          // Сверху (Current)
          Stack(
            fit: StackFit.expand,
            children: [buildCurrent(), buildCurrentShadow()],
          ),
        ],
      );
    } else {
      return Stack(
        fit: StackFit.expand,
        children: [
          // Снизу (Current)
          Stack(
            fit: StackFit.expand,
            children: [buildCurrent(), buildCurrentShadow()],
          ),
          // Сверху (Next)
          Stack(
            fit: StackFit.expand,
            children: [buildNext(), buildNextShadow()],
          ),
        ],
      );
    }
  }
}