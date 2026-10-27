import 'dart:convert';
import 'dart:io';

import 'package:dslideshow_backend/config.dart';

/// The saved configuration is separate from the configuration used by services
/// until the application is restarted.
class SavedConfigRepository {
  SavedConfigRepository(this._activeConfig)
    : _file = File(_activeConfig.fullConfigFilename);

  final AppConfig _activeConfig;
  final File _file;

  AppConfig load() {
    String content;
    try {
      content = _file.readAsStringSync();
    } on FileSystemException catch (error) {
      // A new installation can run with defaults before config.json exists.
      // Do not hide permissions, invalid paths or other read failures behind
      // an old configuration. ENOENT is the only allowed fallback.
      if (error.osError?.errorCode != 2) rethrow;
      // Unknown future screen options contain opaque JSON whose nested maps
      // are not copied by the generated model parser.
      return _parse(jsonEncode(_activeConfig.toJson()));
    }
    return _parse(content);
  }

  void save(String content) {
    // Parsing into a separate model also excludes the private filename from
    // input and keeps the active configuration untouched.
    final config = _parse(content);
    config.toFile(_file.path);
  }

  AppConfig _parse(String content) {
    final value = jsonDecode(content);
    if (value is! Map<String, dynamic>) {
      throw const FormatException('Configuration must be a JSON object');
    }
    return AppConfig.fromJson(value);
  }
}
