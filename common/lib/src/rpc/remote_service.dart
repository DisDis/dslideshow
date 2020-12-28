import 'dart:async';
import 'dart:convert';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:dslideshow_common/src/rpc/command.dart';
import 'package:dslideshow_common/src/rpc/exception.dart';
import 'package:isolate/isolate.dart';
import 'package:dslideshow_common/src/rpc/init_rpc.dart';

class RemoteService{
  final IsolateRunner _service;
  final RemoteServiceTransport _transport;
  final Serializers _serializers;

  RemoteService(this._service, this._serializers,[RemoteServiceTransport/*!*/ transport]): _transport = transport == null? new DirectSpawnTransport(): transport {
  }

  // Запрос и ответ не обрабатывается
  FutureOr<String> transparentSend(String cmdStr) async{
    // ignore: return_of_invalid_type
    return _transport.send(_service, cmdStr);
  }

  FutureOr<RpcResult> send(RpcCommand cmd) async{
    if(cmd.id == null && cmd is Built){
      cmd = (cmd as Built).rebuild((b){
        (b as dynamic).id = RpcCommand.generateId();
        return b;
      }) as RpcCommand;
    }
    var jsonO = await transparentSend(json.encode(_serializers.serialize(cmd)));
    RpcResult result = _serializers.deserialize(json.decode(jsonO) as Object) as RpcResult;
    if (result is RpcErrorResult){
      throw new RpcErrorResultException(result);
    }
    return result;
  }
}

abstract class RemoteServiceTransport{
  FutureOr<String> send(IsolateRunner service, String cmdStr);
}

class DirectSpawnTransport implements RemoteServiceTransport{
  @override
  FutureOr<String> send(IsolateRunner service, String cmdStr) {
    // ignore: argument_type_not_assignable, strong_mode_invalid_cast_function
    return service.run<String, String>(executeCommandStr, cmdStr);
  }
}