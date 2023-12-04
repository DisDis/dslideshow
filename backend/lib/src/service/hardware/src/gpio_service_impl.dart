import 'dart:async';

import 'package:dslideshow_backend/src/service/hardware/src/gpio_service.dart';
import 'package:dslideshow_backend/src/service/hardware/src/hardware_service_config.dart';
import 'package:flutter_gpiod/flutter_gpiod.dart';
import 'package:logging/logging.dart';

class GPIOServiceImpl extends GPIOService {
  static final Logger _log = new Logger('GPIOFlutterService');
  final HardwareConfig _config;
  FlutterGpiod get _gpio => FlutterGpiod.instance;
  late GpioChip _chip;
  late GpioLine _linePowerLED;
  late GpioLine _linePIR;
  late GpioLine _lineButton0;
  late GpioLine _lineButton1;
  late GpioLine _lineButton2;
  late GpioLine _lineButton3;

  // Default ON
  bool? _powerLEDStatus = true;
  final StreamController<bool> _scMotion = new StreamController.broadcast();
  Stream<bool> get onMotion => _scMotion.stream;

  final StreamController<bool> _scButton0 = new StreamController.broadcast();
  final StreamController<bool> _scButton3 = new StreamController.broadcast();
  final StreamController<bool> _scButton1 = new StreamController.broadcast();
  final StreamController<bool> _scButton2 = new StreamController.broadcast();

  @override
  //Pause
  Stream<bool> get onButton0 => _scButton0.stream;
  @override
  //Menu
  Stream<bool> get onButton1 => _scButton1.stream;
  @override
  //ScreenToggle
  Stream<bool> get onButton2 => _scButton2.stream;
  @override
  //Back
  Stream<bool> get onButton3 => _scButton3.stream;

  GPIOServiceImpl(this._config) {}

  void _status() async {
    _log.info('GPIO Status:');
    try {
      final chips = _gpio.chips;

      /// Print out all GPIO chips and all lines
      /// for all GPIO chips.
      for (var chip in chips) {
        _log.info('chip: "$chip"');

        var index = 0;
        for (var line in chip.lines) {
          final info = await line.info;
          if (info.consumer != null) {
            _log.info('$index:  ${info}');
          }
          index++;
        }
      }
    } catch (e, s) {
      _log.severe('GPIO error: ', e, s);
    }
  }

  DateTime _lastPIRTime = new DateTime.now();
  DateTime _lastPauseButtonTime = new DateTime.now();
  DateTime _lastMenuButtonTime = new DateTime.now();
  DateTime _lastScreenButtonTime = new DateTime.now();
  DateTime _lastBackButtonTime = new DateTime.now();
  Future init() async {
    _log.info('init...');
    try {
      /// Retrieve the list of GPIO chips.
      final chips = _gpio.chips;
      _log.info('chips - OK');
      // old kernel: pinctrl-bcm2835, new kernel: pinctrl-bcm2711
      _chip = chips.singleWhere((chip) => chip.label == 'pinctrl-bcm2711' || chip.label == 'pinctrl-bcm2835');
      _log.info('Found: ${_chip.label} - OK');
      _linePowerLED = _chip.lines[_config.pinPowerLED];
      _log.info('linePowerLED - OK');
      _linePIR = _chip.lines[_config.pinPIRSensor];
      _lineButton0 = _chip.lines[_config.pinButton0];
      _lineButton1 = _chip.lines[_config.pinButton1];
      _lineButton2 = _chip.lines[_config.pinButton2];
      _lineButton3 = _chip.lines[_config.pinButton3];

      _linePowerLED.requestOutput(consumer: "PowerLED", initialValue: true);

      _linePIR.requestInput(consumer: "PIR Sensor", triggers: {SignalEdge.falling, SignalEdge.rising});

      _lineButton0.requestInput(consumer: "Button0", triggers: {SignalEdge.falling, SignalEdge.rising});
      _lineButton1.requestInput(consumer: "Button1", triggers: {SignalEdge.falling, SignalEdge.rising});
      _lineButton2.requestInput(consumer: "Button2", triggers: {SignalEdge.falling, SignalEdge.rising});
      _lineButton3.requestInput(consumer: "Button3", triggers: {SignalEdge.falling, SignalEdge.rising});

      _linePIR.onEvent.listen((event) {
        if (DateTime.now().difference(_lastPIRTime).inSeconds > 1) {
          _log.info('PIR: $event');
          _lastPIRTime = DateTime.now();
          _scMotion.add(event.edge == SignalEdge.rising);
        }
      });

      _lineButton0.onEvent.listen((event) {
        if (DateTime.now().difference(_lastPauseButtonTime).inMilliseconds > _config.smoothingGPIOMs) {
          _log.info('PauseButton: $event');
          _lastPauseButtonTime = DateTime.now();
          _scButton0.add(event.edge == SignalEdge.falling);
        }
      });
      _lineButton3.onEvent.listen((event) {
        if (DateTime.now().difference(_lastBackButtonTime).inMilliseconds > _config.smoothingGPIOMs) {
          _log.info('BackButton: $event');
          _lastBackButtonTime = DateTime.now();
          _scButton3.add(event.edge == SignalEdge.falling);
        }
      });
      _lineButton1.onEvent.listen((event) {
        if (DateTime.now().difference(_lastMenuButtonTime).inMilliseconds > _config.smoothingGPIOMs) {
          _log.info('MenuButton: $event');
          _lastMenuButtonTime = DateTime.now();
          _scButton1.add(event.edge == SignalEdge.falling);
        }
      });
      _lineButton2.onEvent.listen((event) {
        if (DateTime.now().difference(_lastScreenButtonTime).inMilliseconds > _config.smoothingGPIOMs) {
          _log.info('ScreenToggleButton: $event');
          _lastScreenButtonTime = DateTime.now();
          _scButton2.add(event.edge == SignalEdge.falling);
        }
      });
      _log.info('initialization completed');
    } catch (e, s) {
      _log.severe('initialization error: ', e, s);
    }
    _status();
  }

  Future release() async {
    _linePowerLED.release();
    _linePIR.release();
    _lineButton0.release();
    _lineButton3.release();
    _lineButton1.release();
    _lineButton2.release();
  }

  set powerLED(bool? value) {
    if (_powerLEDStatus == value) {
      return;
    }
    _powerLEDStatus = value;
    _linePowerLED.setValue(value!);
  }
}
