// ignore_for_file: prefer-match-file-name

import 'package:config_app/features/config/presentation/pages/config_screen.dart';
import 'package:config_app/features/auth/presentation/bloc/authentication_bloc.dart';
import 'package:config_app/features/permission/domain/entities/permission.dart';
import 'package:config_app/features/permission/domain/services/permission_service.dart';
import 'package:config_app/features/uikit/presentation/widgets/navigation_bar/configapp_navigation_bar.dart';
import 'package:config_app/features/uikit/presentation/widgets/noaccess/noaccess_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class ConfigPages {
  final String value;
  const ConfigPages._(this.value);
  static const main = ConfigPages._("/config");
}

//ignore: avoid-unused-parameters
GoRoute createRoute(BuildContext context) {
  final permissionService = GetIt.instance.get<PermissionService>();
  final screenKey = GlobalKey<ConfigScreenState>();
  return GoRoute(
    path: ConfigPages.main.value,
    builder: (context, state) => permissionService.check(Permission.NONE)
        ? ConfigScreen(key: screenKey)
        : const NoAccessPage(drawerWidget: ConfigAppNavigationBar()),
    onExit: (context, state) {
      // Authentication redirects must be able to remove an expired session.
      // Explicit logout is confirmed by the drawer before authentication ends.
      final authentication = context.read<AuthenticationBloc?>();
      if (authentication != null &&
          authentication.state is! AuthenticationAuthenticatedState) {
        return true;
      }
      return screenKey.currentState?.confirmExit() ?? true;
    },

    //Sub routes
    // routes: <RouteBase>[
    //   GoRoute(
    //     path: 'tview',
    //     builder: (context, state) => permissionService.check(Permission.NONE)
    //         ? const TViewPage()
    //         : const NoAccessPage(
    //             drawerWidget: const ConfigAppNavigationBar(),
    //           ),
    //   ),
    // ],
  );
}
