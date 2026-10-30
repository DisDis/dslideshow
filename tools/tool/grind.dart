import 'dart:async';
import 'dart:io';

import 'package:args/args.dart';
import 'package:cli_util/cli_logging.dart' show Ansi;
import 'package:dslideshow_tools/src/build/pipeline.dart';
import 'package:dslideshow_tools/src/process/console.dart';
import 'package:dslideshow_tools/src/process/supervisor.dart';
import 'package:dslideshow_tools/src/repository.dart';
import 'package:dslideshow_tools/src/testing/groups.dart';
import 'package:grinder/grinder.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart' as p;

enum _BuildTask { analyze, tests, toolsTests, aot, web, release }

extension on _BuildTask {
  String get cliName => switch (this) {
    _BuildTask.toolsTests => 'tools-tests',
    _ => name,
  };
}

const _descriptions = {
  _BuildTask.analyze: 'Analyze every Dart and Flutter package without changing versions',
  _BuildTask.tests: 'Run application and build-tool tests without changing versions',
  _BuildTask.toolsTests: 'Run the complete tools test suite without changing versions',
  _BuildTask.aot: 'Build production Raspberry Pi AOT',
  _BuildTask.web: 'Build the offline Wasm and JavaScript web bundle',
  _BuildTask.release: 'Prepare a version, run four parallel branches, then package DEB (default)',
};
final _log = Logger('build');

