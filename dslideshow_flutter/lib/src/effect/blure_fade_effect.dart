import 'dart:ui';

import 'package:dslideshow_flutter/src/effect/media_slider_item_effect.dart';
import 'package:flutter/material.dart';

class BlurFadeEffect extends MediaSliderItemEffect {
  final double maxSigma; // Сила размытия

  BlurFadeEffect({this.maxSigma = 10.0});

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
    Animation<double> controller,
    double screenW,
    double screenH,
  ) {
    // With no blur, preserve Opacity's rounding and group semantics.
    if (maxSigma <= 0) {
      return Stack(
        fit: StackFit.expand,
        children: [
          nextWidget,
          Opacity(opacity: 1.0 - controller.value, child: currentWidget),
        ],
      );
    }
    return Stack(
      fit: StackFit.expand,
      children: [
        // 1. Новое изображение (внизу)
        nextWidget,

        // 2. Старое изображение (сверху) с эффектами
        ImageFiltered(
          imageFilter: ImageFilter.compose(
            outer: ColorFilter.mode(
              Colors.white.withValues(alpha: 1.0 - controller.value),
              BlendMode.modulate,
            ),
            inner: ImageFilter.blur(
              sigmaX: controller.value * maxSigma,
              sigmaY: controller.value * maxSigma,
              // A standalone ImageFiltered uses decal. compose otherwise
              // resolves a dynamic blur tile mode to clamp, changing edges.
              tileMode: TileMode.decal,
            ),
          ),
          enabled: controller.value > 0,
          child: currentWidget,
        ),
      ],
    );
  }
}
