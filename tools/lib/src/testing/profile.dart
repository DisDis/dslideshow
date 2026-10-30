import 'dart:convert';
import 'dart:io';

import 'package:logging/logging.dart';
import 'package:path/path.dart' as p;

import 'groups.dart';

final _profileLog = Logger('testProfile');
final _controls = RegExp(r'[\x00-\x1f\x7f]');
final _urls = RegExp(r'(?:https?|wss?)://\S+');
const _countKeys = ['total', 'passed', 'failed', 'skipped', 'unfinished', 'measured_tests', 'test_duration_ms'];

enum _Outcome { passed, failed, skipped, unfinished }

enum _Kind { test, loading, hook, hidden }

class IncompleteTestProfile implements Exception {
  const IncompleteTestProfile();

  @override
  String toString() => 'Test profile is incomplete or unsuccessful; summaries were saved';
}

typedef _Started = ({int suite, String name, int? time, bool loading, bool hook});
typedef _Finished = ({_Outcome outcome, int? time, bool hidden});

int? _integer(Object? value) => value is int && value >= 0 ? value : null;
Map<String, dynamic> _counts() => {for (final key in _countKeys) key: 0};
void _add(Map<String, dynamic> target, String key, num value) => target[key] = (target[key] as num? ?? 0) + value;
void _mergeCounts(Map<String, dynamic> target, Map<String, dynamic> source) {
  for (final key in _countKeys) {
    _add(target, key, source[key] as num);
  }
}

String _safeName(String value, Directory repository) {
  final safe = value.replaceAll(repository.absolute.path, '.').replaceAll(_controls, ' ').replaceAll(_urls, '[URL]');
  return safe.length > 240 ? '${safe.substring(0, 240)}…' : safe;
}

