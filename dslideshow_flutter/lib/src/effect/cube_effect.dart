import 'dart:math';

import 'package:dslideshow_flutter/src/effect/media_slider_item_effect.dart';
import 'package:flutter/material.dart';

class CubeEffect extends MediaSliderItemEffect {
  // Поставьте 0.0, чтобы отключить тени и проверить
  // Поставьте 0.3 - 0.5 для реализма
  final double shadowIntensity;
  final double perspectiveStrength;

  CubeEffect({this.shadowIntensity = 0.5, this.perspectiveStrength = 1});

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
    EffectSlideInput current,
    EffectSlideInput next,
    Animation<double> controller,
    double screenW,
    double screenH,
  ) {
    final double progress = controller.value;
    final double angle = progress * (pi / 2);

    // Вспомогательный метод для построения грани
    Widget buildFace({
      required Key key,
      required Widget child,
      required double translateOffset,
      required AlignmentGeometry alignment,
      required double rotateAngle,
      required double opacity, // Значение затемнения (0.0 - 1.0)
    }) {
      return Transform.translate(
        key: key,
        offset: Offset(translateOffset, 0),
        child: Transform(
          alignment: alignment,
          // Keep the same relative camera distance as the viewport grows.
          transform: Matrix4.identity()
            ..setEntry(3, 2, perspectiveStrength * 0.0015 * 320 / screenW)
            ..rotateY(rotateAngle),
          child: Stack(
            fit: StackFit.expand,
            children: [
              ClipRect(child: child),

              // РИСУЕМ ТЕНЬ ТОЛЬКО ЕСЛИ ОНА НУЖНА
              if (shadowIntensity > 0 && opacity > 0)
                Container(
                  // Используем умножение для плавной настройки силы тени
                  color: Colors.black.withAlpha(
                    (255.0 * (opacity * shadowIntensity)).round(),
                  ),
                ),
            ],
          ),
        ),
      );
    }

    // 1. Current (Уходит, становится темнее)
    final currentFace = buildFace(
      key: const ValueKey('cube-current'),
      child: current.view,
      translateOffset: -screenW * progress,
      alignment: Alignment.centerRight,
      rotateAngle: angle,
      opacity: progress, // Тень нарастает
    );

    // 2. Next (Приходит, становится светлее)
    final nextFace = buildFace(
      key: const ValueKey('cube-next'),
      child: next.view,
      translateOffset: screenW * (1 - progress),
      alignment: Alignment.centerLeft,
      rotateAngle: angle - (pi / 2),
      opacity: 1.0 - progress, // Тень убывает
    );

    // Z-Order
    if (progress < 0.5) {
      return Stack(fit: StackFit.expand, children: [nextFace, currentFace]);
    } else {
      return Stack(fit: StackFit.expand, children: [currentFace, nextFace]);
    }
  }
}
