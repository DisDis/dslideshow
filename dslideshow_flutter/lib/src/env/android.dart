import 'dart:io';

import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart' as path_prov;
export 'package:dslideshow_backend/environment.dart';

Future<Directory> getApplicationDocumentsDirectory() {
  return path_prov.getApplicationDocumentsDirectory();
}

Future<dynamic> checkPermissionReadExternalStorage() async {
  var status = await Permission.storage.status;
  if (status.isUndetermined) {
    // We didn't ask for permission yet.
    status = await Permission.storage.request();
  }
  return status == PermissionStatus.granted;
//  var isOk =
//      await SimplePermissions.checkPermission(Permission.ReadExternalStorage);
//  if (!isOk) {
//    return SimplePermissions.requestPermission(Permission.ReadExternalStorage);
//  }
//  return new Future<dynamic>.value(PermissionStatus.authorized);
}
