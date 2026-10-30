import 'dart:async';
import 'dart:convert';
import 'dart:io';

Future<void> main(List<String> arguments) async {
  final label = arguments[0];
  final socket = await Socket.connect(InternetAddress.loopbackIPv4, int.parse(arguments[1]));
  StreamSubscription<ProcessSignal>? signal;
  if (label == 'pipe-child') {
    signal = ProcessSignal.sigterm.watch().listen((_) {});
  } else {
    final command = [arguments[2], '--disable-dart-dev', Platform.script.toFilePath(), 'pipe-child', arguments[1]];
    await Process.start(
      arguments[3] == 'detached' ? 'setsid' : command.first,
      arguments[3] == 'detached' ? command : command.skip(1).toList(),
      mode: ProcessStartMode.inheritStdio,
    );
  }
  socket.writeln(jsonEncode({'label': label, 'pid': pid}));
  await socket.flush();
  await for (final command in socket.cast<List<int>>().transform(utf8.decoder).transform(const LineSplitter())) {
    if (command == 'pass' || command == 'fail') {
      // This fixture deliberately leaves an inherited writer behind. Production
      // CLIs return normally; abrupt exit models compiler/launcher failure.
      exit(command == 'fail' ? 7 : 0);
    }
  }
  await signal?.cancel();
  socket.destroy();
}
