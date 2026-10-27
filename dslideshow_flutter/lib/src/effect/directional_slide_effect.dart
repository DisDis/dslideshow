import 'package:dslideshow_common/effects.dart';
export 'package:dslideshow_common/effects.dart' show SlideMode;
import 'package:flutter/material.dart';

import 'media_slider_item_effect.dart';

class DirectionalSlideEffect extends MediaSliderItemEffect {
  final AxisDirection direction;
  final SlideMode mode;
  DirectionalSlideEffect({
    this.direction = AxisDirection.left,
    this.mode = SlideMode.push,
  });
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
    final vector = switch (direction) {
      AxisDirection.left => Offset(-screenW, 0),
      AxisDirection.right => Offset(screenW, 0),
      AxisDirection.up => Offset(0, -screenH),
      AxisDirection.down => Offset(0, screenH),
    };
    final current = Transform.translate(
      offset: mode == SlideMode.cover ? Offset.zero : vector * controller.value,
      child: currentWidget,
    );
    final next = Transform.translate(
      offset: mode == SlideMode.reveal
          ? Offset.zero
          : vector * (controller.value - 1),
      child: nextWidget,
    );
    return ClipRect(
      child: Stack(
        fit: StackFit.expand,
        children: mode == SlideMode.reveal ? [next, current] : [current, next],
      ),
    );
  }
}
