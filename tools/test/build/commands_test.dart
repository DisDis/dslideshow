import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dslideshow_tools/src/build/pipeline.dart';
import 'package:dslideshow_tools/src/process/supervisor.dart';
import 'package:dslideshow_tools/src/repository.dart';
import 'package:dslideshow_tools/src/testing/groups.dart';
import 'package:dslideshow_tools/src/testing/profile.dart';
import 'package:dslideshow_tools/src/testing/selection.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart' as p;
import 'package:test/test.dart';

class _Recorder extends ProcessSupervisor {
  _Recorder({this.onRun});
  final Future<void> Function(List<String> arguments, String label)? onRun;
  final commands = <(String, List<String>, String?, String)>[];
  int? elapsed;
  @override
  int get elapsedMilliseconds => elapsed ?? super.elapsedMilliseconds;
  @override
  Future<int> run(
    String executable,
    List<String> arguments, {
    String label = 'job',
    String? workingDirectory,
    Map<String, String>? environment,
    bool includeParentEnvironment = true,
    IOSink? stdoutSink,
    IOSink? stderrSink,
    bool streamOutput = true,
    Duration? timeout,
  }) async {
    commands.add((executable, List.of(arguments), workingDirectory, label));
    await onRun?.call(arguments, label);
    return 0;
  }
}

void _recordProtocol(List<String> arguments, Iterable<String> suites) {
  final argument = arguments.singleWhere((arg) => arg.startsWith('--file-reporter=json:'));
  final path = argument.substring('--file-reporter=json:'.length);
  expect(File(p.join(File(path).parent.path, 'scope.json')).existsSync(), isTrue);
  final events = <Map<String, Object?>>[
    {'type': 'start', 'time': 0},
  ];
  var index = 0;
  for (final suite in suites) {
    events.addAll([
      <String, Object?>{
        'type': 'suite',
        'time': index * 4,
        'suite': {'id': index, 'path': suite},
      },
      {
        'type': 'testStart',
        'time': index * 4 + 1,
        'test': {'id': index + 1, 'name': 'example $index', 'suiteID': index},
      },
      {
        'type': 'testDone',
        'time': index * 4 + 3,
        'testID': index + 1,
        'result': 'success',
        'skipped': false,
        'hidden': false,
      },
    ]);
    index++;
  }
  events.add({'type': 'done', 'time': index * 4 + 1, 'success': true});
  File(path).writeAsStringSync(events.map(jsonEncode).join('\n'));
}

void _createReleaseToolSuites(Directory root) {
  for (final name in releaseToolTestSuites) {
    final file = File(p.join(root.path, 'tools', name));
    file.parent.createSync(recursive: true);
    file.writeAsStringSync('// release tooling fixture');
  }
}

Directory _profileRepository() {
  final root = Directory.systemTemp.createTempSync('test-profile-command-');
  addTearDown(() => root.deleteSync(recursive: true));
  for (final package in testPackages.where((package) => package != 'tools')) {
    final suite = File(p.join(root.path, package, 'test/sample_test.dart'));
    suite.parent.createSync(recursive: true);
    suite.writeAsStringSync('// reporter fixture');
  }
  _createReleaseToolSuites(root);
  for (final name in [
    'ambient/ignored_test.dart',
    'benchmarks/ignored_test.dart',
    'build/benchmark_bundle_test.dart',
  ]) {
    final file = File(p.join(root.path, 'tools/test', name));
    file.parent.createSync(recursive: true);
    file.writeAsStringSync('// outside the release test scope');
  }
  return root;
}

