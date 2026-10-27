import 'dart:convert';

import 'package:dslideshow_backend/config.dart';

/// Copy nested JSON so the editable draft stays independent of saved settings.
AppConfig cloneConfig(AppConfig value) => AppConfig.fromJson(
  jsonDecode(jsonEncode(value.toJson())) as Map<String, dynamic>,
);

/// An in-memory draft. Secrets are never persisted in browser storage.
class ConfigDraft {
  AppConfig? _value;
  String? _savedJson;
  String? _savedFingerprint;

  AppConfig? get value => _value;

  bool get hasChanges {
    final value = _value;
    if (value == null) return false;
    try {
      return _fingerprint(value) != _savedFingerprint;
    } on JsonUnsupportedObjectError {
      // Invalid numeric input must remain an unsaved draft, not defeat the
      // navigation guard. Save will report its serialization error separately.
      return true;
    }
  }

  void replaceSaved(AppConfig config) {
    final snapshot = jsonEncode(config.toJson());
    final copy = AppConfig.fromJson(
      jsonDecode(snapshot) as Map<String, dynamic>,
    );
    _savedJson = snapshot;
    _savedFingerprint = _fingerprint(copy);
    _value = copy;
  }

  void discard() {
    final saved = _savedJson;
    if (saved != null) {
      _value = AppConfig.fromJson(jsonDecode(saved) as Map<String, dynamic>);
    }
  }
}

String _fingerprint(AppConfig config) =>
    jsonEncode(_orderedJson(config.toStorageJson()));

Object? _orderedJson(Object? value) => switch (value) {
  Map<String, dynamic>() => <String, Object?>{
    for (final key in value.keys.toList()..sort())
      key: _orderedJson(value[key]),
  },
  List() => value.map(_orderedJson).toList(),
  _ => value,
};