/// Reads one package:test JSON reporter stream without retaining print/errors.
/// Times belong to the runner clock and exclude work before the JSON reporter.
Future<Map<String, dynamic>> readTestProtocol(Directory repository, String package, File input) async {
  if (!testPackages.contains(package)) throw ArgumentError.value(package, 'package', 'Unknown package');
  final suites = <int, String?>{}, started = <int, _Started>{}, finished = <int, _Finished>{};
  final errors = <int>{};
  var invalid = 0, startEvents = 0, doneEvents = 0, lateErrors = 0;
  int? runnerStart, runnerDone;
  bool? reportedSuccess;
  if (await input.exists()) {
    await for (final line
        in input.openRead().transform(const Utf8Decoder(allowMalformed: true)).transform(const LineSplitter())) {
      if (line.trim().isEmpty) continue;
      dynamic decoded;
      try {
        decoded = jsonDecode(line);
      } on FormatException {
        invalid++;
        continue;
      }
      if (decoded is! Map<String, dynamic>) {
        invalid++;
        continue;
      }
      final event = decoded, time = _integer(event['time']);
      if (event['type'] is! String) {
        invalid++;
        continue;
      }
      switch (event['type']) {
        case 'start':
          startEvents++;
          runnerStart ??= time;
          if (time == null) invalid++;
        case 'done':
          doneEvents++;
          runnerDone = time;
          reportedSuccess = event['success'] is bool ? event['success'] as bool : null;
          if (time == null) invalid++;
        case 'suite':
          final value = event['suite'];
          if (value is! Map<String, dynamic> || _integer(value['id']) == null || value['path'] is! String) {
            invalid++;
            continue;
          }
          final id = value['id'] as int;
          if (suites.containsKey(id)) invalid++;
          suites[id] = normalizeTestSuite(repository, package, value['path'] as String);
          if (suites[id] == null) invalid++;
        case 'testStart':
          final value = event['test'];
          if (value is! Map<String, dynamic> ||
              _integer(value['id']) == null ||
              _integer(value['suiteID']) == null ||
              value['name'] is! String) {
            invalid++;
            continue;
          }
          final id = value['id'] as int, name = value['name'] as String;
          if (started.containsKey(id)) {
            invalid++;
            continue;
          }
          started[id] = (
            suite: value['suiteID'] as int,
            name: _safeName(name, repository),
            time: time,
            loading:
                name.startsWith('loading ') &&
                (value['groupIDs'] == null || (value['groupIDs'] is List && (value['groupIDs'] as List).isEmpty)),
            hook: name.endsWith('(setUpAll)') || name.endsWith('(tearDownAll)'),
          );
          if (time == null) invalid++;
        case 'testDone':
          final id = _integer(event['testID']);
          if (id == null || !['success', 'failure', 'error'].contains(event['result'])) {
            invalid++;
            continue;
          }
          if (finished.containsKey(id)) {
            invalid++;
            continue;
          }
          finished[id] = (
            outcome: event['result'] != 'success'
                ? _Outcome.failed
                : event['skipped'] == true
                ? _Outcome.skipped
                : _Outcome.passed,
            time: time,
            hidden: event['hidden'] == true,
          );
          if (time == null || !started.containsKey(id)) invalid++;
          if ((event.containsKey('hidden') && event['hidden'] is! bool) ||
              (event.containsKey('skipped') && event['skipped'] is! bool) ||
              (event['skipped'] == true && event['result'] != 'success')) {
            invalid++;
          }
        case 'error':
          final id = _integer(event['testID']);
          if (id == null) {
            invalid++;
          } else {
            if (finished.containsKey(id) || doneEvents > 0) lateErrors++;
            errors.add(id);
          }
        default:
          // group, allSuites, print and future protocol metadata are not tests.
          // In particular, error text, stack traces and print payloads stay raw-only.
          break;
      }
    }
  }
  final suiteRows = <String, Map<String, dynamic>>{}, testRows = <Map<String, dynamic>>[];
  final services = {
    for (final kind in [_Kind.loading, _Kind.hook, _Kind.hidden])
      kind.name: <String, dynamic>{'total': 0, 'failed': 0, 'unfinished': 0, 'duration_ms': 0},
  };
  final totals = _counts();
  if (runnerStart != null && runnerDone != null && runnerDone < runnerStart) invalid++;
  int? firstVisible;
  var unfinished = 0;
  for (final entry in started.entries) {
    final test = entry.value, done = finished[entry.key];
    final suite = suites[test.suite], path = suite ?? '[unresolved suite ${test.suite}]';
    final group = suite == null ? TestGroup.unclassified : testGroupForSuite(repository, package, suite);
    final row = suiteRows.putIfAbsent(
      path,
      () => {
        'package': package,
        'suite': path,
        'group': group.cliName,
        ..._counts(),
        'first_event_ms': null,
        'last_event_ms': null,
        'wall_interval_ms': null,
        'loading_count': 0,
        'loading_duration_ms': 0,
        'hidden_count': 0,
        'hook_count': 0,
      },
    );
    if (suite == null) invalid++;
    final start = test.time, end = done?.time;
    if ((start != null && runnerStart != null && start < runnerStart) ||
        (end != null && runnerDone != null && end > runnerDone)) {
      invalid++;
    }
    int? duration;
    if (start != null && end != null) {
      if (end >= start) {
        duration = end - start;
      } else {
        invalid++;
      }
    }
    if (start != null && (row['first_event_ms'] == null || start < (row['first_event_ms'] as int))) {
      row['first_event_ms'] = start;
    }
    if (end != null && (row['last_event_ms'] == null || end > (row['last_event_ms'] as int))) {
      row['last_event_ms'] = end;
    }
    final outcome = errors.contains(entry.key) ? _Outcome.failed : done?.outcome ?? _Outcome.unfinished;
    if (done == null) unfinished++;
    final kind = test.hook
        ? _Kind.hook
        : test.loading && (done == null || done.hidden)
        ? _Kind.loading
        : done?.hidden == true
        ? _Kind.hidden
        : _Kind.test;
    if (kind != _Kind.test) {
      final service = services[kind.name]!;
      _add(service, 'total', 1);
      if (outcome == _Outcome.failed) _add(service, 'failed', 1);
      if (done == null) _add(service, 'unfinished', 1);
      if (duration != null) _add(service, 'duration_ms', duration);
      _add(
        row,
        kind == _Kind.loading
            ? 'loading_count'
            : kind == _Kind.hook
            ? 'hook_count'
            : 'hidden_count',
        1,
      );
      if (kind == _Kind.loading && duration != null) _add(row, 'loading_duration_ms', duration);
      continue;
    }
    if (start != null && (firstVisible == null || start < firstVisible)) firstVisible = start;
    _add(row, 'total', 1);
    _add(row, outcome.name, 1);
    if (duration != null) {
      _add(row, 'measured_tests', 1);
      _add(row, 'test_duration_ms', duration);
    }
    testRows.add({
      'package': package,
      'suite': path,
      'group': group.cliName,
      'name': test.name,
      'status': outcome.name,
      'duration_ms': duration,
    });
  }
  for (final id in errors) {
    if (!started.containsKey(id)) invalid++;
  }
  for (final row in suiteRows.values) {
    if (row['first_event_ms'] is int && row['last_event_ms'] is int) {
      row['wall_interval_ms'] = (row['last_event_ms'] as int) - (row['first_event_ms'] as int);
    }
    _mergeCounts(totals, row);
  }
  final protocolComplete =
      startEvents == 1 &&
      doneEvents == 1 &&
      runnerDone != null &&
      reportedSuccess != null &&
      invalid == 0 &&
      unfinished == 0 &&
      finished.length == started.length;
  final serviceFailures = services.values.fold<int>(0, (value, row) => value + (row['failed'] as int));
  return {
    'package': package,
    'present': await input.exists(),
    'counts': totals,
    'runner_wall_ms': runnerStart != null && runnerDone != null && runnerDone >= runnerStart
        ? runnerDone - runnerStart
        : null,
    'runner_first_test_ms': runnerStart != null && firstVisible != null && firstVisible >= runnerStart
        ? firstVisible - runnerStart
        : null,
    'runner_reported_success': reportedSuccess,
    'success': reportedSuccess == true && totals['failed'] == 0 && serviceFailures == 0 && errors.isEmpty,
    'protocol_complete': protocolComplete,
    'protocol_issues': invalid,
    'late_errors': lateErrors,
    'unfinished_events': unfinished,
    'services': services,
    'suites': suiteRows.values.toList()..sort((a, b) => (a['suite'] as String).compareTo(b['suite'] as String)),
    'tests': testRows,
  };
}

