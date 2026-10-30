import 'dart:async';

import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_backend/storage.dart';
import 'package:dslideshow_common/rpc.dart';
import 'package:dslideshow_flutter/src/service/cancellable_waits.dart';
import 'package:logging/logging.dart';

class FrontendService implements RpcService {
  static final Logger _log = Logger('FrontendService');
  late final RemoteService _backendService;
  late final RemoteService _otaService;
  final _waits = CancellableWaits();
  Timer? _systemInfoTimer;
  final _screenStateChangePreparation = StreamController<bool>.broadcast();
  final _onSystemInfoUpdate = StreamController<SystemInfo>.broadcast();
  final _onButtonEvent = StreamController<ButtonEvent>.broadcast();

  final _onAction = StreamController<ActionWithParam<bool>>.broadcast();

  final _onOTAReady = StreamController<bool>.broadcast();
  final _onOTAInfo = StreamController<OTAInfo>.broadcast();
  final _onOTAOutput = StreamController<String>.broadcast();

  bool get isClosed => _waits.isClosed;

  Stream<bool> get onOTAReady => _onOTAReady.stream;
  Stream<OTAInfo> get onOTAInfo => _onOTAInfo.stream;
  Stream<String> get onOTAOutput => _onOTAOutput.stream;

  Stream<bool> get onScreenStateChangePreparation => _screenStateChangePreparation.stream;
  Stream<SystemInfo> get onSystemInfoUpdate => _onSystemInfoUpdate.stream;
  Stream<ButtonEvent> get onButtonEvent => _onButtonEvent.stream;
  Stream<ActionWithParam> get onAction => _onAction.stream;

  FrontendService(
    AppConfig config,
    this._backendService,
    this._otaService, {
    Duration systemInfoInterval = const Duration(minutes: 1),
  }) {
    if (systemInfoInterval <= Duration.zero) {
      throw ArgumentError.value(systemInfoInterval, 'systemInfoInterval', 'Must be positive');
    }
    _systemInfoTimer = Timer.periodic(systemInfoInterval, (_) {
      unawaited(_updateSystemInfo());
    });
    unawaited(_updateSystemInfo());
  }

  @override
  Future<RpcResult> executeCommand(RpcCommand command) async {
    if (_waits.isClosed) {
      return _generateErrorResult(StateError('Frontend service is closed'), command);
    }
    try {
      return await _executeCommand(command);
    } catch (error) {
      return _generateErrorResult(error, command);
    } finally {
      _log.fine('command result requestId=${command.id} type=${command.type}');
    }
  }

  Future<RpcResult> _sendBackend(RpcCommand command) => _send(_backendService, command);
  Future<RpcResult> _sendOta(RpcCommand command) => _send(_otaService, command);

  Future<RpcResult> _send(RemoteService remote, RpcCommand command) async {
    if (_waits.isClosed) throw StateError('Frontend service is closed');
    try {
      final result = await _waits.wait(remote.send(command));
      if (_waits.isClosed || result == null) {
        throw StateError('Frontend service is closed');
      }
      if (result is RpcErrorResult) throw RpcErrorResultException(result);
      return result;
    } catch (error) {
      if (!_waits.isClosed) {
        _log.fine(
          'RPC failed requestId=${command.id}'
          ' type=${command.type} errorType=${error.runtimeType}',
        );
      }
      rethrow;
    } finally {
      _log.fine(
        'RPC result requestId=${command.id} type=${command.type}'
        ' cancelled=${_waits.isClosed}',
      );
    }
  }

  Future<MediaItem> getStorageCurrentItem() async {
    final result = await _sendBackend(GetMediaItemCommand(isCurrent: true, id: RpcCommand.generateId()));
    var resultMediaItem = result as GetMediaItemCommandResult;
    return MediaItem(resultMediaItem.mediaId, resultMediaItem.mediaUri);
  }

  Future<MediaItem> getStorageNextItem() async {
    final result = await _sendBackend(GetMediaItemCommand(isCurrent: false, id: RpcCommand.generateId()));
    var resultMediaItem = result as GetMediaItemCommandResult;
    return MediaItem(resultMediaItem.mediaId, resultMediaItem.mediaUri);
  }

  Future swithLED(LEDType type, bool value) async {
    return _sendBackend(LEDControlCommand(id: RpcCommand.generateId(), led: type, value: value));
  }

  Future storageNext() async {
    return _sendBackend(StorageNextCommand(id: RpcCommand.generateId()));
  }

  Future<void> testEcho(String text) async {
    final command = EchoCommand(id: RpcCommand.generateId(), text: text);
    await _sendBackend(command);
    _log.fine('echo complete requestId=${command.id}');
  }

