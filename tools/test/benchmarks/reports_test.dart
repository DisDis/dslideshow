import 'dart:convert';
import 'dart:io';

import 'package:dslideshow_tools/src/benchmarks/json_io.dart';
import 'package:dslideshow_tools/src/benchmarks/reports.dart';
import 'package:path/path.dart' as p;
import 'package:test/test.dart';

import '../support/benchmark_fixture.dart';

void main() {
  final records = jsonDecode(
    utf8.decode(gzip.decode(File('test/benchmarks/fixtures/reports_parity.json.gz').readAsBytesSync())),
  ) as List;
  for (final record in records) {
    test(record['name'] as String, () {
      final root = Directory.systemTemp.createTempSync('reports-');
      addTearDown(() => root.deleteSync(recursive: true));
      materializeBenchmarkFixture(root, asMap(record['inputs']));
      if (record['kind'] == 'collect') {
        expect(collectReports(root), record['expected']);
      } else {
        final renderer = Directory(p.join(root.path, record['renderer'] as String)),
            attempt = Directory(p.join(root.path, record['attempt'] as String));
        expect(checkpoint(renderer, attempt, record['code'] as int), record['expected']);
        expect(readJson(File(p.join(renderer.path, 'renderer-status.json')), []), record['state']);
      }
    });
  }
  test('HTML escapes report and case values', () {
    final result = {
      'renderers': {
        'opengl': {'status': '<unsafe>', 'complete': false, 'cases': <dynamic>[]},
      },
      'comparison': <Map<String, dynamic>>[
        {'id': '<unsafe>'},
      ],
      'comparability': <String, dynamic>{},
    };
    final document = renderReports(result);
    expect(document, contains('&lt;unsafe&gt;'));
    expect(document, isNot(contains('<unsafe>')));
  });
}
