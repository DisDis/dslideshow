import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_flutter/environment.dart' as environment;
import 'package:dslideshow_flutter/src/injector.dart';
import 'package:dslideshow_common/version.dart';
import 'package:dslideshow_flutter/src/route_bloc.dart';
import 'package:dslideshow_flutter/src/service/frontend.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

class AnimatedLogo extends AnimatedWidget {
  // Make the Tweens static because they don't change.
  static final _opacityTween = Tween<double>(begin: 0, end: 1);

//  static final _sizeTween = Tween<double>(begin: 20, end: 50);

  final String text;
  final double size;

  const AnimatedLogo(this.text, this.size, {Key? key, required Animation<double> animation}) : super(key: key, listenable: animation);

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

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> with SingleTickerProviderStateMixin {
  static final Logger _log = Logger('_WelcomePageState');
  late Animation<double> animation;
  late AnimationController controller;
  final FrontendService _frontendService = injector.get<FrontendService>();
  final AppConfig _appConfig = injector.get<AppConfig>();
  final List<StreamSubscription> _subs = <StreamSubscription>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: AnimatedLogo(
          _appConfig.welcome.text,
          _appConfig.welcome.size,
          animation: animation,
        ));
  }

  @override
  void dispose() {
    controller.dispose();
    for (var element in _subs) {
      element.cancel();
    }
    _subs.clear();
    super.dispose();
  }

  @override
  void initState() {
    _log.info("initState");
    super.initState();
    var future = environment.checkPermissionReadExternalStorage();
    controller = AnimationController(duration: Duration(milliseconds: _appConfig.welcome.delayMs), vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller.stop();
          _frontendService.backendIsReady().then((dynamic _) {
            future.then((dynamic _) => context.read<RouteBloc>().add(ChangePageEvent(RoutePage.slideshow)));
          });
        }
      });
    controller.forward();
  }
}
