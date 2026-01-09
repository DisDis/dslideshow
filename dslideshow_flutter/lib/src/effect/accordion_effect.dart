import 'package:dslideshow_flutter/src/effect/media_slider_item_effect.dart';
import 'package:flutter/material.dart';

class AccordionEffect extends MediaSliderItemEffect {
  
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

    // --- ЛОГИКА ---
    // Мы не обрезаем картинки (ClipRect), мы их сплющиваем (Scale X).
    // Чтобы картинка не стала просто узкой полоской посередине,
    // мы используем Alignment.
    
    // 1. Current (Левая часть): Сжимается от 100% до 0%.
    // Привязка: CenterLeft (чтобы уезжала влево).
    Widget buildCurrent() {
      return Align(
        alignment: Alignment.centerLeft,
        child: Transform(
          alignment: Alignment.centerLeft, // Сжимаем к левому краю
          // Масштабируем только по оси X (width)
          transform: Matrix4.identity()..scaleByDouble(1.0 - progress, 1.0,1.0 - progress,1.0), 
          child: SizedBox(
            // Важно! Заставляем виджет думать, что он все еще на весь экран,
            // чтобы контент внутри сжимался (эффект гармошки), а не перестраивался.
            width: screenW, 
            height: screenH,
            child: currentWidget,
          ),
        ),
      );
    }

    // 2. Next (Правая часть): Растет от 0% до 100%.
    // Привязка: CenterRight (чтобы росла от правого края навстречу левому).
    Widget buildNext() {
      return Align(
        alignment: Alignment.centerRight,
        child: Transform(
          alignment: Alignment.centerRight, // Растягиваем от правого края
          transform: Matrix4.identity()..scaleByDouble(progress, 1.0, progress, 1.0),
          child: SizedBox(
            width: screenW,
            height: screenH,
            child: nextWidget,
          ),
        ),
      );
    }

    // --- ТЕНИ ДЛЯ ОБЪЕМА ---
    // При сжатии гармошки складки обычно темнеют.
    
    // Тень для сжимающегося (Current)
    Widget buildCurrentShadow() {
      return Align(
        alignment: Alignment.centerLeft,
        child: Transform(
          alignment: Alignment.centerLeft,
          transform: Matrix4.identity()..scaleByDouble(1.0 - progress, 1.0, 1.0 - progress, 1.0),
          child: SizedBox(
            width: screenW,
            height: screenH,
            // Тень становится темнее по мере сжатия
            child: Container(color: Colors.black.withAlpha((255.0 * (progress * 0.5)).round())),
          ),
        ),
      );
    }

    // Тень для растущего (Next)
    Widget buildNextShadow() {
      return Align(
        alignment: Alignment.centerRight,
        child: Transform(
          alignment: Alignment.centerRight,
          transform: Matrix4.identity()..scaleByDouble(progress, 1.0,progress,1.0),
          child: SizedBox(
            width: screenW,
            height: screenH,
            // Тень светлеет по мере расширения
            child: Container(color: Colors.black.withAlpha((255.0 * ((1.0 - progress) * 0.5)).round())),
          ),
        ),
      );
    }

    // Z-Order здесь не важен, так как они не пересекаются (занимают разные области экрана).
    // Но для порядка:
    return Stack(
      fit: StackFit.expand,
      children: [
        buildCurrent(),
        buildCurrentShadow(),
        buildNext(),
        buildNextShadow(),
      ],
    );
  }
}