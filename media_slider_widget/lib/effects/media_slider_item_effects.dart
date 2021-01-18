import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:media_slider_widget/media_slider_item_effect.dart';

class TranslateEffect {
  Matrix4 translateCurrent(Matrix4 transform,double pageDelta, double screenW, double screenH){
    transform.translate( -pageDelta * screenW);
    return transform;
  }
  Matrix4 translateNext(Matrix4 transform,double pageDelta, double screenW, double screenH){
    transform.translate(screenW - pageDelta * screenW);
    return transform;
  }
}

class AccordionEffect with TranslateEffect implements MediaSliderItemEffect  {
  final bool transformRight;
  final bool transformLeft;

  AccordionEffect({
    this.transformRight = true,
    this.transformLeft = true,
  });

  @override
  Widget transform(BuildContext context, Widget page, bool isCurrentPage /*int index, int currentPage*/, double pageDelta/*, int itemCount*/,
      double screenW, double screenH) {
    if (isCurrentPage/*index == currentPage*/ && transformLeft) {
      return Transform(
        transformHitTests: false,
        alignment: Alignment.centerRight,
        transform: translateCurrent(Matrix4.identity()..rotateY(math.pi / 2 * pageDelta), pageDelta, screenW, screenH),
        child: page,
      );
    }
    if (!isCurrentPage/*index == currentPage + 1*/ && transformRight) {
      return Transform(
        transformHitTests: false,
        alignment: Alignment.centerLeft,
        transform: translateNext(Matrix4.identity()..rotateY(-math.pi / 2 * (1 - pageDelta)), pageDelta, screenW, screenH),
        child: page,
      );
    } else {
      return Transform(
          transformHitTests: false,
          transform: isCurrentPage? translateCurrent(Matrix4.identity(), pageDelta, screenW, screenH):
          translateNext(Matrix4.identity(), pageDelta, screenW, screenH),
          child:page);
    }
  }
}

class BackgroundToForegroundEffect with TranslateEffect implements MediaSliderItemEffect {
  final double startScale;

  BackgroundToForegroundEffect({
    this.startScale = 0.4,
  });

  @override
  Widget transform(BuildContext context, Widget page, bool isCurrentPage /*int index, int currentPage*/, double pageDelta/*, int itemCount*/,
      double screenW, double screenH) {
    if (!isCurrentPage/*index == currentPage + 1 || currentPage == itemCount - 1 && index == 0*/) {
      final double scale = startScale + (1 - startScale) * pageDelta;
      return Transform(
          transformHitTests: false,
        alignment: Alignment.center,
        transform: translateNext(Matrix4.identity()..scale(scale, scale), pageDelta, screenW, screenH),
        child: page,
      );
    } else {
      return
        Transform(
          transformHitTests: false,
            transform: translateCurrent(Matrix4.identity(), pageDelta, screenW, screenH),
            child:page);
    }
  }
}

class CubeEffect with TranslateEffect implements MediaSliderItemEffect {
  final double perspectiveScale;
  final AlignmentGeometry rightPageAlignment;
  final AlignmentGeometry leftPageAlignment;
  final double rotationAngle;

  CubeEffect({
    this.perspectiveScale = 0.0014,
    this.rightPageAlignment = Alignment.centerLeft,
    this.leftPageAlignment = Alignment.centerRight,
    double rotationAngle = 90,
  }) : this.rotationAngle = math.pi / 180 * rotationAngle;

