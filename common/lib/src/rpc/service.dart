import 'dart:async';

import 'dart:convert';

import 'dart:isolate';

import 'package:built_value/serializer.dart';
import 'package:dslideshow_common/rpc.dart';

import 'package:logging/logging.dart';

class Service {
  static final _log = new Logger('Service');
  final SendPort commanOPort;
  final List<SendPort> resultOPorts;
  final ReceivePort commandIPort;
  final List<ReceivePort> resultIPorts;
  // final messages = Map<int, Future<RpcResult>>();

  // late StreamQueue<dynamic> events;

  Service({required this.commandIPort, required this.commanOPort, required this.resultIPorts, required this.resultOPorts}) {
    // events = StreamQueue<dynamic>(receivePort);
  }

  Future processing(final RpcService service, final Serializers serializers) async {
    late StreamSubscription sub;
    final result = Completer();
    // Wait for messages from the main isolate.
    sub = commandIPort.listen((commandRaw) async {
      if (commandRaw == null) {
        sub.cancel();
        result.complete();
        // break;
      } else {
        try {
          final commandList = commandRaw as List;
          final resultOPort = resultOPorts[commandList[0]];
          final command = commandList[1];
          _log.info("i:${commandList[0]}, c:$command");
          if (command is String) {
            RpcCommand cmd = serializers.deserialize(json.decode(command) as Object) as RpcCommand;
            var result = await service.executeCommand(cmd);
            var str = json.encode(serializers.serialize(result));
            resultOPort.send(str);
          } else {
            RpcCommand cmd = serializers.deserialize(command) as RpcCommand;
            var result = await service.executeCommand(cmd);
            resultOPort.send(serializers.serialize(result));
          }
        } catch (e, s) {
          _log.severe('executeCommand', e, s);
          rethrow;
        }
      }
    });
    return result.future;
  }
}

abstract class RpcService {
//  Future<RpcResult> executeCommandStr(String commandJson);
  Future<RpcResult> executeCommand(RpcCommand command);
}
