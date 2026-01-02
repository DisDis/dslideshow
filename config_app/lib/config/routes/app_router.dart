// ignore_for_file: prefer-match-file-name

import 'dart:async';

import 'package:config_app/features/app/presentation/pages/home_page.dart';
import 'package:config_app/features/app/presentation/pages/splash_page.dart';
import 'package:config_app/features/auth/presentation/bloc/authentication_bloc.dart';
import 'package:config_app/features/login/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:config_app/features/web_server_config/config/router.dart'
    as web_config;
import 'package:config_app/features/wifi_config/config/router.dart'
    as wifi_config;
import 'package:config_app/features/slideshow_config/config/router.dart'
    as slideshow_config;
import 'package:config_app/features/gallery/config/router.dart' as gallery;
import 'package:config_app/features/ota/config/router.dart' as ota;
import 'package:config_app/features/config/config/router.dart'
    as config;

const _defaultPath = '/splash';
const _loginPath = '/login';
const _homePath = '/home';

//TODO: Fix it
String _lastPath = _defaultPath;

// ignore: long-method
GoRouter createAppRouter(BuildContext context) {
  return GoRouter(
    //! TODO: Remove before release
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: _loginPath,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: _homePath,
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: '/',
        builder: (context, state) => const HomePage(),
      ),
      ota.createRoute(context),
      web_config.createRoute(context),
      wifi_config.createRoute(context),
      gallery.createRoute(context),
      slideshow_config.createRoute(context),
      config.createRoute(context),
      GoRoute(
        path: _defaultPath,
        builder: (context, state) => const SplashPage(),
      ),
    ],
    initialLocation: _lastPath /*_defaultPath*/,

    // redirect to the login page if the user is not logged in
    redirect: (BuildContext context, GoRouterState state) {
      final authState = context.read<AuthenticationBloc>().state;
      final location = state.uri.toString();
      if (location != _defaultPath &&
          authState is! AuthenticationAuthenticatedState) {
        return _loginPath;
      }
      if (authState is AuthenticationAuthenticatedState &&
          (location == _loginPath || location == _defaultPath)) {
        return _homePath;
      }
      _lastPath = location;
      return null;
    },

    // changes on the listenable will cause the router to refresh it's route
    refreshListenable:
        _GoRouterRefreshStream(context.read<AuthenticationBloc>().stream),
  );
}

class _GoRouterRefreshStream extends ChangeNotifier {
  _GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen(
          (dynamic _) => notifyListeners(),
        );
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
