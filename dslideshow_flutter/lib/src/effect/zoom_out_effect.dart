import 'package:dslideshow_flutter/src/effect/media_slider_item_effect.dart';
import 'package:dslideshow_flutter/src/effect/translate_effect.dart';
import 'package:flutter/material.dart';

class ZoomOutEffect extends MediaSliderItemEffect with TranslateEffect {
  final double zoomOutScale;
  final bool enableOpacity;

  ZoomOutEffect({this.zoomOutScale = 0.8, this.enableOpacity = true});

  @override
  Widget transform(
    BuildContext context,
    Widget page,
    bool isCurrentPage /*int index, int currentPage*/,
    double pageDelta /*, int itemCount*/,
    double screenW,
    double screenH,
  ) {
    // Scaling a translation would expose slide B before the transition starts.
    if (isCurrentPage) {
      double scale = 1 - pageDelta < zoomOutScale
          ? zoomOutScale
          : zoomOutScale + ((1 - pageDelta) - zoomOutScale);
      return Transform(
        transformHitTests: false,
        alignment: Alignment.center,
        transform: translateCurrent(
          Matrix4.identity(),
          pageDelta,
          screenW,
          screenH,
        )..scaleByDouble(scale, scale, scale, 1.0),
        child: enableOpacity ? Opacity(opacity: scale, child: page) : page,
      );
    } else if (!isCurrentPage /*index == currentPage + 1 || index == 0 && currentPage == itemCount - 1*/ ) {
      double scale = pageDelta < zoomOutScale
          ? zoomOutScale
          : zoomOutScale + (pageDelta - zoomOutScale);
      return Transform(
        transformHitTests: false,
        alignment: Alignment.center,
        transform: translateNext(
          Matrix4.identity(),
          pageDelta,
          screenW,
          screenH,
        )..scaleByDouble(scale, scale, scale, 1.0),
        child: enableOpacity ? Opacity(opacity: scale, child: page) : page,
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