void main() {
  test('analysis covers all packages and retains diagnostic policy and no-pub', () async {
    final recorder = _Recorder();
    final root = Directory('/fixture');
    await BuildPipeline(root: root, supervisor: recorder, dartExecutable: 'sdk-dart').analyze();
    expect(recorder.commands.map((command) => p.relative(command.$3!, from: root.path)).toSet(), {
      'common',
      'rpc_serializers_generator',
      'backend',
      'autover',
      'autover/example',
      'tools',
      'i18n',
      'system_metrics_widget',
      'dslideshow_flutter',
      'config_app',
      'benchmarks',
    });
    for (final (_, args, _, _) in recorder.commands) {
      expect(args, containsAll(['analyze', '--fatal-warnings']));
      expect(args, isNot(contains('--fatal-infos')));
    }
    for (final command in recorder.commands.where((command) => command.$1 == 'flutter')) {
      expect(command.$2, containsAll(['--no-pub', '--no-fatal-infos']));
    }
  });
  test('tests are independent of analyze and preserve backend port serialization', () async {
    final recorder = _Recorder();
    await BuildPipeline(root: findRepository(), supervisor: recorder, dartExecutable: 'sdk-dart').tests();
    expect(recorder.commands.map((command) => p.basename(command.$3!)).toSet(), {
      'common',
      'rpc_serializers_generator',
      'backend',
      'tools',
      'i18n',
      'system_metrics_widget',
      'dslideshow_flutter',
      'config_app',
    });
    expect(recorder.commands.every((command) => command.$2.first == 'test'), isTrue);
    expect(
      recorder.commands.singleWhere((command) => p.basename(command.$3!) == 'backend').$2,
      contains('--concurrency=1'),
    );
    for (final command in recorder.commands.where((command) => command.$1 == 'flutter')) {
      expect(command.$2, containsAll(['--no-pub', '--concurrency=4']));
    }
    expect(recorder.commands.every((command) => !command.$2.any((arg) => arg.startsWith('--file-reporter'))), isTrue);
  });
  test('application build commands preserve target and offline web resources', () async {
    final recorder = _Recorder();
    final pipeline = BuildPipeline(root: Directory('/fixture'), supervisor: recorder);
    await pipeline.aot();
    await pipeline.web();
    expect(recorder.commands[0].$2, ['build', '--arch=arm64', '--cpu=pi4', '--release']);
    expect(recorder.commands[1].$2, ['build', 'web', '--release', '--no-pub', '--no-web-resources-cdn', '--wasm']);
  });

  test('Flutter suite concurrency overrides do not change backend serialization', () async {
    final recorder = _Recorder();
    final pipeline = BuildPipeline(
      root: findRepository(),
      supervisor: recorder,
      dartExecutable: 'sdk-dart',
      flutterTestConcurrency: 2,
    );
    addTearDown(pipeline.close);
    await pipeline.tests();
    for (final command in recorder.commands.where((command) => command.$1 == 'flutter')) {
      expect(command.$2, contains('--concurrency=2'));
    }
    expect(recorder.commands.singleWhere((command) => command.$4 == 'tests:backend').$2, contains('--concurrency=1'));
  });

  test('all package jobs queue before work starts and backlog wait includes earlier jobs', () async {
    final firstBatch = Completer<void>();
    final pending = <Completer<void>>[];
    final messages = <String>[];
    final subscription = Logger.root.onRecord.listen((record) {
      if (record.loggerName == 'build') messages.add(record.message);
    });
    addTearDown(subscription.cancel);
    var active = 0, peak = 0;
    var released = false;
    final recorder = _Recorder(
      onRun: (_, _) async {
        active++;
        if (active > peak) peak = active;
        if (!released) {
          final gate = Completer<void>();
          pending.add(gate);
          if (pending.length == 3) firstBatch.complete();
          await gate.future;
        }
        active--;
      },
    )..elapsed = 100;
    final pipeline = BuildPipeline(root: Directory('/fixture'), supervisor: recorder, dartExecutable: 'sdk-dart');
    addTearDown(pipeline.close);
    final work = pipeline.analyze();
    await firstBatch.future;
    expect(messages.take(11).every((message) => message.contains('action=queued')), isTrue);
    expect(messages.where((message) => message.contains('action=queued')), hasLength(11));
    expect(recorder.commands, hasLength(3));
    expect(peak, 3);
    recorder.elapsed = 350;
    released = true;
    for (final gate in pending) {
      gate.complete();
    }
    await work;
    final starts = messages.where((message) => message.contains('action=dequeued')).toList();
    expect(starts, hasLength(11));
    expect(starts.take(3).every((message) => message.contains('queueWaitMs=0 elapsedMs=100')), isTrue);
    expect(starts.skip(3).every((message) => message.contains('queueWaitMs=250 elapsedMs=350')), isTrue);
    expect(peak, 3);
  });

  test('cancelled backlog never starts another package command', () async {
    late final _Recorder recorder;
    recorder = _Recorder(onRun: (_, _) => recorder.cancel(130));
    final pipeline = BuildPipeline(
      root: Directory('/fixture'),
      supervisor: recorder,
      jobs: 1,
      dartExecutable: 'sdk-dart',
    );
    addTearDown(pipeline.close);
    await expectLater(
      pipeline.analyze(),
      throwsA(isA<ProcessJobFailure>().having((failure) => failure.code, 'code', 130)),
    );
    expect(recorder.commands, hasLength(1));
  });

  test('native JSON file reporters preserve console reporting and produce one combined profile', () async {
    final root = _profileRepository();
    final messages = <String>[];
    final subscription = Logger.root.onRecord.listen((record) {
      if (record.loggerName == 'build') messages.add(record.message);
    });
    addTearDown(subscription.cancel);
    final reports = Directory(p.join(root.path, 'reports with spaces'));
    final toolsReports = Directory(p.join(root.path, 'full tools reports'));
    final recorder = _Recorder(
      onRun: (arguments, label) async {
        final tools = label == 'tests:tools';
        final suites = !tools
            ? ['test/sample_test.dart']
            : arguments.contains(releaseToolTestSuites.first)
            ? releaseToolTestSuites
            : allTestSuites(root, 'tools');
        _recordProtocol(arguments, suites);
      },
    );
    final pipeline = BuildPipeline(
      root: root,
      supervisor: recorder,
      dartExecutable: 'sdk-dart',
      testReportDirectory: reports,
      toolsTestReportDirectory: toolsReports,
    );
    addTearDown(pipeline.close);
    await pipeline.tests();
    expect(recorder.commands, hasLength(8));
    for (final (_, arguments, _, label) in recorder.commands) {
      expect(
        arguments,
        contains('--file-reporter=json:${p.join(reports.path, '${label.substring('tests:'.length)}.jsonl')}'),
      );
      expect(arguments, contains('--reporter=expanded'));
    }
    expect(reports.listSync().whereType<File>().where((file) => p.extension(file.path) == '.jsonl'), hasLength(8));
    expect(File(p.join(reports.path, 'summary.json')).existsSync(), isTrue);
    expect(File(p.join(reports.path, 'summary.md')).existsSync(), isTrue);
    final savedScope = File(p.join(reports.path, 'scope.json')).readAsStringSync();
    final scope = jsonDecode(savedScope) as Map<String, dynamic>;
    expect(scope['expected_suites']['tools'], releaseToolTestSuites);
    expect(recorder.commands.singleWhere((command) => command.$4 == 'tests:tools').$2, [
      'test',
      '--reporter=expanded',
      '--file-reporter=json:${p.join(reports.path, 'tools.jsonl')}',
      ...releaseToolTestSuites,
    ]);
    final summary = jsonDecode(File(p.join(reports.path, 'summary.json')).readAsStringSync()) as Map<String, dynamic>;
    expect(summary['completeness']['selected_scope_complete'], isTrue);
    expect(summary['completeness']['complete'], isFalse);
    final phases = messages.where((message) => message.contains('action=test-profile')).toList();
    expect(phases, hasLength(2));
    expect(phases.first, contains('result=started'));
    expect(phases.last, contains('result=passed'));
    expect(phases.last, contains('durationMs='));
    expect(phases.every((message) => message.contains('elapsedMs=')), isTrue);
    await pipeline.toolsTests();
    expect(recorder.commands, hasLength(9));
    expect(recorder.commands.last.$4, 'tests:tools');
    expect(recorder.commands.last.$2, [
      'test',
      '--reporter=expanded',
      '--file-reporter=json:${p.join(toolsReports.path, 'tools.jsonl')}',
    ]);
    final toolsScope =
        jsonDecode(File(p.join(toolsReports.path, 'scope.json')).readAsStringSync()) as Map<String, dynamic>;
    expect(toolsScope['expected_packages'], ['tools']);
    expect(toolsScope['expected_suites']['tools'], allTestSuites(root, 'tools'));
    expect(File(p.join(toolsReports.path, 'summary.json')).existsSync(), isTrue);
    expect(File(p.join(reports.path, 'scope.json')).readAsStringSync(), savedScope);
    expect(messages, contains(contains('action=tests scope=release result=passed')));
    expect(messages, contains(contains('action=tests scope=tools result=passed')));
  });

  test('missing mandatory tooling suite rejects test jobs before commands or reports start', () async {
    final root = _profileRepository();
    final missing = File(p.join(root.path, 'tools', releaseToolTestSuites.last))..deleteSync();
    final reports = Directory(p.join(root.path, 'reports'));
    final recorder = _Recorder();
    final pipeline = BuildPipeline(root: root, supervisor: recorder, testReportDirectory: reports);
    addTearDown(pipeline.close);
    await expectLater(
      pipeline.tests(),
      throwsA(isA<FileSystemException>().having((error) => error.path, 'path', missing.path)),
    );
    expect(recorder.commands, isEmpty);
    expect(reports.existsSync(), isFalse);
  });

  test('successful runner exit cannot hide a selected tooling suite missing from the profile', () async {
    final root = _profileRepository();
    final reports = Directory(p.join(root.path, 'reports'));
    final recorder = _Recorder(
      onRun: (arguments, label) async => _recordProtocol(
        arguments,
        label == 'tests:tools' ? releaseToolTestSuites.skip(1) : ['test/sample_test.dart'],
      ),
    );
    final pipeline = BuildPipeline(root: root, supervisor: recorder, testReportDirectory: reports);
    addTearDown(pipeline.close);
    await expectLater(pipeline.tests(), throwsA(isA<IncompleteTestProfile>()));
    expect(recorder.commands, hasLength(8));
    final summary = jsonDecode(File(p.join(reports.path, 'summary.json')).readAsStringSync()) as Map<String, dynamic>;
    expect(summary['completeness']['selected_scope_complete'], isFalse);
    expect(summary['completeness']['missing_suites'], [
      {'package': 'tools', 'suite': releaseToolTestSuites.first, 'group': 'tooling-protocol'},
    ]);
    expect(File(p.join(reports.path, 'summary.md')).existsSync(), isTrue);
  });

  test('functional group passes literal suite paths and skips packages without matching files', () async {
    final root = Directory.systemTemp.createTempSync('grouped-command-');
    addTearDown(() => root.deleteSync(recursive: true));
    _createReleaseToolSuites(root);
    final effect = File(p.join(root.path, 'dslideshow_flutter/test/mosaic_optimization_test.dart'));
    effect.parent.createSync(recursive: true);
    effect.writeAsStringSync('// effects fixture');
    final other = File(p.join(root.path, 'backend/test/gallery_catalog_test.dart'));
    other.parent.createSync(recursive: true);
    other.writeAsStringSync('// gallery fixture');
    final reports = Directory(p.join(root.path, 'reports'));
    final recorder = _Recorder(onRun: (arguments, _) async => _recordProtocol(arguments, [arguments.last]));
    final pipeline = BuildPipeline(
      root: root,
      supervisor: recorder,
      dartExecutable: 'sdk-dart',
      testReportDirectory: reports,
    );
    addTearDown(pipeline.close);
    await pipeline.tests(group: TestGroup.effects);
    expect(recorder.commands, hasLength(1));
    expect(recorder.commands.single.$4, 'tests:dslideshow_flutter');
    expect(recorder.commands.single.$2, [
      'test',
      '--reporter=expanded',
      '--no-pub',
      '--concurrency=4',
      '--file-reporter=json:${p.join(reports.path, 'dslideshow_flutter.jsonl')}',
      'test/mosaic_optimization_test.dart',
    ]);
    final scope = jsonDecode(File(p.join(reports.path, 'scope.json')).readAsStringSync()) as Map<String, dynamic>;
    expect(scope['expected_packages'], ['dslideshow_flutter']);
    expect(scope['expected_suites'], {
      'dslideshow_flutter': ['test/mosaic_optimization_test.dart'],
    });
    final summary = jsonDecode(File(p.join(reports.path, 'summary.json')).readAsStringSync()) as Map<String, dynamic>;
    expect(summary['completeness']['selected_scope_complete'], isTrue);
    expect(summary['completeness']['full_package_scope'], isFalse);
  });

  test('compact display selects the native test reporter without changing concurrency', () async {
    final recorder = _Recorder();
    final pipeline = BuildPipeline(
      root: findRepository(),
      supervisor: recorder,
      dartExecutable: 'sdk-dart',
      testReporter: BuildTestReporter.compact,
    );
    addTearDown(pipeline.close);
    await pipeline.tests();
    expect(recorder.commands, hasLength(8));
    for (final (_, arguments, _, label) in recorder.commands) {
      expect(arguments, contains('--reporter=compact'));
      expect(arguments, isNot(contains('--reporter=json')));
      if (label == 'tests:backend') expect(arguments, contains('--concurrency=1'));
      if (label == 'tests:dslideshow_flutter' || label == 'tests:config_app') {
        expect(arguments, containsAll(['--no-pub', '--concurrency=4']));
      }
    }
  });

  test('existing report files are preserved and rejected before any command starts', () async {
    final root = Directory.systemTemp.createTempSync('stale-profile-command-');
    addTearDown(() => root.deleteSync(recursive: true));
    _createReleaseToolSuites(root);
    final reports = Directory(p.join(root.path, 'reports'))..createSync();
    for (final name in ['backend.jsonl', 'summary.json', 'scope.json']) {
      final saved = File(p.join(reports.path, name))..writeAsStringSync('previous run');
      final recorder = _Recorder();
      final pipeline = BuildPipeline(root: root, supervisor: recorder, testReportDirectory: reports);
      addTearDown(pipeline.close);
      await expectLater(pipeline.tests(group: TestGroup.effects), throwsStateError);
      expect(recorder.commands, isEmpty);
      expect(saved.readAsStringSync(), 'previous run');
      saved.deleteSync();
    }
  });
}
