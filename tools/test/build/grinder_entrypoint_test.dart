@Timeout(Duration(seconds: 60))
library;

import 'dart:convert';
import 'dart:io';

import 'package:cli_util/cli_util.dart' as cli;
import 'package:dslideshow_tools/src/build/pipeline.dart';
import 'package:dslideshow_tools/src/repository.dart';
import 'package:dslideshow_tools/src/testing/selection.dart';
import 'package:path/path.dart' as p;
import 'package:test/test.dart';

import '../support/compiled_dart_fixture.dart';
import '../support/process_gate.dart';

void main() {
  final source = File(p.join(findRepository().path, 'tools/tool/grind.dart'));
  final packages = File('.dart_tool/package_config.json').absolute.path;
  final worker = File('test/support/process_worker.dart').absolute.path;
  late String entry;
  late Directory root;
  late ProcessGate gate;
  late File commandLog;
  late Map<String, String> environment;

  setUpAll(() async {
    final directory = await Directory.systemTemp.createTemp('grinder-entry-kernel-');
    addTearDown(() async {
      if (directory.existsSync()) await directory.delete(recursive: true);
    });
    entry = (await compileDartFixture(source, directory, packageConfig: File(packages))).path;
  });

  setUp(() async {
    root = await Directory.systemTemp.createTemp('grinder-entry-');
    gate = await ProcessGate.start();
    for (final package in [...BuildPipeline.dartPackages, ...BuildPipeline.flutterPackages, 'deb_factory']) {
      await Directory(p.join(root.path, package)).create(recursive: true);
    }
    for (final suite in releaseToolTestSuites) {
      final fixture = File(p.join(root.path, 'tools', suite));
      await fixture.parent.create(recursive: true);
      await fixture.writeAsString('// selected tool contract fixture; never executed');
    }
    commandLog = File(p.join(root.path, 'commands.log'));
    final stub = File(p.join(root.path, 'fake-dart'));
    await stub.writeAsString(
      '#!/bin/sh\nprintf "%s\\n" "\$1" >> "\$GRINDER_TEST_LOG"\n'
      'exec "${cli.dartExecutable}" --disable-dart-dev "$worker" analyze "${gate.port}" "${cli.dartExecutable}"\n',
    );
    expect((await Process.run('chmod', ['0755', stub.path])).exitCode, 0);
    environment = {
      'DSLIDESHOW_REPO': root.path,
      'DART_EXECUTABLE': stub.path,
      'DSLIDESHOW_BUILD_JOBS': '1',
      'DSLIDESHOW_FLUTTER_TEST_CONCURRENCY': '4',
      'GRINDER_TEST_LOG': commandLog.path,
    };
  });
  tearDown(() async {
    await gate.close();
    await root.delete(recursive: true);
  });

  Future<Process> start(List<String> tasks) => Process.start(
    cli.dartExecutable!,
    ['--disable-dart-dev', '--packages=$packages', entry, '--no-color', ...tasks],
    workingDirectory: p.join(root.path, 'tools'),
    environment: environment,
  );

  Future<void> recordPackageArguments() => File(p.join(root.path, 'fake-dart')).writeAsString(
    '#!/bin/sh\nprintf "%s\\n" "\$PWD" "\$@" >> "\$GRINDER_TEST_LOG"\n'
    'exec "${cli.dartExecutable}" --disable-dart-dev "$worker" analyze "${gate.port}" "${cli.dartExecutable}"\n',
  );

  test('task failure reaches owner cleanup and prevents later requested tasks', () async {
    environment['DSLIDESHOW_TEST_REPORT_DIR'] = 'profiles with spaces';
    final process = await start(['analyze', 'tests']);
    final output = process.stdout.transform(utf8.decoder).join();
    final errors = process.stderr.transform(utf8.decoder).join();
    await gate.ready(1);
    final child = gate.pids['analyze']!;
    gate.send('analyze', 'fail');
    expect(await process.exitCode.timeout(const Duration(seconds: 15)), isNonZero);
    final diagnostics = await errors;
    expect(diagnostics, contains('action=finish result=failed'));
    expect(diagnostics, contains('jobs=1 flutterTestConcurrency=4'));
    expect(diagnostics, contains('testReportDirectory=${p.join(root.path, 'profiles with spaces')}'));
    expect(diagnostics, contains('elapsedMs='));
    expect(diagnostics, contains('color=false progress=false testReporter=expanded'));
    expect(diagnostics, isNot(contains('\u001b[')));
    await output;
    expect(await commandLog.readAsLines(), ['analyze']);
    expect(Directory('/proc/$child').existsSync(), false);
  }, timeout: const Timeout(Duration(seconds: 30)));

  test('explicit color overrides NO_COLOR while redirected output stays expanded', () async {
    environment['NO_COLOR'] = '';
    final process = await start(['analyze', '--color', '--progress']);
    final output = process.stdout.transform(utf8.decoder).join();
    final errors = process.stderr.transform(utf8.decoder).join();
    await gate.ready(1);
    gate.send('analyze', 'fail');
    expect(await process.exitCode.timeout(const Duration(seconds: 15)), isNonZero);
    final diagnostics = await errors;
    expect(diagnostics, contains('\u001b['));
    expect(diagnostics, contains('color=true progress=false testReporter=expanded'));
    expect(diagnostics, contains('action=finish result=failed'));
    await output;
    expect(await commandLog.readAsLines(), ['analyze']);
  }, timeout: const Timeout(Duration(seconds: 30)));

  test('closed stdout pipe preserves failure exit and cleanup without an unhandled exception', () async {
    final source = File(p.join(root.path, 'write_after_gate.dart'))
      ..writeAsStringSync(r'''
import 'dart:convert';
import 'dart:io';
Future<void> main(List<String> args) async {
  final socket = await Socket.connect(InternetAddress.loopbackIPv4, int.parse(args.single));
  socket.writeln(jsonEncode({'label': 'analyze', 'pid': pid}));
  await socket.flush();
  await socket.cast<List<int>>().transform(utf8.decoder).transform(const LineSplitter()).first;
  stdout.writeln('worker stdout after readiness');
  await stdout.flush();
  socket.destroy();
  exitCode = 7;
}
''');
    await File(p.join(root.path, 'fake-dart')).writeAsString(
      '#!/bin/sh\nprintf "%s\\n" "\$1" >> "\$GRINDER_TEST_LOG"\n'
      'exec "${cli.dartExecutable}" --disable-dart-dev "${source.path}" "${gate.port}"\n',
    );
    final process = await start(['analyze', 'tests']);
    final output = process.stdout.listen((_) {});
    final errors = process.stderr.transform(utf8.decoder).join();
    await gate.ready(1);
    final child = gate.pids['analyze']!;
    await output.cancel();
    gate.send('analyze', 'fail');
    expect(await process.exitCode.timeout(const Duration(seconds: 15)), 1);
    final diagnostics = await errors;
    expect(diagnostics, contains('Build console failed:'));
    expect(diagnostics, contains('action=finish result=failed code=1'));
    expect(diagnostics, isNot(contains('Unhandled exception')));
    expect(await commandLog.readAsLines(), ['analyze']);
    expect(Directory('/proc/$child').existsSync(), false);
  }, timeout: const Timeout(Duration(seconds: 30)));

  test('tools-tests invokes only the tools package and preserves a single scope override', () async {
    environment['DSLIDESHOW_TEST_REPORT_DIR'] = 'tools profile with spaces';
    await recordPackageArguments();
    final process = await start(['tools-tests']);
    final output = process.stdout.transform(utf8.decoder).join();
    final errors = process.stderr.transform(utf8.decoder).join();
    await gate.ready(1);
    final child = gate.pids['analyze']!;
    gate.send('analyze', 'fail');
    expect(await process.exitCode.timeout(const Duration(seconds: 15)), 1);
    final arguments = await commandLog.readAsLines();
    expect(arguments.first, p.join(root.path, 'tools'));
    expect(arguments.where((argument) => argument == 'test'), hasLength(1));
    final reports = p.join(root.path, 'tools profile with spaces');
    expect(arguments, contains('--file-reporter=json:${p.join(reports, 'tools.jsonl')}'));
    final scope = jsonDecode(File(p.join(reports, 'scope.json')).readAsStringSync()) as Map<String, dynamic>;
    expect(scope['expected_packages'], ['tools']);
    final diagnostics = await errors;
    expect(diagnostics, contains('packages=1'));
    expect(diagnostics, isNot(contains('action=version')));
    expect(diagnostics, contains('action=finish result=failed code=1'));
    expect(Directory('/proc/$child').existsSync(), false);
    await output;
  }, timeout: const Timeout(Duration(seconds: 30)));

  test('tests and tools-tests reserve separate profile scopes under a shared override', () async {
    environment['DSLIDESHOW_TEST_REPORT_DIR'] = 'profiles with spaces';
    await recordPackageArguments();
    final process = await start(['tests', 'tools-tests']);
    final output = process.stdout.transform(utf8.decoder).join();
    final errors = process.stderr.transform(utf8.decoder).join();
    await gate.ready(1);
    final child = gate.pids['analyze']!;
    gate.send('analyze', 'fail');
    expect(await process.exitCode.timeout(const Duration(seconds: 15)), 1);
    final diagnostics = await errors;
    final reports = p.join(root.path, 'profiles with spaces');
    final core = p.join(reports, 'tests'), tools = p.join(reports, 'tools-tests');
    expect(diagnostics, contains('testReportDirectory=$core'));
    expect(diagnostics, contains('toolsTestReportDirectory=$tools'));
    expect(File(p.join(core, 'scope.json')).existsSync(), true);
    final arguments = await commandLog.readAsLines();
    expect(arguments.first, p.join(root.path, 'common'));
    expect(
      arguments.where((argument) => argument == 'test'),
      hasLength(1),
      reason: 'The failed first task stops tools-tests',
    );
    expect(arguments, contains('--file-reporter=json:${p.join(core, 'common.jsonl')}'));
    expect(arguments.any((argument) => argument.contains(p.join(tools, 'tools.jsonl'))), false);
    expect(Directory('/proc/$child').existsSync(), false);
    await output;
  }, timeout: const Timeout(Duration(seconds: 30)));

  for (final signal in [ProcessSignal.sigint, ProcessSignal.sigterm]) {
    test('actual entrypoint preserves $signal exit code after queue and process cleanup', () async {
      final process = await start(['analyze', 'tests']);
      final output = process.stdout.transform(utf8.decoder).join();
      final errors = process.stderr.transform(utf8.decoder).join();
      await gate.ready(1);
      final child = gate.pids['analyze']!;
      process.kill(signal);
      final expected = 128 + signal.signalNumber;
      expect(await process.exitCode.timeout(const Duration(seconds: 15)), expected);
      expect(await errors, contains('action=finish result=cancelled code=$expected'));
      await output;
      expect(await commandLog.readAsLines(), ['analyze']);
      expect(Directory('/proc/$child').existsSync(), false);
    }, timeout: const Timeout(Duration(seconds: 30)));
  }

  test('help and invalid tasks work before repository or worker initialization', () async {
    for (final arguments in [
      <String>['--help'],
      <String>['unknown-task'],
    ]) {
      final result = await Process.run(
        cli.dartExecutable!,
        ['--disable-dart-dev', '--packages=$packages', entry, ...arguments],
        workingDirectory: root.path,
        environment: {'DSLIDESHOW_REPO': p.join(root.path, 'absent')},
      );
      expect(result.exitCode, arguments.first == '--help' ? 0 : 64);
      if (arguments.first == '--help') {
        expect(result.stdout, contains('release'));
        expect(result.stdout, contains('tools-tests'));
        expect(result.stdout, contains('--[no-]progress'));
      }
    }
    expect(commandLog.existsSync(), false);
  }, timeout: const Timeout(Duration(seconds: 30)));

  test('invalid task and group combinations fail before repository initialization', () async {
    for (final arguments in [
      ['tests', 'release'],
      ['release', 'tests'],
      ['tests', '--test-group=unknown'],
      ['release', '--test-group=effects'],
      ['analyze', 'tests', '--test-group=gallery'],
      ['--test-group=effects'],
      ['tools-tests', '--test-group=effects'],
      ['tests', 'tools-tests', '--test-group=gallery'],
      ['toolsTests'],
    ]) {
      final result = await Process.run(
        cli.dartExecutable!,
        ['--disable-dart-dev', '--packages=$packages', entry, ...arguments],
        workingDirectory: root.path,
        environment: {'DSLIDESHOW_REPO': p.join(root.path, 'absent')},
      );
      expect(result.exitCode, 64);
      expect(result.stderr.toString(), isNot(contains('action=settings')));
    }
    final help = await Process.run(
      cli.dartExecutable!,
      ['--disable-dart-dev', '--packages=$packages', entry, '--test-group=slideshow-media', '--help'],
      workingDirectory: root.path,
      environment: {'DSLIDESHOW_REPO': p.join(root.path, 'absent')},
    );
    expect(help.exitCode, 0);
    expect(help.stdout, contains('tooling-protocol'));
    expect(commandLog.existsSync(), false);
  }, timeout: const Timeout(Duration(seconds: 30)));

  test('invalid runner settings fail before workers or repository lookup', () async {
    for (final values in [
      {'DSLIDESHOW_BUILD_JOBS': '0'},
      {'DSLIDESHOW_FLUTTER_TEST_CONCURRENCY': '0'},
      {'DSLIDESHOW_FLUTTER_TEST_CONCURRENCY': 'not-an-integer'},
      {'DSLIDESHOW_TEST_REPORT_DIR': ''},
    ]) {
      final result = await Process.run(
        cli.dartExecutable!,
        ['--disable-dart-dev', '--packages=$packages', entry, 'analyze'],
        workingDirectory: root.path,
        environment: {'DSLIDESHOW_REPO': p.join(root.path, 'absent'), ...values},
      );
      expect(result.exitCode, 64);
      expect(result.stderr.toString(), isNot(contains('action=settings')));
    }
    expect(commandLog.existsSync(), false);
  }, timeout: const Timeout(Duration(seconds: 30)));
}
