@Timeout(Duration(seconds: 60))
library;

import 'dart:convert';
import 'dart:io';

import 'package:cli_util/cli_util.dart' as cli;
import 'package:dslideshow_tools/src/benchmarks/json_io.dart';
import 'package:dslideshow_tools/src/process/supervisor.dart';
import 'package:path/path.dart' as p;
import 'package:test/test.dart';

import '../support/compiled_dart_fixture.dart';

void main() {
  late File driver, server;
  setUpAll(() async {
    final compiled = await Directory.systemTemp.createTemp('gallery-lifecycle-kernel-');
    addTearDown(() => compiled.delete(recursive: true));
    final packages = File('.dart_tool/package_config.json').absolute;
    final fixtures = await Future.wait([
      compileDartFixture(File('test/support/gallery_trial_driver.dart'), compiled, packageConfig: packages),
      compileDartFixture(File('test/support/gallery_stalled_server.dart'), compiled, packageConfig: packages),
    ]);
    driver = fixtures[0];
    server = fixtures[1];
  });

  for (final signal in [ProcessSignal.sigint, ProcessSignal.sigterm]) {
    test('gallery trial $signal reaps its server and removes temporary media', () async {
      final root = Directory.systemTemp.createTempSync('gallery-lifecycle-');
      addTearDown(() => root.deleteSync(recursive: true));
      final control = await ServerSocket.bind(InternetAddress.loopbackIPv4, 0);
      addTearDown(() => control.close());
      final accepted = control.first;
      final runtime = File(p.join(root.path, 'runtime'));
      final dart = cli.dartExecutable!;
      String quote(String value) => "'${value.replaceAll("'", "'\\''")}'";
      runtime.writeAsStringSync('#!/bin/sh\nexec ${quote(dart)} --disable-dart-dev ${quote(server.path)} "\$@"\n');
      final mode = await Process.run('chmod', ['0755', runtime.path]);
      expect(mode.exitCode, 0);
      final photo = File(p.join(root.path, 'original.jpg'))..writeAsStringSync('fixture');
      final owner = ProcessSupervisor();
      final process = await Process.start(
        'setsid',
        ['--', dart, '--disable-dart-dev', driver.path, runtime.path, p.join(root.path, 'result'), photo.path],
        environment: {'GALLERY_TEST_CONTROL': control.port.toString()},
      );
      owner.adopt(process);
      addTearDown(() async {
        await owner.cancel(143);
        await owner.close();
      });
      final out = process.stdout.transform(utf8.decoder).join(), err = process.stderr.transform(utf8.decoder).join();
      final socket = await accepted.timeout(const Duration(seconds: 30));
      addTearDown(socket.destroy);
      final ready = asMap(
        decodeStrictJson(
          await socket
              .cast<List<int>>()
              .transform(utf8.decoder)
              .transform(const LineSplitter())
              .first
              .timeout(const Duration(seconds: 5)),
        ),
      );
      process.kill(signal);
      expect(
        await process.exitCode.timeout(const Duration(seconds: 8)),
        128 + signal.signalNumber,
        reason: (await out) + (await err),
      );
      expect(Directory('/proc/${ready['pid']}').existsSync(), false);
      expect(Directory(ready['fixture'] as String).parent.existsSync(), false);
      await socket.close();
    }, timeout: const Timeout(Duration(seconds: 45)));
  }
}
