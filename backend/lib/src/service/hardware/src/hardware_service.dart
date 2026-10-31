import 'dart:async';
import 'dart:io';

import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_backend/src/service/hardware/hardware.dart';
import 'package:dslideshow_backend/src/service/mqtt/mqtt_service.dart';
import 'package:dslideshow_backend/src/service/slideshow/slideshow_config.dart' show SlideshowAction;
import 'package:dslideshow_backend/src/service/storage/storage.dart';
import 'package:dslideshow_backend/src/service/storage/storage_provider_registry.dart';
import 'package:dslideshow_backend/src/service/system_info/system_info_service.dart';
import 'package:dslideshow_backend/src/service/wifi/wifi_service.dart';
import 'package:dslideshow_common/rpc.dart';
import 'package:logging/logging.dart';

import 'device_event_bindings.dart';
import 'frame_state_reader.dart';
import 'gpio_service.dart';

class HardwareService implements RpcService {
  static final Logger _log = new Logger('HardwareService');

  final SystemInfoService _systemInfoService;
  final RemoteService _frontendService;
  final RemoteService _webServer;
  final PowerOffService _powerOffService;
  final StorageProviderRegistry _storageProviders;
  Storage get _storage => _storageProviders.selected;

  final GPIOService _gpioService;
  final ScreenService _screenService;
  final MqttService _mqttService;
  final WiFiService _wifiService;
  final ApplicationStateService _applicationStateService;
  final FrameStateReader _frameStateReader;

  HardwareService({
    required RemoteService frontendService,
    required StorageProviderRegistry storageProviders,
    required GPIOService gpioService,
    required ScreenService screenService,
    required SystemInfoService systemInfoService,
    required RemoteService webServer,
    required MqttService mqttService,
    required WiFiService wifiService,
    required PowerOffService powerOffService,
    required ApplicationStateService applicationStateService,
    required FrameStateReader frameStateReader,
  }) : _frontendService = frontendService,
       _storageProviders = storageProviders,
       _gpioService = gpioService,
       _screenService = screenService,
       _systemInfoService = systemInfoService,
       _webServer = webServer,
       _mqttService = mqttService,
       _wifiService = wifiService,
       _powerOffService = powerOffService,
       _applicationStateService = applicationStateService,
       _frameStateReader = frameStateReader {
    _init();
  }

  final List<Future> _initFutures = <Future>[];
  late final DeviceEventBindings _eventBindings;
  bool _disposed = false;
  StreamSubscription<StorageStatusEnum>? _storageStatusSubscription;
  void _init() {
    _storageStatusSubscription = _storage.onStatusChanged.listen(_notifyStorageStatus);
    unawaited(_notifyStorageStatus(_storage.status));
    _initFutures.add(_storageProviders.init());
    if (Platform.isLinux) {
      _initFutures.add(_gpioService.init());
    } else {
      _log.warning('GPIO does not support except Linux');
    }
    _eventBindings = DeviceEventBindings(
      gpioService: _gpioService,
      mqttService: _mqttService,
      screenService: _screenService,
      onButtonEvent: _sendButtonEvent,
      onScreenPreparation: screenConfigure,
      onAction: _executeAction,
      logger: _log,
    );
    _initFutures.add(_systemInfoService.init());
  }

  Future<void> _notifyStorageStatus(StorageStatusEnum status) async {
    if (_disposed) return;
    try {
      _log.fine('Storage status delivery started status=${status.name}');
      final result = await _frontendService.send(StorageStatusCommand(id: RpcCommand.generateId(), status: status));
      if (result is RpcErrorResult) throw RpcErrorResultException(result);
      if (result is! EmptyResult) throw StateError('Unexpected storage status response');
      _log.fine('Storage status delivered status=${status.name}');
    } catch (error) {
      _log.log(
        _disposed ? Level.FINE : Level.WARNING,
        'Storage status delivery ${_disposed ? 'cancelled' : 'failed'} status=${status.name} type=${error.runtimeType}',
      );
    }
  }

