import 'package:flutter/material.dart';

abstract class MediaSliderItemEffect {
  // current:itemCount = 2
  // next:itemCount = 1
  Widget transform(BuildContext context, Widget page, bool isCurrentPage /* int index, int currentPage*/, double pageDelta/*, int itemCount*/,
      double screenW, double screenH);
}
