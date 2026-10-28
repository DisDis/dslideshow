import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:dslideshow_flutter/src/effect/media_slider_item_effect.dart';
import 'package:flutter/material.dart';

import 'effect_geometry.dart';

import 'package:dslideshow_common/effects.dart';

class ZoomOverEffect extends MediaSliderItemEffect {
  final double outgoingScale, blurFraction;
  final EffectOrigin origin;
  final double startScale; // С какого масштаба начинать (например, 1.5)

  ZoomOverEffect({
    this.startScale = 1.5,
    this.outgoingScale = .9,
    this.blurFraction = 0,
    this.origin = EffectOrigin.center,
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
    Animation<double> controller,
    double screenW,
    double screenH,
  ) {
    final scene = Stack(
      fit: StackFit.expand,
      children: [
        // 1. Старое изображение (остается внизу, можно чуть уменьшить для глубины)
        Transform.scale(
          scale:
              1.0 -
              ((1 - outgoingScale) *
                  controller.value), // Едва заметное отдаление
          alignment: effectOrigin(origin),
          child: currentWidget,
        ),

        // 2. Новое изображение (появляется сверху)
        Opacity(
          opacity: Curves.easeIn.transform(controller.value),
          // Bound the opacity surface before the incoming slide is enlarged.
          child: ClipRect(
            child: Transform.scale(
              scale: startScale - (startScale - 1.0) * controller.value,
              alignment: effectOrigin(origin),
              child: nextWidget,
            ),
          ),
        ),
      ],
    );
    if (blurFraction == 0) return scene;
    final sigma =
        math.min(screenW, screenH) *
        blurFraction *
        math.sin(math.pi * controller.value);
    return ImageFiltered(
      enabled: sigma > 0,
      imageFilter: ui.ImageFilter.blur(
        sigmaX: sigma,
        sigmaY: sigma,
        tileMode: TileMode.clamp,
      ),
      child: ClipRect(child: scene),
    );
  }
}
