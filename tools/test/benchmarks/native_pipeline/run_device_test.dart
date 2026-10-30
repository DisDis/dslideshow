import 'dart:convert';
import 'dart:io';

import 'package:dslideshow_tools/src/benchmarks/native_pipeline/posix.dart';
import 'package:path/path.dart' as p;
import 'package:test/test.dart';

import '../../support/native_fixture.dart';

void main() {
  late Directory root;
  late String benchmark, experiment, bundle, runtime, runner, log, executable;
  final repository = p.normalize(p.join(Directory.current.path, '..'));
  late Map<String, String> environment;
  void write(String path, String content, {bool executable = false}) {
    File(path).parent.createSync(recursive: true);
    File(path).writeAsStringSync(content);
    if (executable) {
      final result = Process.runSync('chmod', ['0700', path]);
      expect(result.exitCode, 0);
    }
  }

  setUpAll(() async {
    executable = p.join(Directory.systemTemp.createTempSync('native-runner-exe-').path, 'tools');
    final result = await Process.run(Platform.resolvedExecutable, [
      '--suppress-analytics',
      'compile',
      'exe',
      'bin/dslideshow_tools.dart',
      '-o',
      executable,
    ]);
    expect(result.exitCode, 0, reason: '${result.stdout}\n${result.stderr}');
  });
  tearDownAll(() => Directory(p.dirname(executable)).deleteSync(recursive: true));
  setUp(() {
    root = Directory.systemTemp.createTempSync('native-runner-');
    benchmark = p.join(root.path, 'benchmark');
    experiment = p.join(root.path, 'experiment');
    bundle = p.join(root.path, 'bundle');
    runtime = p.join(root.path, 'runtime');
    log = p.join(root.path, 'events.jsonl');
    Directory(p.join(root.path, 'tools')).createSync();
    runner = p.join(root.path, 'tools/run-device.sh');
    File(p.join(repository, 'benchmarks/tool/native_pipeline/run-device.sh')).copySync(runner);
    write(p.join(experiment, 'config/native-pipeline-photo.json'), '{}');
    write(p.join(bundle, 'app.so'), 'frozen app');
    write(p.join(bundle, 'libflutter_engine.so'), 'frozen engine');
    write(runtime, 'frozen runtime', executable: true);
    write(p.join(benchmark, 'run.sh'), '# unused host fixture');
    write(p.join(root.path, 'tools/libnative_pipeline.so'), 'host mock library');
    write(p.join(root.path, 'tools/runtime-wrapper.sh'), '#unused', executable: true);
    write(p.join(benchmark, 'run-managed.sh'), r'''#!/bin/sh
set -eu
printf '{"event":"managed"}\n' >> "$MOCK_LOG"
i=0
while [ "$i" -lt "$MOCK_CAPTURES" ]; do
  target="$MOCK_EXPERIMENT/reports/new-$i/opengl/attempt-001"
  mkdir -p "$target"
  cp "$MOCK_NATIVE" "$target/native-pipeline.bin"
  cp "$MOCK_PROOF" "$target/native-pipeline-provenance.json"
  printf '{"exit_code":0}\n' > "$target/launcher-status.json"
  i=$((i+1))
done
exit "$MOCK_MANAGED_EXIT"
''', executable: true);
    final proxy = p.join(root.path, 'tool-proxy');
    write(proxy, r'''#!/bin/sh
set -eu
if [ "$1:$2" = native:trace ]; then
  printf '{"event":"trace","action":"%s"}\n' "$3" >> "$MOCK_LOG"
  if [ "$3" = init ]; then mkdir "$5"; fi
  exit 0
fi
if [ "$1:$2" = native:finalize-new ] && [ "$MOCK_FINALIZER_EXIT" != 0 ]; then exit "$MOCK_FINALIZER_EXIT"; fi
exec "$MOCK_REAL_TOOLS" "$@"
''', executable: true);
    write(p.join(root.path, 'bin/sudo'), '#!/bin/sh\n[ "\$1" = -n ] || exit 99\nshift\nexec "\$@"\n', executable: true);
    final native = p.join(root.path, 'native.fixture');
    nativeFile(native);
    final bytes = File(native).readAsBytesSync();
    // Choose a PID outside Linux pid_max so local process absence is unambiguous.
    for (var i = 0; i < 4; i++) {
      bytes[28 + i] = (1000000000 >> (8 * i)) & 255;
    }
    File(native).writeAsBytesSync(bytes);
    final proof = p.join(root.path, 'proof.fixture');
    write(
      proof,
      jsonEncode({
        'schema_version': 1,
        'kind': 'native_pipeline_loaded_engine',
        'status': 'verified',
        'pid': 1000000000,
        'process_start_ticks': 99,
        'engine': {'path': '/frozen/libflutter_engine.so', 'sha256': 'a' * 64},
        'timing_results_valid': false,
        'captured_monotonic_ns': 1050,
      }),
    );
    environment = {
      ...Platform.environment,
      'PATH': '${p.join(root.path, 'bin')}:${Platform.environment['PATH']}',
      'BENCHMARK_TOOLS_EXECUTABLE': proxy,
      'BENCH_NATIVE_PIPELINE_RUNTIME': runtime,
      'BENCH_NATIVE_PIPELINE_RUNTIME_SHA256': hashFile(runtime),
      'BENCH_NATIVE_PIPELINE_ENGINE_SHA256': hashFile(p.join(bundle, 'libflutter_engine.so')),
      'MOCK_LOG': log,
      'MOCK_EXPERIMENT': experiment,
      'MOCK_NATIVE': native,
      'MOCK_PROOF': proof,
      'MOCK_REAL_TOOLS': executable,
      'MOCK_CAPTURES': '1',
      'MOCK_MANAGED_EXIT': '0',
      'MOCK_FINALIZER_EXIT': '0',
    };
  });
  tearDown(() => root.deleteSync(recursive: true));
  Future<ProcessResult> run({String mode = 'diagnostic', Map<String, String> extra = const {}}) => Process.run(
    'bash',
    [runner, mode, benchmark, experiment, bundle, 'host-job'],
    environment: {...environment, ...extra},
  ).timeout(const Duration(seconds: 15));
  List<Map<String, dynamic>> events() => File(log).existsSync()
      ? File(log).readAsLinesSync().map((line) => jsonDecode(line) as Map<String, dynamic>).toList()
      : [];
  test('success finalizes exactly new attempt after managed and closes trace', () async {
    write(p.join(experiment, 'reports/old/opengl/attempt-001/native-pipeline.bin'), 'old capture');
    final result = await run();
    expect(result.exitCode, 0, reason: result.stderr.toString());
    expect(events().map((value) => '${value['event']}:${value['action'] ?? ''}'), [
      'trace:init',
      'trace:start',
      'managed:',
      'trace:stop',
      'trace:close',
    ]);
    expect(
      File(p.join(experiment, 'reports/new-0/opengl/attempt-001/native-pipeline-finalization.json')).existsSync(),
      true,
    );
    expect(
      File(p.join(experiment, 'reports/old/opengl/attempt-001/native-pipeline-finalization.json')).existsSync(),
      false,
    );
    expect(File(p.join(experiment, 'host-job-exit-code')).readAsStringSync(), '0\n');
  });
  test('managed and finalizer failures remain failures with trace cleanup', () async {
    final result = await run(extra: {'MOCK_MANAGED_EXIT': '7'});
    expect(result.exitCode, 7, reason: result.stderr.toString());
    expect(events().where((event) => event['event'] == 'trace').map((event) => event['action']), [
      'init',
      'start',
      'stop',
      'close',
    ]);
    expect(
      File(p.join(experiment, 'reports/new-0/opengl/attempt-001/native-pipeline-finalization.json')).existsSync(),
      false,
    );
  });
  test('finalizer failure prevents success and closes private trace', () async {
    final result = await run(extra: {'MOCK_FINALIZER_EXIT': '5'});
    expect(result.exitCode, 5, reason: result.stderr.toString());
    expect(events().where((event) => event['event'] == 'trace').map((event) => event['action']), [
      'init',
      'start',
      'stop',
      'close',
    ]);
  });
  for (final count in ['0', '2']) {
    test('ambiguous new capture count $count never picks arbitrary attempt', () async {
      final result = await run(extra: {'MOCK_CAPTURES': count});
      expect(result.exitCode, isNonZero);
      expect(result.stderr, contains('Expected exactly one new native capture'));
      expect(
        Directory(experiment)
            .listSync(recursive: true)
            .whereType<File>()
            .where((file) => p.basename(file.path) == 'native-pipeline-finalization.json'),
        isEmpty,
      );
      expect(events().last['action'], 'close');
    });
  }
  test('control and rejected pinned runtime perform no trace action', () async {
    final result = await run(mode: 'control', extra: {'MOCK_CAPTURES': '0'});
    expect(result.exitCode, 0, reason: result.stderr.toString());
    expect(events(), [
      {'event': 'managed'},
    ]);
  });
  test('wrong runtime fails before managed and trace', () async {
    final result = await run(extra: {'BENCH_NATIVE_PIPELINE_RUNTIME_SHA256': '0' * 64});
    expect(result.exitCode, isNonZero);
    expect(result.stderr, contains('Actual runtime differs from pinned runtime'));
    expect(events(), isEmpty);
  });
}
