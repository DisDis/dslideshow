import 'dart:async';

import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_backend/storage.dart';
import 'package:dslideshow_common/rpc.dart';
import 'package:dslideshow_flutter/src/redux/actions/change_internet_action.dart';
import 'package:dslideshow_flutter/src/redux/state/global_state.dart';
import 'package:logging/logging.dart';
import 'package:redux/redux.dart';

class FrontendService implements RpcService {
  static final Logger _log = new Logger('FlutterService');
  late RemoteService _backendService;
  late RemoteService _otaService;
  final _screenStateChangePreparation = new StreamController<bool>.broadcast();
  final _onSystemInfoUpdate = new StreamController<SystemInfo>.broadcast();
  final _onPushButton = new StreamController<ButtonType>.broadcast();
  final _onOTAReady = new StreamController<bool>.broadcast();
  final _onOTAInfo = new StreamController<OTAInfo>.broadcast();
  final _onOTAOutput = new StreamController<String>.broadcast();

  Stream<bool> get onOTAReady => _onOTAReady.stream;
  Stream<OTAInfo> get onOTAInfo => _onOTAInfo.stream;
  Stream<String> get onOTAOutput => _onOTAOutput.stream;

  Stream<bool> get onScreenStateChangePreparation => _screenStateChangePreparation.stream;
  Stream<SystemInfo> get onSystemInfoUpdate => _onSystemInfoUpdate.stream;
  Stream<ButtonType> get onPushButton => _onPushButton.stream;

  final Store<GlobalState> _store;
  Store<GlobalState> get store => _store;

  FrontendService(AppConfig config, this._backendService, this._otaService, this._store) {
    new Timer.periodic(new Duration(minutes: 1), (Timer timer) => _updateSystemInfo());
    _updateSystemInfo();
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
    final result = await _backendService.send(new GetMediaItemCommand((b) => b.isCurrent = true));
    var resultMediaItem = result as GetMediaItemCommandResult;
    return new MediaItem(resultMediaItem.mediaId, resultMediaItem.mediaUri);
  }

  Future<MediaItem> getStorageNextItem() async {
    final result = await _backendService.send(new GetMediaItemCommand((b) => b.isCurrent = false));
//    _log.info("Message: $result");
    var resultMediaItem = result as GetMediaItemCommandResult;
    return new MediaItem(resultMediaItem.mediaId, resultMediaItem.mediaUri);
  }

  Future LEDControl(LEDType type, bool value) async {
    return _backendService.send(new LEDControlCommand((b) => b
      ..led = type
      ..value = value));
  }

  Future storageNext() async {
    return _backendService.send(new StorageNextCommand());
  }

  void testEcho(String text) async {
    final result = await _backendService.send(new EchoCommand((b) => b.text = text));
    _log.info("Message: $result");
  }

  Future<RpcResult> _executeCommand(RpcCommand command) {
    switch (command.type) {
      case PushButtonCommand.TYPE:
        return _executePushButtonCommand(command as PushButtonCommand);
      case ScreenTurnCommand.TYPE:
        return new Future.value(_executeScreenTurnCommand(command as ScreenTurnCommand));
      case EchoCommand.TYPE:
        return new Future.value(_executeEchoCommand(command as EchoCommand));
      case OTAReadyCommand.TYPE:
        return new Future.value(_executeOTAReadyCommand(command as OTAReadyCommand));
      case OTAGetInfoCommand.TYPE:
        return new Future.value(_executeOTAGetInfoCommand(command as OTAGetInfoCommand));
      case OTAOutputCommand.TYPE:
        return new Future.value(_executeOTAOutputCommand(command as OTAOutputCommand));

      default:
        return new Future.value(_generateErrorResult(new Exception("Unknown command: ${command.type}"), command));
    }
  }

  RpcResult _executeEchoCommand(EchoCommand command) {
    if (command.text == 'error') {
      return _generateErrorResult(new Exception("Echo error"), command);
    }
    return new EchoCommandResult((b) {
      b.id = command.id;
      b.resultText = "${command.text} Service ${new DateTime.now()}";
    });
  }

  FutureOr<RpcResult> _executeScreenTurnCommand(ScreenTurnCommand command) {
    _screenStateChangePreparation.add(command.enabled);
    return new EmptyResult.respond(command);
  }

  RpcErrorResult _generateErrorResult(Object e, RpcCommand command) {
    return new ErrorResult((b) => b
      ..id = command.id
      ..error = "$e");
  }

  Future<SystemInfo> getSystemInfo() async {
    final resultRaw = await _backendService.send(new GetSystemInfoCommand());
    var result = resultRaw as GetSystemInfoCommandResult;
    return result.systemInfo;
  }

  void _updateSystemInfo() async {
    var result = await getSystemInfo();
    if (_store.state.hasInternet != result.networkInfo.hasInternet) {
      _store.dispatch(ChangeInternetAction(result.networkInfo.hasInternet));
    }
    _onSystemInfoUpdate.add(result);
  }

  Future<RpcResult> _executePushButtonCommand(PushButtonCommand command) async {
    _onPushButton.add(command.button);
    return new EmptyResult.respond(command);
  }

  Future<RpcResult> changeScreenLock(bool isScreenLockNewValue) async {
    return _backendService.send(new ScreenLockCommand((b) => b.isLock = isScreenLockNewValue));
  }

  Future pushButton(ButtonType buttonType) async {
    return _backendService.send(new PushButtonCommand((b) => b.button = buttonType));
  }

  Future screenTurn(bool value) async {
    return _backendService.send(new ScreenTurnCommand((b) => b.enabled = value));
  }

  Future backendIsReady() async {
    return _backendService.send(new AreYouReadyCommand());
  }

  Future stopWebServer() async {
    return _backendService.send(new WebServerControlCommand((b) => b.enable = false));
  }

  Future<String> startWebServer() async {
    var codeMsg = await _backendService.send(new WebServerControlCommand((b) => b.enable = true))
        as WebServerControlCommandResult;
    return codeMsg.code;
  }

  Future<RpcResult> _executeOTAReadyCommand(OTAReadyCommand command) async {
    _onOTAReady.add(command.ready);
    return new EmptyResult.respond(command);
  }

  FutureOr<RpcResult>? _executeOTAGetInfoCommand(OTAGetInfoCommand command) async {
    _onOTAInfo.add(command.info!);
    return new EmptyResult.respond(command);
  }

  Future<OTAInfo> getOTAInfo() async {
    var result = await _otaService.send(new OTAGetInfoCommand());
    return (result as OTAGetInfoCommandResult).info;
  }

  FutureOr<RpcResult>? _executeOTAOutputCommand(OTAOutputCommand command) async {
    _onOTAOutput.add(command.output);
    return new EmptyResult.respond(command);
  }
}
