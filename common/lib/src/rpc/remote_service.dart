import 'dart:async';
import 'dart:convert';
import 'dart:isolate';
import 'package:built_value/serializer.dart';
import 'package:dslideshow_common/rpc.dart';
import 'package:dslideshow_common/src/rpc/command.dart';
import 'package:dslideshow_common/src/rpc/exception.dart';
import 'package:async/async.dart';
import 'package:logging/logging.dart';

class Service {
  static final _log = new Logger('Service');
  final SendPort commanOPort;
  final SendPort resultOPort;
  final ReceivePort commandIPort;
  final ReceivePort resultIPort;
  // final messages = Map<int, Future<RpcResult>>();

  // late StreamQueue<dynamic> events;

  Service({required this.commandIPort, required this.commanOPort, required this.resultIPort, required this.resultOPort}) {
    // events = StreamQueue<dynamic>(receivePort);
  }

  Future processing(final RpcService service, final Serializers serializers) async {
    late StreamSubscription sub;
    final result = Completer();
    // Wait for messages from the main isolate.
    sub = commandIPort.listen((command) async {
      if (command == null) {
        sub.cancel();
        result.complete();
        // break;
      } else {
        try {
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
          _log.severe('executeCommandStr', e, s);
          rethrow;
        }
      }
    });
    return result.future;
  }
}

abstract class RemoteService {
  Future<RpcResult> sendStr(RpcCommand cmd);

  Future<Object> transparentSend(Object cmd);

  Future<String> transparentSendStr(String cmdStr);

  Future<RpcResult> send(RpcCommand cmd);
}

class RemoteServiceImpl implements RemoteService {
  late Service service;
  late RemoteServiceTransport _transport;
  final Serializers serializers;
  // StreamQueue<dynamic>? commands;
  late StreamQueue<dynamic> results;

  RemoteServiceImpl({
    required this.serializers,
    RemoteServiceTransport? transport,
  }) {
    _transport = transport ?? new DirectSpawnTransport();
  }

  void connect(List<SendPort> ports) {
    SendPort commanOPort = ports[0];
    SendPort resultOPort = ports[1];
    final commandIPort = ReceivePort();
    final resultIPort = ReceivePort();
    service = Service(
      commanOPort: commanOPort,
      resultOPort: resultOPort,
      commandIPort: commandIPort,
      resultIPort: resultIPort,
    );
    results = StreamQueue<dynamic>(resultIPort);
    service.resultOPort.send(
      [service.commandIPort.sendPort, service.resultIPort.sendPort],
    );
  }

  Future<void> spawn(void entryPoint(List<SendPort> ports)) async {
    final commandIPort = ReceivePort();
    final resultIPort = ReceivePort();
    results = StreamQueue<dynamic>(resultIPort);
    await Isolate.spawn(entryPoint, [commandIPort.sendPort, resultIPort.sendPort]);
    final List<SendPort> ports = await results.next;
    service = Service(
      commanOPort: ports[0],
      resultOPort: ports[1],
      commandIPort: commandIPort,
      resultIPort: resultIPort,
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

  Future<RpcResult> sendStr(RpcCommand cmd) async {
    final jsonO = await transparentSendStr(json.encode(serializers.serialize(cmd)));
    RpcResult result = serializers.deserialize(json.decode(jsonO) as Object) as RpcResult;
    if (result is RpcErrorResult) {
      throw new RpcErrorResultException(result);
    }
    return result;
  }

  Future<RpcResult> send(RpcCommand cmd) async {
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
    // ignore: argument_type_not_assignable, strong_mode_invalid_cast_function
    service.service.commanOPort.send(cmdStr);
    return await (service.results.next);
  }

  @override
  Future<Object> send(RemoteServiceImpl service, Object cmd) async {
    // ignore: argument_type_not_assignable, strong_mode_invalid_cast_function
    service.service.commanOPort.send(cmd);
    return await (service.results.next);
  }
}
