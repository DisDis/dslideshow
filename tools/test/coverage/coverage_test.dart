import 'dart:convert';
import 'dart:io';

import 'package:dslideshow_tools/src/coverage/cli.dart';
import 'package:dslideshow_tools/src/coverage/coverage.dart';
import 'package:path/path.dart' as p;
import 'package:test/test.dart';

void main() {
  late Directory root;
  late File source;
  setUp(() {
    root = Directory.systemTemp.createTempSync('dart-coverage-');
    source = File(p.join(root.path, 'backend/lib/service.dart'));
    source.parent.createSync(recursive: true);
    source.writeAsStringSync('void run() {\n  action();\n}\n');
  });
  tearDown(() => root.deleteSync(recursive: true));
  CoverageRecords report(String text) {
    final file = File(p.join(root.path, 'input.info'))..writeAsStringSync(text);
    return readLcov(file, root, 'backend');
  }

  void manifest(Directory run, Map<String, dynamic> fields) =>
      writeCoverageJson(File(p.join(run.path, 'manifest.json')), {
        'status': 'finished',
        'packages': ['backend'],
        'snapshot': sourceSnapshot(root),
        ...fields,
      });

  test('duplicate LCOV records preserve misses and merge branch identity', () {
    final records = report(
      'SF:lib/service.dart\nDA:1,0\nDA:2,1\nBRDA:2,0,0,-\nLF:999\nend_of_record\n'
      'SF:lib/service.dart\nDA:2,3\nDA:3,0\nBRDA:2,0,0,2\nBRDA:2,0,1,0\nend_of_record\n',
    );
    expect(records['backend/lib/service.dart']!['lines'], {'1': 0, '2': 4, '3': 0});
    expect(totals(records), {
      'lines_found': 3,
      'lines_hit': 1,
      'branches_found': 2,
      'branches_hit': 1,
      'line_percent': 33.33,
      'branch_percent': 50.0,
      'functions_found': 0,
      'functions_hit': 0,
      'function_percent': null,
    });
  });
  test('package paths, file URIs and literal percent sequences remain distinct', () {
    final records = report(
      'SF:${source.uri}\nDA:1,1\nend_of_record\n'
      'SF:../config_app/lib/a%20b.dart\nDA:2,1\nend_of_record\n'
      'SF:package:dslideshow_flutter/a.dart\nDA:1,0\nend_of_record\n'
      'SF:/outside/repo.dart\nDA:1,99\nend_of_record\n',
    );
    expect(
      records.keys,
      unorderedEquals(['backend/lib/service.dart', 'config_app/lib/a%20b.dart', 'dslideshow_flutter/lib/a.dart']),
    );
  });
  test('missing source coverage stays unknown; generated files excluded and drift detected', () {
    final missing = File(p.join(source.parent.path, 'never_imported.dart'))..writeAsStringSync('int answer() => 42;\n');
    File(p.join(source.parent.path, 'service.freezed.dart')).writeAsStringSync('generated\n');
    final run = Directory(p.join(root.path, 'run/backend'))..createSync(recursive: true);
    manifest(run.parent, {});
    File(p.join(run.path, 'lcov.info')).writeAsStringSync('SF:lib/service.dart\nDA:2,1\nend_of_record\n');
    final summary = summarize(run.parent, root);
    expect(summary['reporter_sha256'], coverageImplementationSha256());
    expect(summary['packages']['backend']['own_suite']['line_percent'], 100.0);
    expect(summary['packages']['backend']['not_measured'], ['backend/lib/never_imported.dart']);
    expect(summary['excluded_generated'], ['backend/lib/service.freezed.dart']);
    expect(summary['source_changed'], isEmpty);
    expect(File(p.join(run.parent.path, 'files.csv')).readAsStringSync(), contains('not_measured'));
    missing.writeAsStringSync('int answer() => 43;\n');
    expect(summarize(run.parent, root)['source_changed'], ['backend/lib/never_imported.dart']);
  });
  test('cross-suite union and overlap do not double count executable lines', () {
    final a = report('SF:lib/service.dart\nDA:1,1\nDA:2,0\nend_of_record\n');
    final b = report('SF:lib/service.dart\nDA:1,3\nDA:2,1\nend_of_record\n');
    final union = mergeRecords([a, b]);
    expect(totals(union)['lines_hit'], 2);
    expect(overlap({'a': a, 'b': b}), [
      {'left': 'a', 'right': 'b', 'shared_hit_lines': 1, 'left_only': 0, 'right_only': 1, 'jaccard_percent': 50.0},
    ]);
    final normalized = File(p.join(root.path, 'normalized.info'));
    writeLcov(normalized, union);
    expect(readLcov(normalized, root, ''), union);
  });
  test('HTML escapes source filenames', () {
    File(p.join(source.parent.path, '<unsafe>.dart')).writeAsStringSync('void action() {}');
    final run = Directory(p.join(root.path, 'run'))..createSync();
    manifest(run, {'packages': <String>[]});
    summarize(run, root);
    final html = File(p.join(run.path, 'index.html')).readAsStringSync();
    expect(html, contains('&lt;unsafe&gt;'));
    expect(html, isNot(contains('<unsafe>')));
  });
  test('machine events distinguish hidden, skipped, failed, unfinished and timed tests', () {
    final events = [
      {
        'type': 'suite',
        'suite': {'id': 1, 'path': 'test/example_test.dart'},
      },
      for (var i = 0; i < 5; i++)
        {
          'type': 'testStart',
          'test': {'id': i, 'name': 'scenario $i', 'suiteID': 1},
          'time': 10,
        },
      {'type': 'testDone', 'testID': 0, 'result': 'success', 'time': 21},
      {'type': 'testDone', 'testID': 1, 'result': 'success', 'skipped': true},
      {'type': 'testDone', 'testID': 2, 'result': 'success', 'hidden': true},
      {'type': 'testDone', 'testID': 3, 'result': 'error'},
    ];
    final file = File(p.join(root.path, 'events.jsonl'))
      ..writeAsStringSync('VM preamble\n${events.map(jsonEncode).join('\n')}');
    final result = testResults(file);
    expect(
      {
        for (final key in ['passed', 'skipped', 'hidden', 'failed', 'unfinished']) key: result[key],
      },
      {'passed': 1, 'skipped': 1, 'hidden': 1, 'failed': 1, 'unfinished': 1},
    );
    expect(result['failures'], [
      {'name': 'scenario 3', 'suite': 'test/example_test.dart'},
    ]);
    expect((result['slowest_instrumented_tests'] as List).single['milliseconds'], 11);
  });
  test('function declarations without hits stay uncovered and round trip', () {
    final records = report('SF:lib/service.dart\nFN:1,run\nFN:3,unused\nFNDA:4,run\nDA:1,4\nend_of_record\n');
    expect(totals(records)['function_percent'], 50.0);
    final file = File(p.join(root.path, 'normalized.info'));
    writeLcov(file, records);
    expect(readLcov(file, root, ''), records);
    expect(() => report('SF:lib/service.dart\nFNDA:1,unknown\n'), throwsFormatException);
  });
  test('merge replaces reruns; rejects overwrite, nested output, subsets and snapshot mismatch', () {
    final runs = [Directory(p.join(root.path, 'old')), Directory(p.join(root.path, 'new'))];
    for (var i = 0; i < runs.length; i++) {
      final dir = Directory(p.join(runs[i].path, 'backend'))..createSync(recursive: true);
      manifest(runs[i], {
        'results': {
          'backend': {
            'tests': {'exit_code': 0},
          },
        },
      });
      File(p.join(dir.path, 'lcov.info'))
          .writeAsStringSync('SF:lib/service.dart\nDA:1,${i == 0 ? 5 : 2}\nend_of_record\n');
    }
    final output = Directory(p.join(root.path, 'merged'));
    expect(mergeRuns(runs, output, root)['checks_passed'], isTrue);
    expect(readLcov(File(p.join(output.path, 'union.lcov.info')), root, '')['backend/lib/service.dart']!['lines'], {
      '1': 2,
    });
    expect(() => mergeRuns(runs, output, root), throwsA(isA<FileSystemException>()));
    expect(() => mergeRuns(runs, Directory(p.join(runs.first.path, 'backend/nested')), root), throwsArgumentError);
    final file = File(p.join(runs.last.path, 'manifest.json'));
    final original = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
    writeCoverageJson(file, {
      ...original,
      'tests': ['test/selected_test.dart'],
    });
    expect(() => mergeRuns(runs, Directory(p.join(root.path, 'partial')), root), throwsArgumentError);
    original['snapshot']['sha256'] = 'changed';
    writeCoverageJson(file, original);
    expect(() => mergeRuns(runs, Directory(p.join(root.path, 'invalid')), root), throwsArgumentError);
  });
  test('saved inventory survives deleted source and invalidates baseline', () {
    final run = Directory(p.join(root.path, 'run/backend'))..createSync(recursive: true);
    final (sources, excluded) = inventory(root);
    manifest(run.parent, {'inventory': sources, 'excluded_generated': excluded});
    File(p.join(run.path, 'lcov.info')).writeAsStringSync('SF:lib/service.dart\nDA:1,1\nend_of_record\n');
    source.deleteSync();
    final result = summarize(run.parent, root);
    expect(result['checks_passed'], isFalse);
    expect(result['packages']['backend']['source_files'], 1);
    expect(result['source_changed'], ['backend/lib/service.dart']);
  });
  test('unresolved coverage fails before any implicit pub operation', () {
    final config = File(p.join(root.path, 'backend/.dart_tool/package_config.json'));
    config.parent.createSync();
    writeCoverageJson(config, {'packages': <dynamic>[]});
    expect(() => requirePackageConfigs(root, ['backend']), throwsStateError);
    writeCoverageJson(config, {
      'packages': [
        {'name': 'coverage', 'rootUri': '../../missing'},
      ],
    });
    expect(() => requirePackageConfigs(root, ['backend']), throwsStateError);
    final binary = File(p.join(root.path, 'missing/bin/test_with_coverage.dart'));
    binary.parent.createSync(recursive: true);
    binary.writeAsStringSync('// fixture');
    expect(() => requirePackageConfigs(root, ['backend']), returnsNormally);
  });
  test('collector validates tests scope before commands or output creation', () async {
    final args = coverageParser().parse([
      'collect',
      '--root',
      root.path,
      '--packages',
      'backend',
      '--tests',
      '../lib/service.dart',
    ]).command!;
    await expectLater(collectCoverage(args), throwsFormatException);
    expect(Directory(p.join(root.path, '.local')).existsSync(), isFalse);
  });
  test('CLI help and invalid invocation require no SDK or dependency fetching', () async {
    final helpOutput = StringBuffer();
    final helpErrors = StringBuffer();
    expect(
      await runCoverage(['--help'], output: helpOutput, errors: helpErrors),
      0,
      reason: helpErrors.toString(),
    );
    expect(helpOutput.toString(), startsWith('Usage: dslideshow_tools coverage <collect|summarize|compare|merge>'));
    expect(helpOutput.toString(), contains('--help'));
    expect(helpErrors.toString(), isEmpty);
    final invalidOutput = StringBuffer();
    final invalidErrors = StringBuffer();
    expect(
      await runCoverage(
        [
          'collect',
          '--root',
          root.path,
          '--tests',
          'test/private-access-token_test.dart',
          '--packages',
          'backend',
          'config_app',
        ],
        output: invalidOutput,
        errors: invalidErrors,
      ),
      64,
      reason: invalidErrors.toString(),
    );
    expect(invalidOutput.toString(), isEmpty);
    expect(invalidErrors.toString(), startsWith('--tests requires exactly one --packages entry\n'));
    expect(invalidErrors.toString(), contains('--help'));
    expect(invalidErrors.toString(), isNot(contains('private-access-token')));
  });
  test('CLI symlink root resolves physical absolute LCOV sources', () async {
    final run = Directory(p.join(root.path, 'run/backend'))..createSync(recursive: true);
    manifest(run.parent, {});
    File(p.join(run.path, 'lcov.info')).writeAsStringSync('SF:${source.path}\nDA:2,1\nend_of_record\n');
    final alias = Link(p.join(root.path, 'checkout-link'))..createSync(root.path);
    expect(await runCoverage(['summarize', run.parent.path, '--root', alias.path]), 0);
    final summary = jsonDecode(File(p.join(run.parent.path, 'summary.json')).readAsStringSync()) as Map;
    expect(summary['packages']['backend']['own_suite']['lines_hit'], 1);
    expect(summary['files'].single['status'], 'measured');
  });
}
