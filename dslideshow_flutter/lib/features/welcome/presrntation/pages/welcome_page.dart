import 'dart:async';

import 'package:dslideshow_flutter/features/welcome/presrntation/widgets/animated_logo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_flutter/environment.dart' as environment;
import 'package:dslideshow_flutter/src/injector.dart';
import 'package:dslideshow_flutter/src/route_bloc.dart';
import 'package:dslideshow_flutter/src/service/frontend.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> with SingleTickerProviderStateMixin {
  static final Logger _log = Logger('WelcomePageState');
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
    final bloc = context.read<RouteBloc>();
    var future = environment.checkPermissionReadExternalStorage();
    controller = AnimationController(duration: Duration(milliseconds: _appConfig.welcome.delayMs), vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller.stop();
          _frontendService.backendIsReady().then((dynamic _) {
            future.then((dynamic _) => bloc.add(ChangePageEvent(RoutePage.slideshow)));
          });
        }
      });
    controller.forward();
  }
}
