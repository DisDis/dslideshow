import 'package:config_app/features/device/presentation/pages/device_page.dart';
import 'package:config_app/features/permission/domain/entities/permission.dart';
import 'package:config_app/features/permission/domain/services/permission_service.dart';
import 'package:config_app/features/uikit/presentation/widgets/navigation_bar/configapp_navigation_bar.dart';
import 'package:config_app/features/uikit/presentation/widgets/noaccess/noaccess_page.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

GoRoute createDeviceRoute(DeviceSection section) => GoRoute(
  path: section == DeviceSection.telemetry ? '/telemetry' : '/device_control',
  builder: (context, state) =>
      GetIt.instance.get<PermissionService>().check(Permission.NONE)
      ? DevicePage(section: section)
      : const NoAccessPage(drawerWidget: ConfigAppNavigationBar()),
);
