import 'dart:async';

import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_backend/src/service/system_info/system_info.dart';
import 'package:dslideshow_backend/storage.dart';
import 'package:dslideshow_common/rpc.dart';
import 'package:logging/logging.dart';

class FrontendService implements RpcService {
  static final Logger _log = new Logger('FlutterService');
  final RemoteService _backendService;
  final _screenStateChangePreparation = new StreamController<bool>.broadcast();
  final _onSystemInfoUpdate = new StreamController<SystemInfo>.broadcast();
  final _onPushButton = new StreamController<ButtonType>.broadcast();

  FrontendService(
    AppConfig config,
    this._backendService,
  ) {
    new Timer.periodic(new Duration(minutes: 1), (Timer timer) => _updateSystemInfo());
    _updateSystemInfo();
  }
  Stream<ButtonType> get onPushButton => _onPushButton.stream;
  Stream<bool> get onScreenStateChangePreparation => _screenStateChangePreparation.stream;

  Stream<SystemInfo> get onSystemInfoUpdate => _onSystemInfoUpdate.stream;

  Future<RpcResult> changeScreenLock(bool isScreenLockNewValue) async {
    return _backendService.send(new ScreenLockCommand((b) => b
      ..isLock = isScreenLockNewValue
      ..id = RpcCommand.generateId()));
  }

  @override
  Future<RpcResult> executeCommand(RpcCommand command) {
//    _log.info("Execute command [${command.hashCode}]${command.id}:${command.type}");
    Stopwatch work = new Stopwatch()
      ..reset()
      ..start();
    return _executeCommand(command).whenComplete(() {
      work.stop();
      _log.info(
          "Command: [${command.hashCode}]${command.id}:${command.type} duration: ${work.elapsed.inMilliseconds.toString()}ms");
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

  Future<SystemInfo> getSystemInfo() async {
    final resultRaw = await _backendService.send(new GetSystemInfoCommand((b) => b..id = RpcCommand.generateId()));
    var result = resultRaw as GetSystemInfoCommandResult;
    return result.systemInfo;
  }

  Future LEDControl(LEDType type, bool value) async {
    return _backendService.send(new LEDControlCommand((b) => b
      ..id = RpcCommand.generateId()
      ..led = type
      ..value = value));
  }

  Future screenTurn(bool value) async {
    return _backendService.send(new ScreenTurnCommand((b) => b
      ..enabled = value
      ..id = RpcCommand.generateId()));
  }

  Future storageNext() async {
    return _backendService.send(new StorageNextCommand((b) => b..id = RpcCommand.generateId()));
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

  Future<RpcResult> _executePushButtonCommand(PushButtonCommand command) async {
    _onPushButton.add(command.button);
    return new EmptyResult((b) => b..id = command.id);
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

  void _updateSystemInfo() async {
    var result = await getSystemInfo();
    _onSystemInfoUpdate.add(result);
  }
}
