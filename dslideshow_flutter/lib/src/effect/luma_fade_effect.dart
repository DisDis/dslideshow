import 'package:flutter/material.dart';

import 'media_slider_item_effect.dart';

/// Bright parts of the outgoing image disappear first. A color matrix derives
/// alpha from luminance on the composited layer, including live GIF/Texture.
class LumaFadeEffect extends MediaSliderItemEffect {
  @override
  Widget transform(
    BuildContext context,
    Widget page,
    bool isCurrentPage,
    double pageDelta,
    double screenW,
    double screenH,
  ) => page;

  @override
  Widget createTransformWidget(
    BuildContext context,
    Widget currentWidget,
    Widget nextWidget,
    Animation<double> controller,
    double screenW,
    double screenH,
  ) {
    const softness = .18;
    final threshold = 1 + softness - controller.value * (1 + 2 * softness);
    return Stack(
      fit: StackFit.expand,
      children: [
        ColoredBox(color: Colors.black, child: nextWidget),
        ColorFiltered(
          colorFilter: ColorFilter.matrix([
            1,
            0,
            0,
            0,
            0,
            0,
            1,
            0,
            0,
            0,
            0,
            0,
            1,
            0,
            0,
            -.2126 / softness,
            -.7152 / softness,
            -.0722 / softness,
            0,
            255 * threshold / softness,
          ]),
          // Back transparent areas before deriving alpha; otherwise zero-alpha
          // source pixels could acquire opacity from the matrix's bias term.
          child: ColoredBox(color: Colors.black, child: currentWidget),
        ),
      ],
    );
  }
}
