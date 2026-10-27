import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_backend/serializers.dart';
import 'package:dslideshow_backend/src/web_server/web_server_routes.dart';
import 'package:dslideshow_backend/src/web_server/web_service.dart'
    show WebService;
import 'package:dslideshow_backend/src/web_server/web_socket_user.dart';
import 'package:dslideshow_common/rpc.dart';
import 'package:fake_async/fake_async.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:test/test.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'support/web_socket_channel.dart';

class _Remote implements RemoteService {
  final commands = <RpcCommand>[];
  final pending = Completer<RpcResult>();

  @override
  Future<RpcResult> send<T extends RpcCommand>(T command) {
    commands.add(command);
    return pending.future;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _Fixture {
  final channel = TestWebSocketChannel();
  final remote = _Remote();
  late final WebSocketUser user;

  _Fixture() {
    user = WebSocketUser(AppConfig.fromJson({}), 'code', channel, {}, remote);
  }

  void authenticate(FakeAsync clock, {String code = 'code'}) {
    channel.receive(WSAuthCommand(userName: 'admin', code: code, id: 1));
    clock.elapse(const Duration(milliseconds: 999));
    expect(channel.sent, isEmpty);
    clock.elapse(const Duration(milliseconds: 1));
  }

  void close(FakeAsync clock) {
    channel.incoming.close();
    clock.flushMicrotasks();
  }
}

void main() {
  test(
    'WebService authenticates and disconnects its sessions over HTTP',
    () async {
      final root = await Directory.systemTemp.createTemp('web-socket-route-');
      addTearDown(() => root.delete(recursive: true));
      await Directory('${root.path}/web').create();
      final config = AppConfig.fromJson({
        'web': {'permanentCode': 'code'},
      });
      final cwd = Directory.current;
      late final WebService service;
      try {
        Directory.current = root;
        service = WebService(
          config,
          config.webServer,
          _Remote(),
          cacheDirectory: Directory('${root.path}/media'),
          galleryDirectory: Directory('${root.path}/gallery'),
          startServer: false,
        );
      } finally {
        Directory.current = cwd;
      }
      var serviceClosed = false;
      addTearDown(() async {
        if (!serviceClosed) await service.close();
      });
      final server = await shelf_io.serve(
        service.handler,
        InternetAddress.loopbackIPv4,
        0,
      );
      addTearDown(() => server.close(force: true));
      final channel = WebSocketChannel.connect(
        Uri.parse('ws://127.0.0.1:${server.port}${WebServerRoutes.webSocket}'),
      );
      addTearDown(() => channel.sink.close());
      await channel.ready;
      final messages = StreamIterator(channel.stream);
      addTearDown(messages.cancel);
      channel.sink.add(
        jsonEncode(
          serializers.serialize(
            const WSAuthCommand(userName: 'admin', code: 'code', id: 1),
          ),
        ),
      );
      expect(await messages.moveNext(), isTrue);
      expect(
        serializers.deserialize(jsonDecode(messages.current as String)),
        isA<WSHelloCommand>(),
      );
      expect(await messages.moveNext(), isTrue);
      expect(
        serializers.deserialize(jsonDecode(messages.current as String)),
        const WSResultOk(id: 1),
      );
      channel.sink.add(
        jsonEncode(
          serializers.serialize(const WSEchoCommand(id: 2, msg: 'route')),
        ),
      );
      expect(await messages.moveNext(), isTrue);
      expect(
        serializers.deserialize(jsonDecode(messages.current as String)),
        const WSEchoResult(id: 2, msg: 'route'),
      );
      await service.close();
      serviceClosed = true;
      expect(await messages.moveNext(), isFalse);
    },
  );

  test('authentication preserves delay and hello-before-ack ordering', () {
    fakeAsync((clock) {
      final fixture = _Fixture();
      fixture.authenticate(clock);
      expect(fixture.channel.sent, [
        isA<WSHelloCommand>(),
        const WSResultOk(id: 1),
      ]);
      fixture.close(clock);
    });
  });

  test('invalid code disconnects and returns the original auth id', () {
    fakeAsync((clock) {
      final fixture = _Fixture();
      fixture.authenticate(clock, code: 'incorrect');
      expect(fixture.channel.sink.closeCalls, 1);
      expect(
        fixture.channel.sent.single,
        isA<WSErrorResult>().having((result) => result.id, 'id', 1),
      );
      expect(fixture.remote.commands, isEmpty);
      fixture.close(clock);
    });
  });

  test('anonymous command disconnects without reaching backend', () {
    fakeAsync((clock) {
      final fixture = _Fixture();
      fixture.channel.receive(const WSEchoCommand(id: 2, msg: 'hello'));
      clock.flushMicrotasks();
      expect(fixture.channel.sink.closeCalls, 1);
      expect(fixture.channel.sent, isEmpty);
      expect(fixture.remote.commands, isEmpty);
      fixture.close(clock);
    });
  });

  test('authorized echo and failure preserve request ids', () {
    fakeAsync((clock) {
      final fixture = _Fixture();
      fixture.authenticate(clock);
      fixture.channel.receive(const WSEchoCommand(id: 2, msg: 'hello'));
      clock.flushMicrotasks();
      expect(
        fixture.channel.sent.last,
        const WSEchoResult(id: 2, msg: 'hello'),
      );
      fixture.channel.receive(const WSEchoCommand(id: 3, msg: 'error'));
      clock.flushMicrotasks();
      expect(
        fixture.channel.sent.last,
        const WSErrorResult(id: 3, error: 'error'),
      );
      fixture.close(clock);
    });
  });

  for (final fail in [false, true]) {
    test('RPC proxy waits and correlates its response (failure=$fail)', () {
      fakeAsync((clock) {
        final fixture = _Fixture();
        fixture.authenticate(clock);
        fixture.channel.sent.clear();
        const inner = EchoCommand(id: 41, text: 'backend');
        fixture.channel.receive(
          WSSendRpcCommand(id: 9, commandData: serializers.serialize(inner)!),
        );
        clock.flushMicrotasks();
        expect(fixture.remote.commands.single, inner);
        expect(fixture.channel.sent, isEmpty);
        if (fail) {
          fixture.remote.pending.completeError(
            StateError('backend unavailable'),
          );
        } else {
          fixture.remote.pending.complete(
            const EchoCommandResult(id: 41, resultText: 'done'),
          );
        }
        clock.flushMicrotasks();
        final result = fixture.channel.sent.last;
        expect(result.id, 9);
        if (fail) {
          expect(result, isA<WSErrorResult>());
          expect(
            (result as WSErrorResult).error,
            contains('backend unavailable'),
          );
        } else {
          final rpc = result as WSRpcResult;
          expect(
            serializers.deserialize(rpc.resultData),
            const EchoCommandResult(id: 41, resultText: 'done'),
          );
        }
        fixture.close(clock);
      });
    });
  }

  test(
    'server requests resolve by id and explicit disconnect fails pending',
    () {
      fakeAsync((clock) {
        final fixture = _Fixture();
        final responses = <WebSocketResult>[];
        final errors = <Object>[];
        fixture.user
            .send(const WSEchoCommand(id: 20, msg: 'outgoing'))
            .then(responses.add);
        fixture.channel.receive(const WSEchoResult(id: 21, msg: 'unrelated'));
        clock.flushMicrotasks();
        expect(responses, isEmpty);
        fixture.channel.receive(const WSEchoResult(id: 20, msg: 'reply'));
        clock.flushMicrotasks();
        expect(responses, [const WSEchoResult(id: 20, msg: 'reply')]);

        fixture.user
            .send(const WSEchoCommand(id: 22, msg: 'pending'))
            .then(responses.add, onError: (Object error) => errors.add(error));
        fixture.user.disconnect();
        clock.flushMicrotasks();
        expect(errors, [const WSErrorResult(id: 22, error: 'disconnect')]);
        expect(fixture.channel.sink.closeCalls, 1);
        var disconnected = false;
        fixture.user.onDisconnect.then((_) => disconnected = true);
        fixture.close(clock);
        expect(disconnected, isTrue);
      });
    },
  );
}
