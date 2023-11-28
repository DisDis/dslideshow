import 'dart:async';
import 'dart:convert';
import 'dart:isolate';
import 'package:built_value/serializer.dart';
import 'package:dslideshow_common/src/rpc/command.dart';
import 'package:dslideshow_common/src/rpc/exception.dart';

class Service {
  final SendPort sendPort;
  final ReceivePort receivePort;

  Service({required this.sendPort, ReceivePort? receivePortI}) : this.receivePort = receivePortI ?? ReceivePort();
}

abstract class RemoteService {
  FutureOr<RpcResult> sendStr(RpcCommand cmd);

  FutureOr<Object> transparentSend(Object cmd);

  FutureOr<String> transparentSendStr(String cmdStr);

  FutureOr<RpcResult> send(RpcCommand cmd);
}

class RemoteServiceImpl implements RemoteService {
  late Service _service;
  late RemoteServiceTransport _transport;
  final Serializers serializers;
  Service get service => _service;

  RemoteServiceImpl({
    required this.serializers,
    RemoteServiceTransport? transport,
  }) {
    _transport = transport ?? new DirectSpawnTransport();
  }

  void connect(SendPort remoteIsolateSendPort) {
    _service = Service(sendPort: remoteIsolateSendPort);
    _service.sendPort.send(_service.receivePort.sendPort);
  }

  Future<void> spawn(void entryPoint(SendPort message)) async {
    final receivePort = ReceivePort();
    await Isolate.spawn(entryPoint, receivePort.sendPort);
    final sendPort = await receivePort.first;
    _service = Service(sendPort: sendPort, receivePortI: receivePort);
  }

  // Запрос и ответ не обрабатывается
  FutureOr<String> transparentSendStr(String cmdStr) async {
    // ignore: return_of_invalid_type
    return _transport.sendStr(_service, cmdStr);
  }

  FutureOr<Object> transparentSend(Object cmd) {
    // ignore: return_of_invalid_type
    return _transport.send(_service, cmd);
  }

  FutureOr<RpcResult> sendStr(RpcCommand cmd) async {
    var jsonO = await transparentSendStr(json.encode(serializers.serialize(cmd)));
    RpcResult result = serializers.deserialize(json.decode(jsonO) as Object) as RpcResult;
    if (result is RpcErrorResult) {
      throw new RpcErrorResultException(result);
    }
    return result;
  }

  FutureOr<RpcResult> send(RpcCommand cmd) async {
    var jsonO = await transparentSend(serializers.serialize(cmd)!);
    RpcResult result = serializers.deserialize(jsonO) as RpcResult;
    if (result is RpcErrorResult) {
      throw new RpcErrorResultException(result);
    }
    return result;
  }
}

abstract class RemoteServiceTransport {
  FutureOr<String> sendStr(Service service, String cmdStr);
  FutureOr<Object> send(Service service, Object cmd);
}

class DirectSpawnTransport implements RemoteServiceTransport {
  @override
  Future<String> sendStr(Service service, String cmdStr) async {
    // ignore: argument_type_not_assignable, strong_mode_invalid_cast_function
    service.sendPort.send(cmdStr);
    return await service.receivePort.first;
  }

  @override
  Future<Object> send(Service service, Object cmd) async {
    // ignore: argument_type_not_assignable, strong_mode_invalid_cast_function
    service.sendPort.send(cmd);
    return await service.receivePort.first;
  }
}
