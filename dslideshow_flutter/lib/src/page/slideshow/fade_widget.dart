import 'package:flutter/material.dart';

class FadeWidget extends AnimatedWidget {
  static final _opacityTween = Tween<double>(begin: 0, end: 1);

  const FadeWidget({Key? key, required Animation<double> animation}) : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable as Animation<double>;
    return Center(
      child: Opacity(
        opacity: _opacityTween.evaluate(animation),
        child: Container(
          color: Colors.black,
        ),
      ),
    );
  }
}
