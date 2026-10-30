import 'dart:convert';
import 'dart:io';

import 'package:args/args.dart';
import 'package:logging/logging.dart';

import '../repository.dart';
import 'groups.dart';
import 'profile.dart';

enum _Command { groups, report }

final _testingLog = Logger('testing');
const _usage =
    'tests groups [--group effects] [--package backend] [--json]\n'
    'tests report DIRECTORY\nRun selected tests: dart run tool/grind.dart tests --test-group=effects';

Future<int> runTests(List<String> arguments, {Directory? repository, StringSink? output}) async {
  final out = output ?? stdout;
  if (arguments.isEmpty || arguments.first == '--help' || arguments.first == '-h') {
    out.writeln(_usage);
    return 0;
  }
  final command = switch (arguments.first) {
    'groups' => _Command.groups,
    'report' => _Command.report,
    _ => null,
  };
  if (command == null) throw ArgumentError('Unknown tests command; use tests --help');
  final rest = arguments.skip(1).toList();
  switch (command) {
    case _Command.groups:
      final parser = ArgParser()
        ..addOption('group', allowed: TestGroup.values.map((group) => group.cliName).toList())
        ..addMultiOption('package', allowed: testPackages)
        ..addFlag('json', negatable: false)
        ..addFlag('help', abbr: 'h', negatable: false);
      final parsed = parser.parse(rest);
      if (parsed.flag('help')) {
        out.writeln('$_usage\n${parser.usage}');
        return 0;
      }
      if (parsed.rest.isNotEmpty) throw ArgumentError('groups accepts named options only');
      final root = repository ?? findRepository(), selected = parsed.multiOption('package');
      final packages = selected.isEmpty ? testPackages : selected.toSet().toList();
      final groupName = parsed.option('group'),
          groups = groupName == null ? TestGroup.values : [parseTestGroup(groupName)!];
      final catalogue = <Map<String, dynamic>>[];
      for (final group in groups) {
        final selections = <Map<String, dynamic>>[];
        for (final package in packages) {
          final suites = testSuitesForGroup(root, package, group);
          if (suites.isEmpty) continue;
          selections.add({
            'package': package,
            'suites': suites,
            'command': [
              package == 'common' ||
                      package == 'rpc_serializers_generator' ||
                      package == 'backend' ||
                      package == 'tools'
                  ? 'dart'
                  : 'flutter',
              'test',
              if (package == 'backend') '--concurrency=1',
              if (!['common', 'rpc_serializers_generator', 'backend', 'tools'].contains(package)) '--no-pub',
              ...suites,
            ],
            'working_directory': package,
          });
        }
        catalogue.add({
          'group': group.cliName,
          'suite_count': selections.fold<int>(0, (sum, selection) => sum + (selection['suites'] as List).length),
          'packages': selections,
        });
      }
      final count = catalogue.fold<int>(0, (sum, row) => sum + (row['suite_count'] as int));
      if (parsed.flag('json')) {
        out.writeln(
          jsonEncode({
            'schema_version': 1,
            'suite_count': count,
            'groups': catalogue,
            'scope': 'Primary file contracts for the full catalogue; no source coverage inference. Grinder tests/release select application and build-tool suites; tools-tests runs all tools suites.',
          }),
        );
      } else {
        for (final row in catalogue) {
          out.writeln('${row['group']}: ${row['suite_count']} suites');
          for (final selection in (row['packages'] as List).cast<Map<String, dynamic>>()) {
            out.writeln('  cwd=${selection['package']} argv=${jsonEncode(selection['command'])}');
            for (final suite in selection['suites'] as List) {
              out.writeln('    $suite');
            }
          }
        }
      }
      _testingLog.info(
        'action=groups result=listed packages=${packages.length} groups=${catalogue.length} suites=$count',
      );
      return 0;
    case _Command.report:
      if (rest.length == 1 && ['--help', '-h'].contains(rest.single)) {
        out.writeln(_usage);
        return 0;
      }
      if (rest.length != 1 || rest.single.startsWith('-')) throw ArgumentError('report requires DIRECTORY');
      final directory = Directory(rest.single);
      if (!directory.existsSync()) throw ArgumentError('Profile directory does not exist');
      try {
        await writeTestProfile(repository ?? findRepository(), directory);
      } on IncompleteTestProfile {
        out.writeln('Test profile saved with incomplete or failed results: summary.json, summary.md');
        return 1;
      }
      out.writeln('Test profile written: summary.json, summary.md');
      return 0;
  }
}
