// ignore_for_file: prefer-match-file-name

import 'package:config_app/features/permission/domain/entities/permission.dart';
import 'package:config_app/features/permission/domain/services/permission_service.dart';
import 'package:config_app/features/uikit/presentation/widgets/navigation_bar/configapp_navigation_bar.dart';
import 'package:config_app/features/uikit/presentation/widgets/noaccess/noaccess_page.dart';
import 'package:config_app/features/wifi_config/presentation/pages/wifi_config_main_page.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class WiFiConfigPages {
  final String value;
  const WiFiConfigPages._(this.value);
  static const main = WiFiConfigPages._("/wifi_config");
}

//ignore: avoid-unused-parameters
GoRoute createRoute(BuildContext context) {
  final permissionService = GetIt.instance.get<PermissionService>();
  return GoRoute(
    path: WiFiConfigPages.main.value,
    builder: (context, state) => permissionService.check(Permission.NONE)
        ? const WiFiConfigMainPage()
        : const NoAccessPage(
            drawerWidget: ConfigAppNavigationBar(),
          ),

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
