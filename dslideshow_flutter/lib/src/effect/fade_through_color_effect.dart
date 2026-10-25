import 'package:flutter/material.dart';

import 'media_slider_item_effect.dart';

class FadeThroughColorEffect extends MediaSliderItemEffect {
  final Color color;
  FadeThroughColorEffect({this.color = Colors.black});
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
  ) => Stack(
    fit: StackFit.expand,
    children: [
      ColoredBox(color: color),
      Opacity(
        opacity: (1 - 2 * controller.value).clamp(0, 1),
        child: currentWidget,
      ),
      Opacity(
        opacity: (2 * controller.value - 1).clamp(0, 1),
        child: nextWidget,
      ),
    ],
  );
}
