import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:logging/logging.dart';
import 'package:path/path.dart' as path;

class AppStorage {
  static const String STORAGE_FILE = "storage.json";
  static final Logger _log = new Logger('AppStorage');
  Map<String, dynamic> _storage = <String, dynamic>{};
  final File _storageFile;
  Timer? _saveTimer;

  AppStorage([String? rootPath])
    : this._storageFile = new File(
        rootPath != null ? path.join(rootPath, AppStorage.STORAGE_FILE) : AppStorage.STORAGE_FILE,
      ) {
    load();
  }

  void load() {
    _log.info('load started');
    final String configStr;
    try {
      configStr = _storageFile.existsSync() ? _storageFile.readAsStringSync() : '{}';
    } catch (error) {
      _log.warning(
        'load failed '
        'type=${error.runtimeType}',
      );
      rethrow;
    }
    try {
      final decoded = json.decode(configStr);
      if (decoded is! Map<String, dynamic>) {
        throw const FormatException('Expected a JSON object');
      }
      _storage = decoded;
    } catch (error) {
      // FormatException can include the document itself. Keep diagnostics safe.
      _log.warning(
        'load failed '
        'type=${error.runtimeType} recovery=empty',
      );
      _storage = <String, dynamic>{};
    }
    _log.info(
      'load completed '
      'keys=${_storage.length}',
    );
  }

  void save() {
    _log.info('save started');
    if (_saveTimer != null) {
      _saveTimer!.cancel();
      _saveTimer = null;
    }
    try {
      final contents = json.encode(_storage);
      _storageFile.writeAsStringSync(contents);
    } catch (error) {
      _log.warning(
        'save failed '
        'type=${error.runtimeType}',
      );
      rethrow;
    }
    _log.info(
      'save completed '
      'keys=${_storage.length}',
    );
  }

  /// Autosave every 10 sec
  void setValue<T>(String key, T value) {
    _storage[key] = value;
    if (_saveTimer == null) {
      _saveTimer = new Timer(new Duration(seconds: 10), () {
        save();
      });
    }
  }

  T getValue<T>(String field, [T? defaultValue]) {
    var value = _storage[field] as T?;
    if (value == null) {
      if (defaultValue == null) {
        throw new Exception('Field "$field" not set.');
      }
      return defaultValue;
    }
    return value;
  }

  dynamic getRaw(String field) => _storage[field];

  int getInt(String field, int defaultValue) {
    dynamic value = getRaw(field);
    if (value == null) {
      _log.fine('Integer field missing; using default');
      return defaultValue;
    }
    if (value is int) {
      return value;
    }
    final valueO = int.tryParse(value as String);
    if (valueO == null) {
      _log.fine('Invalid integer field; using default');
      return defaultValue;
    } else {
      return valueO;
    }
  }
}
