import 'dart:async';
import 'dart:io';

import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_backend/src/command/echo.dart';
import 'package:dslideshow_backend/src/command/empty_result.dart';
import 'package:dslideshow_backend/src/command/hardware_commands.dart';
import 'package:dslideshow_backend/src/command/screen_commands.dart';
import 'package:dslideshow_backend/src/command/storage_commands.dart';
import 'package:dslideshow_backend/src/service/hardware/src/screen_service.dart';
import 'package:dslideshow_backend/src/service/mqtt/mqtt_service.dart';
import 'package:dslideshow_backend/src/service/storage/storage.dart';
import 'package:dslideshow_backend/src/service/system_info/system_info_service.dart';
import 'package:dslideshow_common/rpc.dart';
import 'package:logging/logging.dart';

import 'gpio_service.dart';

class HardwareService implements RpcService{
  static final Logger _log = new Logger('HardwareService');

  final SystemInfoService _systemInfoService;
  final RemoteService _frontendService;
  final RemoteService _webServer;
  final Storage _storage;

  final GPIOService _gpioService;
  final ScreenService _screenService;
  final MqttService _mqttService;

  HardwareService(AppConfig config, this._frontendService, this._storage, this._gpioService, this._screenService, this._systemInfoService, this._webServer, this._mqttService){
    _init();
  }

  final List<Future> _initFutures = <Future>[];
  void _init() {
    _initFutures.add( _storage.init());
    if (Platform.isLinux) {
      _initFutures.add(_gpioService.init());
    } else {
      _log.warning('GPIO does not support except Linux');
    }
    _gpioService.onMenu.listen((event) {
      _log.info('onMenu button = $event');
      if (event) _pushButton(ButtonType.menu);
    });
    _gpioService.onScreenToggle.listen((event) {
      _log.info('onScreenToggle button = $event');
      if (event) _pushButton(ButtonType.screentoggle);
    });
    _gpioService.onPause.listen((event) {
      _log.info('onPause button = $event');
      if (event) _pushButton(ButtonType.pause);
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
      _pushButton(ButtonType.pause);
    });
    _mqttService.onScreenToggle.listen((event) {
      _pushButton(ButtonType.screentoggle);
    });
    _mqttService.onMenu.listen((event) {
      _pushButton(ButtonType.menu);
    });
    _initFutures.add(_systemInfoService.init());
  }

  void screenConfigure(bool enabled){
    _frontendService.send(new ScreenTurnCommand((b) =>
    b
      ..id = RpcCommand.generateId()
      ..enabled = enabled));
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
//    _log.info("Execute command [${command.hashCode}]${command.id}:${command.type}");
    Stopwatch work = new Stopwatch()
      ..reset()
      ..start();
    return _executeCommand(command).whenComplete((){
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
      case EchoCommand.TYPE:
        return new Future.value(_executeEchoCommand(command as EchoCommand));
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
    return new EmptyResult((b) {
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

  Future<RpcResult> _executeGetSystemInfoCommand(GetSystemInfoCommand command) async{
    final info = await _systemInfoService.getFullInfo();
    return new GetSystemInfoCommandResult((b) {
      b.id = command.id;
      b.systemInfo = info.toBuilder();
      return b;
    });
  }

  Future<RpcResult> _pushButton(ButtonType type) async{
    return _frontendService.send(new PushButtonCommand((b) =>
    b
      ..id = RpcCommand.generateId()
      ..button = type));
  }

  Future<RpcResult> _executeLEDControlCommand(LEDControlCommand command) async {
    if (command.led == LEDType.power) {
      _gpioService.powerLED = command.value;
    }
    return new EmptyResult((b) {
      b.id = command.id;
      return b;
    });
  }

  Future<RpcResult> _executeScreenLockCommand(ScreenLockCommand command) async{
    _screenService.isScreenOffLock = command.isLock;
    return new EmptyResult((b) {
      b.id = command.id;
      return b;
    });
  }

  Future<RpcResult> _executeScreenTurnCommand(ScreenTurnCommand command) async{
    if (command.enabled){
      _screenService.screenOn();
    } else {
      _screenService.screenOff();
    }
    return new EmptyResult((b) {
      b.id = command.id;
      return b;
    });
  }

  Future<RpcResult> _executeWebServerControlCommand(WebServerControlCommand command) async{
    return _webServer.send(command);
  }

  Future<RpcResult> _executeAreYouReadyCommand(AreYouReadyCommand command) async{
    if (_initFutures.isNotEmpty) {
      await Future.wait<dynamic>(_initFutures);
      _initFutures.clear();
    }
    return new EmptyResult((b) {
      b.id = command.id;
      return b;
    });
  }

  Future<RpcResult> _executePushButtonCommand(PushButtonCommand command) async{
    //Emulate
    _pushButton(command.button);
    return new EmptyResult((b) {
      b.id = command.id;
      return b;
    });
  }
}