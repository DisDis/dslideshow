import 'package:dslideshow_flutter/src/effect/media_slider_item_effect.dart';
import 'package:flutter/material.dart';

class ZoomOverEffect extends MediaSliderItemEffect {
  final double startScale; // С какого масштаба начинать (например, 1.5)

  ZoomOverEffect({this.startScale = 1.5});

  @override
  Widget transform(
    BuildContext context,
    Widget page,
    bool isCurrentPage,
    double pageDelta,
    double screenW,
    double screenH,
  ) {
    return page;
  }

  @override
  Widget createTransformWidget(
    BuildContext context,
    Widget currentWidget,
    Widget nextWidget,
    Animation<double> controller,
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
        Opacity(
          opacity: Curves.easeIn.transform(controller.value),
          // Bound the opacity surface before the incoming slide is enlarged.
          child: ClipRect(
            child: Transform.scale(
              scale: startScale - (startScale - 1.0) * controller.value,
              child: nextWidget,
            ),
          ),
        ),
      ],
    );
  }
}
