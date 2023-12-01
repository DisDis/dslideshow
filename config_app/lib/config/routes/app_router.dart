// ignore_for_file: prefer-match-file-name

import 'dart:async';

import 'package:config_app/features/app/presentation/pages/home_page.dart';
import 'package:config_app/features/app/presentation/pages/splash_page.dart';
import 'package:config_app/features/auth/presentation/bloc/authentication_bloc.dart';
import 'package:config_app/features/login/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// import 'package:wa_chat/config/routes/router.dart' as chat;

const _defaultPath = '/splash';
const _loginPath = '/login';

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
        path: '/home',
        builder: (context, state) => const HomePage(),
      ),
      // chat.createRoute(context),
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
      if (location != _defaultPath && authState is! AuthenticationAuthenticatedState) {
        return _loginPath;
      }
      if (authState is AuthenticationAuthenticatedState && (location == _loginPath || location == _defaultPath)) {
        return '/home';
      }
      _lastPath = location;
      return null;
    },

    // changes on the listenable will cause the router to refresh it's route
    refreshListenable: _GoRouterRefreshStream(context.read<AuthenticationBloc>().stream),
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