  Future<void> screenConfigure(bool enabled) async {
    if (_disposed) return;
    try {
      _log.fine('Screen notification started enabled=$enabled');
      final result = await _frontendService.send(ScreenTurnCommand(enabled: enabled, id: RpcCommand.generateId()));
      if (result is RpcErrorResult) throw RpcErrorResultException(result);
      if (result is! EmptyResult) throw StateError('Unexpected screen notification response');
      _log.fine('Screen notification delivered enabled=$enabled');
    } catch (error) {
      _log.log(
        _disposed ? Level.FINE : Level.WARNING,
        'Screen notification ${_disposed ? 'cancelled' : 'failed'} enabled=$enabled type=${error.runtimeType}',
      );
    }
  }

  Future<void> dispose() async {
    _disposed = true;
    final storageStatusCancelled = _storageStatusSubscription?.cancel();
    await _eventBindings.dispose();
    await storageStatusCancelled;
    await _applicationStateService.dispose();
    await _screenService.dispose();
    await _gpioService.release();
    await Future.wait([
      _storageProviders.release(),
      _systemInfoService.release(),
      _wifiService.close(),
      _mqttService.close(),
    ]);
  }

  void testEcho(String text) async {
    final result = await _frontendService.send(new EchoCommand(text: text, id: RpcCommand.generateId()));
    _log.info("Message: $result");
  }

  @override
  Future<RpcResult> executeCommand(RpcCommand command) {
    if (_disposed) return _generateErrorResult(StateError('Hardware service disposed'), command);
    //    _log.info("Execute command [${command.hashCode}]${command.id}:${command.type}");
    return _executeCommand(command).whenComplete(() {
      _log.fine(() => "Command: [${command.hashCode}]${command.id}:${command.type}");
    });
  }

  Future<RpcResult> _executeCommand(RpcCommand command) {
    if (command is DriveCommand) return _storageProviders.executeDriveCommand(command);
    switch (command.type) {
      case AreYouReadyCommand.TYPE:
        return _executeAreYouReadyCommand(command as AreYouReadyCommand);
      case WebServerControlCommand.TYPE:
        return _executeWebServerControlCommand(command as WebServerControlCommand);
      case UpdateFrontendStateCommand.TYPE:
        return _executeUpdateFrontendStateCommand(command as UpdateFrontendStateCommand);
      case PowerOffCommand.TYPE:
        return _executePowerOffCommand(command as PowerOffCommand);
      case RestartAppCommand.TYPE:
        return _executeRestartAppCommand(command as RestartAppCommand);
      case ScreenTurnCommand.TYPE:
        return _executeScreenTurnCommand(command as ScreenTurnCommand);
      case ScreenLockCommand.TYPE:
        return _executeScreenLockCommand(command as ScreenLockCommand);
      case LEDControlCommand.TYPE:
        return _executeLEDControlCommand(command as LEDControlCommand);
      case GetSystemInfoCommand.TYPE:
        return _executeGetSystemInfoCommand(command as GetSystemInfoCommand);
      case GetFrameStateCommand.TYPE:
        return _executeGetFrameStateCommand(command as GetFrameStateCommand);
      case SetFrameControlCommand.TYPE:
        return _executeSetFrameControlCommand(command as SetFrameControlCommand);
      case GetMediaItemCommand.TYPE:
        return _executeGetMediaItemCommand(command as GetMediaItemCommand);
      case StorageNextCommand.TYPE:
        return _executeStorageNextCommand(command as StorageNextCommand);
      case EmulatePushButtonCommand.TYPE:
        return _executeEmulatePushButtonCommand(command as EmulatePushButtonCommand);
      case WiFiRescanCommand.TYPE:
        return _executeWiFiRescanCommand(command as WiFiRescanCommand);
      case WiFiListCommand.TYPE:
        return _executeWiFiListCommand(command as WiFiListCommand);
      case WiFiAddCommand.TYPE:
        return _executeWiFiAddCommand(command as WiFiAddCommand);
      case WiFiRemoveCommand.TYPE:
        return _executeWiFiRemoveCommand(command as WiFiRemoveCommand);
      case WiFiGetConnectionsCommand.TYPE:
        return _executeWiFiGetConnectionsCommand(command as WiFiGetConnectionsCommand);
      case EchoCommand.TYPE:
        return _executeEchoCommand(command as EchoCommand);
      default:
        return _generateErrorResult(new Exception("Unknown command: ${command.type}"), command);
    }
  }

