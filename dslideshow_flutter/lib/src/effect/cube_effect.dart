import 'dart:math' as math;
import 'package:dslideshow_flutter/src/effect/media_slider_item_effect.dart';
import 'package:dslideshow_flutter/src/effect/translate_effect.dart';
import 'package:flutter/material.dart';

class CubeEffect extends MediaSliderItemEffect with TranslateEffect {
  final double perspectiveScale;
  final AlignmentGeometry rightPageAlignment;
  final AlignmentGeometry leftPageAlignment;
  final double rotationAngle;

  CubeEffect({
    this.perspectiveScale = 0.0014,
    this.rightPageAlignment = Alignment.centerLeft,
    this.leftPageAlignment = Alignment.centerRight,
    double rotationAngle = 90,
  }) : rotationAngle = math.pi / 180 * rotationAngle;

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
        alignment: leftPageAlignment,
        transform: translateCurrent(
          Matrix4.identity()
            ..setEntry(3, 2, perspectiveScale)
            ..rotateY(rotationAngle * pageDelta),
          pageDelta,
          screenW,
          screenH,
        ),
        child: page,
      );
    } else {
      return Transform(
        transformHitTests: false,
        alignment: rightPageAlignment,
        transform: translateNext(
          Matrix4.identity()
            ..setEntry(3, 2, perspectiveScale)
            ..rotateY(-rotationAngle * (1 - pageDelta)),
          pageDelta,
          screenW,
          screenH,
        ),
        child: page,
      );
    }
  }
}
