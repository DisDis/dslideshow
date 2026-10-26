// ignore_for_file: prefer-match-file-name

import 'dart:async';

import 'package:config_app/features/app/presentation/pages/home_page.dart';
import 'package:config_app/features/app/presentation/pages/splash_page.dart';
import 'package:config_app/features/auth/presentation/bloc/authentication_bloc.dart';
import 'package:config_app/features/login/presentation/pages/login_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:config_app/features/power/config/router.dart' as web_config;
import 'package:config_app/features/wifi_config/config/router.dart'
    as wifi_config;
import 'package:config_app/features/gallery/config/router.dart' as gallery;
import 'package:config_app/features/ota/config/router.dart' as ota;
import 'package:config_app/features/config/config/router.dart' as config;
import 'package:config_app/features/upload/config/router.dart' as upload;
import 'package:config_app/features/device/config/router.dart' as device;
import 'package:config_app/features/device/presentation/pages/device_page.dart';

const _defaultPath = '/splash';
const _loginPath = '/login';
const _homePath = '/home';

// ignore: long-method
GoRouter createAppRouter(BuildContext context) {
  return _AppRouter(
    routes: [
      GoRoute(path: _loginPath, builder: (context, state) => const LoginPage()),
      GoRoute(path: _homePath, builder: (context, state) => const HomePage()),
      GoRoute(path: '/', builder: (context, state) => const HomePage()),
      device.createDeviceRoute(DeviceSection.telemetry),
      device.createDeviceRoute(DeviceSection.controls),
      ota.createRoute(context),
      web_config.createRoute(context),
      wifi_config.createRoute(context),
      gallery.createRoute(context),
      upload.createRoute(context),
      config.createRoute(context),
      GoRoute(
        path: _defaultPath,
        builder: (context, state) => const SplashPage(),
      ),
    ],
    initialLocation: _defaultPath,

    // redirect to the login page if the user is not logged in
    redirect: (BuildContext context, GoRouterState state) {
      final authState = context.read<AuthenticationBloc>().state;
      final location = state.uri.path;
      // There is no automatic session restoration. Read the current state on
      // the first parse as well: its initial status may predate the widget tree.
      if (authState is! AuthenticationAuthenticatedState) {
        return location == _loginPath ? null : _loginPath;
      }
      if (location == _loginPath || location == _defaultPath) {
        return _homePath;
      }
      return null;
    },

    // changes on the listenable will cause the router to refresh it's route
    refreshListenable: _GoRouterRefreshStream(
      context.read<AuthenticationBloc>().stream,
    ),
  );
}

/// Owns the authentication listener for exactly the lifetime of this router.
class _AppRouter extends GoRouter {
  factory _AppRouter({
    required List<RouteBase> routes,
    required String initialLocation,
    required GoRouterRedirect redirect,
    required _GoRouterRefreshStream refreshListenable,
  }) {
    final config = ValueNotifier(
      RoutingConfig(routes: routes, redirect: redirect),
    );
    return _AppRouter._(config, refreshListenable, initialLocation);
  }

  _AppRouter._(this._config, this._refresh, String initialLocation)
    : super.routingConfig(
        routingConfig: _config,
        refreshListenable: _refresh,
        initialLocation: initialLocation,
        debugLogDiagnostics: kDebugMode,
      );

  final ValueNotifier<RoutingConfig> _config;
  final _GoRouterRefreshStream _refresh;

  @override
  void dispose() {
    super.dispose();
    _refresh.dispose();
    _config.dispose();
  }
}

class _GoRouterRefreshStream extends ChangeNotifier {
  _GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.listen((dynamic _) => notifyListeners());
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