  @override
  Widget transform(BuildContext context, Widget page, bool isCurrentPage /*int index, int currentPage*/, double pageDelta/*, int itemCount*/,
      double screenW, double screenH) {
    if (isCurrentPage) {
      return Transform(
          transformHitTests: false,
        alignment: leftPageAlignment,
        transform: translateCurrent(Matrix4.identity()
          ..setEntry(3, 2, perspectiveScale)
          ..rotateY(rotationAngle * pageDelta), pageDelta, screenW, screenH),
        child: page,
      );
    } else //if (!isCurrentPage /*index == currentPage + 1*/)
    {
      return Transform(
          transformHitTests: false,
        alignment: rightPageAlignment,
        transform: translateNext(Matrix4.identity()
          ..setEntry(3, 2, perspectiveScale)
          ..rotateY(-rotationAngle * (1 - pageDelta)), pageDelta, screenW, screenH),
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

class DefaultEffect with TranslateEffect implements MediaSliderItemEffect {
  @override
  Widget transform(BuildContext context, Widget page, bool isCurrentPage /*int index, int currentPage*/, double pageDelta/*, int itemCount*/,
      double screenW, double screenH) {
    return Transform(
          transformHitTests: false,
        transform: isCurrentPage? translateCurrent(Matrix4.identity(), pageDelta, screenW, screenH):
            translateNext(Matrix4.identity(), pageDelta, screenW, screenH),
        child:page);
  }
}

class DepthEffect with TranslateEffect implements MediaSliderItemEffect {
  final double startScale;

  DepthEffect({
    this.startScale = 0.4,
  });

  @override
  Widget transform(BuildContext context, Widget page, bool isCurrentPage /*int index, int currentPage*/, double pageDelta/*, int itemCount*/,
      double screenW, double screenH) {
    if (isCurrentPage) {
      final double scale = startScale + (1 - startScale) * (1 - pageDelta);
      double width = MediaQuery.of(context).size.width;
      return Transform(
          transformHitTests: false,
        alignment: Alignment.center,
        transform: translateCurrent(Matrix4.identity()
          ..translate(width * pageDelta)
          ..scale(scale, scale), pageDelta, screenW, screenH),
        child: Opacity(
          opacity: (1 - pageDelta),
          child: page,
        ),
      );
    } else {
      return Transform(
          transformHitTests: false,
          transform: isCurrentPage? translateCurrent(Matrix4.identity(), pageDelta, screenW, screenH):
          translateNext(Matrix4.identity(), pageDelta, screenW, screenH),
          child:page);
    }
  }
}

class FlipHorizontalEffect with TranslateEffect implements MediaSliderItemEffect {
  final double perspectiveScale;

  FlipHorizontalEffect({
    this.perspectiveScale = 0.002,
  });

  @override
  Widget transform(BuildContext context, Widget page, bool isCurrentPage /*int index, int currentPage*/, double pageDelta/*, int itemCount*/,
      double screenW, double screenH) {
    final double width = MediaQuery.of(context).size.width;
    if ((!isCurrentPage /*index == currentPage + 1 || index == 0 && currentPage == itemCount - 1*/) && pageDelta > 0.5) {
      return Transform(
          transformHitTests: false,
        alignment: Alignment.center,
        child: page,
        transform: translateNext(Matrix4.identity()
          ..setEntry(3, 2, perspectiveScale)
          ..rotateY(math.pi * (pageDelta - 1))
          ..leftTranslate(-width * (1 - pageDelta)), pageDelta, screenW, screenH),
      );
    } else if (isCurrentPage/*index == currentPage*/ && pageDelta <= 0.5) {
      return Transform(
          transformHitTests: false,
        alignment: Alignment.center,
        child: page,
        transform: translateCurrent(Matrix4.identity()
          ..setEntry(3, 2, perspectiveScale)
          ..rotateY(math.pi * pageDelta)
          ..leftTranslate(width * pageDelta), pageDelta, screenW, screenH)
      );
    } else {
      return Transform(
          transformHitTests: false,
          transform: isCurrentPage? translateCurrent(Matrix4.identity(), pageDelta, screenW, screenH):
          translateNext(Matrix4.identity(), pageDelta, screenW, screenH),
          child:Container());

    }
  }
}

class FlipVerticalEffect with TranslateEffect implements MediaSliderItemEffect {
  final double perspectiveScale;

  FlipVerticalEffect({
    this.perspectiveScale = 0.002,
  });

  @override
  Widget transform(BuildContext context, Widget page, bool isCurrentPage /*int index, int currentPage*/, double pageDelta/*, int itemCount*/,
      double screenW, double screenH) {
    final double width = MediaQuery.of(context).size.width;
    if ((!isCurrentPage/*index == currentPage + 1 || index == 0 && currentPage == itemCount - 1*/) && pageDelta > 0.5) {
      return Transform(
          transformHitTests: false,
        alignment: Alignment.center,
        child: page,
        transform: translateNext(Matrix4.identity()
          ..setEntry(3, 2, perspectiveScale)
          ..rotateX(math.pi * (pageDelta - 1))
          ..leftTranslate(-width * (1 - pageDelta)), pageDelta, screenW, screenH),
      );
    } else if (isCurrentPage/*index == currentPage*/ && pageDelta <= 0.5) {
      return Transform(
          transformHitTests: false,
        alignment: Alignment.center,
        child: page,
        transform: translateCurrent(Matrix4.identity()
          ..setEntry(3, 2, perspectiveScale)
          ..rotateX(math.pi * pageDelta)
          ..leftTranslate(width * pageDelta), pageDelta, screenW, screenH),
      );
    } else {
      return Transform(
          transformHitTests: false,
          transform: isCurrentPage? translateCurrent(Matrix4.identity(), pageDelta, screenW, screenH):
          translateNext(Matrix4.identity(), pageDelta, screenW, screenH),
          child:Container());
    }
  }
}

//1
class ForegroundToBackgroundEffect with TranslateEffect implements MediaSliderItemEffect {
  final double endScale;

  ForegroundToBackgroundEffect({
    this.endScale = 0.4,
  });

  @override
  Widget transform(BuildContext context, Widget page, bool isCurrentPage /*int index, int currentPage*/, double pageDelta/*, int itemCount*/,
      double screenW, double screenH) {
    if (isCurrentPage) {
      final double scale = endScale + (1 - endScale) * (1 - pageDelta);
      return Transform(
          transformHitTests: false,
        alignment: Alignment.center,
        transform: translateCurrent(Matrix4.identity()..scale(scale, scale), pageDelta, screenW, screenH),
        child: page,
      );
    } else {
      return Transform(
          transformHitTests: false,
          transform: isCurrentPage? translateCurrent(Matrix4.identity(), pageDelta, screenW, screenH):
          translateNext(Matrix4.identity(), pageDelta, screenW, screenH),
          child:page);
    }
  }
}

class ParallaxEffect with TranslateEffect implements MediaSliderItemEffect {
  final double clipAmount;

  ParallaxEffect({
    this.clipAmount = 200,
  });

  @override
  Widget transform(BuildContext context, Widget page, bool isCurrentPage /*int index, int currentPage*/, double pageDelta/*, int itemCount*/,
      double screenW, double screenH) {
    if (!isCurrentPage/*index == currentPage + 1|| index == 0 && currentPage == itemCount - 1*/) {
      return Transform(
          transformHitTests: false,
        transform: translateNext(Matrix4.identity()..translate(-clipAmount * (1 - pageDelta)), pageDelta, screenW, screenH),
        // offset: Offset(-clipAmount * (1 - pageDelta), 0),
        child: ClipRect(
          child: page,
          clipper: RectClipper(clipAmount * (1 - pageDelta)),
        ),
      );
    } else {
      return Transform(
          transformHitTests: false,
          transform: isCurrentPage? translateCurrent(Matrix4.identity(), pageDelta, screenW, screenH):
          translateNext(Matrix4.identity(), pageDelta, screenW, screenH),
          child:page);
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

class RotateDownEffect with TranslateEffect implements MediaSliderItemEffect {
  final double rotationAngle;

  RotateDownEffect({
    double rotationAngle = 45,
  }) : this.rotationAngle = math.pi / 180 * rotationAngle;

  @override
  Widget transform(BuildContext context, Widget page, bool isCurrentPage /*int index, int currentPage*/, double pageDelta/*, int itemCount*/,
      double screenW, double screenH) {
    if (isCurrentPage) {
      return Transform(
          transformHitTests: false,
        alignment: Alignment.bottomCenter,
        child: page,
        transform: translateCurrent(Matrix4.identity()..rotateZ(-rotationAngle * pageDelta), pageDelta, screenW, screenH),
      );
    } else if (!isCurrentPage/*index == currentPage + 1 || index == 0 && currentPage == itemCount - 1*/) {
      return Transform(
          transformHitTests: false,
        alignment: Alignment.bottomCenter,
        child: page,
        transform: translateNext(Matrix4.identity()..rotateZ(rotationAngle * (1 - pageDelta)), pageDelta, screenW, screenH),
      );
    } else {
      return Transform(
          transformHitTests: false,
          transform: isCurrentPage? translateCurrent(Matrix4.identity(), pageDelta, screenW, screenH):
          translateNext(Matrix4.identity(), pageDelta, screenW, screenH),
          child:Container());
    }
  }
}

class RotateUpEffect with TranslateEffect implements MediaSliderItemEffect {
  final double rotationAngle;

  RotateUpEffect({
    double rotationAngle = 45,
  }) : this.rotationAngle = math.pi / 180 * rotationAngle;

  @override
  Widget transform(BuildContext context, Widget page, bool isCurrentPage /*int index, int currentPage*/, double pageDelta/*, int itemCount*/,
      double screenW, double screenH) {
    if (isCurrentPage) {
      return Transform(
          transformHitTests: false,
        alignment: Alignment.topCenter,
        child: page,
        transform: translateCurrent(Matrix4.identity()..rotateZ(rotationAngle * pageDelta), pageDelta, screenW, screenH),
      );
    } else if (!isCurrentPage/*index == currentPage + 1 || index == 0 && currentPage == itemCount - 1*/) {
      return Transform(
          transformHitTests: false,
        alignment: Alignment.topCenter,
        child: page,
        transform: translateNext(Matrix4.identity()..rotateZ(-rotationAngle * (1 - pageDelta)), pageDelta, screenW, screenH),
      );
    } else {
      return Transform(
          transformHitTests: false,
          transform: isCurrentPage? translateCurrent(Matrix4.identity(), pageDelta, screenW, screenH):
          translateNext(Matrix4.identity(), pageDelta, screenW, screenH),
          child:Container());
    }
  }
}

class StackEffect with TranslateEffect implements MediaSliderItemEffect {
  @override
  Widget transform(BuildContext context, Widget page, bool isCurrentPage /*int index, int currentPage*/, double pageDelta/*, int itemCount*/,
      double screenW, double screenH) {
    if (isCurrentPage) {
      double width = MediaQuery.of(context).size.width;
      return Transform(
          transformHitTests: false,
        transform: translateCurrent(Matrix4.identity()..translate(width * pageDelta), pageDelta, screenW, screenH),
        child: page,
      );
    } else {
      return Transform(
          transformHitTests: false,
          transform: isCurrentPage? translateCurrent(Matrix4.identity(), pageDelta, screenW, screenH):
          translateNext(Matrix4.identity(), pageDelta, screenW, screenH),
          child:page);
    }
  }
}

class TabletEffect with TranslateEffect implements MediaSliderItemEffect {
  @override
  Widget transform(BuildContext context, Widget page, bool isCurrentPage /*int index, int currentPage*/, double pageDelta/*, int itemCount*/,
      double screenW, double screenH) {
    if (isCurrentPage) {
      return Transform(
          transformHitTests: false,
        alignment: Alignment.center,
        child: page,
        transform: translateCurrent(Matrix4.identity()
          ..setEntry(3, 2, 0.002)
          ..rotateY(-math.pi / 4 * pageDelta), pageDelta, screenW, screenH),
      );
    } else if (!isCurrentPage/*index == currentPage + 1 || index == 0 && currentPage == itemCount - 1*/) {
      return Transform(
          transformHitTests: false,
        alignment: Alignment.center,
        child: page,
        transform: translateNext(Matrix4.identity()
          ..setEntry(3, 2, 0.002)
          ..rotateY(math.pi / 4 * (1 - pageDelta)), pageDelta, screenW, screenH),
      );
    } else {
      return Transform(
          transformHitTests: false,
          transform: isCurrentPage? translateCurrent(Matrix4.identity(), pageDelta, screenW, screenH):
          translateNext(Matrix4.identity(), pageDelta, screenW, screenH),
          child:Container());
    }
  }
}

class ZoomOutEffect with TranslateEffect implements MediaSliderItemEffect {
  final double zoomOutScale;
  final bool enableOpacity;

  ZoomOutEffect({
    this.zoomOutScale = 0.8,
    this.enableOpacity = true,
  });

  @override
  Widget transform(BuildContext context, Widget page, bool isCurrentPage /*int index, int currentPage*/, double pageDelta/*, int itemCount*/,
      double screenW, double screenH) {
    if (isCurrentPage) {
      double scale = 1 - pageDelta < zoomOutScale ? zoomOutScale : zoomOutScale + ((1 - pageDelta) - zoomOutScale);
      return Transform(
          transformHitTests: false,
        alignment: Alignment.center,
        child: enableOpacity ? Opacity(opacity: scale, child: page) : page,
        transform: translateCurrent(Matrix4.identity()..scale(scale, scale), pageDelta, screenW, screenH),
      );
    } else if (!isCurrentPage/*index == currentPage + 1 || index == 0 && currentPage == itemCount - 1*/) {
      double scale = pageDelta < zoomOutScale ? zoomOutScale : zoomOutScale + (pageDelta - zoomOutScale);
      return Transform(
          transformHitTests: false,
        alignment: Alignment.center,
        child: enableOpacity ? Opacity(opacity: scale, child: page) : page,
        transform: translateNext(Matrix4.identity()..scale(scale, scale), pageDelta, screenW, screenH),
      );
    } else {
      return Transform(
          transformHitTests: false,
          transform: isCurrentPage? translateCurrent(Matrix4.identity(), pageDelta, screenW, screenH):
          translateNext(Matrix4.identity(), pageDelta, screenW, screenH),
          child:Container());
    }
  }
}
