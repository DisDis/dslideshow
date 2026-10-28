import 'package:dslideshow_common/effects.dart';
import 'package:flutter/material.dart';

import 'media_slider_item_effect.dart';

Curve effectCurve(BlendCurve curve) => switch (curve) {
  BlendCurve.linear => Curves.linear,
  BlendCurve.easeIn => Curves.easeIn,
  BlendCurve.easeOut => Curves.easeOutCubic,
  BlendCurve.easeInOut => Curves.easeInOutCubic,
};
Alignment effectOrigin(EffectOrigin origin) => switch (origin) {
  EffectOrigin.center => Alignment.center,
  EffectOrigin.topLeft => Alignment.topLeft,
  EffectOrigin.topRight => Alignment.topRight,
  EffectOrigin.bottomLeft => Alignment.bottomLeft,
  EffectOrigin.bottomRight => Alignment.bottomRight,
};

/// Changes the coordinate system and compensates each media view, so text and
/// textures retain their orientation. The original leftward path is unchanged.
class DirectedEffect extends MediaSliderItemEffect {
  final MediaSliderItemEffect inner;
  final EffectDirection direction;
  DirectedEffect(this.inner, this.direction);
  @override
  Future<void> prepare() => inner.prepare();
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
    if (direction == EffectDirection.left) {
      return inner.createTransformWidget(
        context,
        currentWidget,
        nextWidget,
        controller,
        screenW,
        screenH,
      );
    }
    if (direction == EffectDirection.right) {
      return Transform.flip(
        flipX: true,
        child: inner.createTransformWidget(
          context,
          Transform.flip(flipX: true, child: currentWidget),
          Transform.flip(flipX: true, child: nextWidget),
          controller,
          screenW,
          screenH,
        ),
      );
    }
    final turns = direction == EffectDirection.up ? 1 : 3;
    return RotatedBox(
      quarterTurns: turns,
      child: inner.createTransformWidget(
        context,
        RotatedBox(quarterTurns: 4 - turns, child: currentWidget),
        RotatedBox(quarterTurns: 4 - turns, child: nextWidget),
        controller,
        screenH,
        screenW,
      ),
    );
  }
}

class ReversedMaskEffect extends MediaSliderItemEffect {
  final MediaSliderItemEffect inner;
  ReversedMaskEffect(this.inner);
  @override
  Future<void> prepare() => inner.prepare();
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
  ) => inner.createTransformWidget(
    context,
    nextWidget,
    currentWidget,
    AlwaysStoppedAnimation(1 - controller.value),
    screenW,
    screenH,
  );
}

class ReflectedEffect extends MediaSliderItemEffect {
  final MediaSliderItemEffect inner;
  final bool flipX, flipY;
  ReflectedEffect(this.inner, {required this.flipX, required this.flipY});
  @override
  Future<void> prepare() => inner.prepare();
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
  ) => Transform.flip(
    flipX: flipX,
    flipY: flipY,
    child: inner.createTransformWidget(
      context,
      Transform.flip(flipX: flipX, flipY: flipY, child: currentWidget),
      Transform.flip(flipX: flipX, flipY: flipY, child: nextWidget),
      controller,
      screenW,
      screenH,
    ),
  );
}
