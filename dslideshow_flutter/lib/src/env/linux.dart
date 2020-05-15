// export ENABLE_FLUTTER_DESKTOP=true
// debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
// flutter build linux --release
import 'dart:io';

import 'package:path/path.dart' as path;
export 'package:dslideshow_backend/environment.dart';

Future<Directory> getApplicationDocumentsDirectory() async {
  return new Directory(path.current);
}

Future<dynamic> checkPermissionReadExternalStorage() async {
  return true;
}
