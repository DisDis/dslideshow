import 'dart:async';

import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_common/rpc.dart';
import 'package:dslideshow_backend/src/service/storage/storage.dart';
import 'package:logging/logging.dart';

class FrontendService implements RpcService {
  static final Logger _log = new Logger('FlutterService');
  final RemoteService _backendService;
  final _screenStateChangePreparation = new StreamController<bool>.broadcast();
  Stream<bool> get onScreenStateChangePreparation => _screenStateChangePreparation.stream;

  FrontendService(AppConfig config, this._backendService){
  }

  void testEcho(String text) async {
    final result = await _backendService.send(new EchoCommand((b) =>
    b
      ..id = RpcCommand.generateId()
      ..text = text));
    _log.info("Message: $result");
  }

  Future<MediaItem> getStorageCurrentItem() async{
    final result = await _backendService.send(new GetMediaItemCommand((b) =>
    b..id = RpcCommand.generateId()..isCurrent=true));
//    _log.info("Message: ${result}");
    var resultMediaItem = result as GetMediaItemCommandResult;
    return new MediaItem(resultMediaItem.mediaId, resultMediaItem.mediaUri);
  }

  Future<MediaItem> getStorageNextItem() async{
    final result = await _backendService.send(new GetMediaItemCommand((b) =>
    b..id = RpcCommand.generateId()..isCurrent=false));
//    _log.info("Message: $result");
    var resultMediaItem = result as GetMediaItemCommandResult;
    return new MediaItem(resultMediaItem.mediaId, resultMediaItem.mediaUri);
  }

  Future storageNext() async{
//    final result =
    await _backendService.send(new StorageNextCommand((b) =>
    b..id = RpcCommand.generateId()));
//    _log.info("Message: $result");
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
      case ScreenTurnCommand.TYPE:
        return new Future.value(_executeScreenTurnCommand(command as ScreenTurnCommand));
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

  FutureOr<RpcResult> _executeScreenTurnCommand(ScreenTurnCommand command) {
    _screenStateChangePreparation.add(command.enabled);
    return new EmptyResult((b)=>b..id = command.id);
  }
}