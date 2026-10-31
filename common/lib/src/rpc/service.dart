import 'dart:async';
import 'dart:convert';
import 'dart:isolate';

import 'package:dslideshow_common/rpc.dart';
import 'package:dslideshow_common/serializers.dart';
import 'package:logging/logging.dart';

class Service {
  static final _log = new Logger('Service');
  final SendPort commanOPort;
  final List<SendPort> resultOPorts;
  final ReceivePort commandIPort;
  final List<ReceivePort> resultIPorts;
  final RpcTelemetry? telemetry;
  final RpcConnectionMetrics? metrics;
  // final messages = Map<int, Future<RpcResult>>();

  // late StreamQueue<dynamic> events;

  Service({
    required this.commandIPort,
    required this.commanOPort,
    required this.resultIPorts,
    required this.resultOPorts,
    this.telemetry,
    this.metrics,
  }) {
    // events = StreamQueue<dynamic>(receivePort);
  }

  Future processing(RpcService service, Serializers serializers) async {
    late StreamSubscription sub;
    final result = Completer();
    // Wait for messages from the main isolate.
    sub = commandIPort.listen((commandRaw) async {
      if (commandRaw == null) {
        sub.cancel();
        result.complete();
        // break;
      } else {
        final started = metrics?.handlerStarted();
        var failed = false;
        try {
          final commandList = commandRaw as List;
          final resultOPort = resultOPorts[commandList[0]];
          final command = commandList[1];
          if (command is String) {
            RpcCommand cmd = serializers.deserialize(json.decode(command) as Object) as RpcCommand;
            _log.fine(() => 'i:${commandList[0]}, command=${cmd.runtimeType}, id=${cmd.id}');
            var result = await _execute(service, cmd);
            failed = result is RpcErrorResult;
            var str = json.encode(serializers.serialize(result));
            resultOPort.send(str);
          } else {
            RpcCommand cmd = serializers.deserialize(command) as RpcCommand;
            _log.fine(() => 'i:${commandList[0]}, command=${cmd.runtimeType}, id=${cmd.id}');
            var result = await _execute(service, cmd);
            failed = result is RpcErrorResult;
            resultOPort.send(serializers.serialize(result));
          }
        } catch (e) {
          failed = true;
          // Transport and decoding errors may embed credentials or signed URLs.
          // The wire error/throwing contract stays unchanged; diagnostic output
          // contains the safe exception category rather than its payload.
          _log.severe('executeCommand type=${e.runtimeType}');
          rethrow;
        } finally {
          if (started != null) metrics!.handlerFinished(started, error: failed);
        }
      }
    });
    return result.future;
  }

  Future<RpcResult> _execute(RpcService service, RpcCommand command) async {
    if (command is GetRpcTelemetryCommand && telemetry != null) {
      return GetRpcTelemetryResult(id: command.id, snapshot: await telemetry!.collect());
    }
    return service.executeCommand(command);
  }
}

abstract class RpcService {
  //  Future<RpcResult> executeCommandStr(String commandJson);
  Future<RpcResult> executeCommand(RpcCommand command);
}
