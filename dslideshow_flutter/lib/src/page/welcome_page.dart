import 'package:dslideshow_flutter/environment.dart' as environment;
import 'package:dslideshow_flutter/src/injector.dart';
import 'package:dslideshow_flutter/src/service/frontend.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart' as intl;
import 'package:package_info/package_info.dart';

class AnimatedLogo extends AnimatedWidget {
  // Make the Tweens static because they don't change.
  static final _opacityTween = Tween<double>(begin: 0, end: 1);
//  static final _sizeTween = Tween<double>(begin: 20, end: 50);

  AnimatedLogo({Key key, Animation<double> animation}) : super(key: key, listenable: animation);

  String get welcomeText {
    return intl.Intl.message(
      'Welcome',
      name: 'welcomeText',
      desc: 'Welcome text in First screen',
    );
  }

  Widget build(BuildContext context) {
    final Animation<double> animation = listenable as Animation<double>;
    return Center(
      child: Opacity(
        opacity: _opacityTween.evaluate(animation),
        child: Container(
//          margin: EdgeInsets.symmetric(vertical: 10),
//          height: _sizeTween.evaluate(animation),
//          width: _sizeTween.evaluate(animation),
          child:
//          new Directionality(
//              textDirection: TextDirection.ltr,
//              child:
              Column(
            children: <Widget>[
              Text(
                welcomeText,
                style: TextStyle(color: Colors.white, fontSize: 50),
              ),
              FutureBuilder<PackageInfo>(
                  future: PackageInfo.fromPlatform(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Text("v${snapshot.data.version}#${snapshot.data.buildNumber}",
                          style: TextStyle(color: Colors.white, fontSize: 25));
                    }
                    return new Container();
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

class WelcomePage extends StatefulWidget {
  _WelcomePageState createState() => _WelcomePageState();
}

/*
 Container(
      color: Colors.black,
      child: new Directionality(
          textDirection: TextDirection.ltr,
          child: Column(
            children: <Widget>[
              Text('Welcome',style: TextStyle(color: Colors.white, fontSize: 50),)
            ],
          )
      ));
*/

class _WelcomePageState extends State<WelcomePage> with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;
  final FrontendService _frontendService = injector.get(FrontendService) as FrontendService;

  @override
  Widget build(BuildContext context) => AnimatedLogo(animation: animation);

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    var future = environment.checkPermissionReadExternalStorage();

    controller = AnimationController(duration: const Duration(seconds: 2), vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller.stop();
          _frontendService.backendIsReady().then((dynamic _){
            future.then((dynamic _) => Navigator.pushReplacementNamed(context, '/slideshow'));
          });
        }
      });
    controller.forward();
  }
}
