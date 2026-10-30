import 'dart:convert';
import 'dart:io';

import 'package:cli_util/cli_util.dart' as cli;
import 'package:dslideshow_tools/src/repository.dart';
import 'package:path/path.dart' as p;
import 'package:test/test.dart';

void main() {
  final script = p.join(findRepository().path, 'benchmarks/tool/build_tools.sh');
  final compiler = File('test/support/fake_compiler.dart').absolute.path;
  for (final relative in [true, false]) {
    test(
      'benchmark helper uses absolute compiler output for ${relative ? 'relative' : 'absolute'} spaced target',
      () async {
        final root = await Directory.systemTemp.createTemp('helper-package-');
        addTearDown(() => root.delete(recursive: true));
        final stub = File(p.join(root.path, 'fake-dart'));
        await stub.writeAsString('#!/bin/sh\nexec "${cli.dartExecutable}" --disable-dart-dev "$compiler" "\$@"\n');
        expect((await Process.run('chmod', ['0755', stub.path])).exitCode, 0);
        final destination = p.join(root.path, 'output with spaces', 'bundle');
        final log = File(p.join(root.path, 'compiler.json'));
        final result = await Process.run(
          'bash',
          [script, relative ? p.relative(destination, from: root.path) : destination],
          workingDirectory: root.path,
          environment: {'DART_EXECUTABLE': stub.path, 'COMPILER_TEST_LOG': log.path},
        );
        expect(result.exitCode, 0, reason: result.stderr.toString());
        final command = jsonDecode(await log.readAsString()) as Map<String, dynamic>;
        final args = (command['args'] as List).cast<String>();
        expect(args[args.indexOf('-o') + 1], p.join(destination, 'tools/dslideshow_tools'));
        expect(args, containsAll(['--target-os=linux', '--target-arch=arm64']));
        expect(await File(p.join(destination, 'tools/dslideshow_tools')).readAsString(), 'compiled-linux-arm64');
        expect(File(p.join(destination, 'tool/cli.sh')).existsSync(), true);
        final checksum = await Process.run('sha256sum', [
          '-c',
          'tools/dslideshow_tools.sha256',
        ], workingDirectory: destination);
        expect(checksum.exitCode, 0, reason: checksum.stderr.toString());
      },
    );
  }
}
