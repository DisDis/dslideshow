import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FadeWidget extends AnimatedWidget {
  static final _opacityTween = Tween<double>(begin: 0, end: 1);

  FadeWidget({Key key, Animation<double> animation}) : super(key: key, listenable: animation);

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
