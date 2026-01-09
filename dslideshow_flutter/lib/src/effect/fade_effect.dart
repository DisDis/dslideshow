import 'package:dslideshow_flutter/src/effect/media_slider_item_effect.dart';
import 'package:flutter/material.dart';

class FadeEffect extends MediaSliderItemEffect {
  @override
  Widget transform(
    BuildContext context,
    Widget page,
    bool isCurrentPage,
    double pageDelta,
    double screenW,
    double screenH,
  ) {
    return isCurrentPage
        ? Opacity(opacity: 1 - pageDelta, child: page)
        : Opacity(opacity: pageDelta, child: page);
   }
}
