import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cli_util/cli_util.dart' as cli;
import 'package:dslideshow_tools/src/benchmarks/backend_local.dart';
import 'package:dslideshow_tools/src/benchmarks/json_io.dart';
import 'package:dslideshow_tools/src/benchmarks/provenance.dart' show digest;
import 'package:dslideshow_tools/src/process/supervisor.dart';
import 'package:path/path.dart' as p;
import 'package:test/test.dart';

void main() {
  late Directory root;
  final dart = Platform.environment['DART_EXECUTABLE'] ?? p.join(cli.sdkPath!, 'bin', 'dart');
  setUp(() => root = Directory.systemTemp.createTempSync('backend-tools-'));
  tearDown(() => root.deleteSync(recursive: true));
  test('fixture is reusable and detects modified file contents', () {
    final directory = Directory(p.join(root.path, 'nested'));
    final manifest = backendFixture(directory, 101, BackendLayout.nested);
    expect(backendFixture(directory, 101, BackendLayout.nested), manifest);
    final files = filesBelow(Directory(p.join(directory.path, 'images')));
    expect(files, hasLength(101));
    files.first.writeAsStringSync('changed');
    expect(() => backendFixture(directory, 101, BackendLayout.nested), throwsFormatException);
  });
  test('fixture refuses partial directories without overwriting unrelated files', () {
    final directory = Directory(p.join(root.path, 'partial'))..createSync();
    final unrelated = File(p.join(directory.path, 'unrelated'))..writeAsStringSync('preserve');
    expect(() => backendFixture(directory, 3, BackendLayout.flat), throwsFormatException);
    expect(unrelated.readAsStringSync(), 'preserve');
  });
  test('nearest-rank quantiles preserve missing sample denominators', () {
    expect(backendDistribution([]), {'n': 0, 'p50': null, 'p95': null, 'p99': null, 'max': null});
    expect(backendDistribution([1, 2, 30]), {'n': 3, 'p50': 2, 'p95': 30, 'p99': 30, 'max': 30});
  });
  test('trace counts successful process clones including split lines, excluding threads', () {
    const trace =
        '10 clone3({flags=CLONE_VM|CLONE_THREAD}, 88) = -1 ENOSYS (Function not implemented)\n'
        '10 clone(child_stack=NULL, flags=CLONE_VM|CLONE_THREAD) = 11\n'
        '10 clone(child_stack=NULL, flags=CLONE_VM|CLONE_VFORK|SIGCHLD <unfinished ...>\n'
        '10 <... clone resumed>) = 12\n12 vfork() = 13\n13 clone3({flags=SIGCHLD}, 88) = 14\n';
    expect(backendProcessCreations(trace), [12, 13, 14]);
  });
  test('nonzero process exit and real timeout remain observable failures', () async {
    final file = File(p.join(root.path, 'exit.dart'))..writeAsStringSync("import 'dart:io'; void main(){exitCode=3;}");
    await expectLater(
      runBackendProcess([dart, '--disable-dart-dev', file.path]),
      throwsA(isA<ProcessJobFailure>().having((e) => e.exitCode, 'exit', 3)),
    );
    final waiting = File(p.join(root.path, 'wait.dart'))
      ..writeAsStringSync("import 'dart:async'; void main(){Timer(const Duration(seconds:30), (){});}");
    await expectLater(
      runBackendProcess([dart, '--disable-dart-dev', waiting.path], timeout: const Duration(milliseconds: 500)),
      throwsA(isA<ProcessJobFailure>().having((e) => e.exitCode, 'timeout', 124)),
    );
  });
  for (final detached in [false, true]) {
    test('cancellation kills ${detached ? 'detached session' : 'ordinary'} descendants holding pipes', () async {
      final ready = File(p.join(root.path, 'ready'));
      final child = File(p.join(root.path, 'child.dart'))
        ..writeAsStringSync('''
import 'dart:async';
import 'dart:io';
Future<void> main(List<String> args) async {
  ProcessSignal.sigterm.watch().listen((_) {});
  File(args.single).writeAsStringSync('\$pid');
  await stdin.drain<void>();
}
''');
      final parent = File(p.join(root.path, 'parent.dart'))
        ..writeAsStringSync('''
import 'dart:async';
import 'dart:io';
Future<void> main(List<String> args) async {
  final child = await Process.start(${detached ? "'setsid'" : "args[0]"}, ${detached ? "[args[0], '--disable-dart-dev', args[1], args[2]]" : "['--disable-dart-dev', args[1], args[2]]"}, mode: ProcessStartMode.inheritStdio);
  final done = Completer<void>();
  final input = stdin.listen((_) {});
  late StreamSubscription<ProcessSignal> signal;
  signal = ProcessSignal.sigterm.watch().listen((_) async {
    await child.exitCode;
    await signal.cancel();
    await input.cancel();
    done.complete();
  });
  await done.future;
}
''');
      final owner = ProcessSupervisor(terminationGrace: const Duration(milliseconds: 100));
      addTearDown(owner.close);
      final work = runBackendProcess([
        dart,
        '--disable-dart-dev',
        parent.path,
        dart,
        child.path,
        ready.path,
      ], supervisor: owner);
      final failed = expectLater(work, throwsA(isA<ProcessJobFailure>().having((e) => e.exitCode, 'exit', 124)));
      final deadline = Stopwatch()..start();
      while (!ready.existsSync() || ready.readAsStringSync().trim().isEmpty) {
        if (deadline.elapsed > const Duration(seconds: 5)) fail('TERM-resistant child never became ready');
        await Future<void>.delayed(const Duration(milliseconds: 5));
      }
      final childPid = int.parse(ready.readAsStringSync());
      await owner.cancel(124);
      await failed;
      final stat = File('/proc/$childPid/stat');
      if (stat.existsSync()) expect(stat.readAsStringSync().split(') ').last.startsWith('Z '), isTrue);
    });
  }
  test('late adoption after cancellation still stops the just-spawned group', () async {
    final file = File(p.join(root.path, 'late.dart'))
      ..writeAsStringSync("import 'dart:async'; void main(){Timer(const Duration(seconds:30), (){});}");
    final owner = ProcessSupervisor(terminationGrace: const Duration(milliseconds: 80));
    await owner.cancel(130);
    final process = await Process.start('setsid', [dart, '--disable-dart-dev', file.path]);
    final output = process.stdout.drain<void>(), errors = process.stderr.drain<void>();
    owner.adopt(process);
    await owner.close().timeout(const Duration(seconds: 3));
    expect(await process.exitCode, isNonZero);
    await Future.wait([output, errors]);
  });
  test('source snapshot freezes backend/common and absolute package roots', () async {
    final packages = <Map<String, dynamic>>[];
    for (final name in ['dslideshow_backend', 'dslideshow_common']) {
      final directory = Directory(p.join(root.path, name, 'lib'))..createSync(recursive: true);
      File(p.join(directory.path, 'example.dart')).writeAsStringSync('// frozen\n');
      packages.add({'name': name, 'rootUri': directory.parent.uri.toString(), 'packageUri': 'lib/'});
    }
    final harness = File(p.join(root.path, 'harness.dart'))..writeAsStringSync('void main() {}');
    final config = File(p.join(root.path, 'packages.json'));
    writeJson(config, {'configVersion': 2, 'packages': packages});
    final destination = Directory(p.join(root.path, 'variant'))..createSync();
    final (frozen, _, provenance) = await backendSnapshot(config, destination, harness: harness, repository: root);
    File(p.join(root.path, 'dslideshow_backend/lib/example.dart')).writeAsStringSync('// edited\n');
    expect(File(p.join(destination.path, 'sources/backend/lib/example.dart')).readAsStringSync(), '// frozen\n');
    final copied = decodeStrictJson(frozen.readAsStringSync()) as Map;
    expect((copied['packages'] as List).every((item) => (item['rootUri'] as String).startsWith('file:///')), isTrue);
    expect(provenance['source_archive_sha256'], digest(File(p.join(destination.path, 'source.tar.gz'))));
  });
  test('summary retains dropped probes, CPU distinctions and direct command counts', () {
    final rows = <Map<String, dynamic>>[
      {
        'scenario': 'storage',
        'layout': 'flat',
        'count': 1,
        'index_first_selection_ms': 2,
        'remaining_selection_ms': 0,
        'whole_cycle_ms': 2,
        'before': {'cpu_ms': 3},
        'after': {'cpu_ms': 7, 'hwm_bytes': 1024},
      },
      {
        'scenario': 'responsiveness',
        'layout': 'flat',
        'count': 1,
        'rpc_probes': [
          {'status': 'ok', 'latency_ms': 5, 'scheduled_latency_ms': 8},
          {'status': 'capacity_skipped'},
        ],
        'event_loop_samples': [
          {'lag_ms': 2, 'skipped_intervals': 3},
        ],
        'dropped_probe_intervals': 4,
      },
      {
        'scenario': 'metrics',
        'rows': [
          {
            'phase': 'cold',
            'concurrency': 1,
            'elapsed_ms': 6,
            'before': {'cpu_ms': 1},
            'after': {'cpu_ms': 4},
          },
        ],
      },
      {
        'scenario': 'metrics_command_diagnostic',
        'direct_command_invocations': ['df', 'df', 'sensorsScript'],
      },
    ];
    final result = summarizeBackend(rows);
    expect(result['storage/flat/1']['self_cpu_ms']['p50'], 4);
    expect(result['responsiveness/flat/1']['rpc_ms']['n'], 1);
    expect(result['responsiveness/flat/1']['dropped'], 4);
    expect(result['responsiveness/flat/1']['loop_skipped'], 3);
    expect(result['direct_commands'], {'df': 2, 'sensorsScript': 1});
  });
  test('ABBA confirmation uses frozen binaries and records reaped-child CPU', () async {
    for (final variant in ['baseline', 'candidate']) {
      final folder = Directory(p.join(root.path, variant))..createSync();
      final binary = File(p.join(folder.path, 'backend-local'))
        ..writeAsStringSync(
          '#!/bin/sh\nprintf \'%s\\n\' \'{"status":"ok","rows":[{"phase":"immediate","concurrency":1,"elapsed_ms":1,"before":{"cpu_ms":0},"after":{"cpu_ms":1}}]}\'\n',
        );
      expect((await Process.run('chmod', ['755', binary.path])).exitCode, 0);
      writeJson(File(p.join(folder.path, 'provenance.json')), {
        'mode': 'aot',
        'harness_sha256': 'same',
        'dart_version': 'same',
        'tooling': 'dart-v1',
        'binary_sha256': digest(binary),
      });
      sensorFixture(folder);
    }
    expect(await runBackendConfirm(['--output', root.path, '--metrics-only']), 0);
    final rows = readJsonLines(File(p.join(root.path, 'confirm-raw.jsonl')), []);
    expect(rows.map((row) => row['variant']).toList(), ['baseline', 'candidate', 'candidate', 'baseline']);
    expect(
      rows.every(
        (row) =>
            row['process_and_reaped_children_cpu_ms'] is num && (row['process_and_reaped_children_cpu_ms'] as num) >= 0,
      ),
      isTrue,
    );
    expect(Directory(p.join(root.path, 'fixtures')).existsSync(), isFalse);
    expect(await runBackendConfirm(['--output', root.path, '--metrics-only']), 1);
  });

  group('existing production harness on minimal fixtures', () {
    final packages = p.absolute('../backend/.dart_tool/package_config.json');
    final harness = p.absolute('../benchmarks/tool/backend_local.dart');
    final available = File(packages).existsSync() && File(harness).existsSync() && Platform.isLinux;
    Future<Map<String, dynamic>> execute(
      String scenario,
      Directory directory, {
      int? count,
      bool successful = true,
    }) async {
      final out = File(p.join(root.path, 'harness-out')), err = File(p.join(root.path, 'harness-err'));
      final stdout = out.openWrite(), stderr = err.openWrite();
      final owner = ProcessSupervisor();
      var code = 0;
      try {
        await owner.run(
          dart,
          ['--packages=$packages', harness, '--scenario=$scenario', if (count != null) '--count=$count'],
          environment: {...Platform.environment, 'DSLIDESHOW_ROOT': directory.path},
          stdoutSink: stdout,
          stderrSink: stderr,
          timeout: const Duration(seconds: 30),
          streamOutput: false,
        );
      } on ProcessJobFailure catch (error) {
        code = error.exitCode;
      } finally {
        await owner.close();
        await stdout.close();
        await stderr.close();
      }
      expect(code, successful ? 0 : 2, reason: err.readAsStringSync());
      return asMap(decodeStrictJson(const LineSplitter().convert(out.readAsStringSync().trimRight()).last));
    }

    test('exact single-file and seven-file cycles preserve current/next accounting', () async {
      for (final count in [1, 7]) {
        final directory = Directory(p.join(root.path, '$count'));
        backendFixture(directory, count, BackendLayout.nested);
        final result = await execute('storage', directory, count: count);
        expect(result['selected_count'], count);
        expect(result['unique_count'], count);
        expect(result['after']['hwm_bytes'], isNotNull);
      }
    }, skip: available ? false : 'Existing Linux Dart SDK/backend config required; no dependencies installed');
    test('missing directory reports failure and exits', () async {
      final result = await execute('storage', Directory(p.join(root.path, 'missing')), count: 1, successful: false);
      expect(result['status'], 'failed');
      expect(result, contains('error'));
    }, skip: available ? false : 'Existing backend package config required');
    test('RPC worker shuts down and retains raw probe statuses', () async {
      final directory = Directory(p.join(root.path, 'rpc'));
      backendFixture(directory, 10, BackendLayout.flat);
      final result = await execute('responsiveness', directory);
      expect(result['rpc_probes'], isNotEmpty);
      expect(result['event_loop_samples'], isNotEmpty);
      expect(
        (result['rpc_probes'] as List).every((probe) => ['ok', 'capacity_skipped'].contains(probe['status'])),
        isTrue,
      );
    }, skip: available ? false : 'Existing backend package config required');
    test('RPC scan failure completes with error and terminates', () async {
      final result = await execute('responsiveness', Directory(p.join(root.path, 'missing')), successful: false);
      expect(result['status'], 'failed');
      expect(result, contains('error'));
    }, skip: available ? false : 'Existing backend package config required');
  });
}
