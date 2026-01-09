import 'package:dslideshow_flutter/src/effect/media_slider_item_effect.dart';
import 'package:flutter/material.dart';

class BackgroundToForegroundEffect extends MediaSliderItemEffect {
  final double startScale;
  final double shadowIntensity; 

  BackgroundToForegroundEffect({
    this.startScale = 0.5, 
    this.shadowIntensity = 0.5 // Интенсивность затенения
  });

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
    final double progress = controller.value;

    // --- 1. NEXT WIDGET (Задний план -> Передний план) ---
    // Появляется из глубины (Zoom In).
    final double nextScale = startScale + (1.0 - startScale) * progress;
    
    Widget buildNext() {
      return Stack(
        fit: StackFit.expand,
        children: [
          Transform.scale(
            scale: nextScale,
            alignment: Alignment.center,
            child: nextWidget,
          ),
          // Тень для заднего плана:
          // В начале (progress 0) она максимальна (слайд в глубине).
          // В конце (progress 1) она исчезает (слайд вышел на свет).
          if (shadowIntensity > 0)
            Container(
              color: Colors.black.withOpacity(
                // Используем (1 - progress), чтобы тень исчезала
                (1.0 - progress).clamp(0.0, 1.0) * shadowIntensity
              ),
            ),
        ],
      );
    }

    // --- 2. CURRENT WIDGET (Передний план -> Уходит) ---
    // Уезжает влево.
    Widget buildCurrent() {
      return Transform.translate(
        offset: Offset(-screenW * progress, 0),
        child: Stack(
          fit: StackFit.expand,
          children: [
            currentWidget,
            // Тень для переднего плана:
            // В начале (progress 0) её НЕТ (0.0), картинка чистая.
            // По мере ухода она темнеет, чтобы акцентировать внимание на новом слайде.
            if (shadowIntensity > 0)
              Container(
                color: Colors.black.withOpacity(
                  // ИСПРАВЛЕНИЕ: Используем progress, чтобы тень появлялась плавно
                  progress.clamp(0.0, 1.0) * shadowIntensity
                ),
              ),
          ],
        ),
      );
    }

    // Z-ORDER:
    // Next (Фон) рисуется первым.
    // Current (Крышка) рисуется поверх него.
    return Stack(
      fit: StackFit.expand,
      children: [
        buildNext(),    // Снизу
        buildCurrent(), // Сверху
      ],
    );
  }
}