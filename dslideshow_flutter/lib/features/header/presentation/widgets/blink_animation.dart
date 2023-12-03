import 'package:dslideshow_flutter/features/header/presentation/widgets/common_header.dart';
import 'package:flutter/material.dart';

class BlinkAnimation extends StatefulWidget {
  final int countBlink;
  final int milliseconds;
  final Widget child;
  final bool hideAfterBlink;

  const BlinkAnimation({
    super.key,
    this.countBlink = 3,
    this.milliseconds = 1500,
    required this.child,
    this.hideAfterBlink = true,
  });
  @override
  BlinkAnimationState createState() => BlinkAnimationState();
}
