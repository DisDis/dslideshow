import 'dart:async';

import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_backend/storage.dart';
import 'package:dslideshow_common/rpc.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/bloc/slideshow_bloc.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/bloc/slideshow_event.dart';
import 'package:dslideshow_flutter/src/injector.dart';
import 'package:logging/logging.dart';

class FrontendService implements RpcService {
  static final Logger _log = Logger('FrontendService');
  late final RemoteService _backendService;
  late final RemoteService _otaService;
  final _screenStateChangePreparation = StreamController<bool>.broadcast();
  final _onSystemInfoUpdate = StreamController<SystemInfo>.broadcast();
  final _onPushButton = StreamController<ButtonType>.broadcast();
  final _onOTAReady = StreamController<bool>.broadcast();
  final _onOTAInfo = StreamController<OTAInfo>.broadcast();
  final _onOTAOutput = StreamController<String>.broadcast();

  Stream<bool> get onOTAReady => _onOTAReady.stream;
  Stream<OTAInfo> get onOTAInfo => _onOTAInfo.stream;
  Stream<String> get onOTAOutput => _onOTAOutput.stream;

  Stream<bool> get onScreenStateChangePreparation => _screenStateChangePreparation.stream;
  Stream<SystemInfo> get onSystemInfoUpdate => _onSystemInfoUpdate.stream;
  Stream<ButtonType> get onPushButton => _onPushButton.stream;

  FrontendService(AppConfig config, this._backendService, this._otaService) {
    Timer.periodic(const Duration(minutes: 1), (Timer timer) => _updateSystemInfo());
    _updateSystemInfo();
  }

  @override
  Future<RpcResult> executeCommand(RpcCommand command) {
//    _log.info("Execute command [${command.hashCode}]${command.id}:${command.type}");
    Stopwatch work = Stopwatch()
      ..reset()
      ..start();
    return _executeCommand(command).whenComplete(() {
      work.stop();
      _log.info("Command: [${command.hashCode}]${command.id}:${command.type} duration: ${work.elapsed.inMilliseconds.toString()}ms");
    });
  }

  Future<MediaItem> getStorageCurrentItem() async {
    final result = await _backendService.send(GetMediaItemCommand(isCurrent: true, id: RpcCommand.generateId()));
    var resultMediaItem = result as GetMediaItemCommandResult;
    return MediaItem(resultMediaItem.mediaId, resultMediaItem.mediaUri);
  }

  Future<MediaItem> getStorageNextItem() async {
    final result = await _backendService.send(GetMediaItemCommand(isCurrent: false, id: RpcCommand.generateId()));
//    _log.info("Message: $result");
    var resultMediaItem = result as GetMediaItemCommandResult;
    return MediaItem(resultMediaItem.mediaId, resultMediaItem.mediaUri);
  }

  Future swithLED(LEDType type, bool value) async {
    return _backendService.send(LEDControlCommand(
      id: RpcCommand.generateId(),
      led: type,
      value: value,
    ));
  }

  Future storageNext() async {
    return _backendService.send(StorageNextCommand(id: RpcCommand.generateId()));
  }

  void testEcho(String text) async {
    final result = await _backendService.send(EchoCommand(id: RpcCommand.generateId(), text: text));
    _log.info("Message: $result");
  }

  Future<RpcResult> _executeCommand(RpcCommand command) {
    switch (command.type) {
      case PushButtonCommand.TYPE:
        return _executePushButtonCommand(command as PushButtonCommand);
      case ScreenTurnCommand.TYPE:
        return _executeScreenTurnCommand(command as ScreenTurnCommand);
      case EchoCommand.TYPE:
        return _executeEchoCommand(command as EchoCommand);
      case OTAReadyCommand.TYPE:
        return _executeOTAReadyCommand(command as OTAReadyCommand);
      case OTAGetInfoCommand.TYPE:
        return _executeOTAGetInfoCommand(command as OTAGetInfoCommand);
      case OTAOutputCommand.TYPE:
        return _executeOTAOutputCommand(command as OTAOutputCommand);

      default:
        return Future.value(_generateErrorResult(Exception("Unknown command: ${command.type}"), command));
    }
  }

  Future<RpcResult> _executeEchoCommand(EchoCommand command) async {
    if (command.text == 'error') {
      return _generateErrorResult(Exception("Echo error"), command);
    }
    return EchoCommandResult(
      id: command.id,
      resultText: "${command.text} Service ${DateTime.now()}",
    );
  }

  Future<RpcResult> _executeScreenTurnCommand(ScreenTurnCommand command) async {
    _screenStateChangePreparation.add(command.enabled);
    return EmptyResult.respond(command);
  }

  RpcErrorResult _generateErrorResult(Object e, RpcCommand command) {
    return ErrorResult(
      id: command.id,
      error: "$e",
    );
  }

  Future<SystemInfo> getSystemInfo() async {
    final resultRaw = await _backendService.send(GetSystemInfoCommand(id: RpcCommand.generateId()));
    var result = resultRaw as GetSystemInfoCommandResult;
    return result.systemInfo;
  }

  void _updateSystemInfo() async {
    var result = await getSystemInfo();
    final SlideshowBloc bloc = injector();
    if (bloc.state.hasInternet != result.networkInfo.hasInternet) {
      bloc.add(SlideshowInternetEvent(result.networkInfo.hasInternet));
    }
    _onSystemInfoUpdate.add(result);
  }

  Future<RpcResult> _executePushButtonCommand(PushButtonCommand command) async {
    _onPushButton.add(command.button);
    return EmptyResult.respond(command);
  }

  Future<RpcResult> changeScreenLock(bool isScreenLockNewValue) async {
    return _backendService.send(ScreenLockCommand(id: RpcCommand.generateId(), isLock: isScreenLockNewValue));
  }

  Future pushButton(ButtonType buttonType) async {
    return _backendService.send(PushButtonCommand(id: RpcCommand.generateId(), button: buttonType));
  }

  Future screenTurn(bool value) async {
    return _backendService.send(ScreenTurnCommand(id: RpcCommand.generateId(), enabled: value));
  }

  Future backendIsReady() async {
    return _backendService.send(AreYouReadyCommand(id: RpcCommand.generateId()));
  }

  Future stopWebServer() async {
    return _backendService.send(WebServerControlCommand(id: RpcCommand.generateId(), enable: false));
  }

  Future<String> startWebServer() async {
    var codeMsg = await _backendService.send(WebServerControlCommand(id: RpcCommand.generateId(), enable: true)) as WebServerControlCommandResult;
    return codeMsg.code;
  }

  Future<RpcResult> _executeOTAReadyCommand(OTAReadyCommand command) async {
    _onOTAReady.add(command.ready);
    return EmptyResult.respond(command);
  }

  Future<RpcResult> _executeOTAGetInfoCommand(OTAGetInfoCommand command) async {
    _onOTAInfo.add(command.info!);
    return EmptyResult.respond(command);
  }

  Future<OTAInfo> getOTAInfo() async {
    var result = await _otaService.send(OTAGetInfoCommand(id: RpcCommand.generateId()));
    return (result as OTAGetInfoCommandResult).info;
  }

  Future<RpcResult> _executeOTAOutputCommand(OTAOutputCommand command) async {
    _onOTAOutput.add(command.output);
    return EmptyResult.respond(command);
  }
}
