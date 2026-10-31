// ignore_for_file: avoid_slow_async_io
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dslideshow_backend/src/service/gallery/gallery_catalog_service.dart';
import 'package:dslideshow_backend/src/service/gallery/gallery_tool_runner.dart';
import 'package:dslideshow_common/gallery.dart';
import 'package:logging/logging.dart';
import 'package:test/test.dart';

import 'helpers/capture_logs.dart';

import 'package:path/path.dart' as p;

final _dart = Platform.environment['DSLIDESHOW_DART'] ?? 'dart';
final _processFixture = p.absolute('test/support/external_process_fixture.dart');

Matcher fails(GalleryErrorCode code) => throwsA(isA<GalleryCatalogFailure>().having((e) => e.code, 'code', code));

void main() {
  late Directory root;
  setUp(() async {
    root = await Directory.systemTemp.createTemp('gallery-tool-');
  });
  tearDown(() => root.delete(recursive: true));

  test('arguments are literal, environment is forwarded, stderr stays separate', () async {
    final runner = ProcessGalleryToolRunner();
    addTearDown(runner.close);
    const argument =
        r'with spaces; $(touch never) "literal"'
        '\nnext';
    final result = await runner.run(
      _dart,
      ['--disable-dart-dev', _processFixture, 'literal', '', argument],
      environment: {'GALLERY_TEST': 'local-value'},
    );
    expect(result.exitCode, 0);
    expect(jsonDecode(result.stdout), [argument, 'local-value']);
    expect(result.stderr, 'diagnostic');
    expect(await File('${root.path}/never').exists(), false);
  });

  test('missing executable is unavailable and runner remains usable', () async {
    final runner = ProcessGalleryToolRunner();
    addTearDown(runner.close);
    await captureLogs((records) async {
      await expectLater(runner.run('${root.path}/absent', []), fails(GalleryErrorCode.unavailable));
      final launch = records.singleWhere((record) => record.message.contains('Tool launch failed'));
      expect(launch.level, Level.WARNING);
      expect(launch.message, contains('reason=missingExecutable'));
      expect(launch.message, contains('osError=2'));
      expect(launch.message, contains('tool=external'));
      expect(launch.message, isNot(contains(root.path)));
      expect(launch.message, isNot(contains('absent')));
      expect(launch.error, isA<ProcessException>());
      expect(launch.error.toString(), contains(root.path));
      expect(launch.stackTrace, isNotNull);
    });
    expect((await runner.run(_dart, ['--disable-dart-dev', _processFixture, 'ok'])).stdout, 'ok\n');
  });

  test('combined stdout/stderr limit terminates and reaps child', () async {
    Process? child;
    final runner = ProcessGalleryToolRunner(
      startProcess: (executable, arguments, {environment}) async =>
          child = await Process.start(executable, arguments, environment: environment),
    );
    addTearDown(runner.close);
    await expectLater(
      runner.run(_dart, ['--disable-dart-dev', _processFixture, 'flood'], maxOutputBytes: 5000),
      fails(GalleryErrorCode.outputLimitExceeded),
    );
    expect(await child!.exitCode, isA<int>());
    if (Platform.isLinux) expect(await Directory('/proc/${child!.pid}').exists(), false);
  });

  test('discarded stdout is drained while stderr keeps its byte limit', () async {
    final runner = ProcessGalleryToolRunner();
    addTearDown(runner.close);
    final result = await runner.run(
      _dart,
      ['--disable-dart-dev', _processFixture, 'discarded'],
      discardStdout: true,
      maxOutputBytes: 16,
    );
    expect(result.exitCode, 0);
    expect(result.stdout, isEmpty);
    expect(result.stderr, 'kept');
    await expectLater(
      runner.run(
        _dart,
        ['--disable-dart-dev', _processFixture, 'discardedFlood'],
        discardStdout: true,
        maxOutputBytes: 16,
      ),
      fails(GalleryErrorCode.outputLimitExceeded),
    );
  });

  test('cancellation kills a TERM-resistant process before completing', () async {
    final readyServer = await ServerSocket.bind(InternetAddress.loopbackIPv4, 0);
    addTearDown(readyServer.close);
    final ready = readyServer.first.then((socket) async {
      await socket.first;
      socket.destroy();
    });
    Process? child;
    final runner = ProcessGalleryToolRunner(
      startProcess: (executable, arguments, {environment}) async =>
          child = await Process.start(executable, arguments, environment: environment),
    );
    addTearDown(runner.close);
    final cancellation = Completer<void>();
    final work = runner.run(_dart, [
      '--disable-dart-dev',
      _processFixture,
      'resist',
      '${readyServer.port}',
    ], cancellation: cancellation.future);
    final failed = expectLater(work, fails(GalleryErrorCode.cancelled));
    await ready.timeout(const Duration(seconds: 5));
    cancellation.complete();
    await failed;
    expect(await child!.exitCode, isNonZero);
    if (Platform.isLinux) expect(await Directory('/proc/${child!.pid}').exists(), false);
  });

  test('timeout reaps child; close also waits for a pending Process.start', () async {
    final runner = ProcessGalleryToolRunner();
    addTearDown(runner.close);
    await expectLater(
      runner.run(_dart, ['--disable-dart-dev', _processFixture, 'resist'], timeout: const Duration(milliseconds: 300)),
      fails(GalleryErrorCode.timeout),
    );
    final entered = Completer<void>(), release = Completer<void>();
    Process? child;
    final delayed = ProcessGalleryToolRunner(
      startProcess: (executable, arguments, {environment}) async {
        entered.complete();
        await release.future;
        return child = await Process.start(executable, arguments, environment: environment);
      },
    );
    addTearDown(delayed.close);
    final work = delayed.run(_dart, ['--disable-dart-dev', _processFixture, 'wait']);
    final failed = expectLater(work, fails(GalleryErrorCode.cancelled));
    await entered.future;
    final closing = delayed.close();
    release.complete();
    await closing;
    await failed;
    expect(await child!.exitCode, isNonZero);
    await expectLater(delayed.run(_dart, []), fails(GalleryErrorCode.unavailable));
  });

  test('already completed cancellation does not start an executable', () async {
    var starts = 0;
    final runner = ProcessGalleryToolRunner(
      startProcess: (executable, arguments, {environment}) async {
        starts++;
        return Process.start(executable, arguments, environment: environment);
      },
    );
    addTearDown(runner.close);
    await expectLater(runner.run(_dart, [], cancellation: Future<void>.value()), fails(GalleryErrorCode.cancelled));
    expect(starts, 0);
  });
}