  Future<RpcResult> _executeCommand(RpcCommand command) {
    switch (command.type) {
      case ExecuteSSActionCommand.TYPE:
        return _executeSSActionCommand(command as ExecuteSSActionCommand);
      case ButtonChangeStateCommand.TYPE:
        return _executeButtonChangeStateCommand(command as ButtonChangeStateCommand);
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
    return EchoCommandResult(id: command.id, resultText: "${command.text} Service ${DateTime.now()}");
  }

  Future<RpcResult> _executeScreenTurnCommand(ScreenTurnCommand command) async {
    _screenStateChangePreparation.add(command.enabled);
    return EmptyResult.respond(command);
  }

  RpcErrorResult _generateErrorResult(Object e, RpcCommand command) {
    _log.warning('command failed requestId=${command.id} type=${command.type} errorType=${e.runtimeType}');
    return ErrorResult(id: command.id, error: "$e");
  }

  Future<SystemInfo> getSystemInfo() async {
    final resultRaw = await _sendBackend(GetSystemInfoCommand(id: RpcCommand.generateId()));
    var result = resultRaw as GetSystemInfoCommandResult;
    return result.systemInfo;
  }

  Future<void> _updateSystemInfo() async {
    if (_waits.isClosed) return;
    _log.fine('systemInfo start');
    try {
      final result = await getSystemInfo();
      if (_waits.isClosed) return;
      _onSystemInfoUpdate.add(result);
      _log.fine('systemInfo completed');
    } catch (error) {
      if (!_waits.isClosed) {
        _log.warning(
          'systemInfo failed'
          ' errorType=${error.runtimeType}',
        );
      }
    } finally {
      if (_waits.isClosed) {
        _log.fine('systemInfo cancelled');
      }
    }
  }

  Future<void> dispose() async {
    _systemInfoTimer?.cancel();
    _systemInfoTimer = null;
    _waits.close();
    _log.info('dispose');
    await Future.wait([
      _screenStateChangePreparation.close(),
      _onSystemInfoUpdate.close(),
      _onButtonEvent.close(),
      _onAction.close(),
      _onOTAReady.close(),
      _onOTAInfo.close(),
      _onOTAOutput.close(),
    ]);
  }

  Future<RpcResult> _executeButtonChangeStateCommand(ButtonChangeStateCommand command) async {
    _onButtonEvent.add(ButtonEvent(button: command.button, event: command.event, durationMs: command.durationMs));
    return EmptyResult.respond(command);
  }

  Future<RpcResult> changeScreenLock(bool isScreenLockNewValue) async {
    return _sendBackend(ScreenLockCommand(id: RpcCommand.generateId(), isLock: isScreenLockNewValue));
  }

  Future emulatePushButton(ButtonType buttonType, [int durationMs = 1000]) async {
    return _sendBackend(
      EmulatePushButtonCommand(id: RpcCommand.generateId(), button: buttonType, durationMs: durationMs),
    );
  }

  Future screenTurn(bool value) async {
    return _sendBackend(ScreenTurnCommand(id: RpcCommand.generateId(), enabled: value));
  }

  Future powerOff() async {
    return _sendBackend(PowerOffCommand(id: RpcCommand.generateId()));
  }

  Future restartApp() async {
    return _sendBackend(RestartAppCommand(id: RpcCommand.generateId()));
  }

  Future backendIsReady() async {
    return _sendBackend(AreYouReadyCommand(id: RpcCommand.generateId()));
  }

  Future stopWebServer() async {
    return _sendBackend(WebServerControlCommand(id: RpcCommand.generateId(), enable: false));
  }

  Future updateFrontendState({bool? isPaused, bool? isMenu}) async {
    return _sendBackend(UpdateFrontendStateCommand(id: RpcCommand.generateId(), isPaused: isPaused, isMenu: isMenu));
  }

  Future<String> startWebServer() async {
    var codeMsg = await _sendBackend(
      WebServerControlCommand(id: RpcCommand.generateId(), enable: true),
    ) as WebServerControlCommandResult;
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
    var result = await _sendOta(OTAGetInfoCommand(id: RpcCommand.generateId()));
    return (result as OTAGetInfoCommandResult).info;
  }

  Future<RpcResult> _executeOTAOutputCommand(OTAOutputCommand command) async {
    _onOTAOutput.add(command.output);
    return EmptyResult.respond(command);
  }

  Future<RpcResult> _executeSSActionCommand(ExecuteSSActionCommand command) async {
    _onAction.add(ActionWithParam(action: command.action, param: command.value));
    return EmptyResult.respond(command);
  }
}

class ActionWithParam<T> {
  final SlideshowAction action;
  final T param;

  const ActionWithParam({required this.action, required this.param});
}

class ButtonEvent {
  final ButtonType button;
  final ButtonEventType event;
  final int durationMs;
  ButtonEvent({required this.button, required this.event, required this.durationMs});
}
