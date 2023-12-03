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
  // ignore: library_private_types_in_public_api
  _BlinkAnimationState createState() => _BlinkAnimationState();
}

class _BlinkAnimationState extends State<BlinkAnimation> with SingleTickerProviderStateMixin {
  static final _opacityTween = Tween<double>(begin: 0, end: 1);
  late Animation<double> animation;
  late AnimationController controller;

  _BlinkAnimationState();

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: animation,
        builder: (BuildContext context, Widget? child) {
          return Opacity(
            opacity: _opacityTween.evaluate(animation),
            child: widget.child,
          );
        });
  }

  @override
  dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  initState() {
    super.initState();
    int countBlink = widget.countBlink;
    controller = AnimationController(duration: Duration(milliseconds: widget.milliseconds), vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        countBlink--;
        if (countBlink != 0) {
          controller.forward();
        } else {
          controller.value = widget.hideAfterBlink ? 0 : 1;
          controller.stop(canceled: true);
        }
      }
      setState(() {});
    });
    controller.forward();
  }
}
