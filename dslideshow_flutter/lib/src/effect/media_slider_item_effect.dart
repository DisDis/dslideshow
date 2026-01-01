import 'package:flutter/material.dart';

abstract class MediaSliderItemEffect {
  Widget transform(BuildContext context, Widget page, bool isCurrentPage , double pageDelta,
      double screenW, double screenH);
  Widget createTransformWidget(
    BuildContext context,
    Widget currentWidget,
    Widget nextWidget,
    AnimationController controller,
    double screenW,
    double screenH,
  ){
    return Stack(children: <Widget>[
            transform(context, currentWidget, true, controller.value, screenW, screenH),
            transform(context, nextWidget, false, controller.value, screenW, screenH)
          ]);
  }
}