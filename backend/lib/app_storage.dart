import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:logging/logging.dart';
import 'package:path/path.dart' as path;

class AppStorage {
  static const String STORAGE_FILE = "storage.json";
  static final Logger _log = new Logger('AppStorage');
  Map<String, dynamic>? _storage;
  final File _storageFile;
  Timer? _saveTimer;

  AppStorage([String? rootPath])
    : this._storageFile = new File(
        rootPath != null
            ? path.join(rootPath, AppStorage.STORAGE_FILE)
            : AppStorage.STORAGE_FILE,
      ) {
    load();
  }

  void load() {
    _log.info('load');
    String configStr;
    if (!_storageFile.existsSync()) {
      _log.fine('Not found storage file "$_storageFile"');
      configStr = '{}';
    } else {
      configStr = _storageFile.readAsStringSync();
    }
    try {
      _storage = json.decode(configStr) as Map<String, dynamic>?;
    } catch (e, st) {
      _log.severe("Storage.json", e, st);
      _storage = <String, dynamic>{};
    }
    _log.info("Storage loaded");
  }

  void save() {
    _log.info('save');
    if (_saveTimer != null) {
      _saveTimer!.cancel();
      _saveTimer = null;
    }
    String contents = json.encode(_storage);
    _storageFile.writeAsStringSync(contents);
    _log.info("Storage saved");
  }

  /// Autosave every 10 sec
  void setValue<T>(String key, T value) {
    _storage![key] = value;
    if (_saveTimer == null) {
      _saveTimer = new Timer(new Duration(seconds: 10), () {
        save();
      });
    }
  }

  T getValue<T>(String field, [T? defaultValue]) {
    var value = _storage![field] as T?;
    if (value == null) {
      if (defaultValue == null) {
        throw new Exception('Field "$field" not set.');
      }
      return defaultValue;
    }
    return value;
  }

  dynamic getRaw(String field) => _storage![field];

  int getInt(String field, int defaultValue) {
    dynamic value = getRaw(field);
    if (value == null) {
      _log.fine('Field "$field" not set. Set default value: "$defaultValue"');
      return defaultValue;
    }
    if (value is int) {
      return value;
    }
    final valueO = int.tryParse(value as String);
    if (valueO == null) {
      _log.fine(
        'Could not parse value "$value" (field "$field") into a number.',
      );
      return defaultValue;
    } else {
      return valueO;
    }
  }
}
