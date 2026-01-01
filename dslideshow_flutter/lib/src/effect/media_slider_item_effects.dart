import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'media_slider_item_effect.dart';

mixin class TranslateEffect {
  Matrix4 translateCurrent(
    Matrix4 transform,
    double pageDelta,
    double screenW,
    double screenH,
  ) {
    transform.translateByDouble(-pageDelta * screenW, 0, 0, 1.0);
    return transform;
  }

  Matrix4 translateNext(
    Matrix4 transform,
    double pageDelta,
    double screenW,
    double screenH,
  ) {
    transform.translateByDouble(screenW - pageDelta * screenW, 0, 0, 1.0);
    return transform;
  }
}

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

class BackgroundToForegroundEffect
   extends MediaSliderItemEffect  with TranslateEffect
    {
  final double startScale;

  BackgroundToForegroundEffect({this.startScale = 0.4});

  @override
  Widget transform(
    BuildContext context,
    Widget page,
    bool isCurrentPage /*int index, int currentPage*/,
    double pageDelta /*, int itemCount*/,
    double screenW,
    double screenH,
  ) {
    if (!isCurrentPage /*index == currentPage + 1 || currentPage == itemCount - 1 && index == 0*/ ) {
      final double scale = startScale + (1 - startScale) * pageDelta;
      return Transform(
        transformHitTests: false,
        alignment: Alignment.center,
        transform: translateNext(
          Matrix4.identity()..scaleByDouble(scale, scale, scale, 1.0),
          pageDelta,
          screenW,
          screenH,
        ),
        child: page,
      );
    } else {
      return Transform(
        transformHitTests: false,
        transform: translateCurrent(
          Matrix4.identity(),
          pageDelta,
          screenW,
          screenH,
        ),
        child: page,
      );
    }
  }
}

class CubeEffect extends MediaSliderItemEffect  with TranslateEffect {
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
    } else //if (!isCurrentPage /*index == currentPage + 1*/)
    {
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
    } /*else if (index == 0 && currentPage == itemCount - 1) {
      return Transform(
          transformHitTests: false,
          transformHitTests: false,
        alignment: rightPageAlignment,
        transform: Matrix4.identity()
          ..setEntry(3, 2, perspectiveScale)
          ..rotateY(-rotationAngle * (1 - pageDelta)),
        child: page,
      );
    }*/ /*else {
      return Container();
    }*/
  }
}

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

