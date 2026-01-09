import 'package:dslideshow_flutter/src/effect/media_slider_item_effect.dart';
import 'package:dslideshow_flutter/src/effect/translate_effect.dart';
import 'package:flutter/material.dart';

class BackgroundToForegroundEffect
   extends MediaSliderItemEffect  with TranslateEffect
    {
  final double startScale;

  BackgroundToForegroundEffect({this.startScale = 0.4});

  @override
  Widget transform(
    BuildContext context,
    Widget page,
    bool isCurrentPage /*int index, int currentPage*/,
    double pageDelta /*, int itemCount*/,
    double screenW,
    double screenH,
  ) {
    if (!isCurrentPage /*index == currentPage + 1 || currentPage == itemCount - 1 && index == 0*/ ) {
      final double scale = startScale + (1 - startScale) * pageDelta;
      return Transform(
        transformHitTests: false,
        alignment: Alignment.center,
        transform: translateNext(
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
        transform: translateCurrent(
          Matrix4.identity(),
          pageDelta,
          screenW,
          screenH,
        ),
        child: page,
      );
    }
  }
}
