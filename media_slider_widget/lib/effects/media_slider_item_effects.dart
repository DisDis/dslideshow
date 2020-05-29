import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:media_slider_widget/media_slider_item_effect.dart';

class AccordionEffect implements MediaSliderItemEffect {
  final bool transformRight;
  final bool transformLeft;

  AccordionEffect({
    this.transformRight = true,
    this.transformLeft = true,
  });

  @override
  Widget transform(BuildContext context, Widget page, int index, int currentPage, double pageDelta, int itemCount) {
    if (index == currentPage && transformLeft) {
      return Transform(
        alignment: Alignment.centerRight,
        transform: Matrix4.identity()..rotateY(math.pi / 2 * pageDelta),
        child: page,
      );
    }
    if (index == currentPage + 1 && transformRight) {
      return Transform(
        alignment: Alignment.centerLeft,
        transform: Matrix4.identity()..rotateY(-math.pi / 2 * (1 - pageDelta)),
        child: page,
      );
    } else {
      return page;
    }
  }
}

class BackgroundToForegroundEffect implements MediaSliderItemEffect {
  final double startScale;

  BackgroundToForegroundEffect({
    this.startScale = 0.4,
  });

  @override
  Widget transform(BuildContext context, Widget page, int index, int currentPage, double pageDelta, int itemCount) {
    if (index == currentPage + 1 || currentPage == itemCount - 1 && index == 0) {
      final double scale = startScale + (1 - startScale) * pageDelta;
      return Transform(
        alignment: Alignment.center,
        transform: Matrix4.identity()..scale(scale, scale),
        child: page,
      );
    } else {
      return page;
    }
  }
}

class CubeEffect implements MediaSliderItemEffect {
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
  Widget transform(BuildContext context, Widget page, int index, int currentPage, double pageDelta, int itemCount) {
    if (index == currentPage) {
      return Transform(
        alignment: leftPageAlignment,
        transform: Matrix4.identity()
          ..setEntry(3, 2, perspectiveScale)
          ..rotateY(rotationAngle * pageDelta),
        child: page,
      );
    } else if (index == currentPage + 1) {
      return Transform(
        alignment: rightPageAlignment,
        transform: Matrix4.identity()
          ..setEntry(3, 2, perspectiveScale)
          ..rotateY(-rotationAngle * (1 - pageDelta)),
        child: page,
      );
    } else if (index == 0 && currentPage == itemCount - 1) {
      return Transform(
        alignment: rightPageAlignment,
        transform: Matrix4.identity()
          ..setEntry(3, 2, perspectiveScale)
          ..rotateY(-rotationAngle * (1 - pageDelta)),
        child: page,
      );
    } else {
      return Container();
    }
  }
}

class DefaultEffect implements MediaSliderItemEffect {
  @override
  Widget transform(BuildContext context, Widget page, int index, int currentPage, double pageDelta, int itemCount) {
    return page;
  }
}

class DepthEffect implements MediaSliderItemEffect {
  final double startScale;

  DepthEffect({
    this.startScale = 0.4,
  });

  @override
  Widget transform(BuildContext context, Widget page, int index, int currentPage, double pageDelta, int itemCount) {
    if (index == currentPage) {
      final double scale = startScale + (1 - startScale) * (1 - pageDelta);
      double width = MediaQuery.of(context).size.width;
      return Transform(
        alignment: Alignment.center,
        transform: Matrix4.identity()
          ..translate(width * pageDelta)
          ..scale(scale, scale),
        child: Opacity(
          opacity: (1 - pageDelta),
          child: page,
        ),
      );
    } else {
      return page;
    }
  }
}

class FlipHorizontalEffect implements MediaSliderItemEffect {
  final double perspectiveScale;

  FlipHorizontalEffect({
    this.perspectiveScale = 0.002,
  });

  @override
  Widget transform(BuildContext context, Widget page, int index, int currentPage, double pageDelta, int itemCount) {
    final double width = MediaQuery.of(context).size.width;
    if ((index == currentPage + 1 || index == 0 && currentPage == itemCount - 1) && pageDelta > 0.5) {
      return Transform(
        alignment: Alignment.center,
        child: page,
        transform: Matrix4.identity()
          ..setEntry(3, 2, perspectiveScale)
          ..rotateY(math.pi * (pageDelta - 1))
          ..leftTranslate(-width * (1 - pageDelta)),
      );
    } else if (index == currentPage && pageDelta <= 0.5) {
      return Transform(
        alignment: Alignment.center,
        child: page,
        transform: Matrix4.identity()
          ..setEntry(3, 2, perspectiveScale)
          ..rotateY(math.pi * pageDelta)
          ..leftTranslate(width * pageDelta),
      );
    } else {
      return Container();
    }
  }
}

class FlipVerticalEffect implements MediaSliderItemEffect {
  final double perspectiveScale;

  FlipVerticalEffect({
    this.perspectiveScale = 0.002,
  });

  @override
  Widget transform(BuildContext context, Widget page, int index, int currentPage, double pageDelta, int itemCount) {
    final double width = MediaQuery.of(context).size.width;
    if ((index == currentPage + 1 || index == 0 && currentPage == itemCount - 1) && pageDelta > 0.5) {
      return Transform(
        alignment: Alignment.center,
        child: page,
        transform: Matrix4.identity()
          ..setEntry(3, 2, perspectiveScale)
          ..rotateX(math.pi * (pageDelta - 1))
          ..leftTranslate(-width * (1 - pageDelta)),
      );
    } else if (index == currentPage && pageDelta <= 0.5) {
      return Transform(
        alignment: Alignment.center,
        child: page,
        transform: Matrix4.identity()
          ..setEntry(3, 2, perspectiveScale)
          ..rotateX(math.pi * pageDelta)
          ..leftTranslate(width * pageDelta),
      );
    } else {
      return Container();
    }
  }
}

