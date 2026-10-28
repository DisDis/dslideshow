import 'package:flutter/material.dart';

import 'media_slider_item_effect.dart';

import 'package:dslideshow_common/effects.dart';

/// Staggered horizontal strips slide alternately left and right. Views share
/// the prepared media/session supplied by the owner, as in BlindsEffect.
class SliceEffect extends MediaSliderItemEffect {
  final int stripCount;
  final double staggerFraction;
  final StripPattern pattern;

  SliceEffect({
    this.stripCount = 8,
    this.staggerFraction = .32,
    this.pattern = StripPattern.alternating,
  }) : assert(stripCount > 0);

  @override
  Widget transform(
    BuildContext context,
    Widget page,
    bool isCurrentPage,
    double pageDelta,
    double screenW,
    double screenH,
  ) => page;

  @override
  Widget createTransformWidget(
    BuildContext context,
    EffectSlideInput current,
    EffectSlideInput next,
    Animation<double> controller,
    double screenW,
    double screenH,
  ) => ClipRect(
    child: Stack(
      fit: StackFit.expand,
      children: [
        ColoredBox(color: Colors.black, child: next.view),
        for (var i = 0; i < stripCount; i++)
          Positioned(
            left: 0,
            right: 0,
            top: screenH * i / stripCount,
            height: screenH * (i + 1) / stripCount - screenH * i / stripCount,
            child: ClipRect(
              child: OverflowBox(
                alignment: Alignment.topLeft,
                minWidth: screenW,
                maxWidth: screenW,
                minHeight: screenH,
                maxHeight: screenH,
                child: Transform.translate(
                  offset: Offset(
                    ((pattern == StripPattern.sameDirection || i.isEven)
                            ? -1
                            : 1) *
                        screenW *
                        Curves.easeInOutCubic.transform(
                          ((controller.value -
                                      (stripCount == 1
                                          ? 0
                                          : staggerFraction *
                                                i /
                                                (stripCount - 1))) /
                                  (1 - staggerFraction))
                              .clamp(0.0, 1.0),
                        ),
                    -screenH * i / stripCount,
                  ),
                  child: ColoredBox(color: Colors.black, child: current.view),
                ),
              ),
            ),
          ),
      ],
    ),
  );
}
