import 'dart:async';

import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_backend/src/service/hardware/src/gpio_service.dart';
import 'package:dslideshow_backend/src/service/hardware/src/hardware_service_config.dart';
import 'package:flutter_gpiod/flutter_gpiod.dart';
import 'package:logging/logging.dart';

import 'presence_filter.dart';

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

  final _subscriptions = <StreamSubscription<dynamic>>[];
  final _requestedLines = <GpioLine>[];
  PresenceFilter? _presenceFilter;
  Timer? _initialSample;
  bool _initialized = false;
  bool _released = false;
  Future<void>? _releaseFuture;

  GPIOServiceImpl(this._config);

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

  Future<void> init() async {
    if (_released) throw StateError('GPIO service has been released');
    if (_initialized) return;
    _initialized = true;
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
      _requestedLines.add(_linePowerLED);

      _linePeopleSensor.requestInput(
        consumer: "People Sensor",
        bias: Bias.disable,
        activeState: ActiveState.high,
        triggers: {SignalEdge.falling, SignalEdge.rising},
      );
      _requestedLines.add(_linePeopleSensor);

      _lineButton0.requestInput(
        consumer: "Button0",
        bias: Bias.pullUp,
        activeState: ActiveState.low,
        triggers: {SignalEdge.falling, SignalEdge.rising},
      );
      _requestedLines.add(_lineButton0);
      _lineButton1.requestInput(
        consumer: "Button1",
        bias: Bias.pullUp,
        activeState: ActiveState.low,
        triggers: {SignalEdge.falling, SignalEdge.rising},
      );
      _requestedLines.add(_lineButton1);
      _lineButton2.requestInput(
        consumer: "Button2",
        bias: Bias.pullUp,
        activeState: ActiveState.low,
        triggers: {SignalEdge.falling, SignalEdge.rising},
      );
      _requestedLines.add(_lineButton2);
      _lineButton3.requestInput(
        consumer: "Button3",
        bias: Bias.pullUp,
        activeState: ActiveState.low,
        triggers: {SignalEdge.falling, SignalEdge.rising},
      );
      _requestedLines.add(_lineButton3);

      _presenceFilter = PresenceFilter(
        absenceDelay: Duration(milliseconds: _config.smoothingGPIOMs),
        readLevel: _linePeopleSensor.getValue,
        onChanged: _scMotion.add,
      );
      _subscriptions.add(
        _linePeopleSensor.onEvent.listen((event) {
          _log.info('People Sensor: $event');
          _presenceFilter!.onLevel(event.edge == SignalEdge.rising);
        }),
      );
      _initialSample = Timer(const Duration(milliseconds: 200), () {
        _initialSample = null;
        _presenceFilter!.sample();
      });

      final button0Filter = InputLineFilter(
        button: ButtonType.button0,
        skipNoiseMs: _config.smoothingGPIOMs,
        maxDetectTimeMs: maxButtonDetectTimeMs,
        scButtonEvent: _scButtonEvent,
      );
      final button1Filter = InputLineFilter(
        button: ButtonType.button1,
        skipNoiseMs: _config.smoothingGPIOMs,
        maxDetectTimeMs: maxButtonDetectTimeMs,
        scButtonEvent: _scButtonEvent,
      );
      final button2Filter = InputLineFilter(
        button: ButtonType.button2,
        skipNoiseMs: _config.smoothingGPIOMs,
        maxDetectTimeMs: maxButtonDetectTimeMs,
        scButtonEvent: _scButtonEvent,
      );
      final button3Filter = InputLineFilter(
        button: ButtonType.button3,
        skipNoiseMs: _config.smoothingGPIOMs,
        maxDetectTimeMs: maxButtonDetectTimeMs,
        scButtonEvent: _scButtonEvent,
      );
      _subscriptions.add(_lineButton0.onEvent.listen(button0Filter.execute));
      _subscriptions.add(_lineButton1.onEvent.listen(button1Filter.execute));
      _subscriptions.add(_lineButton2.onEvent.listen(button2Filter.execute));
      _subscriptions.add(_lineButton3.onEvent.listen(button3Filter.execute));

      _log.info('initialization completed');
    } catch (e, s) {
      _log.severe('initialization error: ', e, s);
    }
    _status();
  }

  Future<void> release() => _releaseFuture ??= _release();

  Future<void> _release() async {
    _released = true;
    _initialSample?.cancel();
    _presenceFilter?.dispose();
    await Future.wait(
      _subscriptions.map((subscription) => subscription.cancel()),
    );
    for (final line in _requestedLines.reversed) {
      try {
        line.release();
      } catch (error, stack) {
        _log.warning('GPIO release failed', error, stack);
      }
    }
    _requestedLines.clear();
    await _scMotion.close();
    await _scButtonEvent.close();
  }

  set powerLED(bool? value) {
    if (_released ||
        !_initialized ||
        _requestedLines.isEmpty ||
        _powerLEDStatus == value) {
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

  void execute(SignalEvent eventI) {
    final deltaMs = DateTime.now().difference(_lastEdgeRise).inMilliseconds;
    _log.log(
      Level.FINEST,
      "${button}, event:${eventI}, deltaMs:${deltaMs}, skipNoiseMs: ${skipNoiseMs}, maxDetectTimeMs: ${maxDetectTimeMs}",
    );
    // H->L (Button down)
    if (eventI.edge == SignalEdge.rising) {
      if (deltaMs > maxDetectTimeMs) {
        _lastEdgeRise = DateTime.now();
        scButtonEvent.add(
          ButtonEvent(
            button: button,
            event: ButtonEventType.pressed,
            durationMs: 0,
          ),
        );
        _log.info('button${button.index}: $eventI');
      } else if (deltaMs < skipNoiseMs) {
        return;
      }
    } else if (eventI.edge == SignalEdge.falling) {
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
      _log.info('button${button.index}: $eventI');
    }
  }
}
