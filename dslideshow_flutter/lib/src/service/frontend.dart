import 'dart:async';

import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_backend/storage.dart';
import 'package:dslideshow_backend/src/service/system_info/system_info.dart';
import 'package:dslideshow_common/rpc.dart';
import 'package:dslideshow_flutter/src/redux/actions/change_debug_action.dart';
import 'package:dslideshow_flutter/src/redux/actions/change_internet_action.dart';
import 'package:dslideshow_flutter/src/redux/actions/change_pause_action.dart';
import 'package:dslideshow_flutter/src/redux/state/global_state.dart';
import 'package:logging/logging.dart';
import 'package:redux/redux.dart';

class FrontendService implements RpcService {
  static final Logger _log = new Logger('FlutterService');
  final RemoteService _backendService;
  final _screenStateChangePreparation = new StreamController<bool>.broadcast();
  final _onSystemInfoUpdate = new StreamController<SystemInfo>.broadcast();
  final _onPushButton = new StreamController<ButtonType>.broadcast();

  Stream<bool> get onScreenStateChangePreparation => _screenStateChangePreparation.stream;
  Stream<SystemInfo> get onSystemInfoUpdate => _onSystemInfoUpdate.stream;
  Stream<ButtonType> get onPushButton => _onPushButton.stream;

  final Store<GlobalState> _store;

  FrontendService(AppConfig config, this._backendService, this._store) {
    new Timer.periodic(new Duration(minutes: 1), (Timer timer) => _updateSystemInfo());
    _updateSystemInfo();
    onPushButton.listen((event) {
      if (event == ButtonType.pause){
        _store.dispatch(ChangePauseAction(!_store.state.isPaused));
      } else
      if (event == ButtonType.screentoggle){
        _store.dispatch(ChangeInternetAction(!_store.state.hasInternet));
      } else
      if (event == ButtonType.menu){
        _store.dispatch(ChangeDebugAction(!_store.state.isDebug));
      }
    });
  }


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

  Future<MediaItem> getStorageCurrentItem() async {
    final result = await _backendService.send(new GetMediaItemCommand((b) => b
      ..id = RpcCommand.generateId()
      ..isCurrent = true));
//    _log.info("Message: ${result}");
    var resultMediaItem = result as GetMediaItemCommandResult;
    return new MediaItem(resultMediaItem.mediaId, resultMediaItem.mediaUri);
  }

  Future<MediaItem> getStorageNextItem() async {
    final result = await _backendService.send(new GetMediaItemCommand((b) => b
      ..id = RpcCommand.generateId()
      ..isCurrent = false));
//    _log.info("Message: $result");
    var resultMediaItem = result as GetMediaItemCommandResult;
    return new MediaItem(resultMediaItem.mediaId, resultMediaItem.mediaUri);
  }

  Future storageNext() async {
//    final result =
    await _backendService.send(new StorageNextCommand((b) => b..id = RpcCommand.generateId()));
//    _log.info("Message: $result");
  }

  void testEcho(String text) async {
    final result = await _backendService.send(new EchoCommand((b) => b
      ..id = RpcCommand.generateId()
      ..text = text));
    _log.info("Message: $result");
  }

  Future<RpcResult> _executeCommand(RpcCommand command) {
    switch (command.type) {
      case PushButtonCommand.TYPE:
        return _executePushButtonCommand(command as PushButtonCommand);
      case ScreenTurnCommand.TYPE:
        return new Future.value(_executeScreenTurnCommand(command as ScreenTurnCommand));
        break;
      case EchoCommand.TYPE:
        return new Future.value(_executeEchoCommand(command as EchoCommand));
        break;
      default:
        return new Future.value(_generateErrorResult(new Exception("Unknown command: ${command.type}"), command));
        break;
    }
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
    return new EmptyResult((b) => b..id = command.id);
  }

  RpcErrorResult _generateErrorResult(Object e, RpcCommand command) {
    return new ErrorResult((b) => b
      ..id = (command.id == null ? 0 : command.id)
      ..error = "$e");
  }

  Future<SystemInfo> getSystemInfo() async {
    final resultRaw = await _backendService.send(new GetSystemInfoCommand((GetSystemInfoCommandBuilder b) => b
      ..id = RpcCommand.generateId()
      ));
    var result = resultRaw as GetSystemInfoCommandResult;
    return result.systemInfo;
  }

  void _updateSystemInfo() async{
    var result = await getSystemInfo();
    if (_store.state.hasInternet != result.networkInfo.hasInternet){
      _store.dispatch(ChangeInternetAction(result.networkInfo.hasInternet));
    }
    _onSystemInfoUpdate.add(result);
  }

  Future<RpcResult> _executePushButtonCommand(PushButtonCommand command) async{
    _onPushButton.add(command.button);
    return new EmptyResult((b) => b..id = command.id);
  }
}