class ForegroundToBackgroundEffect implements MediaSliderItemEffect {
  final double endScale;

  ForegroundToBackgroundEffect({
    this.endScale = 0.4,
  });

  @override
  Widget transform(BuildContext context, Widget page, int index, int currentPage, double pageDelta, int itemCount) {
    if (index == currentPage) {
      final double scale = endScale + (1 - endScale) * (1 - pageDelta);
      return Transform(
        alignment: Alignment.center,
        transform: Matrix4.identity()..scale(scale, scale),
        child: page,
      );
    } else {
      return page;
    }
  }
}

class ParallaxEffect implements MediaSliderItemEffect {
  final double clipAmount;

  ParallaxEffect({
    this.clipAmount = 200,
  });

  @override
  Widget transform(BuildContext context, Widget page, int index, int currentPage, double pageDelta, int itemCount) {
    if (index == currentPage + 1 || index == 0 && currentPage == itemCount - 1) {
      return Transform.translate(
        offset: Offset(-clipAmount * (1 - pageDelta), 0),
        child: ClipRect(
          child: page,
          clipper: RectClipper(clipAmount * (1 - pageDelta)),
        ),
      );
    } else {
      return page;
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

class RotateDownEffect implements MediaSliderItemEffect {
  final double rotationAngle;

  RotateDownEffect({
    double rotationAngle = 45,
  }) : this.rotationAngle = math.pi / 180 * rotationAngle;

  @override
  Widget transform(BuildContext context, Widget page, int index, int currentPage, double pageDelta, int itemCount) {
    if (index == currentPage) {
      return Transform(
        alignment: Alignment.bottomCenter,
        child: page,
        transform: Matrix4.identity()..rotateZ(-rotationAngle * pageDelta),
      );
    } else if (index == currentPage + 1 || index == 0 && currentPage == itemCount - 1) {
      return Transform(
        alignment: Alignment.bottomCenter,
        child: page,
        transform: Matrix4.identity()..rotateZ(rotationAngle * (1 - pageDelta)),
      );
    } else {
      return Container();
    }
  }
}

class RotateUpEffect implements MediaSliderItemEffect {
  final double rotationAngle;

  RotateUpEffect({
    double rotationAngle = 45,
  }) : this.rotationAngle = math.pi / 180 * rotationAngle;

  @override
  Widget transform(BuildContext context, Widget page, int index, int currentPage, double pageDelta, int itemCount) {
    if (index == currentPage) {
      return Transform(
        alignment: Alignment.topCenter,
        child: page,
        transform: Matrix4.identity()..rotateZ(rotationAngle * pageDelta),
      );
    } else if (index == currentPage + 1 || index == 0 && currentPage == itemCount - 1) {
      return Transform(
        alignment: Alignment.topCenter,
        child: page,
        transform: Matrix4.identity()..rotateZ(-rotationAngle * (1 - pageDelta)),
      );
    } else {
      return Container();
    }
  }
}

class StackEffect implements MediaSliderItemEffect {
  @override
  Widget transform(BuildContext context, Widget page, int index, int currentPage, double pageDelta, int itemCount) {
    if (index == currentPage) {
      double width = MediaQuery.of(context).size.width;
      return Transform(
        transform: Matrix4.identity()..translate(width * pageDelta),
        child: page,
      );
    } else {
      return page;
    }
  }
}

class TabletEffect implements MediaSliderItemEffect {
  @override
  Widget transform(BuildContext context, Widget page, int index, int currentPage, double pageDelta, int itemCount) {
    if (index == currentPage) {
      return Transform(
        alignment: Alignment.center,
        child: page,
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.002)
          ..rotateY(-math.pi / 4 * pageDelta),
      );
    } else if (index == currentPage + 1 || index == 0 && currentPage == itemCount - 1) {
      return Transform(
        alignment: Alignment.center,
        child: page,
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.002)
          ..rotateY(math.pi / 4 * (1 - pageDelta)),
      );
    } else {
      return Container();
    }
  }
}

class ZoomOutEffect implements MediaSliderItemEffect {
  final double zoomOutScale;
  final bool enableOpacity;

  ZoomOutEffect({
    this.zoomOutScale = 0.8,
    this.enableOpacity = true,
  });

  @override
  Widget transform(BuildContext context, Widget page, int index, int currentPage, double pageDelta, int itemCount) {
    if (index == currentPage) {
      double scale = 1 - pageDelta < zoomOutScale ? zoomOutScale : zoomOutScale + ((1 - pageDelta) - zoomOutScale);
      return Transform(
        alignment: Alignment.center,
        child: enableOpacity ? Opacity(opacity: scale, child: page) : page,
        transform: Matrix4.identity()..scale(scale, scale),
      );
    } else if (index == currentPage + 1 || index == 0 && currentPage == itemCount - 1) {
      double scale = pageDelta < zoomOutScale ? zoomOutScale : zoomOutScale + (pageDelta - zoomOutScale);
      return Transform(
        alignment: Alignment.center,
        child: enableOpacity ? Opacity(opacity: scale, child: page) : page,
        transform: Matrix4.identity()..scale(scale, scale),
      );
    } else {
      return Container();
    }
  }
}
