import 'package:flutter/material.dart';

abstract class MediaSliderItemEffect {
  /// Prepare optional GPU resources before the transition clock starts.
  Future<void> prepare() async {}
  Widget transform(
    BuildContext context,
    Widget page,
    bool isCurrentPage,
    double pageDelta,
    double screenW,
    double screenH,
  );
  Widget createTransformWidget(
    BuildContext context,
    Widget currentWidget,
    Widget nextWidget,
    Animation<double> controller,
    double screenW,
    double screenH,
  ) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        transform(
          context,
          currentWidget,
          true,
          controller.value,
          screenW,
          screenH,
        ),
        transform(
          context,
          nextWidget,
          false,
          controller.value,
          screenW,
          screenH,
        ),
      ],
    );
  }
}
