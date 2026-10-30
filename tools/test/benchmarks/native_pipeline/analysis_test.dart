import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dslideshow_tools/src/benchmarks/native_pipeline/analyze.dart';
import 'package:dslideshow_tools/src/benchmarks/native_pipeline/binary.dart';
import 'package:path/path.dart' as p;
import 'package:test/test.dart';

Object? semantic(Object? value, String root, [String? key]) {
  if (value is Map) {
    return {for (final entry in value.entries) entry.key: semantic(entry.value, root, entry.key as String)};
  }
  if (value is List) {
    // Diagnostics are observable through scope/completeness and their count;
    // language-specific exception messages are deliberately not API strings.
    if (['diagnostics', 'cleanup_errors'].contains(key)) {
      return value.length;
    }
    return value.map((v) => semantic(v, root)).toList();
  }
  return value is String ? value.replaceAll(root, r'$ROOT').replaceAll('None', 'null') : value;
}

void compare(Object? actual, Object? expected, [String location = r'$']) {
  if (actual is num && expected is num) {
    expect(actual, closeTo(expected, expected.abs() * 1e-12 + 1e-10), reason: location);
  } else if (actual is Map && expected is Map) {
    expect(actual.keys.toSet(), expected.keys.toSet(), reason: location);
    for (final key in expected.keys) {
      compare(actual[key], expected[key], '$location.$key');
    }
  } else if (actual is List && expected is List) {
    expect(actual.length, expected.length, reason: location);
    for (var i = 0; i < expected.length; i++) {
      compare(actual[i], expected[i], '$location[$i]');
    }
  } else {
    expect(actual, expected, reason: location);
  }
}

void main() {
  final corpus = jsonDecode(
    File('test/benchmarks/native_pipeline/fixtures/analysis_vectors.json').readAsStringSync(),
  ) as Map<String, dynamic>;
  final vectors = corpus['vectors'] as List<dynamic>;
  for (final (index, raw) in vectors.indexed) {
    test('native diagnostic behavior vector $index', () {
      final vector = Map<String, dynamic>.from(raw as Map);
      final root = Directory.systemTemp.createTempSync('native-analysis-');
      addTearDown(() => root.deleteSync(recursive: true));
      for (final entry in (vector['files'] as Map<String, dynamic>).entries) {
        final file = File(p.join(root.path, entry.key));
        file.parent.createSync(recursive: true);
        file.writeAsBytesSync(base64Decode(entry.value as String));
      }
      final actual = analyzePipeline(
        p.join(root.path, vector['collection'] as String),
        p.join(root.path, vector['native'] as String),
        p.join(root.path, vector['trace'] as String),
        includeWarmup: vector['include_warmup'] as bool,
        expectedEngine: vector['expected_engine'] as String?,
      );
      actual.remove('notes');
      compare(semantic(actual, root.path), semantic(vector['expected'], root.path));
      final rendered = renderPipeline({...actual, 'notes': <String>[]});
      expect(rendered, contains('Performance acceptance: not assessed'));
    });
  }
  test('union clips overlapping intervals without double counting', () {
    expect(unionNs([(1, 5), (3, 7), (9, 12)], start: 2, end: 10), 6);
  });
  test('truncated and invalid native headers remain explicit diagnostics', () {
    final root = Directory.systemTemp.createTempSync('native-header-');
    addTearDown(() => root.deleteSync(recursive: true));
    final file = File(p.join(root.path, 'calls.bin'))..writeAsBytesSync([1, 2]);
    final result = readNative(file.path);
    expect(result['complete'], false);
    expect(result['diagnostics'], isNotEmpty);
  });
  test('uint64 argument bits retain all sixteen hexadecimal digits', () {
    final root = Directory.systemTemp.createTempSync('native-uint64-');
    addTearDown(() => root.deleteSync(recursive: true));
    final files = (vectors.first as Map<String, dynamic>)['files'] as Map<String, dynamic>;
    final raw = base64Decode(files['calls.bin'] as String);
    ByteData.sublistView(raw).setUint64(128 + 64, -1, Endian.little);
    final file = File(p.join(root.path, 'calls.bin'))..writeAsBytesSync(raw);
    final result = readNative(file.path);
    expect(
      (((result['calls'] as List<dynamic>).first as Map<String, dynamic>)['args'] as List<dynamic>).first,
      '0xffffffffffffffff',
    );
  });
}
