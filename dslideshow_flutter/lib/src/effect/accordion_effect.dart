import 'dart:math' as math;
import 'package:dslideshow_flutter/src/effect/media_slider_item_effect.dart';
import 'package:dslideshow_flutter/src/effect/translate_effect.dart';
import 'package:flutter/material.dart';

class AccordionEffect extends MediaSliderItemEffect with TranslateEffect {
  final bool transformRight;
  final bool transformLeft;

  AccordionEffect({this.transformRight = true, this.transformLeft = true});

  @override
  Widget transform(
    BuildContext context,
    Widget page,
    bool isCurrentPage /*int index, int currentPage*/,
    double pageDelta /*, int itemCount*/,
    double screenW,
    double screenH,
  ) {

    if (isCurrentPage /*index == currentPage*/ && transformLeft) {
      return Transform(
        transformHitTests: false,
        alignment: Alignment.centerRight,
        transform: translateCurrent(
          Matrix4.identity()..rotateY(math.pi / 2 * pageDelta),
          pageDelta,
          screenW,
          screenH,
        ),
        child: page,
      );
    }
    if (!isCurrentPage /*index == currentPage + 1*/ && transformRight) {
      return Transform(
        transformHitTests: false,
        alignment: Alignment.centerLeft,
        transform: translateNext(
          Matrix4.identity()..rotateY(-math.pi / 2 * (1 - pageDelta)),
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
