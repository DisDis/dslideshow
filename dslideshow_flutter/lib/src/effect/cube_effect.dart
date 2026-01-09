import 'dart:math';
import 'package:dslideshow_flutter/src/effect/media_slider_item_effect.dart';
import 'package:flutter/material.dart';

class CubeEffect extends MediaSliderItemEffect {
  // Поставьте 0.0, чтобы отключить тени и проверить
  // Поставьте 0.3 - 0.5 для реализма
  final double shadowIntensity;

  CubeEffect({this.shadowIntensity = 0.5});

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
    final double angle = progress * (pi / 2);

    // Вспомогательный метод для построения грани
    Widget buildFace({
      required Widget child,
      required double translateOffset,
      required AlignmentGeometry alignment,
      required double rotateAngle,
      required double opacity, // Значение затемнения (0.0 - 1.0)
    }) {
      return Transform.translate(
        offset: Offset(translateOffset, 0),
        child: Transform(
          alignment: alignment,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.0015)
            ..rotateY(rotateAngle),
          child: Stack(
            fit: StackFit.expand,
            children: [
              ClipRect(child: child),
              
              // РИСУЕМ ТЕНЬ ТОЛЬКО ЕСЛИ ОНА НУЖНА
              if (shadowIntensity > 0 && opacity > 0)
                Container(
                  // Используем умножение для плавной настройки силы тени
                  color: Colors.black.withAlpha((255.0 * (opacity * shadowIntensity)).round()),
                ),
            ],
          ),
        ),
      );
    }

    // 1. Current (Уходит, становится темнее)
    final currentFace = buildFace(
      child: currentWidget,
      translateOffset: -screenW * progress,
      alignment: Alignment.centerRight,
      rotateAngle: angle, 
      opacity: progress, // Тень нарастает
    );

    // 2. Next (Приходит, становится светлее)
    final nextFace = buildFace(
      child: nextWidget,
      translateOffset: screenW * (1 - progress),
      alignment: Alignment.centerLeft,
      rotateAngle: angle - (pi / 2),
      opacity: 1.0 - progress, // Тень убывает
    );

    // Z-Order
    if (progress < 0.5) {
      return Stack(
        fit: StackFit.expand,
        children: [nextFace, currentFace],
      );
    } else {
      return Stack(
        fit: StackFit.expand,
        children: [currentFace, nextFace],
      );
    }
  }
}