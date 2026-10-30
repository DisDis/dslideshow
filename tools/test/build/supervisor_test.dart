import 'dart:convert';
import 'dart:io';

import 'package:cli_util/cli_util.dart' as cli;
import 'package:dslideshow_tools/src/process/console.dart';
import 'package:dslideshow_tools/src/process/supervisor.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart' as p;
import 'package:test/test.dart';

import '../support/process_gate.dart';

final _elapsedPattern = RegExp(r'(?:^| )elapsedMs=(\d+)(?= |$)');

class _ObservedConsole extends BuildConsole {
  _ObservedConsole({required super.output, required super.errors, required super.color, required super.interactive});

  final started = <({String label, bool compact})>[];
  final finished = <String>[];
  final chunks = <({String label, String text, bool isError})>[];
  var closeCalls = 0;

  @override
  Future<void> startJob(String label, {bool compact = false}) async {
    await super.startJob(label, compact: compact);
    started.add((label: label, compact: compact));
  }

  @override
  Future<void> writeChunk(String label, String text, {bool isError = false}) async {
    chunks.add((label: label, text: text, isError: isError));
    await super.writeChunk(label, text, isError: isError);
  }

  @override
  Future<void> finishJob(String label) async {
    finished.add(label);
    await super.finishJob(label);
  }

  @override
  Future<void> close() async {
    closeCalls++;
    await super.close();
  }
}

void _expectElapsedLogs(ProcessSupervisor owner, List<LogRecord> logs, {int minimum = 0}) {
  final records = logs.where((record) => record.message.startsWith('run=${owner.runId} ')).toList();
  expect(records, isNotEmpty);
  final maximum = owner.elapsedMilliseconds;
  var previous = minimum;
  for (final record in records) {
    final match = _elapsedPattern.firstMatch(record.message);
    expect(match, isNotNull, reason: 'Missing monotonic elapsed time: ${record.message}');
    final elapsed = int.parse(match!.group(1)!);
    expect(elapsed, inInclusiveRange(previous, maximum), reason: record.message);
    previous = elapsed;
  }
}

