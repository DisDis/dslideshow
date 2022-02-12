import 'dart:io';

import 'package:path/path.dart' as path;
export 'package:dslideshow_backend/environment.dart';

final bool isLinuxEmbedded =
    Platform.environment['DSLIDESHOW_EMBEDDED'] == 'true';

Directory? _appDocumentsDirectory;

Future<Directory> getApplicationDocumentsDirectory() async {
  return _appDocumentsDirectory ??= new Directory(
      Platform.environment.containsKey("DSLIDESHOW_ROOT")
          ? Platform.environment["DSLIDESHOW_ROOT"]!
          : path.current);
}

Future<bool> checkPermissionReadExternalStorage() async {
  return true;
}
