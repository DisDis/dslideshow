import 'dart:async';
import 'dart:io';

import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_backend/src/service/hardware/hardware.dart';
import 'package:dslideshow_backend/src/service/hardware/src/power_off_service.dart';
import 'package:dslideshow_backend/src/service/hardware/src/screen_service.dart';
import 'package:dslideshow_backend/src/service/mqtt/mqtt_service.dart';
import 'package:dslideshow_backend/src/service/storage/storage.dart';
import 'package:dslideshow_backend/src/service/system_info/system_info_service.dart';
import 'package:dslideshow_backend/src/service/wifi/wifi_service.dart';
import 'package:dslideshow_common/rpc.dart';
import 'package:logging/logging.dart';

import 'gpio_service.dart';

class HardwareService implements RpcService {
  static final Logger _log = new Logger('HardwareService');

  final SystemInfoService _systemInfoService;
  final RemoteService _frontendService;
  final RemoteService _webServer;
  final PowerOffService _powerOffService;
  final Storage _storage;

  final GPIOService _gpioService;
  final ScreenService _screenService;
  final MqttService _mqttService;
  final WiFiService _wifiService;
  final ApplicationStateService _applicationStateService;

  HardwareService(
    AppConfig config,
    this._frontendService,
    this._storage,
    this._gpioService,
    this._screenService,
    this._systemInfoService,
    this._webServer,
    this._mqttService,
    this._wifiService,
    this._powerOffService,
    this._applicationStateService,
  ) {
    _init();
  }

  final List<Future> _initFutures = <Future>[];
  void _init() {
    _initFutures.add(_storage.init());
    if (Platform.isLinux) {
      _initFutures.add(_gpioService.init());
    } else {
      _log.warning('GPIO does not support except Linux');
    }
    _gpioService.onButtonEvent.listen((event) {
      _log.info('onButtonEvent button${event.button.index} = $event');
      _sendButtonEvent(event);
    });
    _screenService.onStateChangePreparation.listen((newState) {
      screenConfigure(newState);
    });
    _gpioService.onMotion.listen((event) {
      _log.info('Motion = $event');
      if (event) {
        _screenService.screenOn();
      } else {
        _screenService.scheduleScreenOff();
      }
    });
    _mqttService.onPause.listen((event) {
      _log.info("MQTT: onPause, $event");
      _executeAction(SlideshowAction.pause, event);
    });
    _mqttService.onScreen.listen((event) {
      _log.info("MQTT: onScreenToggle, $event");
      // Because toggleScreen has invert logic :(
      _executeAction(SlideshowAction.toggleScreen, !event);
    });
    _mqttService.onMenu.listen((event) {
      _log.info("MQTT: onMenu, $event");
      _executeAction(SlideshowAction.showMenu, event);
    });
    _initFutures.add(_systemInfoService.init());
  }

  void screenConfigure(bool enabled) {
    _frontendService.send(
      ScreenTurnCommand(enabled: enabled, id: RpcCommand.generateId()),
    );
  }

