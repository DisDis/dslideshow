// export ENABLE_FLUTTER_DESKTOP=true
// debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
// run ./build_linux

import 'dart:io';

import 'package:path/path.dart' as path;
export 'package:dslideshow_backend/environment.dart';

final bool isLinuxEmbedded = true;

Future<Directory> getApplicationDocumentsDirectory() async {
  return new Directory(path.current);
}

Future<bool> checkPermissionReadExternalStorage() async {
  return true;
}
