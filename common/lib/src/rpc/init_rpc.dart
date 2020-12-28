import 'dart:convert';
import 'dart:async';
import 'package:built_value/serializer.dart';
import 'package:dslideshow_common/src/rpc/command.dart';
import 'package:dslideshow_common/src/rpc/service.dart';
import 'package:logging/logging.dart';

/*late*/ Serializers _serializers;
/*late*/ RpcService _service;
final Logger _log = new Logger('rpc_service');

void initRpc(RpcService service, Serializers serializers){
  _service = service;
  _serializers = serializers;
}

FutureOr<String> executeCommandStr(String commandStr) async {
  try {
    RpcCommand cmd = _serializers.deserialize(json.decode(commandStr) as Object) as RpcCommand;
    var result = await _service.executeCommand(cmd);
    var str = json.encode(_serializers.serialize(result));
    return str;
  } catch (e, s) {
    _log.severe('executeCommandStr', e, s);
    rethrow;
  }
}