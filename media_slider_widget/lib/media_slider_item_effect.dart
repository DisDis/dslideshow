import 'package:flutter/material.dart';

abstract class MediaSliderItemEffect {
  Widget transform(BuildContext context, Widget page, int index, int currentPage, double pageDelta, int itemCount);
}
