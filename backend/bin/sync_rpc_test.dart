import 'dart:io';
import 'dart:isolate';
import 'dart:math';

import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_common/log.dart';
import 'package:dslideshow_common/rpc.dart';
import 'package:dslideshow_backend/serializers.dart';
import 'package:logging/logging.dart';

main() async {
  final Logger _log = new Logger('main');
  initLog("local");
  _log.info("Run.");
  final backendService = RemoteServiceImpl(serializers: serializers);
  await backendService.spawn(serviceMain1, 3);
  backendService.service.processing(LocalService(), serializers);

  final futures = <Future>[];
  for (var i = 0; i < 50; i++) {
    futures.add(checkMessage(i, backendService));
  }
  await Future.wait(futures);
}

checkMessage(int i, RemoteServiceImpl backendService) async {
  final text = "_${i}_";
  final result = (await backendService.send(EchoCommand(text: text, id: RpcCommand.generateId()))) as EchoCommandResult;
  if (result.resultText!.startsWith(text)) {
    print('OK: $i->${result.resultText}');
  } else {
    print('ERROR: $i->${result.resultText}');
    exit(1);
  }
  return result;
}

class LocalService implements RpcService {
  final Logger _log = new Logger('LocalService');
  @override
  Future<RpcResult> executeCommand(RpcCommand command) {
//    _log.info("Execute command [${command.hashCode}]${command.id}:${command.type}");
    Stopwatch work = new Stopwatch()
      ..reset()
      ..start();
    return _executeCommand(command).whenComplete(() {
      work.stop();
      _log.info("Command: [${command.hashCode}]${command.id}:${command.type} duration: ${work.elapsed.inMilliseconds.toString()}ms");
    });
  }

  Future<RpcResult> _executeCommand(RpcCommand command) {
    switch (command.type) {
      case EchoCommand.TYPE:
        return _executeEchoCommand(command as EchoCommand);
      default:
        return _generateErrorResult(new Exception("Unknown command: ${command.type}"), command);
    }
  }

  Future<RpcErrorResult> _generateErrorResult(Object e, RpcCommand command) async {
    return ErrorResult(
      id: command.id,
      error: "$e",
    );
  }

  Future<RpcResult> _executeEchoCommand(EchoCommand command) async {
    if (command.text == 'error') {
      return _generateErrorResult(new Exception("Echo error"), command);
    }
    return EchoCommandResult(
      id: command.id,
      resultText: "${command.text} LS ${new DateTime.now().microsecond}",
    );
  }
}

void serviceMain1(Map<String, dynamic> handshakeMessage) async {
  final Logger _log = new Logger('main');
  initLog("remote");
  _log.info("Run. Spawned isolate started.");

  try {
    final _remoteMainService = new RemoteServiceImpl(serializers: serializers);
    _remoteMainService.connect(HandshakeMessage.fromMap(handshakeMessage), 3);

    await _remoteMainService.service.processing(RemoteService(), serializers);
  } catch (e, s) {
    _log.severe('Fatal error: $e, $s', e, s);
    _log.info("Spawned isolate finished with error.");
    // exit(1);
    Isolate.exit();
  }
  _log.info("Spawned isolate finished.");
  Isolate.exit();
}

class RemoteService implements RpcService {
  final rnd = Random();
  final Logger _log = new Logger('RemoteService');
  @override
  Future<RpcResult> executeCommand(RpcCommand command) {
//    _log.info("Execute command [${command.hashCode}]${command.id}:${command.type}");
    Stopwatch work = new Stopwatch()
      ..reset()
      ..start();
    return _executeCommand(command).whenComplete(() {
      work.stop();
      _log.info("Command: [${command.hashCode}]${command.id}:${command.type} duration: ${work.elapsed.inMilliseconds.toString()}ms");
    });
  }

  Future<RpcResult> _executeCommand(RpcCommand command) {
    switch (command.type) {
      case EchoCommand.TYPE:
        return _executeEchoCommand(command as EchoCommand);
      default:
        return _generateErrorResult(new Exception("Unknown command: ${command.type}"), command);
    }
  }

  Future<RpcErrorResult> _generateErrorResult(Object e, RpcCommand command) async {
    return ErrorResult(
      id: command.id,
      error: "$e",
    );
  }

  Future<RpcResult> _executeEchoCommand(EchoCommand command) async {
    if (command.text == 'error') {
      return _generateErrorResult(new Exception("Echo error"), command);
    }
    await Future.delayed(Duration(milliseconds: 100 + rnd.nextInt(2000)));
    return EchoCommandResult(
      id: command.id,
      resultText: "${command.text} S ${new DateTime.now().microsecond}",
    );
  }
}
