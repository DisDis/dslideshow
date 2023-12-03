import 'package:dslideshow_common/version.dart';
import 'package:flutter/material.dart';

class AnimatedLogo extends AnimatedWidget {
  // Make the Tweens static because they don't change.
  static final _opacityTween = Tween<double>(begin: 0, end: 1);

//  static final _sizeTween = Tween<double>(begin: 20, end: 50);

  final String text;
  final double size;

  const AnimatedLogo(this.text, this.size, {super.key, required Animation<double> animation}) : super(listenable: animation);

  // String get welcomeText {
  //   return intl.Intl.message(
  //     'Welcome',
  //     name: 'welcomeText',
  //     desc: 'Welcome text in First screen',
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable as Animation<double>;
    return Center(
      child: Opacity(
        opacity: _opacityTween.evaluate(animation),
        child: Column(
          children: <Widget>[
            const Text("front: v${ApplicationInfo.frontendVersion}",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontStyle: FontStyle.italic,
                )),
            const Text("back: v${ApplicationInfo.backendVersion}",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontStyle: FontStyle.italic,
                )),
            Expanded(
                child: Center(
                    child: Text(
              text,
              style: TextStyle(color: Colors.white, fontSize: size),
              textAlign: TextAlign.center,
            ))),
          ],
        ),
      ),
    );
  }
}
