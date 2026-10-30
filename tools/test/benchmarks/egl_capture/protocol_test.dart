import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:dslideshow_tools/src/benchmarks/native_pipeline/posix.dart';
import 'package:path/path.dart' as p;
import 'package:test/test.dart';

class CaptureProcess {
  CaptureProcess(this.process)
    : output = StreamIterator(process.stdout.transform(utf8.decoder).transform(const LineSplitter())),
      error = process.stderr.drain<void>();
  final Process process;
  final StreamIterator<String> output;
  final Future<void> error;
  Future<List<int>> swap() async {
    process.stdin.writeln('swap');
    await process.stdin.flush();
    expect(await output.moveNext().timeout(const Duration(seconds: 5)), true);
    return output.current.split(' ').map(int.parse).toList();
  }

  Future<void> close() async {
    await process.stdin.close();
    await process.exitCode.timeout(
      const Duration(seconds: 5),
      onTimeout: () {
        process.kill(ProcessSignal.sigkill);
        throw TimeoutException('Native IPC probe did not exit');
      },
    );
    await output.cancel();
    await error;
  }
}

void main() {
  late Directory build, capture;
  late String interposer, fake, engine, hashProbe, noEngineProbe, probe;
  final here = p.normalize(p.join(Directory.current.path, '../benchmarks/tool/egl_capture'));
  final processes = <CaptureProcess>[];
  Future<void> compile(List<String> args) async {
    final result = await Process.run('gcc', ['-std=c11', '-Wall', '-Wextra', '-Werror', ...args]);
    expect(result.exitCode, 0, reason: '${result.stdout}\n${result.stderr}');
  }

  setUpAll(() async {
    build = Directory.systemTemp.createTempSync('egl-capture-build-');
    interposer = p.join(build.path, 'libcapture.so');
    fake = p.join(build.path, 'libfakeegl.so');
    engine = p.join(build.path, 'libflutter_engine.so');
    hashProbe = p.join(build.path, 'hash-probe');
    noEngineProbe = p.join(build.path, 'no-engine-probe');
    probe = p.join(build.path, 'probe');
    final result = await Process.run(p.join(here, 'build.sh'), [interposer]);
    expect(result.exitCode, 0, reason: '${result.stdout}\n${result.stderr}');
    await compile(['-fPIC', '-shared', p.join(here, 'test/fake_egl.c'), '-o', fake]);
    await compile(['-fPIC', '-shared', p.join(here, 'test/fake_engine.c'), '-o', engine]);
    await compile([p.join(here, 'test/hash_probe.c'), '-o', hashProbe]);
    await compile([
      '-DNO_ENGINE',
      p.join(here, 'test/probe.c'),
      '-L${build.path}',
      '-lfakeegl',
      '-Wl,-rpath,${build.path}',
      '-o',
      noEngineProbe,
    ]);
    await compile([
      p.join(here, 'test/probe.c'),
      '-L${build.path}',
      '-lfakeegl',
      '-lflutter_engine',
      '-Wl,-rpath,${build.path}',
      '-o',
      probe,
    ]);
  });
  tearDownAll(() => build.deleteSync(recursive: true));
  setUp(() {
    capture = Directory.systemTemp.createTempSync('egl-capture-ipc-');
    processes.clear();
  });
  tearDown(() async {
    for (final process in processes) {
      await process.close();
    }
    capture.deleteSync(recursive: true);
  });
  Future<CaptureProcess> start({String? executable, Map<String, String> extra = const {}}) async {
    final value = CaptureProcess(
      await Process.start(
        executable ?? probe,
        [],
        environment: {...extra, 'BENCHMARK_EGL_CAPTURE_DIR': capture.path, 'LD_PRELOAD': interposer},
      ),
    );
    processes.add(value);
    return value;
  }

  void request(List<int> bytes) {
    File(p.join(capture.path, 'request.tmp')).writeAsBytesSync(bytes);
    File(p.join(capture.path, 'request.tmp')).renameSync(p.join(capture.path, 'request'));
  }

  Map<String, dynamic> ack() {
    expect(File(p.join(capture.path, 'request.active')).existsSync(), false);
    expect(File(p.join(capture.path, 'request')).existsSync(), false);
    return jsonDecode(File(p.join(capture.path, 'ack.json')).readAsStringSync()) as Map<String, dynamic>;
  }

  test('ordinary frames avoid readback; barriers and capture preserve exact top-left RGBA', () async {
    final process = await start();
    expect(await process.swap(), [1, 0, 1, 0]);
    expect(File(p.join(capture.path, 'ack.json')).existsSync(), false);
    for (var id = 1; id < 4; id++) {
      request(utf8.encode('$id barrier\n'));
      expect((await process.swap())[1], 0);
      final value = ack();
      expect([value['request_id'], value['kind'], value['status']], [id, 'barrier', 'ok']);
      expect(value['swap_success'], true);
      expect(value['file'], isNull);
      expect(value['bytes'], 0);
    }
    request(utf8.encode('4\n'));
    final result = await process.swap(), value = ack();
    expect(result.take(3), [1, 1, 5]);
    expect([value['request_id'], value['swap_index'], value['kind'], value['status']], [4, 5, 'capture', 'ok']);
    expect([value['width'], value['height'], value['stride'], value['bytes']], [2560, 1600, 10240, 16384000]);
    expect([value['format'], value['row_order'], value['origin']], ['RGBA8888', 'top_to_bottom', 'top-left']);
    final raw = File(p.join(capture.path, value['file'] as String)).readAsBytesSync();
    expect(raw.length, value['bytes']);
    expect(raw.take(8), [1599 & 255, 0, 37, 255, 1599 & 255, 1, 37, 255]);
    expect(raw.sublist(raw.length - 4), [0, 2559 & 255, 37, 255]);
    expect(await process.swap(), [1, 1, 6, result[3]]);
  });
  test('invalid EGL size framebuffer GL error and draw/read mismatch prevent pixels', () async {
    for (final (environment, expected) in [
      ({'FAKE_WIDTH': '1920'}, 'surface_dimensions_not_2560x1600'),
      ({'FAKE_FBO': '7'}, 'draw_framebuffer_is_not_zero'),
      ({'FAKE_GL_ERROR': '1'}, 'preexisting_gl_error'),
      ({'FAKE_READ_MISMATCH': '1'}, 'current_egl_surface_or_context_mismatch'),
    ]) {
      final process = await start(extra: environment);
      request(utf8.encode('100\n'));
      expect((await process.swap()).take(2), [1, 0]);
      final value = ack();
      expect([value['status'], value['error']], ['error', expected]);
      expect(value['bytes'], 0);
      expect(value['file'], isNull);
    }
  });
  test('invalid uint64 and duplicate requests remain explicit errors', () async {
    final process = await start();
    for (final invalid in ['0\n', '-1\n', '18446744073709551616\n', '1 garbage\n', '2\u0000extra']) {
      request(utf8.encode(invalid));
      expect((await process.swap())[1], 0);
      expect(ack()['status'], 'error');
    }
    request(utf8.encode('9 barrier\n'));
    await process.swap();
    expect(ack()['status'], 'ok');
    request(utf8.encode('9 barrier\n'));
    await process.swap();
    final value = ack();
    expect([value['status'], value['error']], ['error', 'request_id_not_increasing']);
  });
  test('loaded engine proof uses actual mapped library inode and SHA with exact environment', () async {
    const libraryPath = '/preserved:/engine path/"quoted"\\segment\nline';
    final process = await start(extra: {'LD_LIBRARY_PATH': libraryPath});
    request(utf8.encode('1 barrier\n'));
    await process.swap();
    expect(ack()['status'], 'ok');
    final metadata =
        jsonDecode(File(p.join(capture.path, 'capture-runtime.json')).readAsStringSync()) as Map<String, dynamic>;
    expect(metadata['kind'], 'egl_capture_loaded_runtime');
    expect(metadata['pid'], process.process.pid);
    final proof = metadata['engine'] as Map<String, dynamic>;
    expect(proof['path'], engine);
    expect(proof['mapped_inode'], inode(engine));
    expect(proof['sha256'], hashFile(engine));
    expect(metadata['effective_ld_library_path'], libraryPath);
    expect(File(p.join(capture.path, 'capture-runtime.json.tmp')).existsSync(), false);
  });
  test('missing loaded engine and failed real swap cannot accept capture', () async {
    var process = await start(executable: noEngineProbe);
    request(utf8.encode('1 barrier\n'));
    expect((await process.swap()).take(2), [1, 0]);
    var value = ack();
    expect([value['status'], value['error']], ['error', 'loaded_runtime_metadata_failed']);
    expect(File(p.join(capture.path, 'capture-runtime.json')).existsSync(), false);
    process = await start(extra: {'FAKE_SWAP_FALSE': '1'});
    request(utf8.encode('1 barrier\n'));
    expect((await process.swap()).take(2), [0, 0]);
    value = ack();
    expect([value['status'], value['error']], ['error', 'egl_swap_buffers_failed']);
    expect(value['swap_success'], false);
  });
  test('native SHA matches Dart crypto at padding block and streaming boundaries', () async {
    for (final size in [0, 1, 55, 56, 63, 64, 65, 4096, 16385]) {
      final bytes = List.generate(size, (i) => (i * 37 + 19) % 256),
          file = File(p.join(capture.path, 'hash-input'))..writeAsBytesSync(bytes);
      final result = await Process.run(hashProbe, [file.path]);
      expect(result.exitCode, 0);
      expect(result.stdout.toString().trim(), sha256.convert(bytes).toString(), reason: 'size=$size');
    }
  });
  test('existing raw evidence is never replaced and temporary files cleaned', () async {
    final original = File(p.join(capture.path, 'frame-1.rgba'))..writeAsStringSync('previous evidence'),
        process = await start();
    request(utf8.encode('1\n'));
    await process.swap();
    final value = ack();
    expect([value['status'], value['error']], ['error', 'publish_raw_failed']);
    expect(original.readAsStringSync(), 'previous evidence');
    expect(capture.listSync().where((file) => p.basename(file.path).contains('.tmp-')), isEmpty);
  });
  test('wrapper keeps argv native exit preload library priority and provenance', () async {
    final runtime = File(p.join(capture.path, 'fake runtime'))
      ..writeAsStringSync('#!/bin/sh\nprintf \'%s\\n\' "\$@" "\$LD_PRELOAD" "\$LD_LIBRARY_PATH"\nexit 7\n');
    await Process.run('chmod', ['0755', runtime.path]);
    final output = p.join(capture.path, 'wrapped output'), args = ['--release', '/a bundle', '--engine-value=a b'];
    final environment = Map<String, String>.from(Platform.environment)
      ..remove('BENCHMARK_EGL_CAPTURE_DIR')
      ..remove('LD_PRELOAD');
    environment.addAll({
      'BENCHMARK_OUTPUT': output,
      'BENCHMARK_EGL_REAL_RUNTIME': runtime.path,
      'BENCHMARK_EGL_CAPTURE_LIBRARY': interposer,
      'BENCHMARK_RENDERER': 'opengl',
      'LD_LIBRARY_PATH': '/original/bundle',
    });
    final result = await Process.run(p.join(here, 'flutter-pi-capture.sh'), args, environment: environment);
    expect(result.exitCode, 7, reason: result.stderr.toString());
    expect(const LineSplitter().convert(result.stdout.toString()), [
      ...args,
      interposer,
      '/original/bundle:${capture.path}',
    ]);
    final metadata = jsonDecode(
      File(p.join(output, 'egl-capture/runtime-provenance.json')).readAsStringSync(),
    ) as Map<String, dynamic>;
    expect((metadata['real_runtime'] as Map)['sha256'], hashFile(runtime.path));
    expect((metadata['interposer'] as Map)['sha256'], hashFile(interposer));
    expect(metadata['timing_results_valid'], false);
    expect(metadata['argv'], args);
    expect(metadata['effective_ld_library_path'], '/original/bundle:${capture.path}');
  });
}
