import 'dart:async';

import 'package:dslideshow_backend/src/service/hardware/src/hardware_service_config.dart';
import 'package:flutter_gpiod/flutter_gpiod.dart';

class GPIOService{
  final HardwareConfig _config;
  FlutterGpiod _gpio;
  GpioChip _chip;
  GpioLine _linePowerLED;
  GpioLine _linePIR;
  GpioLine _linePauseButton;
  GpioLine _lineMenuButton;
  GpioLine _lineScreenToggleButton;
  // Default ON
  bool _powerLEDStatus = true;
  final StreamController<bool> _scMotion = new StreamController.broadcast();
  Stream<bool> get onMotion =>_scMotion.stream;

  final StreamController<bool> _scPause = new StreamController.broadcast();
  Stream<bool> get onPause =>_scPause.stream;

  final StreamController<bool> _scMenu = new StreamController.broadcast();
  Stream<bool> get onMenu =>_scMenu.stream;

  final StreamController<bool> _scScreenToggle = new StreamController.broadcast();
  Stream<bool> get onScreenToggle =>_scScreenToggle.stream;

  GPIOService(this._config){
  }

  Future init() async
  {
    _gpio = await FlutterGpiod.getInstance();
    /// Retrieve the list of GPIO chips.
    final chips = _gpio.chips;
    _chip = chips.singleWhere((chip) => chip.label == 'pinctrl-bcm2835');
    _linePowerLED = _chip.lines[_config.pinPowerLED];
    _linePIR = _chip.lines[_config.pinPIRSensor];
    _linePauseButton = _chip.lines[_config.pinPauseButton];
    _lineMenuButton = _chip.lines[_config.pinMenuButton];
    _lineScreenToggleButton = _chip.lines[_config.pinScreenToggleButton];

    await _linePowerLED.requestOutput(
        consumer: "PowerLED", initialValue: true);

    await _linePIR.requestInput(
        consumer: "PIR Sensor",
        triggers: {SignalEdge.falling, SignalEdge.rising});

    await _linePauseButton.requestInput(
        consumer: "PauseButton",
        triggers: {SignalEdge.falling, SignalEdge.rising});
    await _lineMenuButton.requestInput(
        consumer: "MenuButton",
        triggers: {SignalEdge.falling, SignalEdge.rising});
    await _lineScreenToggleButton.requestInput(
        consumer: "ScreenToggleButton",
        triggers: {SignalEdge.falling, SignalEdge.rising});


    _linePIR.onEvent.listen((event) {
      _scMotion.add(event.edge == SignalEdge.falling);
    });

    _linePauseButton.onEvent.listen((event) {
      _scPause.add(event.edge == SignalEdge.falling);
    });
    _lineMenuButton.onEvent.listen((event) {
      _scMenu.add(event.edge == SignalEdge.falling);
    });
    _lineScreenToggleButton.onEvent.listen((event) {
      _scScreenToggle.add(event.edge == SignalEdge.falling);
    });
  }

  Future release() async{
    await _linePowerLED.release();
    await _linePIR.release();
    await _linePauseButton.release();
    await _lineMenuButton.release();
    await _lineScreenToggleButton.release();
  }



  set powerLED(bool value){
    if (_powerLEDStatus == value){
      return;
    }
    _powerLEDStatus = value;
    _linePowerLED.setValue(value);
  }
}