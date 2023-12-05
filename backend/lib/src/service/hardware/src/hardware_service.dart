import 'dart:async';
import 'dart:io';

import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_backend/config.dart';
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
  final Storage _storage;

  final GPIOService _gpioService;
  final ScreenService _screenService;
  final MqttService _mqttService;
  final WiFiService _wifiService;

  HardwareService(AppConfig config, this._frontendService, this._storage, this._gpioService, this._screenService, this._systemInfoService, this._webServer,
      this._mqttService, this._wifiService) {
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
    _gpioService.onButton0.listen((event) {
      _log.info('onButton0 button = $event');
      if (event) _pushButton(ButtonType.button0);
    });
    _gpioService.onButton1.listen((event) {
      _log.info('onButton1 button = $event');
      if (event) _pushButton(ButtonType.button1);
    });
    _gpioService.onButton2.listen((event) {
      _log.info('onButton2 button = $event');
      if (event) _pushButton(ButtonType.button2);
    });
    _gpioService.onButton3.listen((event) {
      _log.info('onButton3 button = $event');
      if (event) _pushButton(ButtonType.button3);
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
    _frontendService.send(ScreenTurnCommand(
      enabled: enabled,
      id: RpcCommand.generateId(),
    ));
  }

  void testEcho(String text) async {
    final result = await _frontendService.send(new EchoCommand(
      text: text,
      id: RpcCommand.generateId(),
    ));
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
      _log.info("Command: [${command.hashCode}]${command.id}:${command.type} duration: ${work.elapsed.inMilliseconds.toString()}ms");
    });
  }

  Future<RpcResult> _executeCommand(RpcCommand command) {
    switch (command.type) {
      case AreYouReadyCommand.TYPE:
        return _executeAreYouReadyCommand(command as AreYouReadyCommand);
      case WebServerControlCommand.TYPE:
        return _executeWebServerControlCommand(command as WebServerControlCommand);
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
      case PushButtonCommand.TYPE:
        return _executePushButtonCommand(command as PushButtonCommand);
      case WiFiScanCommand.TYPE:
        return _executeWiFiScanCommand(command as WiFiScanCommand);
      case WiFiAddCommand.TYPE:
        return _executeWiFiAddCommand(command as WiFiAddCommand);
      case WiFiRemoveCommand.TYPE:
        return _executeWiFiRemoveCommand(command as WiFiRemoveCommand);
      case WiFiSaveConfigCommand.TYPE:
        return _executeWiFiSaveConfigCommand(command as WiFiSaveConfigCommand);
      case WiFiGetStoredCommand.TYPE:
        return _executeWiFiGetStoredCommand(command as WiFiGetStoredCommand);
      case EchoCommand.TYPE:
        return _executeEchoCommand(command as EchoCommand);
      default:
        return _generateErrorResult(new Exception("Unknown command: ${command.type}"), command);
    }
  }

  Future<RpcErrorResult> _generateErrorResult(Object e, RpcCommand command) async {
    return ErrorResult(
      id: command.id,
      error: "$e",
    );
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
    final info = await _systemInfoService.getFullInfo();
    return GetSystemInfoCommandResult(
      id: command.id,
      systemInfo: info,
    );
  }

  Future<RpcResult> _pushButton(ButtonType type) async {
    return _frontendService.send(PushButtonCommand(button: type, id: RpcCommand.generateId()));
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
      _screenService.screenOn();
    } else {
      _screenService.screenOff();
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

  Future<RpcResult> _executePushButtonCommand(PushButtonCommand command) async {
    //Emulate
    _pushButton(command.button);
    return EmptyResult.respond(command);
  }

  Future<WiFiScanResult> _executeWiFiScanCommand(WiFiScanCommand command) async {
    var result = await _wifiService.scan();
    return new WiFiScanResult(
      id: command.id,
      networks: result,
    );
  }

  Future<RpcResult> _executeWiFiAddCommand(WiFiAddCommand command) async {
    _wifiService.addNetwork(command.SSID, command.psk);
    return EmptyResult.respond(command);
  }

  Future<RpcResult> _executeWiFiSaveConfigCommand(WiFiSaveConfigCommand command) async {
    _wifiService.saveConfig();
    return EmptyResult.respond(command);
  }

  Future<RpcResult> _executeWiFiRemoveCommand(WiFiRemoveCommand command) async {
    _wifiService.removeNetwork(command.wifiId);
    return EmptyResult.respond(command);
  }

  Future<RpcResult> _executeWiFiGetStoredCommand(WiFiGetStoredCommand command) async {
    var result = await _wifiService.getStored();
    return WiFiGetStoredResult(
      id: command.id,
      networks: result,
    );
  }
}
