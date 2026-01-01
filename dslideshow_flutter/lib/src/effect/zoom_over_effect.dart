import 'package:dslideshow_flutter/src/effect/media_slider_item_effect.dart';
import 'package:flutter/material.dart';

class ZoomOverEffect extends MediaSliderItemEffect {
  final double startScale; // С какого масштаба начинать (например, 1.5)
  
  ZoomOverEffect({this.startScale = 1.5});

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
    return Stack(
      fit: StackFit.expand,
      children: [
        // 1. Старое изображение (остается внизу, можно чуть уменьшить для глубины)
        Transform.scale(
          scale: 1.0 - (0.1 * controller.value), // Едва заметное отдаление
          child: currentWidget,
        ),

        // 2. Новое изображение (появляется сверху)
        AnimatedBuilder(
          animation: controller,
          builder: (context, child) {
            // Интерполяция масштаба: от 1.5 до 1.0
            final double scale =
                startScale - ((startScale - 1.0) * controller.value);
            
            // Интерполяция прозрачности: от 0.0 до 1.0
            // Используем Curves.easeIn для мягкости
            final double opacity = Curves.easeIn.transform(controller.value);

            return Opacity(
              opacity: opacity,
              child: Transform.scale(
                scale: scale,
                child: nextWidget,
              ),
            );
          },
        ),
      ],
    );
  }
}