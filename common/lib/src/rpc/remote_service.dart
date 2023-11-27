import 'dart:async';
import 'dart:convert';
import 'dart:isolate';
import 'package:built_value/serializer.dart';
import 'package:dslideshow_common/src/rpc/command.dart';
import 'package:dslideshow_common/src/rpc/exception.dart';

class Service {
  final SendPort sendPort;
  final ReceivePort receivePort;

  Service({required this.sendPort, ReceivePort? receivePortI}) : this.receivePort = receivePortI ?? ReceivePort() {
    //Auto send receivePort;
    sendPort.send(receivePort);
  }
}

class RemoteService {
  final Service _service;
  late RemoteServiceTransport _transport;
  final Serializers _serializers;

  RemoteService(this._service, this._serializers, [RemoteServiceTransport? transport]) {
    _transport = transport ?? new DirectSpawnTransport();
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
    var jsonO = await transparentSendStr(json.encode(_serializers.serialize(cmd)));
    RpcResult result = _serializers.deserialize(json.decode(jsonO) as Object) as RpcResult;
    if (result is RpcErrorResult) {
      throw new RpcErrorResultException(result);
    }
    return result;
  }

  FutureOr<RpcResult> send(RpcCommand cmd) async {
    var jsonO = await transparentSend(_serializers.serialize(cmd)!);
    RpcResult result = _serializers.deserialize(jsonO) as RpcResult;
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
