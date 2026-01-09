import 'package:dslideshow_flutter/src/effect/media_slider_item_effect.dart';
import 'package:dslideshow_flutter/src/effect/rect_clipper.dart';
import 'package:dslideshow_flutter/src/effect/translate_effect.dart';
import 'package:flutter/material.dart';

class ParallaxEffect extends MediaSliderItemEffect  with TranslateEffect {
  final double clipAmount;

  ParallaxEffect({this.clipAmount = 200});

  @override
  Widget transform(
    BuildContext context,
    Widget page,
    bool isCurrentPage /*int index, int currentPage*/,
    double pageDelta /*, int itemCount*/,
    double screenW,
    double screenH,
  ) {
    if (!isCurrentPage /*index == currentPage + 1|| index == 0 && currentPage == itemCount - 1*/ ) {
      return Transform(
        transformHitTests: false,
        transform: translateNext(
          Matrix4.identity()..
          translateByDouble(-clipAmount * (1 - pageDelta), 0, 0, 1.0),
          pageDelta,
          screenW,
          screenH,
        ),
        // offset: Offset(-clipAmount * (1 - pageDelta), 0),
        child: ClipRect(
          clipper: RectClipper(clipAmount * (1 - pageDelta)),
          child: page,
        ),
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
