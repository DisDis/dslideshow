import 'dart:async';
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:dslideshow_tools/src/ambient/cli.dart';
import 'package:dslideshow_tools/src/benchmarks/cli.dart';
import 'package:dslideshow_tools/src/benchmarks/native_pipeline/cli.dart';
import 'package:dslideshow_tools/src/build/android.dart';
import 'package:dslideshow_tools/src/coverage/cli.dart';
import 'package:dslideshow_tools/src/testing/cli.dart';
import 'package:logging/logging.dart';

enum _Command { coverage, ambient, benchmark, nativePipeline, tests, android }

const _testsUsage =
    'Usage: dslideshow_tools tests <groups [options]|report DIRECTORY>\n'
    'Use dslideshow_tools tests --help for group and report commands.';

Future<void> main(List<String> arguments) async {
  if (arguments.isEmpty || arguments.first == '--help' || arguments.first == '-h') {
    stdout.writeln(
      'DSlideshow tools\nUsage: dslideshow_tools <coverage|ambient|benchmark|native|tests|build-android> [arguments]\n'
      'Production release: dart run tool/grind.dart release',
    );
    return;
  }
  final command = switch (arguments.first) {
    'coverage' => _Command.coverage,
    'ambient' => _Command.ambient,
    'benchmark' => _Command.benchmark,
    'native' => _Command.nativePipeline,
    'tests' => _Command.tests,
    'build-android' => _Command.android,
    _ => null,
  };
  if (command == null) {
    stderr.writeln('Unknown tool; use --help');
    exitCode = 64;
    return;
  }
  Logger.root.level = Level.INFO;
  final logs = Logger.root.onRecord.listen(
    (record) => stderr.writeln('${record.level.name} ${record.loggerName} ${record.message}'),
  );
  try {
    final rest = arguments.skip(1).toList();
    exitCode = await switch (command) {
      _Command.coverage => runCoverage(rest),
      _Command.ambient => runAmbient(rest),
      _Command.benchmark => runBenchmark(rest),
      _Command.nativePipeline => runNativePipeline(rest),
      _Command.tests => runTests(rest),
      _Command.android => runAndroidBuild(rest),
    };
  } on UsageException catch (error) {
    stderr.writeln(error.message);
    stderr.writeln(error.usage);
    exitCode = 64;
  } on FormatException {
    stderr.writeln('Invalid input format');
    if (command == _Command.tests) stderr.writeln(_testsUsage);
    exitCode = 64;
  } on ArgumentError {
    stderr.writeln('Invalid arguments; use the selected command help');
    if (command == _Command.tests) stderr.writeln(_testsUsage);
    exitCode = 64;
  } on Object catch (error) {
    stderr.writeln('Tool failed: ${error.runtimeType}');
    exitCode = 1;
  } finally {
    await logs.cancel();
    await stdout.flush();
    await stderr.flush();
  }
}
