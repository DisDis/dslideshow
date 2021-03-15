import 'dart:io';

// import 'package:permission_handler/permission_handler.dart';
// import 'package:path_provider/path_provider.dart' as path_prov;

final bool isLinuxEmbedded = false;

// Future<Directory> getApplicationDocumentsDirectory() async{
//   return path_prov.getApplicationDocumentsDirectory();
// }
//
// Future<bool> checkPermissionReadExternalStorage() async{
//   var status = await Permission.storage.status;
//   if (status.isUndetermined) {
//     // We didn't ask for permission yet.
//     status = await Permission.storage.request();
//   }
//   return status == PermissionStatus.granted;
// }
