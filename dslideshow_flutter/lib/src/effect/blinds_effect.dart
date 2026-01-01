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
    final double stripHeight = screenH / stripCount;

    return Stack(
      fit: StackFit.expand,
      children: [
        // 1. Новое изображение (лежит на дне)
        nextWidget, 

        // 2. Жалюзи из старого изображения
        Column(
          children: List.generate(stripCount, (index) {
            // Расчет прогресса для "волны"
            final double delay = index * 0.05;
            double progress = (controller.value - delay) * (1.0 + (stripCount * 0.05));
            progress = progress.clamp(0.0, 1.0);

            // Сдвиг контента:
            // Для 0-й полоски сдвиг 0.
            // Для 1-й полоски сдвиг = -stripHeight (поднимаем картинку вверх)
            // Для 2-й полоски сдвиг = -2 * stripHeight
            final double contentOffset = -1.0 * index * stripHeight;

            return SizedBox(
              width: screenW,
              height: stripHeight,
              child: progress >= 1.0
                  ? null // Полоска исчезла
                  : Transform(
                      // Анимация закрытия полоски (сплющивание по вертикали)
                      transform: Matrix4.identity()..scale(1.0, 1.0 - progress),
                      alignment: Alignment.topCenter,
                      child: ClipRect(
                        child: OverflowBox(
                          // !!! ГЛАВНОЕ ИСПРАВЛЕНИЕ !!!
                          // Разрешаем (и заставляем) ребенку быть размером во весь экран,
                          // несмотря на то, что родитель (SizedBox) маленький.
                          minWidth: screenW,
                          maxWidth: screenW,
                          minHeight: screenH,
                          maxHeight: screenH,
                          alignment: Alignment.topLeft, // Якорь слева сверху
                          child: Transform.translate(
                            // Сдвигаем большую картинку вверх, чтобы в окошко
                            // попал нужный фрагмент
                            offset: Offset(0, contentOffset),
                            child: currentWidget,
                          ),
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