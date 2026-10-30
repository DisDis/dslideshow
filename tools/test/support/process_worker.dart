import 'dart:async';
import 'dart:convert';
import 'dart:io';

Future<void> main(List<String> args) async {
  if (args.first == 'echo') {
    stdout.writeln(jsonEncode([args[1], Platform.environment['LITERAL_VALUE']]));
    stderr.write('diagnostic');
    return;
  }
  final label = args[0];
  final connection = await Socket.connect(InternetAddress.loopbackIPv4, int.parse(args[1]));
  StreamSubscription<ProcessSignal>? signals;
  if (label.endsWith('.child') || args.contains('--resist')) {
    signals = ProcessSignal.sigterm.watch().listen((_) {});
  }
  if (args.contains('--child')) {
    final child = await Process.start(args[2], [
      '--disable-dart-dev',
      Platform.script.toFilePath(),
      '$label.child',
      args[1],
      args[2],
      '--resist',
    ]);
    unawaited(child.stdout.drain<void>());
    unawaited(child.stderr.drain<void>());
  }
  connection.writeln(jsonEncode({'label': label, 'pid': pid}));
  await connection.flush();
  await for (final command in connection.cast<List<int>>().transform(utf8.decoder).transform(const LineSplitter())) {
    if (command == 'pass' || command == 'fail') {
      exitCode = command == 'pass' ? 0 : 7;
      if (args.contains('--child')) {
        // Deliberately model an exited parent with a still-running descendant.
        // Normal tool entrypoints return naturally; this fixture must not wait
        // for the child's inherited handles to be released.
        exit(exitCode);
      }
      break;
    }
  }
  await signals?.cancel();
  connection.destroy();
}
