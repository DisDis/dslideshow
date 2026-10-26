import 'dart:async';
import 'dart:convert';
import 'dart:isolate';

import 'package:dslideshow_common/rpc.dart';
import 'package:dslideshow_common/serializers.dart';
import 'package:async/async.dart';
import 'package:pool/pool.dart';

abstract class RemoteService {
  Future<RpcResult> sendStr<T extends RpcCommand>(T cmd);

  Future<Object> transparentSend(Object cmd);

  Future<String> transparentSendStr(String cmdStr);

  Future<RpcResult> send<T extends RpcCommand>(T cmd);
}

class RemoteServiceImpl implements RemoteService {
  late Service service;
  late RemoteServiceTransport _transport;
  final Serializers serializers;
  final RpcTelemetry? telemetry;
  final RpcNode peer;
  late final RpcConnectionMetrics? _metrics;
  final results = <StreamQueue<dynamic>>[];
  late Pool _pool;
  final _freeResultStream = <bool>[];

  Future<T> getFreeResultPort<T>(
    Future<T> Function(int portIndex, StreamQueue<dynamic> resultStream)
    callback, {
    String? commandType,
  }) async {
    final measurement = _metrics?.enqueue(commandType);
    try {
      return await _pool.withResource(() async {
        measurement?.dispatch();
        var i = 0;
        for (i = 0; i < _freeResultStream.length; i++) {
          if (_freeResultStream[i]) {
            break;
          }
        }
        if (_freeResultStream[i]) {
          _freeResultStream[i] = false;
          try {
            final result = await callback(i, results[i]);
            measurement?.response();
            return result;
          } finally {
            _freeResultStream[i] = true;
            measurement?.finish();
          }
        }
        throw Exception('No free resources');
      });
    } catch (_) {
      measurement?.failed();
      rethrow;
    } finally {
      measurement?.finish();
    }
  }

  RemoteServiceImpl({
    required this.serializers,
    RemoteServiceTransport? transport,
    this.telemetry,
    this.peer = RpcNode.unknown,
    bool collectPeerTelemetry = false,
  }) {
    _transport = transport ?? new DirectSpawnTransport();
    _metrics = telemetry?.addConnection(peer);
    if (collectPeerTelemetry) {
      telemetry?.addPeer(() async {
        final result = await send(
          GetRpcTelemetryCommand(id: RpcCommand.generateId()),
        );
        return (result as GetRpcTelemetryResult).snapshot;
      });
    }
  }

  void connect(HandshakeMessage message, [int resultIPortCount = 25]) {
    _metrics?.capacity = resultIPortCount;
    final commandIPort = ReceivePort();
    final resultIPorts = <ReceivePort>[];

    for (var i = 0; i < resultIPortCount; i++) {
      final port = ReceivePort();
      resultIPorts.add(port);
      _freeResultStream.add(true);
      results.add(StreamQueue<dynamic>(port));
    }
    _pool = Pool(resultIPortCount);

    final SendPort commanOPort = message.commanOPort;
    final List<SendPort> resultOPorts = message.resultOPorts;
    service = Service(
      commanOPort: commanOPort,
      resultOPorts: resultOPorts,
      commandIPort: commandIPort,
      resultIPorts: resultIPorts,
      telemetry: telemetry,
      metrics: _metrics,
    );
    service.resultOPorts.first.send(
      HandshakeMessage(
        commanOPort: commandIPort.sendPort,
        resultOPorts: resultIPorts.map((e) => e.sendPort).toList(),
      ).toMap(),
    );
  }

  Future<void> spawn(
    void entryPoint(Map<String, dynamic> handshakeMessage), {
    String? debugName,
    int resultIPortCount = 25,
  }) async {
    if (resultIPortCount <= 0) {
      resultIPortCount = 1;
    }
    _pool = Pool(resultIPortCount);
    _metrics?.capacity = resultIPortCount;
    final commandIPort = ReceivePort();
    final resultIPorts = <ReceivePort>[];
    for (var i = 0; i < resultIPortCount; i++) {
      final port = ReceivePort();
      resultIPorts.add(port);
      _freeResultStream.add(true);
      results.add(StreamQueue<dynamic>(port));
    }
    await Isolate.spawn(
      entryPoint,
      HandshakeMessage(
        commanOPort: commandIPort.sendPort,
        resultOPorts: resultIPorts.map((e) => e.sendPort).toList(),
      ).toMap(),
      debugName: debugName,
    );
    final handshakeMessageO = HandshakeMessage.fromMap(
      await results.first.next,
    );
    service = Service(
      commanOPort: handshakeMessageO.commanOPort,
      resultOPorts: handshakeMessageO.resultOPorts,
      commandIPort: commandIPort,
      resultIPorts: resultIPorts,
      telemetry: telemetry,
      metrics: _metrics,
    );
  }

  // Запрос и ответ не обрабатывается
  Future<String> transparentSendStr(String cmdStr) async {
    // ignore: return_of_invalid_type
    return _transport.sendStr(this, cmdStr);
  }

  Future<Object> transparentSend(Object cmd) {
    // ignore: return_of_invalid_type
    return _transport.send(this, cmd);
  }

  Future<RpcResult> sendStr<T extends RpcCommand>(T cmd) async {
    final jsonO = await transparentSendStr(
      json.encode(serializers.serialize(cmd)),
    );
    RpcResult result =
        serializers.deserialize(json.decode(jsonO) as Object) as RpcResult;
    if (result is RpcErrorResult) {
      _metrics?.recordResponseError();
      throw new RpcErrorResultException(result);
    }
    return result;
  }

  Future<RpcResult> send<T extends RpcCommand>(T cmd) async {
    final jsonO = await transparentSend(serializers.serialize(cmd)!);
    RpcResult result = serializers.deserialize(jsonO) as RpcResult;
    if (result is RpcErrorResult) {
      _metrics?.recordResponseError();
      throw new RpcErrorResultException(result);
    }
    return result;
  }
}

abstract class RemoteServiceTransport {
  Future<String> sendStr(RemoteServiceImpl service, String cmdStr);
  Future<Object> send(RemoteServiceImpl service, Object cmd);
}

class DirectSpawnTransport implements RemoteServiceTransport {
  @override
  Future<String> sendStr(RemoteServiceImpl service, String cmdStr) async {
    return service.getFreeResultPort((index, result) async {
      service.service.commanOPort.send([index, cmdStr]);
      return await result.next;
    });
  }

  @override
  Future<Object> send(RemoteServiceImpl service, Object cmd) async {
    return service.getFreeResultPort((index, result) async {
      service.service.commanOPort.send([index, cmd]);
      return await result.next;
    }, commandType: _commandType(cmd));
  }

  // Payload inspection is confined to the serialization boundary. Custom/raw
  // encodings and JSON strings remain unknown; never retain their contents.
  String? _commandType(Object payload) {
    if (payload is RpcCommand) return payload.type;
    if (payload is List && payload.length == 2 && payload[1] is Map) {
      final type = (payload[1] as Map)['type'];
      if (type is String) return type;
    }
    return null;
  }
}
