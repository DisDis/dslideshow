import 'package:path/path.dart' as path;

/// Yandex resource paths are POSIX paths even when the panel runs on Windows.
class YandexDrivePaths {
  static final _account = RegExp(r'^[0-9]{1,32}$');
  static final _control = RegExp(r'[\x00-\x1f\x7f]');

  static bool validAccountId(String value) => _account.hasMatch(value);

  static String normalize(String value) {
    final text = value.startsWith('disk:') ? value.substring(5) : value;
    if (!text.startsWith('/') || text.length > 4096 || text.contains('\\') || _control.hasMatch(text)) {
      throw const FormatException('Invalid Yandex resource path');
    }
    final parts = text.split('/');
    if (parts.any((part) => part == '.' || part == '..')) {
      throw const FormatException('Invalid Yandex resource path');
    }
    return 'disk:${path.posix.normalize(text)}';
  }

  static String relative(String remotePath, String accountId) {
    if (!validAccountId(accountId)) throw const FormatException('Invalid Yandex account ID');
    final normalized = normalize(remotePath);
    if (normalized == 'disk:/') throw const FormatException('A file path is required');
    return path.posix.join('yandex.drive.$accountId', normalized.substring(6));
  }

  static bool contains(String directory, String resource) {
    final base = normalize(directory);
    final candidate = normalize(resource);
    return base == 'disk:/' || candidate == base || candidate.startsWith('$base/');
  }

  static List<String> distinctRoots(Iterable<String> values) {
    final sorted = values.map(normalize).toSet().toList()..sort();
    final roots = <String>[];
    for (final value in sorted) {
      if (!roots.any((root) => contains(root, value))) roots.add(value);
    }
    return roots;
  }
}