  void testEcho(String text) async {
    final result = await _frontendService.send(
      new EchoCommand(text: text, id: RpcCommand.generateId()),
    );
    _log.info("Message: $result");
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
        "Command: [${command.hashCode}]${command.id}:${command.type} duration: ${work.elapsed.inMilliseconds.toString()}ms",
      );
    });
  }

  Future<RpcResult> _executeCommand(RpcCommand command) {
    switch (command.type) {
      case AreYouReadyCommand.TYPE:
        return _executeAreYouReadyCommand(command as AreYouReadyCommand);
      case WebServerControlCommand.TYPE:
        return _executeWebServerControlCommand(
          command as WebServerControlCommand,
        );
      case UpdateFrontendStateCommand.TYPE:
        return _executeUpdateFrontendStateCommand(
          command as UpdateFrontendStateCommand,
        );
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
      case GetMediaItemCommand.TYPE:
        return _executeGetMediaItemCommand(command as GetMediaItemCommand);
      case StorageNextCommand.TYPE:
        return _executeStorageNextCommand(command as StorageNextCommand);
      case EmulatePushButtonCommand.TYPE:
        return _executeEmulatePushButtonCommand(
          command as EmulatePushButtonCommand,
        );
      case WiFiScanCommand.TYPE:
        return _executeWiFiScanCommand(command as WiFiScanCommand);
      case WiFiAddCommand.TYPE:
        return _executeWiFiAddCommand(command as WiFiAddCommand);
      case WiFiRemoveCommand.TYPE:
        return _executeWiFiRemoveCommand(command as WiFiRemoveCommand);
      case WiFiGetConnectionsCommand.TYPE:
        return _executeWiFiGetConnectionsCommand(
          command as WiFiGetConnectionsCommand,
        );
      case EchoCommand.TYPE:
        return _executeEchoCommand(command as EchoCommand);
      default:
        return _generateErrorResult(
          new Exception("Unknown command: ${command.type}"),
          command,
        );
    }
  }

  Future<RpcErrorResult> _generateErrorResult(
    Object e,
    RpcCommand command,
  ) async {
    return ErrorResult(id: command.id, error: "$e");
  }

  Future<RpcResult> _executeEchoCommand(EchoCommand command) async {
    if (command.text == 'error') {
      return _generateErrorResult(new Exception("Echo error"), command);
    }
    return EchoCommandResult(
      id: command.id,
      resultText: "${command.text} Service ${new DateTime.now()}",
    );
  }

  Future<RpcResult> _executeStorageNextCommand(
    StorageNextCommand command,
  ) async {
    await _storage.next();
    return EmptyResult.respond(command);
  }

  Future<RpcResult> _executeGetMediaItemCommand(
    GetMediaItemCommand command,
  ) async {
    final item = await (command.isCurrent
        ? _storage.getCurrent()
        : _storage.getNext());
    return GetMediaItemCommandResult(
      id: command.id,
      mediaId: item != null ? item.id : null,
      mediaUri: item != null ? item.uri : null,
    );
  }

  Future<RpcResult> _executeGetSystemInfoCommand(
    GetSystemInfoCommand command,
  ) async {
    final info = await _systemInfoService.getFullInfo();
    return GetSystemInfoCommandResult(id: command.id, systemInfo: info);
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
    return _frontendService.send(
      ExecuteSSActionCommand(
        action: action,
        value: value,
        id: RpcCommand.generateId(),
      ),
    );
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
      _screenService.screenOn();
    } else {
      _screenService.screenOff();
    }
    return EmptyResult.respond(command);
  }

  Future<RpcResult> _executePowerOffCommand(PowerOffCommand command) async {
    try {
      _powerOffService.execute();
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

  Future<RpcResult> _executeWebServerControlCommand(
    WebServerControlCommand command,
  ) async {
    return _webServer.send(command);
  }

  Future<RpcResult> _executeAreYouReadyCommand(
    AreYouReadyCommand command,
  ) async {
    if (_initFutures.isNotEmpty) {
      await Future.wait<dynamic>(_initFutures);
      _initFutures.clear();
    }
    return EmptyResult.respond(command);
  }

  Future<RpcResult> _executeEmulatePushButtonCommand(
    EmulatePushButtonCommand command,
  ) async {
    //Emulate
    _sendButtonEvent(
      ButtonEvent(
        button: command.button,
        event: ButtonEventType.released,
        durationMs: command.durationMs,
      ),
    );
    return EmptyResult.respond(command);
  }

  Future<WiFiScanResult> _executeWiFiScanCommand(
    WiFiScanCommand command,
  ) async {
    var result = await _wifiService.scan();
    return new WiFiScanResult(id: command.id, networks: result);
  }

  Future<RpcResult> _executeWiFiAddCommand(WiFiAddCommand command) async {
    _wifiService.addWiFiConnection(command.name, command.SSID, command.psk);
    return EmptyResult.respond(command);
  }

  Future<RpcResult> _executeWiFiRemoveCommand(WiFiRemoveCommand command) async {
    _wifiService.deleteConnection(command.connectionId);
    return EmptyResult.respond(command);
  }

  Future<RpcResult> _executeWiFiGetConnectionsCommand(
    WiFiGetConnectionsCommand command,
  ) async {
    var result = await _wifiService.getConnections();
    return WiFiGetConnectionsResult(id: command.id, networks: result);
  }

  Future<RpcResult> _executeUpdateFrontendStateCommand(
    UpdateFrontendStateCommand command,
  ) async {
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
