import 'package:flutter/material.dart';

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
