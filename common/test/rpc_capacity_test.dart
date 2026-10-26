import 'dart:async';
import 'dart:isolate';

import 'package:async/async.dart';
import 'package:dslideshow_common/rpc.dart';
import 'package:dslideshow_common/serializers.dart';
import 'package:test/test.dart';

enum _Operation { ready, hold, barrier }

enum _Control { releaseFirst, releaseAll }

class _Command implements RpcCommand {
  @override
  final int id;
  final _Operation operation;
  final SendPort events;

  const _Command(this.id, this.operation, this.events);

  @override
  String get type => operation.name;
}

class _Reply implements RpcResult {
  @override
  final int id;

  const _Reply(this.id);
}

class _Ready extends _Reply {
  final SendPort control;
  final int resultPortCount;

  const _Ready(super.id, this.control, this.resultPortCount);
}

// Capacity is independent of payload encoding; these test payloads can travel
// directly between isolates and exercise the production request/result ports.
class _Serializers implements Serializers {
  const _Serializers();

  @override
  Object? serialize<T>(T object) => object;

  @override
  Object? deserialize(Object? object) => object;
}

const _serializers = _Serializers();

class _HoldingService implements RpcService {
  final SendPort control;
  final int resultPortCount;
  final held = <int, Completer<RpcResult>>{};
  final barriers = <Completer<RpcResult>>[];
  SendPort? events;

  _HoldingService(this.control, this.resultPortCount);

  @override
  Future<RpcResult> executeCommand(RpcCommand command) async {
    final request = command as _Command;
    events = request.events;
    switch (request.operation) {
      case _Operation.ready:
        return _Ready(request.id, control, resultPortCount);
      case _Operation.hold:
        final completion = Completer<RpcResult>();
        held[request.id] = completion;
        request.events.send(request.id);
        return completion.future;
      case _Operation.barrier:
        request.events.send(held.keys.toList());
        final completion = Completer<RpcResult>();
        barriers.add(completion);
        return completion.future;
    }
  }

  void releaseFirst() {
    final id = held.keys.first;
    held.remove(id)!.complete(_Reply(id));
  }

  void releaseAll() {
    while (held.isNotEmpty) {
      releaseFirst();
    }
  }

  void finish() {
    releaseAll();
    for (final barrier in barriers) {
      barrier.complete(const _Reply(-1));
    }
  }
}

Future<void> _closePorts(RemoteServiceImpl remote) async {
  remote.service.commandIPort.close();
  for (final port in remote.service.resultIPorts) {
    port.close();
  }
  await Future.wait(
    remote.results.map((queue) async => await queue.cancel(immediate: true)),
  );
}

void _worker(Map<String, dynamic> handshake) async {
  final remote = RemoteServiceImpl(serializers: _serializers);
  remote.connect(HandshakeMessage.fromMap(handshake));
  final control = ReceivePort();
  final service = _HoldingService(control.sendPort, remote.results.length);
  final subscription = control.listen((message) {
    switch (message as _Control) {
      case _Control.releaseFirst:
        service.releaseFirst();
      case _Control.releaseAll:
        service.releaseAll();
    }
  });
  try {
    await remote.service.processing(service, _serializers);
  } finally {
    service.finish();
    await subscription.cancel();
    control.close();
    await _closePorts(remote);
    service.events?.send(null);
  }
  Isolate.exit();
}

void main() {
  test('default spawn and connect allow 25 outstanding RPCs', () async {
    final remote = RemoteServiceImpl(serializers: _serializers);
    final eventPort = ReceivePort();
    final events = StreamQueue<dynamic>(eventPort);
    SendPort? control;
    var spawned = false;
    try {
      await remote.spawn(_worker);
      spawned = true;
      final ready = await remote.send(
        _Command(0, _Operation.ready, eventPort.sendPort),
      ) as _Ready;
      control = ready.control;
      expect(remote.results, hasLength(25), reason: 'spawn default');
      expect(ready.resultPortCount, 25, reason: 'connect default');

      final requests = List.generate(25, (index) {
        final request = remote.send(
          _Command(index + 1, _Operation.hold, eventPort.sendPort),
        );
        request.ignore();
        return request;
      });
      for (var id = 1; id <= 25; id++) {
        expect(await events.next, id);
      }

      final overflow = remote.send(
        _Command(26, _Operation.hold, eventPort.sendPort),
      );
      overflow.ignore();
      requests.add(overflow);
      // Finish dispatch microtasks, then send a barrier through the same command
      // port. FIFO delivery makes its snapshot observe every dispatched command;
      // it does not consume a pooled slot or depend on an elapsed-time threshold.
      await Future<void>.delayed(Duration.zero);
      remote.service.commanOPort.send([
        0,
        _Command(-1, _Operation.barrier, eventPort.sendPort),
      ]);
      expect(await events.next, List.generate(25, (index) => index + 1));

      control.send(_Control.releaseFirst);
      expect(await events.next, 26);
      expect((await requests.first).id, 1);
      control.send(_Control.releaseAll);
      final replies = await Future.wait(requests);
      expect(replies.map((reply) => reply.id), List.generate(26, (i) => i + 1));
    } finally {
      if (spawned) {
        control?.send(_Control.releaseAll);
        remote.service.commanOPort.send(null);
        while (await events.next != null) {}
        await _closePorts(remote);
      }
      await events.cancel(immediate: true);
      eventPort.close();
    }
  }, timeout: const Timeout(Duration(seconds: 10)));
}
