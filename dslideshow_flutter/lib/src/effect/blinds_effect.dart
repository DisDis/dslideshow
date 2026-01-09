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
    // Высота одной полоски (для макета)
    final double stripHeight = screenH / stripCount;

    // --- НАСТРОЙКИ АНИМАЦИИ ---
    // Какую часть общего времени тратит одна полоска на свое закрытие?
    // 0.4 означает, что полоска закрывается за 40% от общего времени перехода.
    // Оставшиеся 60% времени распределяются на задержки (волну).
    // Если хотите более быструю волну (меньше наложений), уменьшите это число (например до 0.3).
    const double oneStripDuration = 0.5; 
    
    // Общее время, доступное для разброса задержек (stagger)
    const double totalStaggerTime = 1.0 - oneStripDuration;

    // Вычисляем шаг задержки между соседними полосками
    // Защита от деления на 0, если вдруг stripCount = 1
    final double delayStep = stripCount > 1 
        ? totalStaggerTime / (stripCount - 1) 
        : 0.0;

    return Stack(
      fit: StackFit.expand,
      children: [
        // 1. Новое изображение (лежит на дне)
        nextWidget, 

        // 2. Жалюзи из старого изображения
        Column(
          children: List.generate(stripCount, (index) {
            
            // --- НОВАЯ МАТЕМАТИКА ---
            
            // Рассчитываем точную задержку для этого индекса
            final double start = index * delayStep;
            
            // Считаем прогресс:
            // (Текущее время - время старта) / длительность одной полоски
            double progress = (controller.value - start) / oneStripDuration;
            
            // Загоняем в рамки от 0.0 до 1.0
            progress = progress.clamp(0.0, 1.0);

            // Сдвиг контента (как в предыдущем рабочем решении)
            final double contentOffset = -1.0 * index * stripHeight;

            return SizedBox(
              width: screenW,
              height: stripHeight, // Жесткая высота
              child: progress >= 1.0
                  ? null // Оптимизация: не рисуем, если закрылось
                  : Transform(
                      // Сплющивание по вертикали
                      transform: Matrix4.identity()..scaleByDouble(1.0, 1.0 - progress,1.0, 1.0),
                      alignment: Alignment.topCenter,
                      child: ClipRect(
                        child: OverflowBox(
                          // Разрешаем быть большим
                          minWidth: screenW,
                          maxWidth: screenW,
                          minHeight: screenH,
                          maxHeight: screenH,
                          alignment: Alignment.topLeft,
                          child: Transform.translate(
                            // Корректируем позицию большой картинки
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