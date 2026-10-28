import 'package:flutter/material.dart';

import 'effect_slide_input.dart';

export 'effect_slide_input.dart';

abstract class MediaSliderItemEffect {
  /// Prepare optional GPU resources before the transition clock starts.
  Future<void> prepare() async {}

  /// Whether these actual prepared inputs can be rendered by this effect.
  /// Callers choose their normal Fade fallback before starting the controller.
  bool supportsInputs(EffectSlideInput current, EffectSlideInput next) => true;
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
    EffectSlideInput current,
    EffectSlideInput next,
    Animation<double> controller,
    double screenW,
    double screenH,
  ) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        transform(
          context,
          current.view,
          true,
          controller.value,
          screenW,
          screenH,
        ),
        transform(
          context,
          next.view,
          false,
          controller.value,
          screenW,
          screenH,
        ),
      ],
    );
  }
}
