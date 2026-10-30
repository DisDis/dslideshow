import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as p;

Future<void> main(List<String> args) async {
  if (args.contains('--help')) {
    stdout.writeln('fake flutter-pi --vulkan');
    return;
  }
  final env = Platform.environment, output = Directory(env['BENCHMARK_OUTPUT']!);
  final record = env['BENCHMARK_TEST_RECORD'];
  if (record != null) {
    File(record).writeAsStringSync('${env['BENCHMARK_RENDERER'] ?? 'unknown'}\n', mode: FileMode.append);
  }
  final policy = env['BENCHMARK_VULKAN_VIDEO'] ?? 'default-false';
  File(p.join(output.path, 'policy.txt')).writeAsStringSync(policy);
  stdout.writeln('native-stdout');
  stderr.writeln('native-fault-operation');
  final code = int.parse(env['BENCHMARK_TEST_EXIT'] ?? '0');
  final control = env['BENCHMARK_TEST_CONTROL'];
  if (control != null) {
    final socket = await Socket.connect(InternetAddress.loopbackIPv4, int.parse(control)),
        done = Completer<void>(),
        release = Completer<void>();
    final input = socket.cast<List<int>>().transform(utf8.decoder).transform(const LineSplitter()).listen((line) {
      if (line == 'release' && !release.isCompleted) release.complete();
    });
    final signal = ProcessSignal.sigterm.watch().listen((_) async {
      socket.writeln('stopping');
      await socket.flush();
      await release.future;
      File(p.join(output.path, 'teardown-complete')).writeAsStringSync('closed');
      if (!done.isCompleted) done.complete();
    });
    socket.writeln('ready');
    await socket.flush();
    await done.future;
    await signal.cancel();
    await input.cancel();
    await socket.close();
  }
  if (code == 0) {
    File(p.join(output.path, 'summary.json')).writeAsStringSync(
      jsonEncode({
        'status': 'completed',
        'expected_cases': 1,
        'observed_cases': 1,
        'failed_runs': 0,
        'metadata': <String, dynamic>{},
        'cases': <dynamic>[],
      }),
    );
  }
  exitCode = code;
}
