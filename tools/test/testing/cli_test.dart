@Timeout(Duration(seconds: 60))
library;

import 'dart:convert';
import 'dart:io';

import 'package:cli_util/cli_util.dart' as cli;
import 'package:dslideshow_tools/src/repository.dart';
import 'package:dslideshow_tools/src/testing/cli.dart';
import 'package:dslideshow_tools/src/testing/groups.dart';
import 'package:path/path.dart' as p;
import 'package:logging/logging.dart';
import 'package:test/test.dart';

import '../support/compiled_dart_fixture.dart';

void main() {
  final repository = findRepository(), source = File(p.absolute('bin/dslideshow_tools.dart'));
  final packages = File('.dart_tool/package_config.json').absolute;
  late String entry;
  setUpAll(() async {
    final directory = await Directory.systemTemp.createTemp('testing-cli-kernel-');
    addTearDown(() async {
      if (directory.existsSync()) await directory.delete(recursive: true);
    });
    entry = (await compileDartFixture(source, directory, packageConfig: packages)).path;
  });
  Future<ProcessResult> run(List<String> arguments, {String? root}) => Process.run(
    cli.dartExecutable!,
    ['--disable-dart-dev', entry, 'tests', ...arguments],
    environment: {'DSLIDESHOW_REPO': root ?? repository.path},
  );
  test('group JSON keeps stdout machine readable and lists each suite once', () async {
    final result = await run(['groups', '--package', 'common', '--json']);
    expect(result.exitCode, 0, reason: result.stderr.toString());
    final report = jsonDecode(result.stdout.toString()) as Map<String, dynamic>;
    final groups = report['groups'] as List;
    expect(groups, hasLength(TestGroup.values.length));
    final suites = [
      for (final row in groups)
        for (final package in row['packages'] as List) ...package['suites'] as List,
    ];
    expect(suites.length, allTestSuites(repository, 'common').length);
    expect(suites.toSet().length, suites.length);
    expect(result.stderr, contains('action=groups result=listed'));
  }, timeout: const Timeout(Duration(seconds: 30)));
  test('effects filter returns scoped argv without executing tests', () async {
    final output = StringBuffer();
    expect(
      await runTests(
        ['groups', '--group', 'effects', '--package', 'common', '--json'],
        repository: repository,
        output: output,
      ),
      0,
    );
    final report = jsonDecode(output.toString()) as Map<String, dynamic>;
    final group = (report['groups'] as List).single as Map, package = (group['packages'] as List).single as Map;
    expect(group['group'], 'effects');
    expect(package['suites'], ['test/effect_presets_test.dart', 'test/effects_test.dart']);
    expect(package['working_directory'], 'common');
    expect(package['command'], ['dart', 'test', 'test/effect_presets_test.dart', 'test/effects_test.dart']);
  }, timeout: const Timeout(Duration(seconds: 30)));
  test('help is available before repository discovery; malformed arguments return usage 64', () async {
    final help = StringBuffer();
    expect(await runTests(['groups', '--help'], repository: Directory('/missing/repository'), output: help), 0);
    expect(help.toString(), contains('--test-group=effects'));
    for (final arguments in [
      ['groups', '--group', 'never-supported'],
      ['groups', '--package', 'absent-package'],
      ['groups', 'extra'],
      ['report'],
      ['unknown-command'],
    ]) {
      await expectLater(
        runTests(arguments, repository: Directory('/missing/repository'), output: StringBuffer()),
        throwsA(anyOf(isA<FormatException>(), isA<ArgumentError>())),
      );
    }
    final result = await run(['groups', '--group', 'never-supported'], root: '/missing/repository');
    expect(result.exitCode, 64);
    expect(result.stdout, isEmpty);
    expect(result.stderr, isNotEmpty);
    expect(result.stderr, contains('Usage: dslideshow_tools tests'));
  }, timeout: const Timeout(Duration(seconds: 30)));
  test('report rebuild preserves selected scope, partial status and raw reporter bytes', () async {
    final directory = Directory.systemTemp.createTempSync('test-profile-cli-');
    addTearDown(() => directory.deleteSync(recursive: true));
    File(p.join(directory.path, 'scope.json')).writeAsStringSync(
      jsonEncode({
        'schema_version': 1,
        'expected_packages': ['common'],
        'expected_suites': {
          'common': ['test/effects_test.dart'],
        },
      }),
    );
    final file = File(p.join(directory.path, 'common.jsonl'))
      ..writeAsStringSync(
        '${[
          {'type': 'start', 'time': 0},
          {
            'type': 'suite',
            'suite': {'id': 1, 'path': 'test/effects_test.dart'},
          },
          {
            'type': 'testStart',
            'time': 1,
            'test': {'id': 2, 'name': 'unfinished', 'suiteID': 1},
          },
          {'type': 'print', 'testID': 2, 'message': 'private-print-payload'},
        ].map(jsonEncode).join('\n')}\n',
      );
    final bytes = file.readAsBytesSync();
    final output = StringBuffer(), logs = <LogRecord>[];
    final subscription = Logger('testProfile').onRecord.listen(logs.add);
    addTearDown(subscription.cancel);
    expect(await runTests(['report', directory.path], repository: repository, output: output), 1);
    expect(output.toString(), contains('saved with incomplete or failed results: summary.json, summary.md'));
    expect(logs.map((row) => row.message).join(), contains('action=report result=written'));
    final summary = File(p.join(directory.path, 'summary.json')).readAsStringSync();
    expect(summary, isNot(contains('private-print-payload')));
    final report = jsonDecode(summary) as Map<String, dynamic>;
    expect((report['completeness'] as Map)['selected_scope_complete'], false);
    expect((report['completeness'] as Map)['expected_packages'], ['common']);
    expect((report['counts'] as Map)['unfinished'], 1);
    expect(file.readAsBytesSync(), bytes);
  }, timeout: const Timeout(Duration(seconds: 30)));
}
