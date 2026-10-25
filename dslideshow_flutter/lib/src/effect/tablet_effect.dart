import 'dart:math' as math;

import 'package:dslideshow_flutter/src/effect/media_slider_item_effect.dart';
import 'package:dslideshow_flutter/src/effect/translate_effect.dart';
import 'package:flutter/material.dart';

class TabletEffect extends MediaSliderItemEffect with TranslateEffect {
  @override
  Widget transform(
    BuildContext context,
    Widget page,
    bool isCurrentPage /*int index, int currentPage*/,
    double pageDelta /*, int itemCount*/,
    double screenW,
    double screenH,
  ) {
    // Translate in screen space, then project/rotate around the slide centre.
    // Perspective uses a 320px reference so large screens stay in front of camera.
    if (isCurrentPage) {
      return Transform(
        transformHitTests: false,
        alignment: Alignment.center,
        transform:
            translateCurrent(Matrix4.identity(), pageDelta, screenW, screenH)
              ..multiply(
                Matrix4.identity()
                  ..setEntry(3, 2, 0.002 * 320 / screenW)
                  ..rotateY(-math.pi / 4 * pageDelta),
              ),
        child: page,
      );
    } else if (!isCurrentPage /*index == currentPage + 1 || index == 0 && currentPage == itemCount - 1*/ ) {
      return Transform(
        transformHitTests: false,
        alignment: Alignment.center,
        transform:
            translateNext(Matrix4.identity(), pageDelta, screenW, screenH)
              ..multiply(
                Matrix4.identity()
                  ..setEntry(3, 2, 0.002 * 320 / screenW)
                  ..rotateY(math.pi / 4 * (1 - pageDelta)),
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
