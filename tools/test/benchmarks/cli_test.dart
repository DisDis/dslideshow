import 'dart:convert';
import 'dart:io';

import 'package:dslideshow_tools/src/benchmarks/cli.dart';
import 'package:dslideshow_tools/src/benchmarks/json_io.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart' as p;
import 'package:test/test.dart';

import '../support/benchmark_fixture.dart';

void main() {
  test('comparison CLI writes complete JSON/Markdown and keeps unsuccessful result nonzero', () async {
    final root = Directory.systemTemp.createTempSync('comparison-cli-');
    addTearDown(() => root.deleteSync(recursive: true));
    final records = asList(
      asMap(
        jsonDecode(
          utf8.decode(gzip.decode(File('test/benchmarks/fixtures/comparison_parity.json.gz').readAsBytesSync())),
        ),
      )['records'],
    );
    for (final accepted in [false, true]) {
      final record = asMap(records.firstWhere((r) => r['expected']['comparison_ready'] == accepted)),
          input = Directory(p.join(root.path, accepted.toString()))..createSync();
      for (final side in ['baseline', 'candidate']) {
        materializeBenchmarkFixture(Directory(p.join(input.path, side)), asMap(record['inputs'][side]));
      }
      final out = Directory(p.join(input.path, 'result'));
      final code = await runBenchmark([
        'compare-effect-performance',
        p.join(input.path, 'baseline'),
        p.join(input.path, 'candidate'),
        out.path,
      ]);
      expect(code, accepted ? 0 : 2);
      final result = readJson(File(p.join(out.path, 'comparison.json')), []);
      expect(result['comparison_ready'], accepted);
      final report = File(p.join(out.path, 'report.md')).readAsStringSync();
      expect(report, contains('Acceptance: not assessed'));
      expect(report, contains('System SwapFree delta'));
      expect(report, contains('Pooled frame distributions'));
    }
  });
  test('diagnostics identify operation/result without echoing invalid command secrets', () async {
    final records = <LogRecord>[], sub = Logger.root.onRecord.listen(records.add);
    addTearDown(sub.cancel);
    await expectLater(runBenchmark(['https://secret-command.invalid/?token=never-log']), throwsArgumentError);
    final logs = records.where((r) => r.loggerName == 'benchmark').toList();
    expect(logs, hasLength(2));
    expect(logs.first.level, Level.INFO);
    expect(logs.first.message, contains('action=start'));
    expect(logs.last.level, Level.WARNING);
    expect(logs.last.message, contains('result=failed'));
    expect(logs.any((r) => r.message.contains('never-log')), false);
  });
  test('report JSON preserves arbitrary integers without treating them as valid metrics', () {
    final text = List.filled(600, '9').join(), value = asMap(decodeStrictJson('{"x":$text}'))['x'];
    expect(value, isA<BigInt>());
    expect(value.toString(), text);
    expect(numeric(value), false);
    expect(integer(value), false);
    expect(encodeReportJson({'x': value}), '{"x":$text}');
  });
}
