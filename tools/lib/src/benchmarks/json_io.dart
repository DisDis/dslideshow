import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as p;

final _jsonNumber = RegExp(r'-?(?:0|[1-9][0-9]*)(?:\.[0-9]+)?(?:[eE][+-]?[0-9]+)?');

/// Strict JSON at report boundaries: duplicate names and non-finite values fail.
dynamic decodeStrictJson(String source) => _StrictJson(source).read();

class _StrictJson {
  _StrictJson(this.source);
  final String source;
  int offset = 0;
  int depth = 0;

  dynamic read() {
    final result = value();
    whitespace();
    if (offset != source.length) invalid('trailing JSON data');
    return result;
  }

  Never invalid(String message) => throw FormatException(message, source, offset);
  void whitespace() {
    while (offset < source.length && const [9, 10, 13, 32].contains(source.codeUnitAt(offset))) {
      offset++;
    }
  }

  dynamic value() {
    whitespace();
    if (++depth > 256) invalid('JSON nesting exceeds 256');
    try {
      if (offset >= source.length) invalid('incomplete JSON');
      switch (source[offset]) {
        case '{':
          offset++;
          final result = <String, dynamic>{};
          whitespace();
          if (take('}')) return result;
          do {
            whitespace();
            if (offset >= source.length || source[offset] != '"') invalid('object key expected');
            final key = string();
            if (result.containsKey(key)) invalid('duplicate JSON key $key');
            whitespace();
            if (!take(':')) invalid('colon expected');
            result[key] = value();
            whitespace();
            if (take('}')) return result;
          } while (take(','));
          invalid('object separator expected');
        case '[':
          offset++;
          final result = <dynamic>[];
          whitespace();
          if (take(']')) return result;
          do {
            result.add(value());
            whitespace();
            if (take(']')) return result;
          } while (take(','));
          invalid('array separator expected');
        case '"':
          return string();
        default:
          for (final literal in const ['true', 'false', 'null']) {
            if (source.startsWith(literal, offset)) {
              offset += literal.length;
              return literal == 'true'
                  ? true
                  : literal == 'false'
                  ? false
                  : null;
            }
          }
          final match = _jsonNumber.matchAsPrefix(source, offset);
          if (match == null) invalid('invalid JSON value');
          offset = match.end;
          final token = match.group(0)!;
          if (!token.contains('.') && !token.contains('e') && !token.contains('E')) {
            return int.tryParse(token) ?? BigInt.parse(token);
          }
          final number = num.tryParse(token);
          if (number == null || !number.isFinite) invalid('non-finite JSON number');
          return number;
      }
    } finally {
      depth--;
    }
  }

  bool take(String char) {
    if (offset < source.length && source[offset] == char) {
      offset++;
      return true;
    }
    return false;
  }

  String string() {
    final start = offset++;
    var escaped = false;
    while (offset < source.length) {
      final char = source[offset++];
      if (!escaped && char == '"') return jsonDecode(source.substring(start, offset)) as String;
      if (!escaped && char == '\\') {
        escaped = true;
      } else {
        escaped = false;
      }
    }
    invalid('unterminated string');
  }
}

Map<String, dynamic> asMap(dynamic value) => value is Map ? Map<String, dynamic>.from(value) : <String, dynamic>{};
List<dynamic> asList(dynamic value) => value is List ? value : <dynamic>[];
bool numeric(dynamic value, {bool positive = false}) =>
    value is num && value.isFinite && (positive ? value > 0 : value >= 0);
bool integer(dynamic value, {bool positive = false}) => value is int && (positive ? value > 0 : value >= 0);
bool truth(dynamic value) =>
    value != null &&
    value != false &&
    value != '' &&
    value != 0 &&
    !(value is Iterable && value.isEmpty) &&
    !(value is Map && value.isEmpty);

String canonical(dynamic value) {
  dynamic sorted(dynamic item) {
    if (item is Map) {
      final keys = item.keys.cast<String>().toList()..sort();
      return {for (final key in keys) key: sorted(item[key])};
    }
    if (item is List) return item.map(sorted).toList();
    return item;
  }

  return encodeReportJson(sorted(value));
}

Map<String, dynamic> readJson(File file, List<String> diagnostics, {bool required = true}) {
  try {
    final result = decodeStrictJson(file.readAsStringSync());
    if (result is! Map<String, dynamic>) throw const FormatException('expected a JSON object');
    return result;
  } on Object catch (error) {
    if (required || file.existsSync()) diagnostics.add('${file.path}: ${error.runtimeType}');
    return {};
  }
}

List<Map<String, dynamic>> readJsonLines(File file, List<String> diagnostics, {bool required = true}) {
  final result = <Map<String, dynamic>>[];
  try {
    var number = 0;
    for (final bytes in _rawLines(file)) {
      number++;
      try {
        final line = utf8.decode(bytes);
        if (line.trim().isEmpty) continue;
        final row = decodeStrictJson(line);
        if (row is! Map<String, dynamic>) throw const FormatException('expected a JSON object');
        result.add(row);
      } on Object catch (error) {
        diagnostics.add('${file.path}:$number: invalid JSONL: ${error.runtimeType}');
      }
    }
  } on FileSystemException {
    if (required) diagnostics.add('${file.path}: missing/unreadable JSONL');
  }
  return result;
}

void writeJson(File file, dynamic value) {
  file.parent.createSync(recursive: true);
  file.writeAsStringSync('${encodeReportJson(value, indent: '  ')}\n');
}

List<File> filesBelow(Directory directory, {String? name}) {
  if (!directory.existsSync()) return [];
  return (directory
      .listSync(recursive: true, followLinks: false)
      .whereType<File>()
      .where((file) => name == null || p.basename(file.path) == name)
      .toList()
    ..sort((a, b) => a.path.compareTo(b.path)));
}

Iterable<List<int>> _rawLines(File file) sync* {
  final handle = file.openSync();
  var pending = <int>[];
  try {
    while (true) {
      final chunk = handle.readSync(65536);
      if (chunk.isEmpty) break;
      var start = 0;
      for (var i = 0; i < chunk.length; i++) {
        if (chunk[i] == 10) {
          yield [...pending, ...chunk.sublist(start, i)];
          pending = [];
          start = i + 1;
        }
      }
      pending.addAll(chunk.sublist(start));
    }
    if (pending.isNotEmpty) yield pending;
  } finally {
    handle.closeSync();
  }
}

/// Preserve arbitrary-size JSON integers without converting them to doubles/strings.
String encodeReportJson(dynamic value, {String? indent}) {
  String encode(dynamic item, int depth) {
    if (item is BigInt) return item.toString();
    if (item is Map || item is List) {
      final map = item is Map;
      final values = map
          ? (item).entries
                .map((e) => jsonEncode(e.key) + (indent == null ? ':' : ': ') + encode(e.value, depth + 1))
                .toList()
          : (item as List).map((e) => encode(e, depth + 1)).toList();
      final open = map ? '{' : '[', close = map ? '}' : ']';
      if (values.isEmpty) return open + close;
      if (indent == null) return open + values.join(',') + close;
      final padding = List.filled(depth + 1, indent).join(), ending = List.filled(depth, indent).join();
      return '$open\n$padding${values.join(',\n$padding')}\n$ending$close';
    }
    return jsonEncode(item);
  }

  return encode(value, 0);
}
