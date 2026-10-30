import 'dart:convert';
import 'dart:io';

import 'package:cli_util/cli_util.dart' as cli;
import 'package:dslideshow_tools/src/repository.dart';
import 'package:path/path.dart' as p;
import 'package:test/test.dart';

void main() {
  final wrapper = p.join(findRepository().path, 'config_app/build_web.sh');
  final stub = p.absolute('test/support/command_stub.dart');
  Future<(int, List<dynamic>)> run(List<String> arguments, {bool failPub = false}) async {
    final root = await Directory.systemTemp.createTemp('web-wrapper-');
    try {
      final flutter = File(p.join(root.path, 'flutter'));
      await flutter.writeAsString('#!/bin/sh\nexec "${cli.dartExecutable}" --disable-dart-dev "$stub" "\$@"\n');
      expect((await Process.run('chmod', ['755', flutter.path])).exitCode, 0);
      final log = File(p.join(root.path, 'commands.jsonl'));
      final result = await Process.run(
        wrapper,
        arguments,
        workingDirectory: root.path,
        environment: {
          'PATH': '${root.path}:${Platform.environment['PATH']}',
          'COMMAND_LOG': log.path,
          'FAIL_PUB': failPub ? '1' : '0',
        },
      );
      return (result.exitCode, (await log.readAsLines()).map(jsonDecode).toList());
    } finally {
      await root.delete(recursive: true);
    }
  }

  const build = ['build', 'web', '--release', '--no-pub', '--no-web-resources-cdn', '--wasm'];
  test('standalone wrapper prepares dependencies once', () async {
    final (code, commands) = await run([]);
    expect(code, 0);
    expect(commands, [
      ['pub', 'get'],
      build,
    ]);
  });
  test('parallel wrapper does not resolve dependencies and forwards literal defines', () async {
    final (code, commands) = await run(['--no-pub', '--dart-define=EXAMPLE=value']);
    expect(code, 0);
    expect(commands, [
      [...build, '--dart-define=EXAMPLE=value'],
    ]);
  });
  test('failed dependency resolution prevents compilation', () async {
    final (code, commands) = await run([], failPub: true);
    expect(code, 7);
    expect(commands, [
      ['pub', 'get'],
    ]);
  });
}
