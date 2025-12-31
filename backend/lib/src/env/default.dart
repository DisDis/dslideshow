import 'dart:io';

import 'package:path/path.dart' as path;

final Directory externalStorage = new Directory(
  Platform.environment.containsKey("DSLIDESHOW_ROOT")
      ? Platform.environment["DSLIDESHOW_ROOT"]!
      : path.current,
);
