import 'dart:async';
import 'dart:io';

import 'package:dslideshow_backend/src/service/system_info/system_command_runner.dart';
import 'package:test/test.dart';

Future<void> _until(bool Function() condition) async {
  final elapsed = Stopwatch()..start();
  while (!condition()) {
    if (elapsed.elapsed > const Duration(seconds: 5)) {
      fail('Expected process state was not reached');
    }
    await Future<void>.delayed(const Duration(milliseconds: 10));
  }
}

bool _running(int pid) {
  try {
    final stat = File('/proc/$pid/stat').readAsStringSync();
    final state = stat.substring(stat.lastIndexOf(')') + 2).split(' ').first;
    return state != 'Z' && state != 'X';
  } on FileSystemException {
    return false;
  }
}

void main() {
  group('BoundedSystemCommandRunner', () {
    late Directory directory;
    late BoundedSystemCommandRunner runner;
    setUp(() async {
      directory = await Directory.systemTemp.createTemp('system-command-test-');
      runner = BoundedSystemCommandRunner(
        deadline: const Duration(milliseconds: 300),
        killGrace: const Duration(milliseconds: 100),
      );
    });
    tearDown(() async {
      await runner.close();
      await directory.delete(recursive: true);
    });

    test('collects both streams and preserves nonzero exit status', () async {
      final result = await runner.run('/bin/sh', [
        '-c',
        'printf output; printf error >&2; exit 7',
      ]);
      expect(result.exitCode, 7);
      expect(result.stdout, 'output');
      expect(result.stderr, 'error');
    });

    test('deadline kills a descendant ignoring TERM', () async {
      final child = File('${directory.path}/child');
      final parent = File('${directory.path}/parent');
      final pending = runner.run('/bin/sh', [
        '-c',
        r'''trap "" TERM; echo $$ > "$1"; sh -c 'trap "" TERM; echo $$ > "$1"; while :; do sleep 1; done' child "$2" & wait''',
        'parent',
        parent.path,
        child.path,
      ]);
      final rejected = expectLater(pending, throwsA(isA<TimeoutException>()));
      await _until(() => child.existsSync());
      final childPid = int.parse(await child.readAsString());
      final parentPid = int.parse(await parent.readAsString());
      await rejected;
      await _until(() => !_running(childPid) && !_running(parentPid));
    });

    test('deadline includes pipes retained after the parent exits', () async {
      final child = File('${directory.path}/child');
      final pending = runner.run('/bin/sh', [
        '-c',
        r'''sh -c 'trap "" TERM; echo $$ > "$1"; exec sleep 30' child "$1" & exit 0''',
        'parent',
        child.path,
      ]);
      final rejected = expectLater(pending, throwsA(isA<TimeoutException>()));
      await _until(() => child.existsSync());
      final childPid = int.parse(await child.readAsString());
      await rejected;
      await _until(() => !_running(childPid));
    });

    test('output limit kills the command and bounds combined output', () async {
      await runner.close();
      runner = BoundedSystemCommandRunner(
        deadline: const Duration(seconds: 3),
        killGrace: const Duration(milliseconds: 100),
        maxOutputBytes: 128,
      );
      await expectLater(
        runner.run('/bin/sh', ['-c', 'yes output >&2']),
        throwsA(isA<SystemCommandOutputLimit>()),
      );
    });

    test(
      'cleans background children after a successful script exits',
      () async {
        final child = File('${directory.path}/child');
        final result = await runner.run('/bin/sh', [
          '-c',
          r'''sh -c 'trap "" TERM; echo $$ > "$1"; exec sleep 30' child "$1" >/dev/null 2>&1 & while [ ! -s "$1" ]; do sleep 0.01; done; exit 0''',
          'parent',
          child.path,
        ]);
        expect(result.exitCode, 0);
        final childPid = int.parse(await child.readAsString());
        await _until(() => !_running(childPid));
      },
    );

    test(
      'close racing process start waits for cleanup and is idempotent',
      () async {
        final pending = runner.run('/bin/sh', ['-c', 'sleep 30']);
        final rejected = expectLater(pending, throwsStateError);
        final firstClose = runner.close();
        expect(identical(firstClose, runner.close()), isTrue);
        await firstClose;
        await rejected;
        await expectLater(runner.run('/bin/true', []), throwsStateError);
      },
    );

    test('close terminates an active script and its child', () async {
      final child = File('${directory.path}/child');
      final pending = runner.run('/bin/sh', [
        '-c',
        r'''sh -c 'trap "" TERM; echo $$ > "$1"; exec sleep 30' child "$1" & wait''',
        'parent',
        child.path,
      ]);
      final rejected = expectLater(pending, throwsStateError);
      await _until(() => child.existsSync());
      final childPid = int.parse(await child.readAsString());
      await runner.close();
      await rejected;
      await _until(() => !_running(childPid));
    });
  }, skip: !Platform.isLinux);
}
