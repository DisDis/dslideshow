import 'package:flutter/material.dart';

class FadeWidget extends AnimatedWidget {
  const FadeWidget({super.key, required Animation<double> animation}) : super(listenable: animation);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable as Animation<double>;
    return Center(
      child: FadeTransition(
        opacity: animation,
        child: Container(
          color: Colors.black,
        ),
      ),
    );
  }
}