Future<void> main(List<String> arguments) async {
  final terminal =
      stdout.hasTerminal &&
      stderr.hasTerminal &&
      stdout.supportsAnsiEscapes &&
      stderr.supportsAnsiEscapes &&
      Platform.environment['TERM'] != 'dumb';
  final parser = ArgParser()
    ..addFlag('help', abbr: 'h', negatable: false, help: 'Show build tasks and options')
    ..addOption(
      'test-group',
      allowed: TestGroup.values.map((group) => group.cliName),
      help: 'Run a functional test group with the standalone tests task',
    )
    ..addFlag(
      'color',
      defaultsTo: terminal && !Platform.environment.containsKey('NO_COLOR'),
      help: 'Enable terminal colors (auto in a terminal; overrides NO_COLOR when explicit)',
    )
    ..addFlag('progress', defaultsTo: terminal, help: 'Update compact test progress in an ANSI terminal');
  late ArgResults parsed;
  try {
    parsed = parser.parse(arguments);
  } on FormatException {
    stderr.writeln('Invalid build arguments');
    stderr.writeln(parser.usage);
    exitCode = 64;
    return;
  }
  if (parsed.flag('help')) {
    stdout.writeln('DSlideshow build tasks\nUsage: dart run tool/grind.dart [options] [tasks]\n${parser.usage}\n');
    for (final task in _BuildTask.values) {
      stdout.writeln('${task.cliName.padRight(12)} ${_descriptions[task]}');
    }
    return;
  }
  final requested = <_BuildTask>[];
  for (final name in parsed.rest) {
    final task = _BuildTask.values.where((task) => task.cliName == name).firstOrNull;
    if (task == null) {
      stderr.writeln('Unknown build task; use --help');
      exitCode = 64;
      return;
    }
    requested.add(task);
  }
  if (requested.isEmpty) requested.add(_BuildTask.release);
  if (requested.contains(_BuildTask.tests) && requested.contains(_BuildTask.release)) {
    stderr.writeln('release already includes application and build-tool tests; choose tests or release');
    exitCode = 64;
    return;
  }
  final groupName = parsed.option('test-group');
  final group = groupName == null ? null : parseTestGroup(groupName)!;
  if (group != null && requested.any((task) => task != _BuildTask.tests)) {
    stderr.writeln('--test-group is only accepted with standalone tests tasks');
    exitCode = 64;
    return;
  }
  final jobs = int.tryParse(Platform.environment['DSLIDESHOW_BUILD_JOBS'] ?? '3');
  if (jobs == null || jobs < 1) {
    stderr.writeln('DSLIDESHOW_BUILD_JOBS must be a positive integer');
    exitCode = 64;
    return;
  }
  final flutterTestConcurrency = int.tryParse(Platform.environment['DSLIDESHOW_FLUTTER_TEST_CONCURRENCY'] ?? '4');
  if (flutterTestConcurrency == null || flutterTestConcurrency < 1) {
    stderr.writeln('DSLIDESHOW_FLUTTER_TEST_CONCURRENCY must be a positive integer');
    exitCode = 64;
    return;
  }
  final reportOverride = Platform.environment['DSLIDESHOW_TEST_REPORT_DIR'];
  if (reportOverride != null && reportOverride.isEmpty) {
    stderr.writeln('DSLIDESHOW_TEST_REPORT_DIR must be a nonempty path');
    exitCode = 64;
    return;
  }

  Logger.root.level = Level.INFO;
  var columns = 120;
  if (terminal) {
    try {
      columns = stdout.terminalColumns;
      if (columns < 2) columns = 120;
    } on StdoutException {
      // A terminal may detach after capability detection.
    }
  }
  final console = BuildConsole(
    output: stdout,
    errors: stderr,
    flushOutput: stdout.flush,
    flushErrors: stderr.flush,
    color: parsed.flag('color'),
    interactive: terminal && parsed.flag('progress'),
    columns: columns,
  );
  Future<void> reportFailure(String message) async {
    try {
      await console.writeLog(LogRecord(Level.SEVERE, message, 'build'));
    } on Object {
      // close() reports queued console failures after process cleanup.
    }
  }

  final logs = Logger.root.onRecord.listen((record) {
    // close() reports the same queued write error after process cleanup.
    unawaited(console.writeLog(record).catchError((Object _) {}));
  });
  final supervisor = ProcessSupervisor(console: console);
  BuildPipeline? pipeline;
  final signals = [
    ProcessSignal.sigint.watch().listen((_) => unawaited(supervisor.cancel(130))),
    if (!Platform.isWindows) ProcessSignal.sigterm.watch().listen((_) => unawaited(supervisor.cancel(143))),
  ];
  try {
    final repository = findRepository();
    final mixedTestScopes =
        requested.contains(_BuildTask.toolsTests) &&
        (requested.contains(_BuildTask.tests) || requested.contains(_BuildTask.release));
    Directory reportDirectory(String scope) {
      if (reportOverride == null) {
        return Directory(p.join(repository.path, '.local/grinder', supervisor.runId, scope));
      }
      final path = p.isAbsolute(reportOverride) ? reportOverride : p.join(repository.path, reportOverride);
      return Directory(mixedTestScopes ? p.join(path, scope) : path);
    }

    final applicationReports = reportDirectory('tests');
    final toolsReports = reportDirectory('tools-tests');
    final active = pipeline = BuildPipeline(
      root: repository,
      supervisor: supervisor,
      jobs: jobs,
      flutterTestConcurrency: flutterTestConcurrency,
      testReporter: console.interactive ? BuildTestReporter.compact : BuildTestReporter.expanded,
      testReportDirectory: applicationReports,
      toolsTestReportDirectory: toolsReports,
    );
    _log.info(
      'run=${supervisor.runId} action=settings jobs=$jobs flutterTestConcurrency=$flutterTestConcurrency '
      'color=${console.color} progress=${console.interactive} testReporter=${active.testReporter.name} '
      'testGroup=${group?.cliName ?? 'full'} testReportDirectory=${applicationReports.absolute.path} '
      'toolsTestReportDirectory=${toolsReports.absolute.path} '
      'elapsedMs=${supervisor.elapsedMilliseconds}',
    );
    final scheduler = Grinder()..ansi = Ansi(console.color);
    for (final task in _BuildTask.values) {
      scheduler.addTask(
        GrinderTask(
          task.cliName,
          description: _descriptions[task],
          taskFunction: () => _run(active, task, group: group),
        ),
      );
    }
    // Grinder's CLI runTasks() calls exit(1) when a task throws. Its scheduler
    // propagates errors, allowing this owner to finish teardown and return 130/143.
    await scheduler.start(requested.map((task) => task.cliName));
  } on ProcessJobFailure catch (error) {
    exitCode = supervisor.cancellationCode ?? error.code;
    await reportFailure(error.toString());
  } on Object catch (error) {
    exitCode = supervisor.cancellationCode ?? 1;
    await reportFailure('Build failed: ${error.runtimeType}');
  } finally {
    try {
      if (pipeline != null) {
        await pipeline.close();
      } else {
        await supervisor.close();
      }
    } on Object catch (error) {
      if (exitCode == 0) exitCode = 1;
      await reportFailure('Build cleanup failed: ${error.runtimeType}');
    } finally {
      for (final subscription in signals) {
        await subscription.cancel();
      }
      final cancellationCode = supervisor.cancellationCode;
      if (exitCode == 0 && (cancellationCode == 130 || cancellationCode == 143)) {
        exitCode = cancellationCode!;
      }
      final outcome = exitCode == 0
          ? 'passed'
          : exitCode == 130 || exitCode == 143
          ? 'cancelled'
          : 'failed';
      _log.info(
        'run=${supervisor.runId} action=finish result=$outcome code=$exitCode elapsedMs=${supervisor.elapsedMilliseconds}',
      );
      await logs.cancel();
      try {
        await console.close();
        await stdout.flush();
        await stderr.flush();
      } on Object catch (error) {
        if (exitCode == 0) exitCode = 1;
        try {
          stderr.writeln('Build console failed: ${error.runtimeType}');
          await stderr.flush();
        } on Object {
          // A detached stderr must not override process failure or signal codes.
        }
      }
    }
  }
}

Future<void> _run(BuildPipeline pipeline, _BuildTask task, {TestGroup? group}) async {
  switch (task) {
    case _BuildTask.analyze:
      await pipeline.analyze();
    case _BuildTask.tests:
      await pipeline.tests(group: group);
    case _BuildTask.toolsTests:
      await pipeline.toolsTests();
    case _BuildTask.aot:
      await pipeline.aot();
    case _BuildTask.web:
      await pipeline.web();
    case _BuildTask.release:
      final artifact = await pipeline.release();
      stdout.writeln(artifact.path);
  }
}
