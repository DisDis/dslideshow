import 'dart:io';

import 'package:simple_permissions/simple_permissions.dart';
import 'package:path_provider/path_provider.dart' as path_prov;

Future<Directory> getApplicationDocumentsDirectory() {
  return path_prov.getApplicationDocumentsDirectory();
}

Future<dynamic> checkPermissionReadExternalStorage() async {
  var isOk =
      await SimplePermissions.checkPermission(Permission.ReadExternalStorage);
  if (!isOk) {
    return SimplePermissions.requestPermission(Permission.ReadExternalStorage);
  }
  return new Future<dynamic>.value(PermissionStatus.authorized);
}

//'/data/user/0/com.home.dslideshow_flutter/app_flutter'
final Directory externalStorage = new Directory('/storage/emulated/0/');