import 'dart:async';

import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_backend/src/command/echo.dart';
import 'package:dslideshow_backend/src/command/storage_commands.dart';
import 'package:dslideshow_backend/src/service/storage/storage.dart';
import 'package:dslideshow_common/rpc.dart';
import 'package:logging/logging.dart';

class HardwareService implements RpcService{
  static final Logger _log = new Logger('HardwareService');

  final RemoteService _frontendService;
  final Storage _storage;
  HardwareService(AppConfig config, this._frontendService, this._storage){
    _storage.init();
  }

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
      case GetMediaItemCommand.TYPE:
        return _executeGetMediaItemCommand(command as GetMediaItemCommand);
        break;

      case StorageNextCommand.TYPE:
        return _executeStorageNextCommand(command as StorageNextCommand);
        break;
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

  Future<RpcResult> _executeStorageNextCommand(StorageNextCommand command) async{
    await _storage.next();
    return new StorageEmptyResult((b) {
      b.id = command.id;
      return b;
    });
  }
  Future<RpcResult> _executeGetMediaItemCommand(GetMediaItemCommand command) async {

    final item = await (command.isCurrent?_storage.getCurrent():_storage.getNext());
    return new GetMediaItemCommandResult((b) {
      b.id = command.id;
      b.mediaId = item!=null? item.id: null;
      b.mediaUri = item!=null? item.uri: null;
      return b;
    });
  }
}