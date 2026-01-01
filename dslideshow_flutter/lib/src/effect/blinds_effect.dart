import 'package:dslideshow_flutter/src/effect/media_slider_item_effect.dart';
import 'package:flutter/material.dart';

class BlindsEffect extends MediaSliderItemEffect {
  final int stripCount;

  BlindsEffect({this.stripCount = 10});

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
    AnimationController controller,
    double screenW,
    double screenH,
  ) {
    return Stack(
      fit: StackFit.expand,
      children: [
        nextWidget, // Внизу новое
        // Сверху старое, разбитое на полосы
        Column(
          children: List.generate(stripCount, (index) {
            // Вычисляем прогресс для волны
            final double delay = index * 0.05;
            double progress =
                (controller.value - delay) * (1.0 + (stripCount * 0.05));
            progress = progress.clamp(0.0, 1.0);

            // Эффект закрытия жалюзи (поворот) или растворения
            // Сделаем эффект "Схлопывания" высоты полоски
            return Flexible(
              flex: 1, // Все полоски равны
              child: progress >= 1.0
                  ? const SizedBox()
                  : FractionallySizedBox(
                      widthFactor: 1.0,
                      // Высота полоски уменьшается до 0
                      heightFactor: 1.0 - progress,
                      alignment: Alignment.topCenter,
                      child: ClipRect(
                        child: Align(
                          alignment: Alignment(
                            0.0,
                            -1.0 + (index / (stripCount - 1)) * 2.0,
                          ),
                          heightFactor:
                              1.0 /
                              stripCount, // Показываем 1/10 часть картинки
                          child: currentWidget,
                        ),
                      ),
                    ),
            );
          }),
        ),
      ],
    );
  }
}
