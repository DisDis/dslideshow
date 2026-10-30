import 'dart:io';
import 'dart:typed_data';

import 'package:dslideshow_tools/src/benchmarks/native_pipeline/binary.dart';
import 'package:path/path.dart' as p;
import 'package:test/test.dart';

void main() {
  late Directory build, directory;
  late String library, failure, probe;
  final here = p.normalize(p.join(Directory.current.path, '../benchmarks/tool/native_pipeline'));
  Future<void> compile(List<String> args) async {
    final result = await Process.run(Platform.environment['CC'] ?? 'cc', args);
    expect(result.exitCode, 0, reason: '${result.stdout}\n${result.stderr}');
  }

  setUpAll(() async {
    build = Directory.systemTemp.createTempSync('native-probe-');
    final flags = ['-std=c11', '-O2', '-Wall', '-Wextra', '-Werror', '-I', p.join(here, 'test/include')];
    library = p.join(build.path, 'libnative_pipeline.so');
    failure = p.join(build.path, 'libfailure.so');
    probe = p.join(build.path, 'probe');
    await compile([
      ...flags,
      '-fPIC',
      '-shared',
      '-Wl,-z,defs',
      p.join(here, 'pipeline_probe.c'),
      '-o',
      library,
      '-ldl',
    ]);
    await compile([
      ...flags,
      '-fPIC',
      '-shared',
      p.join(here, 'test/fake_pipeline.c'),
      '-o',
      p.join(build.path, 'libfake_pipeline.so'),
      '-ldl',
    ]);
    await compile([...flags, '-fPIC', '-shared', p.join(here, 'test/failure_injection.c'), '-o', failure, '-ldl']);
    await compile([
      ...flags,
      p.join(here, 'test/probe.c'),
      '-o',
      probe,
      '-L',
      build.path,
      '-lfake_pipeline',
      '-pthread',
      '-Wl,-rpath,${build.path}',
    ]);
  });
  tearDownAll(() => build.deleteSync(recursive: true));
  setUp(() => directory = Directory.systemTemp.createTempSync('native-probe-case-'));
  tearDown(() => directory.deleteSync(recursive: true));
  String output() => p.join(directory.path, 'pipeline.bin');
  Future<ProcessResult> run({
    List<String> args = const [],
    bool withOutput = true,
    String? target,
    Map<String, String> extra = const {},
  }) async {
    final env = Map<String, String>.from(Platform.environment)
      ..removeWhere((key, value) => key.startsWith('BENCH_NATIVE_PIPELINE_') || key.startsWith('MOCK_'));
    env.addAll({
      'LD_PRELOAD': library,
      'BENCH_NATIVE_PIPELINE_TARGET': target ?? probe,
      if (withOutput) 'BENCH_NATIVE_PIPELINE_OUTPUT': output(),
      ...extra,
    });
    return Process.run(probe, args, environment: env).timeout(const Duration(seconds: 10));
  }

  (Map<String, dynamic>, List<List<int>>) read() {
    final raw = File(output()).readAsBytesSync(), header = decodeHeader(raw);
    expect(header['magic'], 'NPIPV001');
    expect(
      [header['version'], header['endian'], header['header_size'], header['record_size']],
      [1, 0x01020304, 128, 128],
    );
    final capacity = header['capacity'] as int, reserved = header['reserved_count'] as int;
    expect(raw.length, 128 + capacity * 128);
    return (
      header,
      [
        for (var i = 0; i < (capacity < reserved ? capacity : reserved); i++)
          decodeRecord(Uint8List.sublistView(raw, 128 + i * 128, 256 + i * 128)),
      ],
    );
  }

  test('all calls preserve arguments return values errno and timestamps', () async {
    final result = await run();
    expect(result.exitCode, 0);
    expect(result.stderr, '');
    final (h, rows) = read();
    expect([h['reserved_count'], h['committed_count'], h['dropped_count']], [7, 7, 0]);
    expect([h['lifecycle'], h['clock_errors'], h['init_errno'], h['flags']], [2, 0, 0, 3]);
    expect(h['closed_monotonic_ns'], greaterThan(h['start_monotonic_ns'] as int));
    const expected = [(0, 11), (1, 34), (0x88, 4), (0, 5), (-7, 16), (3, 25), (0x99, 19)];
    for (final (i, row) in rows.indexed) {
      expect(row.sublist(0, 4), [1, i + 1, 0, i + 1]);
      expect((row[10], row[9]), expected[i]);
      expect(row[4], greaterThan(0));
      expect(row[5], greaterThanOrEqualTo(row[4]));
      expect(row[6], greaterThan(0));
      expect(row[7], greaterThanOrEqualTo(row[6]));
      expect(row[8], greaterThan(0));
      expect(row[17], 77);
    }
    expect(rows[0].sublist(11, 17), [0x11, 0x22, 0, 0, 0, 0]);
    expect(rows[1].sublist(11, 17), [0x11, 0x22, 0x33, 0x44, 0, 0]);
    expect(rows[4].sublist(11, 17), [9, 0xaa, 0xbb, 0xcc, 0, 0]);
    expect(rows[5].sublist(11, 17), [9, 10, 11, 12, 0xdd, 0]);
  });
  test('disabled output other target and help preserve forwarding without capture', () async {
    for (final (args, target, withOutput) in [
      (<String>[], probe, false),
      (<String>[], '/bin/true', true),
      (['--help'], probe, true),
      (['-h'], probe, true),
    ]) {
      final result = await run(args: args, target: target, withOutput: withOutput);
      expect(result.exitCode, 0);
      expect(result.stderr, '');
      expect(File(output()).existsSync(), false);
    }
  });
  test('target aliases accepted but missing relative or nonexistent target rejected', () async {
    final alias = p.join(directory.path, 'alias');
    Link(alias).createSync(probe);
    expect((await run(target: alias)).exitCode, 0);
    expect(read().$1['committed_count'], 7);
    File(output()).deleteSync();
    for (final target in ['', 'relative-path', p.join(directory.path, 'absent')]) {
      final result = await run(extra: {'BENCH_NATIVE_PIPELINE_TARGET': target});
      expect(result.exitCode, 0);
      expect(result.stderr, contains('operation=target'));
      expect(File(output()).existsSync(), false);
    }
  });
  test('existing file and symbolic link preserve evidence', () async {
    final sentinel = File(p.join(directory.path, 'sentinel'))..writeAsStringSync('do not overwrite');
    for (final linked in [false, true]) {
      if (linked) {
        Link(output()).createSync(sentinel.path);
      } else {
        File(output()).writeAsStringSync('do not overwrite');
      }
      final result = await run();
      expect(result.stderr, contains('operation=open'));
      expect(File(output()).readAsStringSync(), 'do not overwrite');
      expect(sentinel.readAsStringSync(), 'do not overwrite');
      if (linked) {
        Link(output()).deleteSync();
      } else {
        File(output()).deleteSync();
      }
    }
  });
  test('invalid capacity and allocation failure are explicit and do not change calls', () async {
    for (final value in ['0', '-1', '999999999999999999', '10x', '1048577']) {
      final result = await run(extra: {'BENCH_NATIVE_PIPELINE_CAPACITY': value});
      expect(result.exitCode, 0);
      expect(result.stderr, contains('operation=capacity'));
      expect(File(output()).existsSync(), false);
    }
    final result = await run(extra: {'MOCK_FAIL_ALLOCATION': '1', 'LD_PRELOAD': '$failure:$library'});
    expect(result.exitCode, 0);
    expect(result.stderr, contains('operation=posix_fallocate'));
    expect(File(output()).readAsBytesSync().take(8), isNot('NPIPV001'.codeUnits));
  });
  test('clock failures and bounded overflow remain visible', () async {
    expect((await run(extra: {'MOCK_FAIL_CPU_CLOCK': '1', 'LD_PRELOAD': '$failure:$library'})).exitCode, 0);
    var (h, rows) = read();
    expect([h['clock_errors'], h['committed_count']], [14, 7]);
    expect(rows.every((r) => r[6] == 0 && r[7] == 0), true);
    File(output()).deleteSync();
    expect((await run(extra: {'BENCH_NATIVE_PIPELINE_CAPACITY': '2'})).exitCode, 0);
    (h, rows) = read();
    expect([h['capacity'], h['reserved_count'], h['committed_count'], h['dropped_count']], [2, 7, 2, 5]);
    expect(rows.map((r) => r[1]), [1, 2]);
  });
  test('nested timing and multithreaded sequences preserve depth and identity', () async {
    expect((await run(extra: {'MOCK_NESTED': '1'})).exitCode, 0);
    final rows = read().$2;
    expect(rows.take(3).map((r) => (r[1], r[2])), [(1, 0), (2, 1), (2, 0)]);
    expect(rows[0][4], lessThanOrEqualTo(rows[1][4]));
    expect(rows[0][5], greaterThanOrEqualTo(rows[1][5]));
    File(output()).deleteSync();
    expect((await run(args: ['threads'])).exitCode, 0);
    final (h, threaded) = read();
    expect([h['reserved_count'], h['committed_count'], h['dropped_count']], [560, 560, 0]);
    expect(threaded.map((r) => r[3]), List.generate(560, (i) => i + 1));
    expect(threaded.map((r) => r[8]).toSet().length, 4);
    expect(threaded.every((r) => r[0] == 1 && r[2] == 0), true);
  });
  test('abrupt exit incomplete marker fork and spawned preload preserve lifecycle', () async {
    expect((await run(args: ['exit'])).exitCode, 0);
    var (h, rows) = read();
    expect([h['lifecycle'], h['closed_monotonic_ns'], h['committed_count']], [1, 0, 7]);
    expect(rows.every((r) => r[0] == 1), true);
    File(output()).deleteSync();
    expect((await run(extra: {'MOCK_DIE_IN_CALL': '1'})).exitCode, 17);
    (h, rows) = read();
    expect([h['reserved_count'], h['committed_count'], h['lifecycle']], [1, 0, 1]);
    expect([rows[0][0], rows[0][1], rows[0][5]], [0, 1, 0]);
    for (final mode in ['fork', 'spawn']) {
      File(output()).deleteSync();
      final result = await run(args: [mode]);
      expect(result.exitCode, 0);
      expect(result.stderr, '');
      expect(read().$1['reserved_count'], 7);
    }
  });
}
