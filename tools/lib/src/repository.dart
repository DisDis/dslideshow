import 'dart:io';

import 'package:cli_util/cli_util.dart' as cli;
import 'package:path/path.dart' as p;

/// Finds the checkout from an explicit location, override, or executable.
Directory findRepository({String? start}) {
  final override = start ?? Platform.environment['DSLIDESHOW_REPO'];
  final locations = override != null ? [override] : [p.dirname(Platform.script.toFilePath()), Directory.current.path];
  for (final location in locations) {
    var directory = Directory(location).absolute;
    while (true) {
      if (Directory(p.join(directory.path, 'deb_factory')).existsSync() &&
          Directory(p.join(directory.path, 'dslideshow_flutter')).existsSync()) {
        return directory;
      }
      final parent = directory.parent;
      if (parent.path == directory.path) break;
      directory = parent;
    }
  }
  throw StateError('Cannot locate DSlideshow checkout; specify DSLIDESHOW_REPO');
}

/// Resolves the SDK command frontend, including when this tool itself is AOT.
String findDartExecutable() {
  final override = Platform.environment['DART_EXECUTABLE'] ?? Platform.environment['DSLIDESHOW_DART'];
  if (override != null && override.isNotEmpty) return override;
  final sdk = cli.sdkPath;
  if (sdk == null) return cli.dartExecutable ?? 'dart';
  final executable = p.join(sdk, 'bin', Platform.isWindows ? 'dart.exe' : 'dart');
  if (!File(executable).existsSync()) throw StateError('Dart SDK command is unavailable');
  return executable;
}
