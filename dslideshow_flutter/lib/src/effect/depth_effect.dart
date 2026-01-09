import 'package:dslideshow_flutter/src/effect/media_slider_item_effect.dart';
import 'package:dslideshow_flutter/src/effect/translate_effect.dart';
import 'package:flutter/material.dart';

class DepthEffect extends MediaSliderItemEffect  with TranslateEffect{
  final double startScale;

  DepthEffect({this.startScale = 0.4});

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
      final double scale = startScale + (1 - startScale) * (1 - pageDelta);
      double width = MediaQuery.of(context).size.width;
      return Transform(
        transformHitTests: false,
        alignment: Alignment.center,
        transform: translateCurrent(
          Matrix4.identity()
            ..translateByDouble(width * pageDelta, 0, 0, 1.0)
            ..scaleByDouble(scale, scale, scale, 1.0),
          pageDelta,
          screenW,
          screenH,
        ),
        child: Opacity(opacity: (1 - pageDelta), child: page),
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
