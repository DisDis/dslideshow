import 'dart:convert';
import 'dart:async';
import 'dart:isolate';
import 'package:built_value/serializer.dart';
import 'package:dslideshow_common/rpc.dart';
import 'package:dslideshow_common/src/rpc/command.dart';
import 'package:dslideshow_common/src/rpc/service.dart';
import 'package:logging/logging.dart';

Future<void> initRpc(RpcService service, Serializers serializers, Service mainService) async {
  final Logger _log = new Logger('rpc_service');

  final RpcService _service = service;
  final Serializers _serializers = serializers;

  // Wait for messages from the main isolate.
  await for (final command in mainService.receivePort) {
    if (command == null) {
      break;
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
  }
}
