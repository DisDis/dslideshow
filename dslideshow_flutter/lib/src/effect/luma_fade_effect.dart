import 'package:flutter/material.dart';
import 'package:dslideshow_common/effects.dart';

import 'media_slider_item_effect.dart';

/// Bright parts of the outgoing image disappear first. A color matrix derives
/// alpha from luminance on the composited layer, including live GIF/Texture.
class LumaFadeEffect extends MediaSliderItemEffect {
  final double softness;
  final LumaOrder order;
  LumaFadeEffect({this.softness = .18, this.order = LumaOrder.brightFirst});
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
    final sign = order == LumaOrder.brightFirst ? -1.0 : 1.0;
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
            sign * .2126 / softness,
            sign * .7152 / softness,
            sign * .0722 / softness,
            0,
            255 *
                (threshold - (order == LumaOrder.darkFirst ? 1 : 0)) /
                softness,
          ]),
          // Back transparent areas before deriving alpha; otherwise zero-alpha
          // source pixels could acquire opacity from the matrix's bias term.
          child: ColoredBox(color: Colors.black, child: currentWidget),
        ),
      ],
    );
  }
}
