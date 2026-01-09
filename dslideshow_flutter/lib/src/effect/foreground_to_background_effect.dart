import 'package:dslideshow_flutter/src/effect/media_slider_item_effect.dart';
import 'package:dslideshow_flutter/src/effect/translate_effect.dart';
import 'package:flutter/material.dart';

class ForegroundToBackgroundEffect extends MediaSliderItemEffect with TranslateEffect {
  final double endScale;
  final double shadowIntensity; // Настройка силы тени

  ForegroundToBackgroundEffect({
    this.endScale = 0.4,
    this.shadowIntensity = 0.5, // По умолчанию 50% затемнения в конце
  });

  @override
  Widget transform(
    BuildContext context,
    Widget page,
    bool isCurrentPage, /*int index, int currentPage*/
    double pageDelta, /*, int itemCount*/
    double screenW,
    double screenH,
  ) {
    if (isCurrentPage) {
      // --- ТЕКУЩАЯ СТРАНИЦА (Уходит на задний план) ---
      final double scale = endScale + (1 - endScale) * (1 - pageDelta);
      
      return Transform(
        transformHitTests: false,
        alignment: Alignment.center,
        transform: translateCurrent(
          Matrix4.identity()..scaleByDouble(scale, scale, scale, 1.0),
          pageDelta,
          screenW,
          screenH,
        ),
        // Оборачиваем страницу в Stack, чтобы добавить тень
        child: Stack(
          fit: StackFit.expand,
          children: [
            page,
            // ТЕНЬ:
            // Появляется по мере того, как страница уходит (pageDelta растет от 0 до 1)
            if (shadowIntensity > 0)
              Container(
                color: Colors.black.withAlpha((255.0 * 
                  (pageDelta * shadowIntensity).clamp(0.0, 1.0)
                ).round()),
              ),
          ],
        ),
      );
    } else {
      // --- СЛЕДУЮЩАЯ СТРАНИЦА (Выходит на передний план) ---
      return Transform(
        transformHitTests: false,
        transform: isCurrentPage
            ? translateCurrent(Matrix4.identity(), pageDelta, screenW, screenH)
            : translateNext(Matrix4.identity(), pageDelta, screenW, screenH),
        child: page,
        // Для верхнего слайда тень обычно не нужна, он "на свету".
        // Но если захочешь добавить легкую тень при появлении, 
        // оберни в Stack здесь по аналогии.
      );
    }
  }
}