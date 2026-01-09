import 'package:dslideshow_flutter/src/effect/media_slider_item_effect.dart';
import 'package:dslideshow_flutter/src/effect/translate_effect.dart';
import 'package:flutter/material.dart';

class ForegroundToBackgroundEffect
    extends MediaSliderItemEffect  with TranslateEffect
     {
  final double endScale;

  ForegroundToBackgroundEffect({this.endScale = 0.4});

  @override
  Widget transform(
    BuildContext context,
    Widget page,
    bool isCurrentPage /*int index, int currentPage*/,
    double pageDelta /*, int itemCount*/,
    double screenW,
    double screenH,
  ) {
    if (isCurrentPage) {
      final double scale = endScale + (1 - endScale) * (1 - pageDelta);
      return Transform(
        transformHitTests: false,
        alignment: Alignment.center,
        transform: translateCurrent(
          Matrix4.identity()..scaleByDouble(scale, scale, scale, 1.0),
          pageDelta,
          screenW,
          screenH,
        ),
        child: page,
      );
    } else {
      return Transform(
        transformHitTests: false,
        transform: isCurrentPage
            ? translateCurrent(Matrix4.identity(), pageDelta, screenW, screenH)
            : translateNext(Matrix4.identity(), pageDelta, screenW, screenH),
        child: page,
      );
    }
  }
}
