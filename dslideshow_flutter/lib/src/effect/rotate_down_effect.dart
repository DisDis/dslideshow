import 'dart:math' as math;
import 'package:dslideshow_flutter/src/effect/media_slider_item_effect.dart';
import 'package:dslideshow_flutter/src/effect/translate_effect.dart';
import 'package:flutter/material.dart';

class RotateDownEffect extends MediaSliderItemEffect  with TranslateEffect{
  final double rotationAngle;

  RotateDownEffect({double rotationAngle = 45})
    : rotationAngle = math.pi / 180 * rotationAngle;

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
      return Transform(
        transformHitTests: false,
        alignment: Alignment.bottomCenter,
        transform: translateCurrent(
          Matrix4.identity()..rotateZ(-rotationAngle * pageDelta),
          pageDelta,
          screenW,
          screenH,
        ),
        child: page,
      );
    } else if (!isCurrentPage /*index == currentPage + 1 || index == 0 && currentPage == itemCount - 1*/ ) {
      return Transform(
        transformHitTests: false,
        alignment: Alignment.bottomCenter,
        transform: translateNext(
          Matrix4.identity()..rotateZ(rotationAngle * (1 - pageDelta)),
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
        child: Container(),
      );
    }
  }
}
