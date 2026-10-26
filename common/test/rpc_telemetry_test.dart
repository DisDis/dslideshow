import 'dart:async';
import 'dart:isolate';

import 'package:async/async.dart' show StreamQueue;
import 'package:dslideshow_common/rpc.dart';
import 'package:dslideshow_common/serializers.dart';
import 'package:test/test.dart';

enum _Operation { hold, fail }

class _Command implements RpcCommand {
  @override
  final int id;
  final _Operation operation;
  const _Command(this.id, this.operation);
  @override
  String get type => operation.name;
}

class _Serializers implements Serializers {
  const _Serializers();
  @override
  Object? serialize<T>(T object) => object;
  @override
  Object? deserialize(Object? object) => object;
}

class _Service implements RpcService {
  final SendPort events;
  final held = <int, Completer<RpcResult>>{};
  _Service(this.events);
  @override
  Future<RpcResult> executeCommand(RpcCommand command) async {
    final request = command as _Command;
    if (request.operation == _Operation.fail) {
      return ErrorResult(id: request.id, error: 'expected error');
    }
    final result = Completer<RpcResult>();
    held[request.id] = result;
    events.send(request.id);
    return result.future;
  }

  void release(int id) =>
      held.remove(id)!.complete(ErrorResult(id: id, error: 'released'));
}

Future<void> _close(RemoteServiceImpl remote) async {
  remote.service.commandIPort.close();
  for (final port in remote.service.resultIPorts) {
    port.close();
  }
  await Future.wait(
    remote.results.map((queue) async => await queue.cancel(immediate: true)),
  );
}

void _worker(Map<String, dynamic> handshake) async {
  final remote = RemoteServiceImpl(
    serializers: const _Serializers(),
    telemetry: RpcTelemetry(RpcNode.backend),
    peer: RpcNode.frontend,
  );
  remote.connect(HandshakeMessage.fromMap(handshake), 2);
  final control = ReceivePort();
  final service = _Service(remote.service.commanOPort);
  final subscription = control.listen((message) {
    service.release(message as int);
  });
  remote.service.commanOPort.send(control.sendPort);
  try {
    await remote.service.processing(service, const _Serializers());
  } finally {
    for (final id in service.held.keys.toList()) {
      service.release(id);
    }
    await subscription.cancel();
    control.close();
    await _close(remote);
    remote.service.commanOPort.send(null);
  }
  Isolate.exit();
}

RpcNodeSnapshot _node(int time) => RpcNodeSnapshot(
  node: RpcNode.frontend,
  sessionId: 'test',
  sampledAt: DateTime.utc(2026),
  elapsedMicros: time,
);

