import 'dart:async';

import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_backend/src/command/echo.dart';
import 'package:dslideshow_common/rpc.dart';
import 'package:logging/logging.dart';

class HardwareService implements RpcService{
  static final Logger _log = new Logger('HardwareService');

  final RemoteService _frontendService;
  HardwareService(AppConfig config, this._frontendService);

  void testEcho(String text) async {
    final result = await _frontendService.send(new EchoCommand((b) =>
    b
      ..id = RpcCommand.generateId()
      ..text = text));
    _log.info("Message: $result");
  }

  @override
  Future<RpcResult> executeCommand(RpcCommand command) {
    _log.info("Execute command [${command.hashCode}]${command.id}:${command.type}");
    Stopwatch work = new Stopwatch()
      ..reset()
      ..start();
    return _executeCommand(command).whenComplete((){
      work.stop();
      _log.info("Processing command: [${command.hashCode}]${command.id}:${command.type} - ${work.elapsed.toString()}");
    });
  }

  Future<RpcResult> _executeCommand(RpcCommand command) {
    switch (command.type) {
      case EchoCommand.TYPE:
        return new Future.value(_executeEchoCommand(command as EchoCommand));
        break;
      default:
        return new Future.value(_generateErrorResult(
            new Exception("Unknown command: ${command.type}"), command));
        break;
    }
  }

  RpcErrorResult _generateErrorResult(Object e, RpcCommand command) {
    return new ErrorResult((b) =>
    b
      ..id = (command.id == null ? 0 : command.id)
      ..error = "$e");
  }

  RpcResult _executeEchoCommand(EchoCommand command) {
    if (command.text == 'error') {
      return _generateErrorResult(new Exception("Echo error"), command);
    }
    return new EchoCommandResult((b) {
      b.id = command.id;
      b.resultText = "${command.text} Service ${new DateTime.now()}";
      return b;
    });
  }
}