import 'dart:io';

Future<Directory> getApplicationDocumentsDirectory() {
  throw UnimplementedError();
}

Future<bool> checkPermissionReadExternalStorage() {
  throw UnimplementedError();
}

final bool isLinuxEmbedded =
    Platform.environment['DSLIDESHOW_EMBEDDED'] == 'true';