  Future<RpcErrorResult> _generateErrorResult(Object e, RpcCommand command) async {
    return ErrorResult(id: command.id, error: "$e");
  }

  Future<RpcResult> _executeEchoCommand(EchoCommand command) async {
    if (command.text == 'error') {
      return _generateErrorResult(new Exception("Echo error"), command);
    }
    return EchoCommandResult(id: command.id, resultText: "${command.text} Service ${new DateTime.now()}");
  }

  Future<RpcResult> _executeStorageNextCommand(StorageNextCommand command) async {
    await _storage.next();
    return EmptyResult.respond(command);
  }

  Future<RpcResult> _executeGetMediaItemCommand(GetMediaItemCommand command) async {
    final item = await (command.isCurrent ? _storage.getCurrent() : _storage.getNext());
    return GetMediaItemCommandResult(
      id: command.id,
      mediaId: item != null ? item.id : null,
      mediaUri: item != null ? item.uri : null,
    );
  }

  Future<RpcResult> _executeGetSystemInfoCommand(GetSystemInfoCommand command) async {
    try {
      final info = await _systemInfoService.getFullInfo();
      return GetSystemInfoCommandResult(id: command.id, systemInfo: info);
    } catch (error, stack) {
      _log.warning('Could not collect system information', error, stack);
      return _generateErrorResult(error, command);
    }
  }

  void _ensureActive() {
    if (_disposed) throw StateError('Hardware service disposed');
  }

  Future<RpcResult> _executeGetFrameStateCommand(GetFrameStateCommand command) async {
    try {
      final state = await _frameStateReader.read();
      _ensureActive();
      return GetFrameStateResult(id: command.id, state: state);
    } catch (error) {
      _log.log(
        _disposed ? Level.FINE : Level.WARNING,
        'Frame state request ${_disposed ? 'cancelled' : 'failed'} type=${error.runtimeType}',
      );
      return _generateErrorResult(error, command);
    }
  }

  Future<RpcResult> _executeSetFrameControlCommand(SetFrameControlCommand command) async {
    try {
      _log.fine(
        'Frame control started requestId=${command.id} control=${command.control.name} enabled=${command.enabled}',
      );
      final result = await _frontendService.send(command);
      _ensureActive();
      if (result is RpcErrorResult) throw StateError(result.error);
      if (result is! EmptyResult) throw StateError('Unexpected frontend control response');
      _log.fine('Frame control applied requestId=${command.id} control=${command.control.name}');
      final state = await _frameStateReader.read();
      _ensureActive();
      return GetFrameStateResult(id: command.id, state: state);
    } catch (error) {
      _log.log(
        _disposed ? Level.FINE : Level.WARNING,
        'Frame control ${_disposed ? 'cancelled' : 'failed'} type=${error.runtimeType}',
      );
      return _generateErrorResult(error, command);
    }
  }

  Future<RpcResult> _sendButtonEvent(ButtonEvent event) async {
    return _frontendService.send(
      ButtonChangeStateCommand(
        button: event.button,
        event: event.event,
        durationMs: event.durationMs,
        id: RpcCommand.generateId(),
      ),
    );
  }

  Future<RpcResult> _executeAction(SlideshowAction action, bool value) async {
    return _frontendService.send(ExecuteSSActionCommand(action: action, value: value, id: RpcCommand.generateId()));
  }

  Future<RpcResult> _executeLEDControlCommand(LEDControlCommand command) async {
    if (command.led == LEDType.power) {
      _gpioService.powerLED = command.value;
    }
    return EmptyResult.respond(command);
  }

