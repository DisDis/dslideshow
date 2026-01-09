import 'package:dslideshow_flutter/src/effect/media_slider_item_effect.dart';
import 'package:dslideshow_flutter/src/effect/translate_effect.dart';
import 'package:flutter/material.dart';

class DefaultEffect extends MediaSliderItemEffect  with TranslateEffect{
  @override
  Widget transform(
    BuildContext context,
    Widget page,
    bool isCurrentPage /*int index, int currentPage*/,
    double pageDelta /*, int itemCount*/,
    double screenW,
    double screenH,
  ) {
    return Transform(
      transformHitTests: false,
      transform: isCurrentPage
          ? translateCurrent(Matrix4.identity(), pageDelta, screenW, screenH)
          : translateNext(Matrix4.identity(), pageDelta, screenW, screenH),
      child: page,
    );
  }
}
