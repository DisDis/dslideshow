import 'dart:async';
import 'dart:convert';
import 'dart:isolate';

import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_backend/serializers.dart';
import 'package:dslideshow_common/rpc.dart';
import 'package:test/test.dart';

class _SystemInfoFailure implements RpcService {
  @override
  Future<RpcResult> executeCommand(RpcCommand command) async {
    if (command is GetSystemInfoCommand) {
      return ErrorResult(id: command.id, error: 'Collection stopped');
    }
    return EchoCommandResult(id: command.id, resultText: 'alive');
  }
}

void _worker(Map<String, dynamic> handshake) async {
  final remote = RemoteServiceImpl(serializers: serializers);
  remote.connect(HandshakeMessage.fromMap(handshake));
  try {
    await remote.service.processing(_SystemInfoFailure(), serializers);
  } finally {
    remote.service.commandIPort.close();
    for (final port in remote.service.resultIPorts) {
      port.close();
    }
    Isolate.exit();
  }
}

void main() {
  test('system-info error survives backend JSON serialization', () {
    const error = ErrorResult(id: 543, error: 'Collection stopped');
    final wire = jsonDecode(jsonEncode(serializers.serialize(error)));
    expect(serializers.deserialize(wire), error);
  });

  for (final asJson in [false, true]) {
    test('system-info RPC error releases its result port (JSON=$asJson)', () async {
      final remote = RemoteServiceImpl(serializers: serializers);
      await remote.spawn(_worker, resultIPortCount: 1);
      addTearDown(() async {
        remote.service.commanOPort.send(null);
        remote.service.commandIPort.close();
        for (final port in remote.service.resultIPorts) {
          port.close();
        }
        await Future.wait(
          remote.results.map((queue) async {
            await queue.cancel(immediate: true);
          }),
        );
      });
      const command = GetSystemInfoCommand(id: 543);
      final response = asJson ? remote.sendStr(command) : remote.send(command);
      await expectLater(
        response.timeout(const Duration(seconds: 5)),
        throwsA(
          isA<RpcErrorResultException>()
              .having((error) => error.errorResult.id, 'id', command.id)
              .having(
                (error) => error.errorResult.error,
                'error',
                'Collection stopped',
              ),
        ),
      );
      // A single result port must be available again after the failed request.
      final next = await remote
          .send(const EchoCommand(id: 544, text: 'ping'))
          .timeout(const Duration(seconds: 5));
      expect((next as EchoCommandResult).resultText, 'alive');
    });
  }
}