void main() {
  final dart = cli.dartExecutable!;
  final worker = p.absolute('test/support/process_worker.dart');
  test('literal argv/environment and separate byte streams are preserved', () async {
    final root = await Directory.systemTemp.createTemp('literal process ');
    addTearDown(() => root.delete(recursive: true));
    final output = File(p.join(root.path, 'out'));
    final errors = File(p.join(root.path, 'err'));
    final out = output.openWrite(), err = errors.openWrite();
    final console = _ObservedConsole(output: StringBuffer(), errors: StringBuffer(), color: true, interactive: true);
    addTearDown(console.close);
    final owner = ProcessSupervisor(console: console);
    addTearDown(owner.close);
    final logs = <LogRecord>[];
    final subscription = Logger('build').onRecord.listen(logs.add);
    addTearDown(subscription.cancel);
    final beforeRun = owner.elapsedMilliseconds;
    expect(beforeRun, greaterThanOrEqualTo(0));
    const literal = 'spaces; \$(touch never) "quote"\nnext';
    await owner.run(
      dart,
      ['--disable-dart-dev', worker, 'echo', literal],
      workingDirectory: root.path,
      environment: {'LITERAL_VALUE': 'value'},
      label: 'tests:raw',
      stdoutSink: out,
      stderrSink: err,
    );
    await out.close();
    await err.close();
    expect(jsonDecode(await output.readAsString()), [literal, 'value']);
    expect(await errors.readAsString(), 'diagnostic');
    expect(console.chunks, isEmpty, reason: 'Raw stdout/stderr destinations must bypass console decoding');
    expect(console.started, [(label: 'tests:raw', compact: false)]);
    expect(console.finished, ['tests:raw']);
    expect(console.output.toString(), isEmpty);
    expect(console.errors.toString(), isEmpty);
    expect(File(p.join(root.path, 'never')).existsSync(), isFalse);
    _expectElapsedLogs(owner, logs, minimum: beforeRun);
    expect(logs.any((record) => record.message.contains('action=start')), isTrue);
    expect(logs.any((record) => record.message.contains('action=finish result=passed')), isTrue);
  });

  test('console receives decoded progress and diagnostics and clears each owned job once', () async {
    final root = await Directory.systemTemp.createTemp('console process ');
    addTearDown(() => root.delete(recursive: true));
    final output = StringBuffer(), errors = StringBuffer();
    final console = _ObservedConsole(output: output, errors: errors, color: true, interactive: true);
    final owner = ProcessSupervisor(console: console);
    addTearDown(() async {
      await owner.close();
      expect(console.closeCalls, 0, reason: 'The supervisor does not own the shared console');
      await console.close();
    });
    final source = File(p.join(root.path, 'progress.dart'))
      ..writeAsStringSync(r'''
import 'dart:io';
void main() {
  stdout.write('\x1b[32m00:00 +1: first\x1b[0m\r');
  stdout.writeln('00:00 +2: All tests passed!');
  stderr.write('\x1b[31mwarning detail\x1b[0m\r\n');
}
''');
    final arguments = ['--disable-dart-dev', source.path];
    expect(await owner.run(dart, arguments, label: 'tests:progress'), 0);
    final visible = console.chunks.where((chunk) => !chunk.isError).map((chunk) => chunk.text).join();
    final diagnostic = console.chunks.where((chunk) => chunk.isError).map((chunk) => chunk.text).join();
    expect(visible, contains('\x1b[32m00:00 +1: first\x1b[0m\r'));
    expect(visible, contains('All tests passed!'));
    expect(visible, isNot(contains('DSLIDESHOW_PROCESS_READY')));
    expect(diagnostic, '\x1b[31mwarning detail\x1b[0m\r\n');
    expect('$output$errors', contains('All tests passed!'));
    expect('$output$errors', contains('warning detail'));

    final shown = console.chunks.length;
    final displayBeforeSilent = '$output$errors';
    expect(await owner.run(dart, arguments, label: 'tests:silent', streamOutput: false), 0);
    expect(console.chunks, hasLength(shown), reason: 'streamOutput=false must consume without console forwarding');
    expect('$output$errors', displayBeforeSilent, reason: 'A silent job must not draw an empty progress row');
    await expectLater(
      owner.run(dart, arguments, label: 'tests:start-failure', workingDirectory: '/missing/working-directory'),
      throwsA(isA<ProcessJobFailure>().having((failure) => failure.reason, 'reason', 'start')),
    );
    await owner.cancel(130);
    await expectLater(
      owner.run(dart, arguments, label: 'tests:never-started'),
      throwsA(isA<ProcessJobFailure>().having((failure) => failure.code, 'code', 130)),
    );
    expect(console.started, [
      (label: 'tests:progress', compact: true),
      (label: 'tests:silent', compact: false),
      (label: 'tests:start-failure', compact: true),
    ]);
    expect(console.finished, ['tests:progress', 'tests:silent', 'tests:start-failure']);
  });

  for (final cancellation in [1, 130, 143]) {
    test('cancellation $cancellation kills exited-parent descendants and reports safe diagnostics', () async {
      final gate = await ProcessGate.start();
      addTearDown(gate.close);
      final owner = ProcessSupervisor(terminationGrace: const Duration(milliseconds: 80));
      addTearDown(owner.close);
      final logs = <LogRecord>[];
      final subscription = Logger('build').onRecord.listen(logs.add);
      addTearDown(subscription.cancel);
      final parent = owner.run(dart, [
        '--disable-dart-dev',
        worker,
        'parent',
        '${gate.port}',
        dart,
        '--child',
      ], streamOutput: false);
      await gate.ready(2);
      gate.send('parent', 'pass');
      await parent;
      expect(Directory('/proc/${gate.pids['parent.child']}').existsSync(), isTrue);
      await owner.cancel(cancellation);
      final stat = File('/proc/${gate.pids['parent.child']}/stat');
      // The system init may retain a dead zombie briefly; no live child survives.
      if (stat.existsSync()) expect(stat.readAsStringSync().split(') ').last.startsWith('Z '), isTrue);
      await expectLater(
        owner.run(dart, ['--disable-dart-dev', worker, 'echo', 'secret']),
        throwsA(isA<ProcessJobFailure>().having((error) => error.code, 'code', cancellation)),
      );
      expect(logs.any((record) => record.message.contains('action=cancel')), isTrue);
      expect(logs.map((record) => record.message).join(), isNot(contains('secret')));
      _expectElapsedLogs(owner, logs);
    });
  }

  for (final detached in [false, true]) {
    for (final exitCode in [0, 7]) {
      test(
        'exited leader $exitCode drains ${detached ? 'detached' : 'group'} inherited writers and leaves owner usable',
        () async {
          final gate = await ProcessGate.start();
          addTearDown(gate.close);
          final owner = ProcessSupervisor(terminationGrace: const Duration(milliseconds: 80));
          addTearDown(owner.close);
          final logs = <LogRecord>[];
          final subscription = Logger('build').onRecord.listen(logs.add);
          addTearDown(subscription.cancel);
          final sibling = owner.run(
            dart,
            ['--disable-dart-dev', worker, 'sibling', '${gate.port}', dart],
            label: 'sibling',
            streamOutput: false,
            timeout: const Duration(seconds: 25),
          );
          final work = owner.run(
            dart,
            [
              '--disable-dart-dev',
              p.absolute('test/support/pipe_holder_worker.dart'),
              'pipe-parent',
              '${gate.port}',
              dart,
              detached ? 'detached' : 'group',
            ],
            label: 'pipe-parent',
            streamOutput: false,
            timeout: const Duration(seconds: 20),
          );
          final result = exitCode == 0
              ? expectLater(work, completion(0))
              : expectLater(work, throwsA(isA<ProcessJobFailure>().having((error) => error.exitCode, 'exit', 7)));
          await gate.ready(3);
          gate.send('pipe-parent', exitCode == 0 ? 'pass' : 'fail');
          await result;
          expect(owner.cancellationCode, isNull, reason: 'standalone coverage can run later suites');
          final stat = File('/proc/${gate.pids['pipe-child']}/stat');
          if (stat.existsSync()) expect(stat.readAsStringSync().split(') ').last.startsWith('Z '), isTrue);
          final siblingStat = File('/proc/${gate.pids['sibling']}/stat').readAsStringSync();
          expect(
            siblingStat.split(') ').last.startsWith('Z '),
            isFalse,
            reason: 'per-job teardown must preserve siblings',
          );
          gate.send('sibling', 'pass');
          expect(await sibling, 0);
          expect(await owner.run(dart, ['--disable-dart-dev', worker, 'echo', 'next'], streamOutput: false), 0);
          expect(logs.any((record) => record.message.contains('action=cleanup')), isTrue);
          _expectElapsedLogs(owner, logs);
        },
      );
    }
  }

  test('cancellation during spawn observes failed readiness and closes input', () async {
    final owner = ProcessSupervisor(terminationGrace: const Duration(milliseconds: 80));
    addTearDown(owner.close);
    final work = owner.run(dart, ['--disable-dart-dev', worker, 'echo', 'unused'], streamOutput: false);
    final failed = expectLater(work, throwsA(isA<ProcessJobFailure>().having((error) => error.exitCode, 'exit', 130)));
    await owner.cancel(130);
    await failed;
  });

  test('nonzero and missing executable are observable failures', () async {
    final owner = ProcessSupervisor();
    addTearDown(owner.close);
    final logs = <LogRecord>[];
    final subscription = Logger('build').onRecord.listen(logs.add);
    addTearDown(subscription.cancel);
    final gate = await ProcessGate.start();
    addTearDown(gate.close);
    final work = owner.run(dart, ['--disable-dart-dev', worker, 'failure', '${gate.port}', dart], streamOutput: false);
    final failed = expectLater(work, throwsA(isA<ProcessJobFailure>().having((error) => error.code, 'code', 7)));
    await gate.ready(1);
    gate.send('failure', 'fail');
    await failed;
    await expectLater(owner.run('/missing/executable', []), throwsA(isA<ProcessJobFailure>()));
    await expectLater(
      owner.run(dart, [], workingDirectory: '/missing/working-directory', streamOutput: false),
      throwsA(isA<ProcessJobFailure>().having((error) => error.reason, 'reason', 'start')),
    );
    expect(logs.any((record) => record.message.contains('action=finish result=failed reason=start')), isTrue);
    _expectElapsedLogs(owner, logs);
  });
}
