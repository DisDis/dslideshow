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
  bool supportsInputs(EffectSlideInput current, EffectSlideInput next) =>
      direction == EffectDirection.left
      ? inner.supportsInputs(current, next)
      : inner.supportsInputs(
          current.liveView(current.view),
          next.liveView(next.view),
        );
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
    EffectSlideInput current,
    EffectSlideInput next,
    Animation<double> controller,
    double screenW,
    double screenH,
  ) {
    if (direction == EffectDirection.left) {
      return inner.createTransformWidget(
        context,
        current,
        next,
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
          current.liveView(Transform.flip(flipX: true, child: current.view)),
          next.liveView(Transform.flip(flipX: true, child: next.view)),
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
        current.liveView(
          RotatedBox(quarterTurns: 4 - turns, child: current.view),
        ),
        next.liveView(RotatedBox(quarterTurns: 4 - turns, child: next.view)),
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
  bool supportsInputs(EffectSlideInput current, EffectSlideInput next) =>
      inner.supportsInputs(next, current);
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
    EffectSlideInput current,
    EffectSlideInput next,
    Animation<double> controller,
    double screenW,
    double screenH,
  ) => inner.createTransformWidget(
    context,
    next,
    current,
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
  bool supportsInputs(EffectSlideInput current, EffectSlideInput next) =>
      !flipX && !flipY
      ? inner.supportsInputs(current, next)
      : inner.supportsInputs(
          current.liveView(current.view),
          next.liveView(next.view),
        );
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
    EffectSlideInput current,
    EffectSlideInput next,
    Animation<double> controller,
    double screenW,
    double screenH,
  ) {
    if (!flipX && !flipY) {
      return inner.createTransformWidget(
        context,
        current,
        next,
        controller,
        screenW,
        screenH,
      );
    }
    return Transform.flip(
      flipX: flipX,
      flipY: flipY,
      child: inner.createTransformWidget(
        context,
        current.liveView(
          Transform.flip(flipX: flipX, flipY: flipY, child: current.view),
        ),
        next.liveView(
          Transform.flip(flipX: flipX, flipY: flipY, child: next.view),
        ),
        controller,
        screenW,
        screenH,
      ),
    );
  }
}
