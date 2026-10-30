import 'dart:convert';
import 'dart:io';

import 'package:dslideshow_tools/src/testing/groups.dart';
import 'package:dslideshow_tools/src/testing/profile.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart' as p;
import 'package:test/test.dart';

Map<String, dynamic> _start(int id, String name, int time, {int suite = 1}) => {
  'type': 'testStart',
  'time': time,
  'test': {'id': id, 'name': name, 'suiteID': suite, 'groupIDs': <int>[]},
};
Map<String, dynamic> _done(int id, int time, {bool hidden = false, bool skipped = false, String result = 'success'}) =>
    {'type': 'testDone', 'testID': id, 'time': time, 'hidden': hidden, 'skipped': skipped, 'result': result};
List<Map<String, dynamic>> _successful(String path, {int duration = 20}) => [
  {'type': 'start', 'time': 0},
  {
    'type': 'suite',
    'suite': {'id': 1, 'path': path},
    'time': 0,
  },
  _start(2, 'ordinary contract', 10),
  _done(2, 10 + duration),
  {'type': 'done', 'success': true, 'time': 20 + duration},
];

void main() {
  late Directory root, reports;
  setUp(() {
    root = Directory.systemTemp.createTempSync('test-profile-');
    reports = Directory(p.join(root.path, 'reports'))..createSync();
  });
  tearDown(() => root.deleteSync(recursive: true));
  File events(String package, List<Map<String, dynamic>> rows) =>
      File(p.join(reports.path, '$package.jsonl'))..writeAsStringSync('${rows.map(jsonEncode).join('\n')}\n');
  Map<String, dynamic> summary() =>
      jsonDecode(File(p.join(reports.path, 'summary.json')).readAsStringSync()) as Map<String, dynamic>;
  void suite(String package, String path) {
    final file = File(p.join(root.path, package, path));
    file.parent.createSync(recursive: true);
    file.writeAsStringSync('// catalogue only; never executed');
  }

  test('hidden loading and hooks stay separate; concurrent intervals do not inflate counts', () async {
    suite('common', 'test/effects_test.dart');
    final file = events('common', [
      {'type': 'start', 'time': 0},
      {
        'type': 'suite',
        'suite': {'id': 1, 'path': File(p.join(root.path, 'common/test/effects_test.dart')).uri.toString()},
      },
      _start(0, 'loading test/effects_test.dart', 0),
      _done(0, 10, hidden: true),
      _start(1, 'group (setUpAll)', 10),
      _done(1, 20),
      _start(2, 'first', 20),
      _start(3, 'skipped', 25),
      _start(4, 'hidden helper', 30),
      _done(4, 32, hidden: true),
      _done(3, 45, skipped: true),
      _done(2, 50),
      {'type': 'done', 'success': true, 'time': 100},
    ]);
    final result = await readTestProtocol(root, 'common', file);
    expect(result['counts'], {
      'total': 2,
      'passed': 1,
      'failed': 0,
      'skipped': 1,
      'unfinished': 0,
      'measured_tests': 2,
      'test_duration_ms': 50,
    });
    expect(result['runner_wall_ms'], 100);
    expect(result['runner_first_test_ms'], 20);
    expect(result['protocol_complete'], true);
    final services = result['services'] as Map<String, dynamic>;
    expect(services['loading'], {'total': 1, 'failed': 0, 'unfinished': 0, 'duration_ms': 10});
    expect(services['hook'], {'total': 1, 'failed': 0, 'unfinished': 0, 'duration_ms': 10});
    expect(services['hidden'], {'total': 1, 'failed': 0, 'unfinished': 0, 'duration_ms': 2});
    expect((result['suites'] as List).single['wall_interval_ms'], 50);
  });
  test('late errors override a success without publishing raw error, print or URL payloads', () async {
    suite('common', 'test/effects_test.dart');
    final rows = _successful('test/effects_test.dart');
    (rows[2]['test'] as Map<String, dynamic>)['name'] = 'request https://secret.invalid/?token=private-token';
    rows.addAll([
      {'type': 'error', 'testID': 2, 'time': 50, 'error': 'private-error-secret', 'stackTrace': 'private-stack-secret'},
      {'type': 'print', 'testID': 2, 'time': 50, 'message': 'private-print-secret'},
    ]);
    events('common', rows);
    final logs = <LogRecord>[], subscription = Logger('testProfile').onRecord.listen(logs.add);
    addTearDown(subscription.cancel);
    await expectLater(
      writeTestProfile(root, reports, expectedPackages: ['common']),
      throwsA(isA<IncompleteTestProfile>()),
    );
    final report = summary();
    expect((report['counts'] as Map)['failed'], 1);
    expect((report['counts'] as Map)['passed'], 0);
    expect(report['success'], false);
    expect(report['late_errors'], 1);
    final output =
        '${File(p.join(reports.path, 'summary.json')).readAsStringSync()}${File(p.join(reports.path, 'summary.md')).readAsStringSync()}${logs.map((row) => row.message).join()}';
    for (final secret in ['private-token', 'private-error-secret', 'private-stack-secret', 'private-print-secret']) {
      expect(output, isNot(contains(secret)));
    }
    expect(logs.map((row) => row.message).join(), contains('action=report result=written'));
  });
  test('malformed rows and unfinished work remain partial while later valid rows survive', () async {
    final file = events('common', [
      {'type': 'start', 'time': 0},
      {
        'type': 'suite',
        'suite': {'id': 1, 'path': 'test/effects_test.dart'},
      },
      _start(1, 'finished', 1),
      _start(2, 'unfinished', 2),
      _done(1, 5),
    ]);
    file.writeAsStringSync('not JSON\n${file.readAsStringSync()}');
    final result = await readTestProtocol(root, 'common', file);
    expect(result['protocol_complete'], false);
    expect(result['protocol_issues'], 1);
    expect((result['counts'] as Map)['total'], 2);
    expect((result['counts'] as Map)['unfinished'], 1);
    expect((result['counts'] as Map)['passed'], 1);
    expect(result['runner_wall_ms'], isNull);
  });
  test('duplicate test events count once and invalid suite paths are anonymized', () async {
    final rows = _successful('https://private.invalid/?token=never-show');
    rows.insert(3, Map<String, dynamic>.from(rows[2]));
    rows.insert(5, Map<String, dynamic>.from(rows[4]));
    final result = await readTestProtocol(root, 'common', events('common', rows));
    expect((result['counts'] as Map)['total'], 1);
    expect(result['protocol_complete'], false);
    expect(result['protocol_issues'], greaterThanOrEqualTo(3));
    expect(jsonEncode(result), isNot(contains('never-show')));
    expect((result['suites'] as List).single['group'], 'unclassified');
  });
  test('loading failure is visible as a service failure and never a successful report', () async {
    final result = await readTestProtocol(
      root,
      'common',
      events('common', [
        {'type': 'start', 'time': 0},
        {
          'type': 'suite',
          'suite': {'id': 1, 'path': 'test/effects_test.dart'},
        },
        _start(1, 'loading test/effects_test.dart', 0),
        _done(1, 12, hidden: true, result: 'error'),
        {'type': 'done', 'success': false, 'time': 12},
      ]),
    );
    expect((result['counts'] as Map)['total'], 0);
    expect(((result['services'] as Map)['loading'] as Map)['failed'], 1);
    expect(result['runner_first_test_ms'], isNull);
    expect(result['success'], false);
  });
  test('full eight-package report counts each test once and distinguishes interval sums', () async {
    const paths = {
      'common': 'test/effects_test.dart',
      'rpc_serializers_generator': 'test/builder_test.dart',
      'backend': 'test/gallery_catalog_test.dart',
      'tools': 'test/testing/profile_test.dart',
      'i18n': 'test/localizations_test.dart',
      'system_metrics_widget': 'test/os_info_widget_test.dart',
      'dslideshow_flutter': 'test/mosaic_optimization_test.dart',
      'config_app': 'test/effects_editor_test.dart',
    };
    var duration = 0;
    for (final entry in paths.entries) {
      suite(entry.key, entry.value);
      events(entry.key, _successful(entry.value, duration: duration += 10));
    }
    await writeTestProfile(root, reports);
    final report = summary();
    expect((report['counts'] as Map)['total'], 8);
    expect((report['counts'] as Map)['test_duration_ms'], 360);
    expect((report['completeness'] as Map)['complete'], true);
    expect((report['completeness'] as Map)['missing_suites'], isEmpty);
    expect((report['groups'] as List).fold<int>(0, (sum, row) => sum + (row['total'] as int)), 8);
    expect((report['groups'] as List).singleWhere((row) => row['group'] == 'effects')['total'], 3);
    expect((report['slow_tests'] as List).first['duration_ms'], 80);
    expect((report['slow_suites'] as List).first['suite'], 'test/effects_editor_test.dart');
    final markdown = File(p.join(reports.path, 'summary.md')).readAsStringSync();
    expect(markdown, contains('concurrent tests overlap'));
    expect(markdown, contains('before the JSON reporter starts'));
    expect(markdown, contains('../config_app/test/effects_editor_test.dart'));
  });
  test('missing packages and catalogue files stay visible; unknown suites are unclassified', () async {
    suite('common', 'test/new_contract_test.dart');
    suite('common', 'test/effects_test.dart');
    events('common', _successful('test/new_contract_test.dart'));
    await expectLater(writeTestProfile(root, reports), throwsA(isA<IncompleteTestProfile>()));
    final report = summary(), completeness = report['completeness'] as Map;
    expect(completeness['complete'], false);
    expect(completeness['missing_packages'], contains('backend'));
    expect((completeness['missing_suites'] as List).single['suite'], 'test/effects_test.dart');
    expect((report['unclassified'] as List).single['suite'], 'test/new_contract_test.dart');
  });
  test('empty selected run is valid but does not claim full package execution', () async {
    await writeTestProfile(root, reports, expectedPackages: []);
    final report = summary(), completeness = report['completeness'] as Map;
    expect((report['counts'] as Map)['total'], 0);
    expect(completeness['selected_scope_complete'], true);
    expect(completeness['complete'], false);
    expect(completeness['full_package_scope'], false);
    expect(report['groups'], hasLength(TestGroup.values.length));
  });
  test('selected tools build scope survives rebuild and fails missing or unexpected suites', () async {
    const selected = 'test/build/supervisor_test.dart';
    const missing = 'test/build/commands_test.dart';
    const other = 'test/benchmarks/backend_local_test.dart';
    final logs = <LogRecord>[];
    final subscription = Logger('testProfile').onRecord.listen(logs.add);
    addTearDown(subscription.cancel);
    suite('tools', selected);
    suite('tools', missing);
    suite('tools', other);
    events('tools', _successful(selected));
    events('backend', _successful('test/gallery_catalog_test.dart', duration: 999));
    await writeTestProfile(
      root,
      reports,
      expectedPackages: ['tools'],
      expectedSuites: {
        'tools': [selected],
      },
    );
    final original = summary();
    await writeTestProfile(root, reports);
    expect(summary(), original);
    final report = summary(), completeness = report['completeness'] as Map;
    expect((report['counts'] as Map)['total'], 1);
    expect(completeness['selected_scope_complete'], true);
    expect(completeness['complete'], false);
    expect(completeness['full_package_scope'], false);
    expect(completeness['missing_suites'], isEmpty);
    expect(completeness['ignored_package_reports'], ['backend']);
    expect(report['success'], true);
    final markdown = File(p.join(reports.path, 'summary.md')).readAsStringSync();
    expect(markdown, contains('Selected scope complete: **true**'));
    expect(markdown, contains('Full repository scope: **false**'));
    expect(markdown, contains('Complete catalogue execution: **false**'));
    final written = logs.lastWhere((record) => record.message.contains('action=report result=written')).message;
    expect(written, contains('incomplete=false'));
    expect(written, contains('selectedScopeComplete=true'));
    expect(written, contains('fullRepositoryScope=false'));
    expect(written, contains('success=true'));

    await expectLater(
      writeTestProfile(
        root,
        reports,
        expectedPackages: ['tools'],
        expectedSuites: {
          'tools': [selected, missing],
        },
      ),
      throwsA(isA<IncompleteTestProfile>()),
    );
    expect(summary()['completeness']['selected_scope_complete'], false);
    expect(summary()['completeness']['missing_suites'], [
      {'package': 'tools', 'suite': missing, 'group': 'tooling-protocol'},
    ]);

    final unexpected = _successful(selected)
      ..insertAll(4, [
        {
          'type': 'suite',
          'time': 32,
          'suite': {'id': 3, 'path': other},
        },
        _start(4, 'unexpected benchmark', 32, suite: 3),
        _done(4, 33),
      ]);
    events('tools', unexpected);
    await expectLater(
      writeTestProfile(
        root,
        reports,
        expectedPackages: ['tools'],
        expectedSuites: {
          'tools': [selected],
        },
      ),
      throwsA(isA<IncompleteTestProfile>()),
    );
    expect(summary()['success'], true, reason: 'Observed runners passed; their suite selection is invalid');
    expect(summary()['completeness']['selected_scope_complete'], false);
    expect(summary()['completeness']['missing_suites'], isEmpty);
    expect((summary()['completeness']['unexpected_suites'] as List).single['suite'], other);
  });
  test('partial rebuild uses scope saved before any package reporter finishes', () async {
    File(p.join(reports.path, 'scope.json')).writeAsStringSync(
      jsonEncode({
        'schema_version': 1,
        'expected_packages': ['common'],
        'expected_suites': {
          'common': ['test/effects_test.dart'],
        },
      }),
    );
    final rows = _successful('test/effects_test.dart')..removeLast();
    events('common', rows);
    await expectLater(writeTestProfile(root, reports), throwsA(isA<IncompleteTestProfile>()));
    final completeness = summary()['completeness'] as Map;
    expect(completeness['expected_packages'], ['common']);
    expect(completeness['selected_scope_complete'], false);
    expect(completeness['missing_packages'], isEmpty);
  });
  test('backwards/missing timestamps and orphan done events cannot claim a complete stream', () async {
    final rows = _successful('test/effects_test.dart');
    rows[3]['time'] = 2;
    rows.insert(4, _done(900, 20));
    rows[0].remove('time');
    final result = await readTestProtocol(root, 'common', events('common', rows));
    expect(result['protocol_complete'], false);
    expect(result['protocol_issues'], greaterThanOrEqualTo(3));
    expect((result['counts'] as Map)['measured_tests'], 0);
    final earlyDone = _successful('test/effects_test.dart');
    earlyDone.last['time'] = 2;
    expect((await readTestProtocol(root, 'common', events('common', earlyDone)))['protocol_complete'], false);
    final contradictory = _successful('test/effects_test.dart');
    contradictory[3]['skipped'] = true;
    contradictory[3]['result'] = 'failure';
    final failed = await readTestProtocol(root, 'common', events('common', contradictory));
    expect((failed['counts'] as Map)['failed'], 1);
    expect((failed['counts'] as Map)['skipped'], 0);
    expect(failed['protocol_complete'], false);
  });
}
