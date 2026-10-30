import 'dart:convert';
import 'dart:io';

import 'package:dslideshow_tools/src/benchmarks/comparison.dart';
import 'package:dslideshow_tools/src/benchmarks/json_io.dart';
import 'package:path/path.dart' as p;
import 'package:test/test.dart';

Map<String, dynamic> projection(Map<String, dynamic> source) {
  final result = jsonDecode(jsonEncode(source)) as Map<String, dynamic>;
  for (final side in ['baseline', 'candidate']) {
    final report = asMap(result[side]);
    report.remove('collection');
    report['diagnostics'] = asList(report['diagnostics']).length;
    for (final item in asMap(report['cases']).values) {
      item['issues'] = asList(item['issues']).length;
    }
    report.remove('renderer_state');
    for (final attempt in asList(report['attempts'])) {
      attempt.remove('path');
    }
    for (final check in asList(report['conditions'])) {
      check.remove('scope');
    }
    result[side] = report;
  }
  for (final row in asList(result['cases'])) {
    for (final side in ['baseline', 'candidate']) {
      if (row[side] != null) row[side]['issues'] = asList(row[side]['issues']).length;
    }
  }
  result.remove('notes');
  for (final check in asList(result['conditions'])) {
    check.remove('scope');
  }
  return result;
}

void main() {
  final fixture = asMap(
    jsonDecode(utf8.decode(gzip.decode(File('test/benchmarks/fixtures/comparison_parity.json.gz').readAsBytesSync()))),
  );
  for (final record in asList(fixture['records'])) {
    test(record['name'] as String, () {
      final root = Directory.systemTemp.createTempSync('comparison-');
      addTearDown(() => root.deleteSync(recursive: true));
      for (final side in ['baseline', 'candidate']) {
        for (final entry in asMap(record['inputs'][side]).entries) {
          final path = p.join(root.path, side, entry.key);
          if (entry.value == null) {
            Directory(path).createSync(recursive: true);
          } else {
            final file = File(path);
            file.parent.createSync(recursive: true);
            file.writeAsBytesSync(base64Decode(entry.value as String));
          }
        }
      }
      final actual = comparePerformance(
        p.join(root.path, 'baseline'),
        p.join(root.path, 'candidate'),
        renderer: record['renderer'] as String,
      );
      expect(projection(actual), record['expected']);
    });
  }
  test('strict JSON rejects duplicate names and non-finite values at any depth', () {
    for (final input in ['{"x":1,"x":2}', '{"a":{"x":1,"x":2}}', '{"x":1e999}', '{"x":NaN}', '{"x":true,}']) {
      expect(() => decodeStrictJson(input), throwsFormatException);
    }
    expect(decodeStrictJson('{"a":[true,null,"escaped\\"quote",1.5]}'), {
      'a': [true, null, 'escaped"quote', 1.5],
    });
  });
}
