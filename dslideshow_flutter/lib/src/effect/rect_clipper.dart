import 'package:flutter/material.dart';

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