void main() {
  test(
    'telemetry uses the same slots and observes held and queued RPCs',
    () async {
      final telemetry = RpcTelemetry(RpcNode.frontend);
      final remote = RemoteServiceImpl(
        serializers: const _Serializers(),
        telemetry: telemetry,
        peer: RpcNode.backend,
      );
      await remote.spawn(_worker, resultIPortCount: 2);
      final events = StreamQueue<dynamic>(remote.service.commandIPort);
      final control = await events.next as SendPort;
      final failures = <Future<void>>[];
      try {
        for (var id = 1; id <= 2; id++) {
          failures.add(
            expectLater(
              remote.send(_Command(id, _Operation.hold)),
              throwsA(isA<RpcErrorResultException>()),
            ),
          );
          expect(await events.next, id);
        }
        var returned = false;
        final read = remote.send(const GetRpcTelemetryCommand(id: 3)).then((
          value,
        ) {
          returned = true;
          return value as GetRpcTelemetryResult;
        });
        await Future<void>.delayed(Duration.zero);
        final busy = telemetry.localSnapshot().connections.single.outgoing;
        expect(busy.inFlight, 2);
        expect(busy.queued, 1);
        expect(busy.maxQueued, 1);
        expect(busy.maxInFlight, 2);
        expect(busy.sent, 2);
        expect(busy.oldestQueued!.commandType, 'get_rpc_telemetry');
        expect(busy.oldestInFlight!.commandType, 'hold');
        expect(busy.oldestInFlight!.ageMicros, greaterThan(0));
        expect(returned, isFalse);

        control.send(1);
        final result = await read;
        final handler =
            result.snapshot.nodes.single.connections.single.incoming;
        expect(
          handler.active,
          2,
          reason: 'second held RPC and telemetry itself',
        );
        expect(handler.completed, 1);
        expect(handler.errors, 1);
        control.send(2);
        await Future.wait(failures);
        final finished = telemetry.localSnapshot().connections.single.outgoing;
        expect(finished.inFlight, 0);
        expect(finished.queued, 0);
        expect(finished.submitted, 3);
        expect(finished.sent, 3);
        expect(finished.responses, 3);
        expect(finished.responseErrors, 2);
        expect(finished.transportErrors, 0);
        expect(finished.responseWait.count, 3);
        expect(finished.slotWait.count, 3);
        expect(finished.oldestInFlight, isNull);
        expect(finished.oldestQueued, isNull);
      } finally {
        remote.service.commanOPort.send(null);
        while (await events.next != null) {}
        await events.cancel(immediate: true);
        await _close(remote);
      }
    },
    timeout: const Timeout(Duration(seconds: 10)),
  );

  test(
    'partial snapshots retain data and coalesce RPCs after collection deadline',
    () async {
      final telemetry = RpcTelemetry(
        RpcNode.backend,
        collectionTimeout: const Duration(milliseconds: 10),
      );
      var calls = 0;
      Completer<RpcTelemetrySnapshot>? pending;
      telemetry.addPeer(() {
        calls++;
        return pending?.future ??
            Future.value(RpcTelemetrySnapshot(nodes: [_node(1)]));
      });
      final first = telemetry.collect();
      expect(identical(first, telemetry.collect()), isTrue);
      expect((await first).nodes.last.stale, isFalse);
      pending = Completer<RpcTelemetrySnapshot>();
      final stale = await telemetry.collect();
      expect(stale.nodes.first.stale, isFalse);
      expect(stale.nodes.last.stale, isTrue);
      expect(stale.nodes.last.elapsedMicros, 1);
      await telemetry.collect();
      expect(calls, 2, reason: 'the unresolved RPC is reused');
      pending.complete(RpcTelemetrySnapshot(nodes: [_node(2)]));
      await Future<void>.delayed(Duration.zero);
      pending = null;
      await telemetry.collect();
      expect(calls, 3);
    },
  );

  test('JSON roundtrip and unknown peer values preserve metrics safely', () {
    final metrics = RpcConnectionMetrics(RpcNode.web)..capacity = 25;
    final request = metrics.enqueue('echo')..dispatch();
    request.response();
    request.finish();
    request.finish();
    final node = RpcNodeSnapshot(
      node: RpcNode.backend,
      sessionId: 'one',
      sampledAt: DateTime.utc(2026),
      elapsedMicros: 100,
      connections: [metrics.snapshot()],
    );
    final json = RpcTelemetrySnapshot(nodes: [node]).toJson();
    final restored = RpcTelemetrySnapshot.fromJson(json);
    expect(restored.nodes.single.connections.single.outgoing.sent, 1);
    expect(
      restored.nodes.single.connections.single.outgoing.responseWait.count,
      1,
    );
    final raw = node.toJson();
    raw['node'] = 'futureNode';
    expect(RpcNodeSnapshot.fromJson(raw).node, RpcNode.unknown);
  });

  test(
    'late collection errors are consumed and a later poll recovers',
    () async {
      final telemetry = RpcTelemetry(
        RpcNode.backend,
        collectionTimeout: const Duration(milliseconds: 5),
      );
      final pending = Completer<RpcTelemetrySnapshot>();
      var recovering = false;
      telemetry.addPeer(
        () => recovering
            ? Future.value(RpcTelemetrySnapshot(nodes: [_node(2)]))
            : pending.future,
      );
      expect((await telemetry.collect()).nodes, hasLength(1));
      pending.completeError(StateError('late peer failure'));
      await Future<void>.delayed(Duration.zero);
      recovering = true;
      final recovered = await telemetry.collect();
      expect(recovered.nodes.last.node, RpcNode.frontend);
      expect(recovered.nodes.last.stale, isFalse);
    },
  );
}