String _md(Object? value) => '$value'.replaceAll('|', '\\|').replaceAll('`', '\\`').replaceAll('\n', ' ');

String _markdown(Map<String, dynamic> report, Directory repository, Directory destination) {
  final out = StringBuffer('# Test profile\n\n');
  final completeness = report['completeness'] as Map<String, dynamic>,
      totals = report['counts'] as Map<String, dynamic>;
  out.writeln(
    'Selected scope complete: **${completeness['selected_scope_complete']}**. '
    'Successful observed runners: **${report['success']}**.\n',
  );
  out.writeln(
    'Full repository scope: **${completeness['full_package_scope']}**. '
    'Complete catalogue execution: **${completeness['complete']}**.',
  );
  out.writeln(
    'Observed tests: ${totals['total']}; passed ${totals['passed']}, failed ${totals['failed']}, skipped ${totals['skipped']}, unfinished ${totals['unfinished']}.\n',
  );
  out.writeln(
    'Durations sum individual test intervals; concurrent tests overlap. Suite wall intervals also overlap. Neither sum is total command wall time. Runner clocks exclude native-assets/build work before the JSON reporter starts. The catalogue is file classification, not coverage or proof that every possible test was discovered.\n',
  );
  out.writeln(
    '| Group | Tests | Failed | Skipped | Unfinished | Measured | Test interval sum, ms | Suite interval sum, ms |',
  );
  out.writeln('| --- | ---: | ---: | ---: | ---: | ---: | ---: | ---: |');
  for (final row in (report['groups'] as List).cast<Map<String, dynamic>>()) {
    out.writeln(
      '| ${row['group']} | ${row['total']} | ${row['failed']} | ${row['skipped']} | ${row['unfinished']} | ${row['measured_tests']} | ${row['test_duration_ms']} | ${row['suite_wall_interval_sum_ms']} |',
    );
  }
  out.writeln('\n## Runner loading and startup\n');
  out.writeln(
    '| Package | Runner wall, ms | Runner first test, ms | Loading count / sum ms | Hooks count / sum ms | Service failures / unfinished | Protocol complete |',
  );
  out.writeln('| --- | ---: | ---: | --- | --- | --- | --- |');
  for (final row in (report['packages'] as List).cast<Map<String, dynamic>>()) {
    final services = row['services'] as Map<String, dynamic>;
    final loading = services['loading'] as Map<String, dynamic>, hooks = services['hook'] as Map<String, dynamic>;
    final failed = services.values.fold<int>(0, (sum, service) => sum + (service['failed'] as int));
    final unfinished = services.values.fold<int>(0, (sum, service) => sum + (service['unfinished'] as int));
    out.writeln(
      '| ${row['package']} | ${row['runner_wall_ms'] ?? 'unknown'} | ${row['runner_first_test_ms'] ?? 'unknown'} | ${loading['total']} / ${loading['duration_ms']} | ${hooks['total']} / ${hooks['duration_ms']} | $failed / $unfinished | ${row['protocol_complete']} |',
    );
  }
  String suiteLink(Map<String, dynamic> row) {
    final suite = row['suite'] as String, package = row['package'] as String;
    if (normalizeTestSuite(repository, package, suite) == null) return _md(suite);
    final uri = Uri(path: p.relative(p.join(repository.path, package, suite), from: destination.path)).toString();
    return '[${_md('$package/$suite')}]($uri)';
  }

  out.writeln('\n## Slow suites\n\n| Suite | Wall interval, ms | Test interval sum, ms |\n| --- | ---: | ---: |');
  for (final row in (report['slow_suites'] as List).cast<Map<String, dynamic>>()) {
    out.writeln('| ${suiteLink(row)} | ${row['wall_interval_ms'] ?? 'unknown'} | ${row['test_duration_ms']} |');
  }
  out.writeln('\n## Slow tests\n\n| Suite | Test | Duration, ms | Status |\n| --- | --- | ---: | --- |');
  for (final row in (report['slow_tests'] as List).cast<Map<String, dynamic>>()) {
    out.writeln('| ${suiteLink(row)} | ${_md(row['name'])} | ${row['duration_ms']} | ${row['status']} |');
  }
  out.writeln('\n## Completeness and unclassified suites\n');
  out.writeln(
    'Missing packages: ${(completeness['missing_packages'] as List).join(', ')}. Missing catalogue suites: ${(completeness['missing_suites'] as List).length}. Protocol issues: ${report['protocol_issues']}. Late errors: ${report['late_errors']}.\n',
  );
  for (final row in (report['unclassified'] as List).cast<Map<String, dynamic>>()) {
    out.writeln('- ${suiteLink(row)} (${row['total']} observed tests)');
  }
  return out.toString();
}

