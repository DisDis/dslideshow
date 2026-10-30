import 'dart:io';

import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_backend/src/web_server/web_server.dart';
import 'package:dslideshow_backend/src/web_server/web_service.dart';
import 'package:dslideshow_common/rpc.dart';
import 'package:test/test.dart';

import 'helpers/capture_logs.dart';

class _Remote implements RemoteService {
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  late Directory root;
  final services = <WebService>[];
  setUp(() async {
    root = await Directory.systemTemp.createTemp('web-control-');
  });
  tearDown(() async {
    for (final service in services) {
      await service.close();
    }
    services.clear();
    await root.delete(recursive: true);
  });
  WebService create(int port, {bool always = false}) {
    final config = AppConfig.fromJson({
      'web': {
        'port': port,
        'alwaysEnabled': always,
        'permanentCode': 'secret-83472',
      },
    });
    final service = WebService(
      config,
      config.webServer,
      _Remote(),
      cacheDirectory: Directory('${root.path}/media')..createSync(),
      galleryDirectory: Directory('${root.path}/gallery'),
      startServer: false,
    );
    services.add(service);
    return service;
  }

  Future<int> unusedPort() async {
    final socket = await ServerSocket.bind(InternetAddress.loopbackIPv4, 0);
    final port = socket.port;
    await socket.close();
    return port;
  }

  Future<int> get(int port) async {
    final client = HttpClient();
    try {
      final request = await client.getUrl(
        Uri(scheme: 'http', host: '127.0.0.1', port: port, path: '/'),
      );
      final response = await request.close();
      await response.drain<void>();
      return response.statusCode;
    } finally {
      client.close(force: true);
    }
  }

  test('RPC acknowledges only after bind, and stop frees the port', () async {
    final port = await unusedPort();
    final service = create(port);
    final server = WebServer(
      AppConfig.fromJson({}).webServer,
      _Remote(),
      service,
    );
    final result = await server.executeCommand(
      const WebServerControlCommand(id: 1, enable: true),
    );
    expect(result, isA<WebServerControlCommandResult>());
    expect(await get(port), isIn([200, 404, 301]));
    await server.executeCommand(
      const WebServerControlCommand(id: 2, enable: false),
    );
    final socket = await ServerSocket.bind(InternetAddress.anyIPv4, port);
    await socket.close();
  });

  test(
    'bind error reaches RPC, retry succeeds, logs include explicitly authorized access codes',
    () => captureLogs((records) async {
      final socket = await ServerSocket.bind(InternetAddress.anyIPv4, 0);
      final port = socket.port;
      final service = create(port);
      final server = WebServer(
        AppConfig.fromJson({}).webServer,
        _Remote(),
        service,
      );
      final failed = await server.executeCommand(
        const WebServerControlCommand(id: 3, enable: true),
      );
      expect(failed, isA<RpcErrorResult>());
      await socket.close();
      expect(
        await server.executeCommand(
          const WebServerControlCommand(id: 4, enable: true),
        ),
        isA<WebServerControlCommandResult>(),
      );
      expect(await get(port), isIn([200, 404, 301]));
      final logs = records.map((r) => r.message).join('\n');
      expect(logs, contains('Web control id=1'));
      expect(logs, contains('failed type=SocketException'));
      expect(logs, contains('Web control id=2'));
      expect(logs, contains('Access code updated code=secret-83472'));
      expect(
        logs,
        contains('Permanent access code configured code=secret-83472'),
      );
      expect(logs, contains('accessCode=secret-83472'));
      expect(logs, isNot(contains('authCode')));
    }),
  );

  test('close cancels queued activation and leaves no listener', () async {
    final port = await unusedPort();
    final service = create(port);
    final command = service.setEnabled(true);
    final checked = expectLater(command, throwsStateError);
    await service.close();
    services.remove(service);
    await checked;
    final socket = await ServerSocket.bind(InternetAddress.anyIPv4, port);
    await socket.close();
  });

  test(
    'alwaysEnabled survives disable and overlapping commands remain ordered',
    () async {
      final port = await unusedPort();
      final service = create(port, always: true);
      await Future.wait([
        service.setEnabled(true),
        service.setEnabled(false),
        service.setEnabled(true),
      ]);
      expect(service.enabled, isTrue);
      expect(await get(port), isIn([200, 404, 301]));
      await service.close();
      services.remove(service);
      final socket = await ServerSocket.bind(InternetAddress.anyIPv4, port);
      await socket.close();
    },
  );
}