class FlipHorizontalEffect
    extends MediaSliderItemEffect  with TranslateEffect
    {
  final double perspectiveScale;

  FlipHorizontalEffect({this.perspectiveScale = 0.002});

  @override
  Widget transform(
    BuildContext context,
    Widget page,
    bool isCurrentPage /*int index, int currentPage*/,
    double pageDelta /*, int itemCount*/,
    double screenW,
    double screenH,
  ) {
    final double width = MediaQuery.of(context).size.width;
    if ((!isCurrentPage /*index == currentPage + 1 || index == 0 && currentPage == itemCount - 1*/ ) &&
        pageDelta > 0.5) {
      return Transform(
        transformHitTests: false,
        alignment: Alignment.center,
        transform: translateNext(
          Matrix4.identity()
            ..setEntry(3, 2, perspectiveScale)
            ..rotateY(math.pi * (pageDelta - 1))
            ..leftTranslateByDouble(-width * (1 - pageDelta), 0.0, 0.0, 1.0),
          pageDelta,
          screenW,
          screenH,
        ),
        child: page,
      );
    } else if (isCurrentPage /*index == currentPage*/ && pageDelta <= 0.5) {
      return Transform(
        transformHitTests: false,
        alignment: Alignment.center,
        transform: translateCurrent(
          Matrix4.identity()
            ..setEntry(3, 2, perspectiveScale)
            ..rotateY(math.pi * pageDelta)
            ..leftTranslateByDouble(width * pageDelta, 0.0, 0.0, 1.0),
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

class FlipVerticalEffect extends MediaSliderItemEffect  with TranslateEffect {
  final double perspectiveScale;

  FlipVerticalEffect({this.perspectiveScale = 0.002});

  @override
  Widget transform(
    BuildContext context,
    Widget page,
    bool isCurrentPage /*int index, int currentPage*/,
    double pageDelta /*, int itemCount*/,
    double screenW,
    double screenH,
  ) {
    final double width = MediaQuery.of(context).size.width;
    if ((!isCurrentPage /*index == currentPage + 1 || index == 0 && currentPage == itemCount - 1*/ ) &&
        pageDelta > 0.5) {
      return Transform(
        transformHitTests: false,
        alignment: Alignment.center,
        transform: translateNext(
          Matrix4.identity()
            ..setEntry(3, 2, perspectiveScale)
            ..rotateX(math.pi * (pageDelta - 1))
            ..leftTranslateByDouble(-width * (1 - pageDelta), 0.0, 0.0, 1.0),
          pageDelta,
          screenW,
          screenH,
        ),
        child: page,
      );
    } else if (isCurrentPage /*index == currentPage*/ && pageDelta <= 0.5) {
      return Transform(
        transformHitTests: false,
        alignment: Alignment.center,
        transform: translateCurrent(
          Matrix4.identity()
            ..setEntry(3, 2, perspectiveScale)
            ..rotateX(math.pi * pageDelta)
            ..leftTranslateByDouble(width * pageDelta, 0.0, 0.0, 1.0),
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

//1
class ForegroundToBackgroundEffect
    extends MediaSliderItemEffect  with TranslateEffect
     {
  final double endScale;

  ForegroundToBackgroundEffect({this.endScale = 0.4});

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
      final double scale = endScale + (1 - endScale) * (1 - pageDelta);
      return Transform(
        transformHitTests: false,
        alignment: Alignment.center,
        transform: translateCurrent(
          Matrix4.identity()..scaleByDouble(scale, scale, scale, 1.0),
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

class ParallaxEffect extends MediaSliderItemEffect  with TranslateEffect {
  final double clipAmount;

  ParallaxEffect({this.clipAmount = 200});

  @override
  Widget transform(
    BuildContext context,
    Widget page,
    bool isCurrentPage /*int index, int currentPage*/,
    double pageDelta /*, int itemCount*/,
    double screenW,
    double screenH,
  ) {
    if (!isCurrentPage /*index == currentPage + 1|| index == 0 && currentPage == itemCount - 1*/ ) {
      return Transform(
        transformHitTests: false,
        transform: translateNext(
          Matrix4.identity()..
          translateByDouble(-clipAmount * (1 - pageDelta), 0, 0, 1.0),
          pageDelta,
          screenW,
          screenH,
        ),
        // offset: Offset(-clipAmount * (1 - pageDelta), 0),
        child: ClipRect(
          clipper: RectClipper(clipAmount * (1 - pageDelta)),
          child: page,
        ),
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

class RectClipper extends CustomClipper<Rect> {
  final double leftClip;

  RectClipper(this.leftClip);

  @override
  Rect getClip(Size size) {
    return Rect.fromLTRB(leftClip, 0, size.width, size.height);
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}

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

class RotateUpEffect extends MediaSliderItemEffect  with TranslateEffect  {
  final double rotationAngle;

  RotateUpEffect({double rotationAngle = 45})
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
        alignment: Alignment.topCenter,
        transform: translateCurrent(
          Matrix4.identity()..rotateZ(rotationAngle * pageDelta),
          pageDelta,
          screenW,
          screenH,
        ),
        child: page,
      );
    } else if (!isCurrentPage /*index == currentPage + 1 || index == 0 && currentPage == itemCount - 1*/ ) {
      return Transform(
        transformHitTests: false,
        alignment: Alignment.topCenter,
        transform: translateNext(
          Matrix4.identity()..rotateZ(-rotationAngle * (1 - pageDelta)),
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

class StackEffect extends MediaSliderItemEffect  with TranslateEffect {
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
      double width = MediaQuery.of(context).size.width;
      return Transform(
        transformHitTests: false,
        transform: translateCurrent(
          Matrix4.identity()..translateByDouble(width * pageDelta, 0.0, 0.0, 1.0),
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

class TabletEffect extends MediaSliderItemEffect  with TranslateEffect {
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
        alignment: Alignment.center,
        transform: translateCurrent(
          Matrix4.identity()
            ..setEntry(3, 2, 0.002)
            ..rotateY(-math.pi / 4 * pageDelta),
          pageDelta,
          screenW,
          screenH,
        ),
        child: page,
      );
    } else if (!isCurrentPage /*index == currentPage + 1 || index == 0 && currentPage == itemCount - 1*/ ) {
      return Transform(
        transformHitTests: false,
        alignment: Alignment.center,
        transform: translateNext(
          Matrix4.identity()
            ..setEntry(3, 2, 0.002)
            ..rotateY(math.pi / 4 * (1 - pageDelta)),
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

class ZoomOutEffect extends MediaSliderItemEffect  with TranslateEffect {
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
    if (isCurrentPage) {
      double scale = 1 - pageDelta < zoomOutScale
          ? zoomOutScale
          : zoomOutScale + ((1 - pageDelta) - zoomOutScale);
      return Transform(
        transformHitTests: false,
        alignment: Alignment.center,
        transform: translateCurrent(
          Matrix4.identity()..scaleByDouble(scale, scale, scale, 1.0),
          pageDelta,
          screenW,
          screenH,
        ),
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
          Matrix4.identity()..scaleByDouble(scale, scale, scale, 1.0),
          pageDelta,
          screenW,
          screenH,
        ),
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
