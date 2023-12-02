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
  final results = <StreamQueue<dynamic>>[];
  late Pool _pool;
  final _freeResultStream = <bool>[];

  Future<T> getFreeResultPort<T>(Future<T> Function(int portIndex, StreamQueue<dynamic> resultStream) callback) {
    return _pool.withResource(() async {
      var i = 0;
      for (i = 0; i < _freeResultStream.length; i++) {
        if (_freeResultStream[i]) {
          break;
        }
      }
      if (_freeResultStream[i]) {
        _freeResultStream[i] = false;
        try {
          return await callback(i, results[i]);
        } finally {
          _freeResultStream[i] = true;
        }
      }
      throw Exception('No free resources');
    });
  }

  RemoteServiceImpl({
    required this.serializers,
    RemoteServiceTransport? transport,
  }) {
    _transport = transport ?? new DirectSpawnTransport();
  }

  void connect(HandshakeMessage message, [int resultIPortCount = 5]) {
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
    );
    service.resultOPorts.first.send(HandshakeMessage(commanOPort: commandIPort.sendPort, resultOPorts: resultIPorts.map((e) => e.sendPort).toList()).toMap());
  }

  Future<void> spawn(void entryPoint(Map<String, dynamic> handshakeMessage), [int resultIPortCount = 5]) async {
    if (resultIPortCount <= 0) {
      resultIPortCount = 1;
    }
    _pool = Pool(resultIPortCount);
    final commandIPort = ReceivePort();
    final resultIPorts = <ReceivePort>[];
    for (var i = 0; i < resultIPortCount; i++) {
      final port = ReceivePort();
      resultIPorts.add(port);
      _freeResultStream.add(true);
      results.add(StreamQueue<dynamic>(port));
    }
    await Isolate.spawn(entryPoint, HandshakeMessage(commanOPort: commandIPort.sendPort, resultOPorts: resultIPorts.map((e) => e.sendPort).toList()).toMap());
    final handshakeMessageO = HandshakeMessage.fromMap(await results.first.next);
    service = Service(
      commanOPort: handshakeMessageO.commanOPort,
      resultOPorts: handshakeMessageO.resultOPorts,
      commandIPort: commandIPort,
      resultIPorts: resultIPorts,
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
    final jsonO = await transparentSendStr(json.encode(serializers.serialize(cmd)));
    RpcResult result = serializers.deserialize(json.decode(jsonO) as Object) as RpcResult;
    if (result is RpcErrorResult) {
      throw new RpcErrorResultException(result);
    }
    return result;
  }

  Future<RpcResult> send<T extends RpcCommand>(T cmd) async {
    final jsonO = await transparentSend(serializers.serialize(cmd)!);
    RpcResult result = serializers.deserialize(jsonO) as RpcResult;
    if (result is RpcErrorResult) {
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
    });
  }
}
