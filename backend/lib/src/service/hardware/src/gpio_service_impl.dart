import 'dart:async';

import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_backend/src/service/hardware/src/gpio_service.dart';
import 'package:dslideshow_backend/src/service/hardware/src/hardware_service_config.dart';
import 'package:flutter_gpiod/flutter_gpiod.dart';
import 'package:logging/logging.dart';

class GPIOServiceImpl extends GPIOService {
  static final int maxButtonDetectTimeMs = 5000;
  static final Logger _log = new Logger('GPIOFlutterService');
  final HardwareConfig _config;
  FlutterGpiod get _gpio => FlutterGpiod.instance;
  late GpioChip _chip;
  late GpioLine _linePowerLED;
  late GpioLine _linePeopleSensor;
  late GpioLine _lineButton0;
  late GpioLine _lineButton1;
  late GpioLine _lineButton2;
  late GpioLine _lineButton3;

  // Default ON
  bool? _powerLEDStatus = true;
  final StreamController<bool> _scMotion = new StreamController.broadcast();
  Stream<bool> get onMotion => _scMotion.stream;

  final StreamController<ButtonEvent> _scButtonEvent =
      new StreamController.broadcast();

  

  Stream<ButtonEvent> get onButtonEvent => _scButtonEvent.stream;

  GPIOServiceImpl(this._config) {}

  void _status() async {
    _log.info('GPIO Status:');
    try {
      final chips = _gpio.chips;

      /// Print out all GPIO chips and all lines
      /// for all GPIO chips.
      chips.forEach((indexC, chip) {
        _log.info('chip: $indexC - "$chip"');

        var index = 0;
        for (var line in chip.lines) {
          final info = line.info;
          if (info.consumer != null) {
            _log.info('$index:  ${info}');
          }
          index++;
        }
      });
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
      // old kernel: pinctrl-bcm2835, new kernel: pinctrl-bcm2711 , Pi5: pinctrl-rp1
      GpioChip? chipS;
      chips.forEach((indexC, chip) {
        if (chip.label == 'pinctrl-rp1' ||
            chip.label == 'pinctrl-bcm2711' ||
            chip.label == 'pinctrl-bcm2835') {
          chipS = chip;
        }
        _log.info('chip: $indexC - "${chip.label}"');
      });
      if (chipS != null) {
        _chip = chipS!;
      } else {
        _log.severe('Not found chip');
        return;
      }
      _log.info('Found: ${_chip.label} - OK');
      _linePowerLED = _chip.lines[_config.pinPowerLED];
      _log.info('linePowerLED - OK');
      _linePeopleSensor = _chip.lines[_config.pinPeopleSensor];
      _lineButton0 = _chip.lines[_config.pinButton0];
      _lineButton1 = _chip.lines[_config.pinButton1];
      _lineButton2 = _chip.lines[_config.pinButton2];
      _lineButton3 = _chip.lines[_config.pinButton3];

      _linePowerLED.requestOutput(consumer: "PowerLED", initialValue: true);

      _linePeopleSensor.requestInput(
        consumer: "People Sensor",
        bias: Bias.disable,
        activeState: ActiveState.high,
        triggers: {SignalEdge.falling, SignalEdge.rising},
      );

      _lineButton0.requestInput(
        consumer: "Button0",
        bias: Bias.pullUp,
        activeState: ActiveState.low,
        triggers: {SignalEdge.falling, SignalEdge.rising},
      );
      _lineButton1.requestInput(
        consumer: "Button1",
        bias: Bias.pullUp,
        activeState: ActiveState.low,
        triggers: {SignalEdge.falling, SignalEdge.rising},
      );
      _lineButton2.requestInput(
        consumer: "Button2",
        bias: Bias.pullUp,
        activeState: ActiveState.low,
        triggers: {SignalEdge.falling, SignalEdge.rising},
      );
      _lineButton3.requestInput(
        consumer: "Button3",
        bias: Bias.pullUp,
        activeState: ActiveState.low,
        triggers: {SignalEdge.falling, SignalEdge.rising},
      );

      _linePeopleSensor.onEvent.listen((event) {
        if (DateTime.now().difference(_lastPIRTime).inSeconds > 1) {
          _log.info('People Sensor: $event');
          _lastPIRTime = DateTime.now();
          _scMotion.add(event.edge == SignalEdge.rising);
        }
      });
      Future.delayed(
        Duration(milliseconds: 200),
      ).then((_) => _scMotion.add(_linePeopleSensor.getValue()));

      _lineButton0.onEvent.listen(
        (event) => InputLineFilter(
          button: ButtonType.button0,
          skipNoiseMs: _config.smoothingGPIOMs,
          maxDetectTimeMs: maxButtonDetectTimeMs,
          scButtonEvent: _scButtonEvent,
        ).execute,
      );
      _lineButton1.onEvent.listen(
        (event) => InputLineFilter(
          button: ButtonType.button1,
          skipNoiseMs: _config.smoothingGPIOMs,
          maxDetectTimeMs: maxButtonDetectTimeMs,
          scButtonEvent: _scButtonEvent,
        ).execute,
      );
      _lineButton2.onEvent.listen(
        (event) => InputLineFilter(
          button: ButtonType.button2,
          skipNoiseMs: _config.smoothingGPIOMs,
          maxDetectTimeMs: maxButtonDetectTimeMs,
          scButtonEvent: _scButtonEvent,
        ).execute,
      );
      _lineButton3.onEvent.listen(
        (event) => InputLineFilter(
          button: ButtonType.button3,
          skipNoiseMs: _config.smoothingGPIOMs,
          maxDetectTimeMs: maxButtonDetectTimeMs,
          scButtonEvent: _scButtonEvent,
        ).execute,
      );

      _log.info('initialization completed');
    } catch (e, s) {
      _log.severe('initialization error: ', e, s);
    }
    _status();
  }

  Future release() async {
    _linePowerLED.release();
    _linePeopleSensor.release();
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

class InputLineFilter {
  static final Logger _log = new Logger('InputLineFilter');

  // When L -> H, we want to filter out noise
  final int skipNoiseMs;
  // When H -> L, we want to filter out
  final int maxDetectTimeMs;
  final ButtonType button;
  final StreamController<ButtonEvent> scButtonEvent;
  DateTime _lastEdgeRise = DateTime.now();

  InputLineFilter({
    required this.button,
    required this.skipNoiseMs,
    required this.maxDetectTimeMs,
    required this.scButtonEvent,
  });

  void execute(SignalEdge event) {
    final deltaMs = DateTime.now().difference(_lastEdgeRise).inMilliseconds;
    // H->L (Button down)
    if (event == SignalEdge.falling) {
      if (deltaMs > maxDetectTimeMs) {
        _lastEdgeRise = DateTime.now();
        scButtonEvent.add(
          ButtonEvent(
            button: button,
            event: ButtonEventType.pressed,
            durationMs: 0,
          ),
        );
        _log.info('button${button.index}: $event');
      } else if (deltaMs < skipNoiseMs) {
        return;
      }
    } else if (event == SignalEdge.rising) {
      if (deltaMs < skipNoiseMs) {
        return;
      }
      if (deltaMs > maxDetectTimeMs) {
        return;
      }
      scButtonEvent.add(
        ButtonEvent(
          button: button,
          event: ButtonEventType.released,
          durationMs: deltaMs,
        ),
      );
      _lastEdgeRise = DateTime.fromMillisecondsSinceEpoch(0);
      _log.info('button${button.index}: $event');
    }
  }
}
