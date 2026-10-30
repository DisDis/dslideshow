import 'dart:convert';
import 'dart:io';

Future<void> main(List<String> args) async {
  final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
  final control = await Socket.connect(
    InternetAddress.loopbackIPv4,
    int.parse(Platform.environment['GALLERY_TEST_CONTROL']!),
  );
  control.writeln(jsonEncode({'pid': pid, 'fixture': args.single}));
  await control.flush();
  stdout.writeln(jsonEncode({'kind': 'ready', 'pid': pid, 'port': server.port, 'code': 'fixture'}));
  server.listen((request) {});
}
