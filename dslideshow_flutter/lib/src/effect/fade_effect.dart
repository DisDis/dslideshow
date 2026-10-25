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
    // Include letterboxing in the blend, so transparent video/GIF margins
    // cannot reveal the old slide until it is detached at completion.
    final opaquePage = ColoredBox(color: Colors.black, child: page);
    return isCurrentPage
        ? opaquePage
        : Opacity(opacity: pageDelta, child: opaquePage);
  }
}
