// export ENABLE_FLUTTER_DESKTOP=true
// debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
// run ./build_linux

import 'dart:io';

export 'package:dslideshow_backend/environment.dart';

final bool isLinuxEmbedded = Platform.environment['DSLIDESHOW_EMBEDDED'] == 'true';

// Future<Directory> getApplicationDocumentsDirectory() async {
//   return new Directory(path.current);
// }
//
// Future<bool> checkPermissionReadExternalStorage() async {
//   return true;
// }