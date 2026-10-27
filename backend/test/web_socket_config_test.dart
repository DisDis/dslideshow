import 'dart:convert';
import 'dart:io';

import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_backend/src/web_server/web_socket_user.dart';
import 'package:dslideshow_common/rpc.dart';
import 'package:fake_async/fake_async.dart';
import 'package:test/test.dart';

import 'support/web_socket_channel.dart';

void main() {
  test('WebSocket downloads saved config and reports save/read failures', () {
    final directory = Directory.systemTemp.createTempSync('web-socket-config-');
    addTearDown(() => directory.deleteSync(recursive: true));
    final file = File('${directory.path}/config.json');
    final active = AppConfig.fromJson({
      'web': {'port': 8090},
    })..fullConfigFilename = file.path;
    fakeAsync((clock) {
      final channel = TestWebSocketChannel();
      WebSocketUser(active, 'code', channel, {}, _UnusedRemoteService());
      channel.receive(
        const WSAuthCommand(userName: 'admin', code: 'code', id: 1),
      );
      clock.elapse(const Duration(seconds: 1));
      expect(channel.sent.whereType<WSResultOk>().single.id, 1);

      channel.receive(const WSConfigDownloadCommand(id: 2));
      var result = channel.sent.last as WSConfigDownloadResult;
      expect(result.id, 2);
      expect(
        AppConfig.fromJson(jsonDecode(result.content)).webServer.port,
        8090,
      );

      channel.receive(
        const WSConfigUploadCommand(content: '{"web":{"port":8091}}', id: 3),
      );
      expect(channel.sent.last, const WSResultOk(id: 3));
      channel.receive(const WSConfigDownloadCommand(id: 4));
      result = channel.sent.last as WSConfigDownloadResult;
      expect(
        AppConfig.fromJson(jsonDecode(result.content)).webServer.port,
        8091,
      );
      expect(active.webServer.port, 8090);

      file.writeAsStringSync('{"web":{"port":8092}}');
      channel.receive(const WSConfigDownloadCommand(id: 5));
      result = channel.sent.last as WSConfigDownloadResult;
      expect(
        AppConfig.fromJson(jsonDecode(result.content)).webServer.port,
        8092,
      );

      file.writeAsStringSync('{malformed');
      channel.receive(const WSConfigDownloadCommand(id: 6));
      expect(
        channel.sent.last,
        isA<WSErrorResult>().having((r) => r.id, 'id', 6),
      );

      file.deleteSync();
      Directory(file.path).createSync();
      channel.receive(
        const WSConfigUploadCommand(content: '{"web":{"port":8093}}', id: 7),
      );
      expect(
        channel.sent.last,
        isA<WSErrorResult>().having((r) => r.id, 'id', 7),
      );
      expect(active.webServer.port, 8090);
      channel.incoming.close();
      clock.flushMicrotasks();
    });
  });
}

class _UnusedRemoteService implements RemoteService {
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
