import 'dart:convert';
import 'dart:async';
import 'package:built_value/serializer.dart';
import 'package:dslideshow_common/rpc.dart';
import 'package:logging/logging.dart';

Future<void> initRpc(RpcService service, Serializers serializers, Service mainService) async {
  final Logger _log = new Logger('rpc_service');

  final RpcService _service = service;
  final Serializers _serializers = serializers;

  late StreamSubscription sub;
  final result = Completer();
  // Wait for messages from the main isolate.
  sub = mainService.receivePort.listen((command) async {
    if (command == null) {
      sub.cancel();
      result.complete();
      // break;
    } else if (command is String) {
      try {
        RpcCommand cmd = _serializers.deserialize(json.decode(command) as Object) as RpcCommand;
        var result = await _service.executeCommand(cmd);
        var str = json.encode(_serializers.serialize(result));
        mainService.sendPort.send(str);
      } catch (e, s) {
        _log.severe('executeCommandStr', e, s);
        rethrow;
      }
    } else {
      try {
        RpcCommand cmd = _serializers.deserialize(command) as RpcCommand;
        var result = await _service.executeCommand(cmd);
        mainService.sendPort.send(_serializers.serialize(result));
      } catch (e, s) {
        _log.severe('executeCommand', e, s);
        rethrow;
      }
    }
  });
  return result.future;
}