/// Rebuilds a bounded summary from streamed package reporter files.
/// Partial/failed streams produce explicit incomplete reports, not false passes.
Future<void> writeTestProfile(
  Directory repository,
  Directory directory, {
  List<String>? expectedPackages,
  Map<String, List<String>>? expectedSuites,
}) async {
  final scopeFile = File(p.join(directory.path, 'scope.json'));
  if (expectedPackages == null && expectedSuites == null && scopeFile.existsSync()) {
    final scope = jsonDecode(await scopeFile.readAsString());
    if (scope is! Map<String, dynamic> ||
        scope['schema_version'] != 1 ||
        scope['expected_packages'] is! List ||
        scope['expected_suites'] is! Map<String, dynamic>) {
      throw const FormatException('Invalid test profile scope');
    }
    final packages = scope['expected_packages'] as List;
    final suites = scope['expected_suites'] as Map<String, dynamic>;
    if (packages.any((value) => value is! String) ||
        suites.values.any((value) => value is! List || value.any((path) => path is! String))) {
      throw const FormatException('Invalid test profile scope');
    }
    expectedPackages = packages.cast<String>();
    expectedSuites = {for (final entry in suites.entries) entry.key: (entry.value as List).cast<String>()};
  }
  final expected = (expectedPackages ?? expectedSuites?.keys.toList() ?? testPackages).toSet().toList();
  if (expected.any((package) => !testPackages.contains(package))) throw ArgumentError('Unknown expected package');
  if (expectedSuites != null && expectedSuites.keys.any((package) => !expected.contains(package))) {
    throw ArgumentError('Unexpected package in suite selection');
  }
  final selection = <String, List<String>>{};
  for (final package in expected) {
    final paths = expectedSuites?[package] ?? allTestSuites(repository, package);
    final normalized = paths.map((path) => normalizeTestSuite(repository, package, path)).toList();
    if (normalized.any((path) => path == null)) throw ArgumentError('Suite selection must stay inside package tests');
    selection[package] = normalized.cast<String>().toSet().toList()..sort();
  }
  _profileLog.info('action=report phase=start expectedPackages=${expected.length}');
  try {
    await directory.create(recursive: true);
    await scopeFile.writeAsString(
      '${jsonEncode({'schema_version': 1, 'expected_packages': expected, 'expected_suites': selection})}\n',
    );
    final packages = <Map<String, dynamic>>[];
    for (final package in expected) {
      final file = File(p.join(directory.path, '$package.jsonl'));
      packages.add(await readTestProtocol(repository, package, file));
    }
    final totals = _counts(),
        groups = {
          for (final group in TestGroup.values)
            group.cliName: <String, dynamic>{
              'group': group.cliName,
              ..._counts(),
              'suites': 0,
              'suite_wall_interval_sum_ms': 0,
            },
        };
    final suites = <Map<String, dynamic>>[], tests = <Map<String, dynamic>>[];
    for (final package in packages) {
      _mergeCounts(totals, package['counts'] as Map<String, dynamic>);
      suites.addAll((package['suites'] as List).cast<Map<String, dynamic>>());
      tests.addAll((package.remove('tests') as List).cast<Map<String, dynamic>>());
    }
    for (final suite in suites) {
      final group = groups[suite['group']]!;
      _mergeCounts(group, suite);
      _add(group, 'suites', 1);
      if (suite['wall_interval_ms'] is num) _add(group, 'suite_wall_interval_sum_ms', suite['wall_interval_ms'] as num);
    }
    final observedPackages = packages
        .where((row) => row['present'] == true)
        .map((row) => row['package'] as String)
        .toSet();
    final missingPackages = expected.where((package) => !observedPackages.contains(package)).toList();
    final missingSuites = <Map<String, dynamic>>[], unexpectedSuites = <Map<String, dynamic>>[];
    for (final package in expected) {
      final observed = suites.where((row) => row['package'] == package).map((row) => row['suite']).toSet();
      for (final suite in selection[package]!) {
        if (!observed.contains(suite)) {
          missingSuites.add({
            'package': package,
            'suite': suite,
            'group': testGroupForSuite(repository, package, suite).cliName,
          });
        }
      }
      unexpectedSuites.addAll(
        suites.where((row) => row['package'] == package && !selection[package]!.contains(row['suite'])),
      );
    }
    final issues = packages.fold<int>(0, (value, row) => value + (row['protocol_issues'] as int));
    final lateErrors = packages.fold<int>(0, (value, row) => value + (row['late_errors'] as int));
    final protocolsComplete = packages.every((row) => row['protocol_complete'] == true);
    final slowSuites = [...suites]
      ..sort((a, b) => ((b['wall_interval_ms'] as int?) ?? -1).compareTo((a['wall_interval_ms'] as int?) ?? -1));
    final slowTests = tests.where((row) => row['duration_ms'] is int).toList()
      ..sort((a, b) => (b['duration_ms'] as int).compareTo(a['duration_ms'] as int));
    final selectedComplete =
        missingPackages.isEmpty && missingSuites.isEmpty && unexpectedSuites.isEmpty && protocolsComplete;
    final fullScope =
        testPackages.every(expected.contains) &&
        expected.every((package) {
          final catalogue = allTestSuites(repository, package);
          return catalogue.length == selection[package]!.length && catalogue.every(selection[package]!.contains);
        });
    final report = <String, dynamic>{
      'schema_version': 1,
      'timing_semantics': 'Runner-relative milliseconds; test and suite interval sums overlap and are not command wall time. Work before JSON start is not measured.',
      'counts': totals,
      'success': packages.every((row) => row['success'] == true),
      'protocol_issues': issues,
      'late_errors': lateErrors,
      'groups': groups.values.toList(),
      'packages': packages,
      'slow_suites': slowSuites.take(30).toList(),
      'slow_tests': slowTests.take(50).toList(),
      'unclassified': suites.where((row) => row['group'] == TestGroup.unclassified.cliName).toList(),
      'completeness': {
        'complete': fullScope && selectedComplete,
        'selected_scope_complete': selectedComplete,
        'protocols_complete': protocolsComplete,
        'full_package_scope': fullScope,
        'expected_packages': expected,
        'expected_suites': selection,
        'observed_packages': observedPackages.toList(),
        'missing_packages': missingPackages,
        'missing_suites': missingSuites,
        'unexpected_suites': unexpectedSuites,
        'ignored_package_reports': [
          for (final package in testPackages)
            if (!expected.contains(package) && File(p.join(directory.path, '$package.jsonl')).existsSync()) package,
        ],
        'scope': 'Observed runner events compared with current checkout test files; classification is not coverage or proof of discovery.',
      },
    };
    await directory.create(recursive: true);
    await File(p.join(directory.path, 'summary.json'))
        .writeAsString('${const JsonEncoder.withIndent('  ').convert(report)}\n');
    await File(p.join(directory.path, 'summary.md')).writeAsString(_markdown(report, repository, directory));
    _profileLog.info(
      'action=report result=written packages=${packages.length} tests=${totals['total']} failed=${totals['failed']} '
      'incomplete=${!selectedComplete} selectedScopeComplete=$selectedComplete fullRepositoryScope=$fullScope '
      'success=${report['success']}',
    );
    if (!selectedComplete || report['success'] != true) {
      _profileLog.warning(
        'action=report result=incomplete selectedScopeComplete=$selectedComplete fullRepositoryScope=$fullScope '
        'success=${report['success']}',
      );
      throw const IncompleteTestProfile();
    }
  } on IncompleteTestProfile {
    rethrow;
  } on Object catch (error) {
    _profileLog.warning('action=report result=failed reason=${error.runtimeType}');
    rethrow;
  }
}
