import 'package:dslideshow_flutter/src/effect/media_slider_item_effect.dart';
import 'package:dslideshow_flutter/src/effect/translate_effect.dart';
import 'package:flutter/material.dart';

class DepthEffect extends MediaSliderItemEffect with TranslateEffect {
  final double startScale;
  final double shadowIntensity; // Настройка силы затемнения

  DepthEffect({
    this.startScale = 0.5,
    this.shadowIntensity = 0.5, // 50% затемнения в глубине
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
    if (isCurrentPage) {
      // --- ТЕКУЩАЯ СТРАНИЦА (Уходит в глубину) ---
      
      // 1. Рассчитываем масштаб (от 1.0 до startScale)
      final double scale = startScale + (1 - startScale) * (1 - pageDelta);
      
      return Transform(
        transformHitTests: false,
        alignment: Alignment.center, // Сжимается к центру
        transform: translateCurrent(
          Matrix4.identity()
            // ВАЖНО: translateCurrent сдвигает слайд влево на (screenW * pageDelta).
            // Чтобы слайд оставался ПО ЦЕНТРУ и просто уменьшался, 
            // нам нужно компенсировать этот сдвиг, сдвинув его обратно вправо.
            // Используем screenW вместо MediaQuery!
            ..translate(screenW * pageDelta, 0.0, 0.0)
            ..scale(scale, scale, 1.0),
          pageDelta,
          screenW,
          screenH,
        ),
        // Оборачиваем в Stack для добавления тени "глубины"
        child: Stack(
          fit: StackFit.expand,
          children: [
            page,
            // Тень:
            // В начале (0.0) тени нет.
            // В конце (1.0), когда слайд глубоко, тень максимальна.
            if (shadowIntensity > 0)
              Container(
                color: Colors.black.withOpacity(
                  (pageDelta * shadowIntensity).clamp(0.0, 1.0),
                ),
              ),
          ],
        ),
      );
    } else {
      // --- СЛЕДУЮЩАЯ СТРАНИЦА (Выезжает справа) ---
      
      // Просто стандартный выезд (Slide In). 
      // Она перекрывает старую (уменьшенную) страницу.
      return Transform(
        transformHitTests: false,
        // Здесь используем просто translateNext, без лишних проверок
        transform: translateNext(
          Matrix4.identity(),
          pageDelta,
          screenW,
          screenH,
        ),
        child: page,
      );
    }
  }
}