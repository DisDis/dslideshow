import 'dart:ui';
import 'package:dslideshow_flutter/src/effect/media_slider_item_effect.dart';
import 'package:flutter/material.dart';

class BlurFadeEffect extends MediaSliderItemEffect {
  final double maxSigma; // Сила размытия

  BlurFadeEffect({this.maxSigma = 10.0});

  @override
  Widget transform(BuildContext context, Widget page, bool isCurrentPage,
      double pageDelta, double screenW, double screenH) {
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
        // 1. Новое изображение (внизу)
        nextWidget,

        // 2. Старое изображение (сверху) с эффектами
        AnimatedBuilder(
          animation: controller,
          builder: (context, child) {
            // Размытие усиливается от 0 до maxSigma
            final double sigma = controller.value * maxSigma;
            // Прозрачность падает от 1.0 до 0.0
            final double opacity = 1.0 - controller.value;

            return Opacity(
              opacity: opacity,
              child: ImageFiltered(
                imageFilter: ImageFilter.blur(sigmaX: sigma, sigmaY: sigma),
                child: currentWidget,
              ),
            );
          },
        ),
      ],
    );
  }
}