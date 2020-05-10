// export ENABLE_FLUTTER_DESKTOP=true
// debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
// flutter build linux --release
import 'dart:io';

import 'package:path/path.dart' as path;

Future<Directory> getApplicationDocumentsDirectory() async {
  return new Directory(path.current);
}

Future<dynamic> checkPermissionReadExternalStorage() async {
  return true;
}

final Directory externalStorage = new Directory(path.current);
