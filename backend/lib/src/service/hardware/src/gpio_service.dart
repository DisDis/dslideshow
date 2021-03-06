import 'dart:async';

import 'package:dslideshow_backend/src/service/hardware/src/hardware_service_config.dart';
import 'package:gpiod/proxy_gpiod.dart';
import 'package:logging/logging.dart';

// TODO: Unable to call a platform channel method from another isolate  https://github.com/flutter/flutter/issues/13937

abstract class GPIOService{
  Stream<bool> get onBack;
  Stream<bool> get onMotion;
  Stream<bool> get onPause;
  Stream<bool> get onMenu;
  Stream<bool> get onScreenToggle;
  Future init();
  Future release();
  set powerLED(bool? value);
}

class GPIOServiceImpl extends GPIOService{
  static final Logger _log = new Logger('GPIOFlutterService');
  final HardwareConfig _config;
  static final ProxyGpiod _gpio = ProxyGpiod.getInstance();
  late GpioChip _chip;
  late GpioLine _linePowerLED;
  late GpioLine _linePIR;
  late GpioLine _linePauseButton;
  late GpioLine _lineBackButton;
  late GpioLine _lineMenuButton;
  late GpioLine _lineScreenToggleButton;
  // Default ON
  bool? _powerLEDStatus = true;
  final StreamController<bool> _scMotion = new StreamController.broadcast();
  Stream<bool> get onMotion =>_scMotion.stream;

  final StreamController<bool> _scPause = new StreamController.broadcast();
  Stream<bool> get onPause =>_scPause.stream;

  final StreamController<bool> _scBack = new StreamController.broadcast();
  Stream<bool> get onBack =>_scBack.stream;

  final StreamController<bool> _scMenu = new StreamController.broadcast();
  Stream<bool> get onMenu =>_scMenu.stream;

  final StreamController<bool> _scScreenToggle = new StreamController.broadcast();
  Stream<bool> get onScreenToggle =>_scScreenToggle.stream;

  GPIOServiceImpl(this._config){
  }

  void _status() async{
    _log.info('GPIO Status:');
    final chips = _gpio.chips;
    /// Print out all GPIO chips and all lines
    /// for all GPIO chips.
    for (var chip in chips) {
      _log.info('chip: "$chip"');

      var index = 0;
      for (var line in chip.lines) {
        final info = await line.info;
        if (info.consumer!=null) {
          _log.info('$index:  ${info}');
        }
        index++;
      }
    }
  }

  DateTime _lastPIRTime = new DateTime.now();
  DateTime _lastPauseButtonTime = new DateTime.now();
  DateTime _lastMenuButtonTime = new DateTime.now();
  DateTime _lastScreenButtonTime = new DateTime.now();
  DateTime _lastBackButtonTime = new DateTime.now();
  Future init() async{
    _log.info('init...');
    try {
      /// Retrieve the list of GPIO chips.
      final chips = _gpio.chips;
      _log.info('chips - OK');
      _chip = chips.singleWhere((chip) => chip.label == 'pinctrl-bcm2835');
      _log.info('pinctrl-bcm2835 - OK');
      _linePowerLED = _chip.lines[_config.pinPowerLED];
      _log.info('linePowerLED - OK');
      _linePIR = _chip.lines[_config.pinPIRSensor];
      _linePauseButton = _chip.lines[_config.pinPauseButton];
      _lineBackButton = _chip.lines[_config.pinBackButton];
      _lineMenuButton = _chip.lines[_config.pinMenuButton];
      _lineScreenToggleButton = _chip.lines[_config.pinScreenToggleButton];

      _linePowerLED.requestOutput(
          consumer: "PowerLED", initialValue: true);

      _linePIR.requestInput(
          consumer: "PIR Sensor",
          triggers: {SignalEdge.falling, SignalEdge.rising});

      _linePauseButton.requestInput(
          consumer: "PauseButton",
          triggers: {SignalEdge.falling, SignalEdge.rising});
      _lineBackButton.requestInput(
          consumer: "BackButton",
          triggers: {SignalEdge.falling, SignalEdge.rising});
      _lineMenuButton.requestInput(
          consumer: "MenuButton",
          triggers: {SignalEdge.falling, SignalEdge.rising});
      _lineScreenToggleButton.requestInput(
          consumer: "ScreenToggleButton",
          triggers: {SignalEdge.falling, SignalEdge.rising});


      _linePIR.onEvent.listen((event) {
        if (DateTime.now().difference(_lastPIRTime).inSeconds > 1) {
          _log.info('PIR: $event');
          _lastPIRTime = DateTime.now();
          _scMotion.add(event.edge == SignalEdge.rising);
        }
      });

      _linePauseButton.onEvent.listen((event) {
        if (DateTime.now().difference(_lastPauseButtonTime).inMilliseconds > _config.smoothingGPIOMs) {
          _log.info('PauseButton: $event');
          _lastPauseButtonTime = DateTime.now();
          _scPause.add(event.edge == SignalEdge.falling);
        }
      });
      _lineBackButton.onEvent.listen((event) {
        if (DateTime.now().difference(_lastBackButtonTime).inMilliseconds > _config.smoothingGPIOMs) {
          _log.info('BackButton: $event');
          _lastBackButtonTime = DateTime.now();
          _scBack.add(event.edge == SignalEdge.falling);
        }
      });
      _lineMenuButton.onEvent.listen((event) {
        if (DateTime.now().difference(_lastMenuButtonTime).inMilliseconds > _config.smoothingGPIOMs) {
          _log.info('MenuButton: $event');
          _lastMenuButtonTime = DateTime.now();
          _scMenu.add(event.edge == SignalEdge.falling);
        }
      });
      _lineScreenToggleButton.onEvent.listen((event) {
        if (DateTime.now().difference(_lastScreenButtonTime).inMilliseconds > _config.smoothingGPIOMs) {
          _log.info('ScreenToggleButton: $event');
          _lastScreenButtonTime = DateTime.now();
          _scScreenToggle.add(event.edge == SignalEdge.falling);
        }
      });
      _log.info('initialization completed');
    } catch (e, s) {
      _log.severe('initialization error: ', e, s);
    }
    _status();
  }

  Future release() async{
    _linePowerLED.release();
    _linePIR.release();
    _linePauseButton.release();
    _lineBackButton.release();
    _lineMenuButton.release();
    _lineScreenToggleButton.release();
  }



  set powerLED(bool? value){
    if (_powerLEDStatus == value){
      return;
    }
    _powerLEDStatus = value;
    _linePowerLED.setValue(value!);
  }
}
