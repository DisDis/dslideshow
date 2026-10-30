import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:dslideshow_tools/src/benchmarks/native_pipeline/capture_process.dart';
import 'package:dslideshow_tools/src/benchmarks/native_pipeline/finalize_capture.dart';
import 'package:dslideshow_tools/src/benchmarks/native_pipeline/posix.dart';
import 'package:path/path.dart' as p;
import 'package:test/test.dart';

import '../../support/native_fixture.dart';

void main() {
  late Directory root;
  late String proc, engine, digest;
  setUp(() {
    root = Directory.systemTemp.createTempSync('native-service-');
    proc = p.join(root.path, 'proc');
    Directory(p.join(proc, '123')).createSync(recursive: true);
    engine = p.join(root.path, 'libflutter_engine.so');
    File(engine).writeAsStringSync('frozen-engine');
    digest = hashFile(engine);
    File(p.join(proc, '123', 'stat')).writeAsStringSync(
      '123 (flutter-pi test) S ${[...List.filled(18, '0'), '567', ...List.filled(8, '0')].join(' ')}',
    );
    File(p.join(proc, '123', 'cmdline'))
        .writeAsStringSync('/opt/dslideshow/flutter-pi\u0000--release\u0000bundle\u0000');
    final identity = fileIdentity(engine), device = int.parse(identity[0]);
    File(p.join(proc, '123', 'maps')).writeAsStringSync(
      '00010000-00020000 r-xp 00000000 ${deviceMajor(device).toRadixString(16)}:${deviceMinor(device).toRadixString(16)} ${identity[1]} $engine\n',
    );
  });
  tearDown(() => root.deleteSync(recursive: true));

  test('mapped path device inode SHA and process identity are verified', () {
    final value = captureProcess(123, engine, digest, procRoot: proc);
    expect(value['status'], 'verified');
    expect(value['pid'], 123);
    expect(value['process_start_ticks'], 567);
    expect((value['engine'] as Map)['sha256'], digest);
    expect(value['timing_results_valid'], false);
    expect(value['argv'], ['/opt/dslideshow/flutter-pi', '--release', 'bundle']);
  });
  test('missing mapping is retryable; deleted or alternate mapped path fails', () {
    final file = File(p.join(proc, '123', 'maps')), original = file.readAsStringSync();
    file.writeAsStringSync('');
    expect(() => captureProcess(123, engine, digest, procRoot: proc), throwsA(isA<EngineNotMapped>()));
    file.writeAsStringSync('${original.trimRight()} (deleted)');
    expect(() => captureProcess(123, engine, digest, procRoot: proc), throwsStateError);
    file.writeAsStringSync(original.replaceAll(engine, '/other/libflutter_engine.so'));
    expect(() => captureProcess(123, engine, digest, procRoot: proc), throwsStateError);
  });
  test('wrong hash and changing process start ticks cannot produce proof', () {
    expect(() => captureProcess(123, engine, '0' * 64, procRoot: proc), throwsStateError);
    var reads = 0;
    expect(
      () => captureProcess(123, engine, digest, procRoot: proc, startTicks: (_) => ++reads == 1 ? 567 : 568),
      throwsStateError,
    );
    final value = captureProcess(123, engine, digest, procRoot: proc, clock: () => 1234);
    expect(value['captured_monotonic_ns'], 1234);
  });
  test('exclusive output never replaces file or symlink', () {
    final output = p.join(root.path, 'proof.json');
    writeExclusive(output, {'status': 'verified'});
    expect(() => writeExclusive(output, {}), throwsA(isA<FileSystemException>()));
    final link = p.join(root.path, 'link.json');
    Link(link).createSync(output);
    expect(() => writeExclusive(link, {}), throwsA(isA<FileSystemException>()));
    expect(jsonDecode(File(output).readAsStringSync()), {'status': 'verified'});
  });

  void prepare() {
    Directory(p.join(proc, '123')).deleteSync(recursive: true);
    nativeFile(p.join(root.path, 'native-pipeline.bin'));
    File(p.join(root.path, 'launcher-status.json')).writeAsStringSync(jsonEncode({'exit_code': 0}));
    File(p.join(root.path, 'native-pipeline-provenance.json')).writeAsStringSync(
      jsonEncode({
        'schema_version': 1,
        'kind': 'native_pipeline_loaded_engine',
        'status': 'verified',
        'pid': 123,
        'process_start_ticks': 99,
        'engine': {'path': '/frozen/libflutter_engine.so', 'sha256': 'a' * 64},
        'timing_results_valid': false,
        'captured_monotonic_ns': 1050,
      }),
    );
  }

  test('external post-exit proof is bound to unchanged raw launcher and engine bytes', () {
    prepare();
    final native = File(p.join(root.path, 'native-pipeline.bin')), before = native.readAsBytesSync();
    final proof = verifyCapture(root.path, procRoot: proc);
    expect(proof['raw_lifecycle'], 1);
    expect(proof['raw_closed_monotonic_ns'], 0);
    expect(proof['process_start_ticks'], 99);
    expect((proof['native_capture'] as Map)['sha256'], sha256.convert(before).toString());
    expect(native.readAsBytesSync(), before);
  });
  test('live or reused pid and inaccessible proc directory never mean absent', () {
    prepare();
    Directory(p.join(proc, '123')).createSync();
    expect(() => verifyCapture(root.path, procRoot: proc), throwsStateError);
    expect(
      () =>
          verifyCapture(root.path, procRoot: proc, absent: (_) => throw const FileSystemException('permission denied')),
      throwsA(isA<FileSystemException>()),
    );
  });
  test('pending dropped or uncommitted records refuse finalization', () {
    prepare();
    for (final values in [(0, 1, 0), (1, 0, 0), (1, 1, 1)]) {
      nativeFile(
        p.join(root.path, 'native-pipeline.bin'),
        committed: values.$1,
        complete: values.$2,
        dropped: values.$3,
      );
      expect(() => verifyCapture(root.path, procRoot: proc), throwsStateError);
    }
  });
  test('failed launcher different process incomplete engine and other boot are rejected', () {
    prepare();
    final launch = File(p.join(root.path, 'launcher-status.json'));
    launch.writeAsStringSync('{"exit_code":2}');
    expect(() => verifyCapture(root.path, procRoot: proc), throwsStateError);
    launch.writeAsStringSync('{"exit_code":0}');
    final file = File(p.join(root.path, 'native-pipeline-provenance.json')),
        value = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
    value['pid'] = 124;
    file.writeAsStringSync(jsonEncode(value));
    expect(() => verifyCapture(root.path, procRoot: proc), throwsStateError);
    value['pid'] = 123;
    value.remove('engine');
    file.writeAsStringSync(jsonEncode(value));
    expect(() => verifyCapture(root.path, procRoot: proc), throwsStateError);
    value['engine'] = {'path': '/frozen/libflutter_engine.so', 'sha256': 'a' * 64};
    file.writeAsStringSync(jsonEncode(value));
    expect(() => verifyCapture(root.path, procRoot: proc, clock: () => 100), throwsStateError);
  });
  test('changed bytes with equal stat identity are rejected by second snapshot', () {
    prepare();
    var calls = 0;
    expect(
      () => verifyCapture(
        root.path,
        procRoot: proc,
        takeSnapshot: (path) {
          final (data, identity) = snapshot(path);
          if (p.basename(path) == 'native-pipeline.bin' && ++calls == 2) data[data.length - 1] ^= 1;
          return (data, identity);
        },
      ),
      throwsStateError,
    );
  });
}