  Future<RpcResult> _executeScreenLockCommand(ScreenLockCommand command) async {
    _screenService.isScreenOffLock = command.isLock;
    return EmptyResult.respond(command);
  }

  Future<RpcResult> _executeScreenTurnCommand(ScreenTurnCommand command) async {
    if (command.enabled) {
      unawaited(_screenService.screenOn());
    } else {
      unawaited(_screenService.screenOff());
    }
    return EmptyResult.respond(command);
  }

  Future<RpcResult> _executePowerOffCommand(PowerOffCommand command) async {
    try {
      _powerOffService.powerOff();
    } catch (e, s) {
      _log.severe('powerOff', e, s);
    }
    return EmptyResult.respond(command);
  }

  Future<RpcResult> _executeRestartAppCommand(RestartAppCommand command) async {
    try {
      _powerOffService.restartApp();
    } catch (e, s) {
      _log.severe('restartApp', e, s);
    }
    return EmptyResult.respond(command);
  }

  Future<RpcResult> _executeWebServerControlCommand(WebServerControlCommand command) async {
    return _webServer.send(command);
  }

  Future<RpcResult> _executeAreYouReadyCommand(AreYouReadyCommand command) async {
    if (_initFutures.isNotEmpty) {
      await Future.wait<dynamic>(_initFutures);
      _initFutures.clear();
    }
    return EmptyResult.respond(command);
  }

  Future<RpcResult> _executeEmulatePushButtonCommand(EmulatePushButtonCommand command) async {
    //Emulate
    _sendButtonEvent(
      ButtonEvent(button: command.button, event: ButtonEventType.released, durationMs: command.durationMs),
    );
    return EmptyResult.respond(command);
  }

  Future<RpcResult> _executeWiFiListCommand(WiFiListCommand command) =>
      _wifiReply(command, () async => WiFiListResult(id: command.id, networks: await _wifiService.list()));

  Future<RpcResult> _executeWiFiRescanCommand(WiFiRescanCommand command) => _wifiReply(command, () async {
    await _wifiService.rescan();
    return EmptyResult.respond(command);
  });

  Future<RpcResult> _executeWiFiAddCommand(WiFiAddCommand command) => _wifiReply(command, () async {
    await _wifiService.addWiFiConnection(command.name, command.SSID, command.psk);
    return EmptyResult.respond(command);
  });

  Future<RpcResult> _executeWiFiRemoveCommand(WiFiRemoveCommand command) => _wifiReply(command, () async {
    await _wifiService.deleteConnection(command.connectionId);
    return EmptyResult.respond(command);
  });

  Future<RpcResult> _executeWiFiGetConnectionsCommand(WiFiGetConnectionsCommand command) => _wifiReply(
    command,
    () async => WiFiGetConnectionsResult(id: command.id, networks: await _wifiService.getConnections()),
  );

  Future<RpcResult> _wifiReply(RpcCommand command, Future<RpcResult> Function() operation) async {
    _log.info('event=wifiStarted rpcId=${command.id} action=${command.type}');
    try {
      final result = await operation();
      _ensureActive();
      _log.info('event=wifiCompleted rpcId=${command.id} action=${command.type}');
      return result;
    } catch (error) {
      _log.log(
        _disposed ? Level.INFO : Level.WARNING,
        'event=${_disposed ? 'wifiCancelled' : 'wifiFailed'} rpcId=${command.id} '
        'action=${command.type} type=${error.runtimeType}',
      );
      return _generateErrorResult(error, command);
    }
  }

  Future<RpcResult> _executeUpdateFrontendStateCommand(UpdateFrontendStateCommand command) async {
    var state = _applicationStateService.state;

    if (command.isMenu != null) {
      state = state.copyWith(isMenu: command.isMenu!);
    }
    if (command.isPaused != null) {
      state = state.copyWith(isPaused: command.isPaused!);
    }

    _applicationStateService.update(state);
    return EmptyResult.respond(command);
  }
}
