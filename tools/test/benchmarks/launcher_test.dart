import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cli_util/cli_util.dart' as cli;
import 'package:dslideshow_tools/src/benchmarks/json_io.dart';
import 'package:dslideshow_tools/src/benchmarks/provenance.dart';
import 'package:dslideshow_tools/src/repository.dart';
import 'package:path/path.dart' as p;
import 'package:test/test.dart';

void main() {
  final repository = findRepository();
  late Directory compiled;
  late File tools, runtime;
  setUpAll(() async {
    compiled = Directory.systemTemp.createTempSync('launcher-binaries-');
    tools = File(p.join(compiled.path, 'dslideshow_tools'));
    runtime = File(p.join(compiled.path, 'runtime'));
    for (final (source, target) in [
      ('bin/dslideshow_tools.dart', tools.path),
      ('test/support/benchmark_runtime.dart', runtime.path),
    ]) {
      final process = await Process.run(cli.dartExecutable!, [
        '--suppress-analytics',
        'compile',
        'exe',
        source,
        '-o',
        target,
      ]);
      expect(process.exitCode, 0, reason: process.stderr.toString());
    }
  });
  tearDownAll(() => compiled.deleteSync(recursive: true));
  late Directory root, bundle;
  late Map<String, String> environment;
  setUp(() {
    root = Directory.systemTemp.createTempSync('launcher-');
    bundle = Directory(p.join(root.path, 'bundle'))..createSync();
    File(p.join(bundle.path, 'app.so')).writeAsStringSync('frozen renderer application');
    environment = {
      for (final entry in Platform.environment.entries)
        if (!entry.key.startsWith('BENCHMARK_') && entry.key != 'FLUTTER_PI') entry.key: entry.value,
      'BENCHMARK_TOOLS_EXECUTABLE': tools.path,
      'FLUTTER_PI': runtime.path,
      'BENCHMARK_BUNDLE': bundle.path,
      'XDG_RUNTIME_DIR': root.path,
      'BENCHMARK_TIMEOUT_SECONDS': '20',
      'BENCHMARK_TEST_RECORD': p.join(root.path, 'calls'),
      'BENCHMARK_OUTPUT': p.join(root.path, 'results'),
    };
  });
  tearDown(() => root.deleteSync(recursive: true));
  Future<ProcessResult> launch(String script, {List<String> args = const [], Map<String, String> extra = const {}}) =>
      Process.run(
        'bash',
        [p.join(repository.path, 'benchmarks', script), ...args],
        environment: {...environment, ...extra},
      );
  for (final script in ['run_renderer.sh', 'run_ota.sh']) {
    for (final code in [0, 139]) {
      test('$script preserves exit $code without retry and archives native logs', () async {
        final result = await launch(script, extra: {'BENCHMARK_TEST_EXIT': code.toString()});
        expect(result.exitCode, code, reason: result.stderr.toString());
        expect(File(p.join(root.path, 'calls')).readAsLinesSync(), ['opengl']);
        final output = Directory(environment['BENCHMARK_OUTPUT']!);
        expect(readJson(File(p.join(output.path, 'launcher-status.json')), [])['exit_code'], code);
        expect(File(p.join(output.path, 'native.log')).readAsStringSync(), contains('native-fault-operation'));
        final provenance = readJson(File(p.join(output.path, 'launch.json')), []);
        expect(provenance['runtime_sha256'], digest(runtime));
        expect(provenance['app_so_sha256'], digest(File(p.join(bundle.path, 'app.so'))));
        final archive = await Process.run('tar', ['-tzf', '${output.path}.tar.gz']);
        expect(archive.exitCode, 0);
        expect(archive.stdout, contains('results/native.log'));
        expect(archive.stdout, contains('results/launcher-status.json'));
      });
    }
    test('$script refuses nonempty output without a runtime invocation', () async {
      final output = Directory(environment['BENCHMARK_OUTPUT']!)..createSync();
      File(p.join(output.path, 'preserve')).writeAsStringSync('preserve');
      final result = await launch(script);
      expect(result.exitCode, isNonZero);
      expect(File(p.join(root.path, 'calls')).existsSync(), isFalse);
      expect(File(p.join(output.path, 'preserve')).readAsStringSync(), 'preserve');
    });
    test('$script waits for held native teardown before archiving', () async {
      final server = await ServerSocket.bind(InternetAddress.loopbackIPv4, 0);
      addTearDown(() => server.close());
      final accepted = server.first;
      final process = await Process.start(
        'bash',
        [p.join(repository.path, 'benchmarks', script)],
        environment: {...environment, 'BENCHMARK_TEST_CONTROL': server.port.toString()},
      );
      final out = process.stdout.transform(utf8.decoder).join(), err = process.stderr.transform(utf8.decoder).join();
      final socket = await accepted.timeout(const Duration(seconds: 5));
      final lines = StreamIterator(socket.cast<List<int>>().transform(utf8.decoder).transform(const LineSplitter()));
      expect(await lines.moveNext(), true);
      expect(lines.current, 'ready');
      process.kill(ProcessSignal.sigterm);
      expect(await lines.moveNext().timeout(const Duration(seconds: 5)), true);
      expect(lines.current, 'stopping');
      expect(File('${environment['BENCHMARK_OUTPUT']!}.tar.gz').existsSync(), false);
      socket.writeln('release');
      await socket.flush();
      expect(await process.exitCode.timeout(const Duration(seconds: 8)), 130, reason: (await out) + (await err));
      await lines.cancel();
      await socket.close();
      final archive = await Process.run('tar', ['-tzf', '${environment['BENCHMARK_OUTPUT']!}.tar.gz']);
      expect(archive.stdout, contains('results/teardown-complete'));
    });
  }
  for (final (name, flags, rendererEnv, expected) in [
    ('default', <String>[], null, ['opengl']),
    ('explicit both', ['--renderers', 'both'], null, ['opengl', 'vulkan']),
    ('environment', <String>[], 'vulkan', ['vulkan']),
    ('CLI wins', ['--renderers', 'opengl'], 'both', ['opengl']),
  ]) {
    test('general launcher renderer selection: $name', () async {
      final result = await launch(
        'run.sh',
        args: ['--suite', 'smoke', '--output', p.join(root.path, 'reports'), ...flags],
        extra: {'BENCHMARK_RENDERERS': ?rendererEnv},
      );
      expect(result.exitCode, 0, reason: result.stdout.toString() + result.stderr.toString());
      expect(File(p.join(root.path, 'calls')).readAsLinesSync(), expected);
    });
  }
  test('general launcher archives native failure in explicit both mode', () async {
    final result = await launch(
      'run.sh',
      args: ['--suite', 'smoke', '--renderers', 'both', '--output', p.join(root.path, 'reports')],
      extra: {'BENCHMARK_TEST_EXIT': '42'},
    );
    expect(result.exitCode, 2, reason: result.stderr.toString());
    final archives = Directory(p.join(root.path, 'reports'))
        .listSync()
        .whereType<File>()
        .where((f) => p.extension(f.path) == '.gz')
        .toList();
    expect(archives, hasLength(1));
    final files = await Process.run('tar', ['-tzf', archives.single.path]);
    expect(files.stdout, contains('/opengl/attempt-001/native.log'));
    expect(files.stdout, contains('/vulkan/attempt-001/launcher-status.json'));
  });
  for (final (flags, expected) in [
    (<String>[], 'default-false'),
    (['--vulkan-video'], 'true'),
    (['--vulkan-video', '--no-vulkan-video'], 'false'),
  ]) {
    test('Vulkan policy flags $flags reach runtime', () async {
      final result = await launch(
        'run.sh',
        args: ['--suite', 'smoke', '--renderers', 'vulkan', '--output', p.join(root.path, 'reports'), ...flags],
      );
      expect(result.exitCode, 0, reason: result.stderr.toString());
      final policy = Directory(p.join(root.path, 'reports'))
          .listSync(recursive: true)
          .whereType<File>()
          .singleWhere((f) => p.basename(f.path) == 'policy.txt');
      expect(policy.readAsStringSync(), expected);
    });
  }
}
