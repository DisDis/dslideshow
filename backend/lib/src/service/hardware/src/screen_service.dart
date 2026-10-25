import 'dart:async';

import 'package:logging/logging.dart';

import 'hardware_service_config.dart';
import 'screen_power.dart';

enum ScreenPhase {
  on,
  waitingOff,
  fadingOut,
  poweringOff,
  off,
  wakingUp,
  fadingIn,
  failed,
  disposed,
}

enum ScreenTransitionResult { applied, cancelled, failed }

class ScreenService {
  static const Duration wakeUpDelay = Duration(milliseconds: 500);
  static final _log = Logger('ScreenService');
  final HardwareConfig _config;
  final ScreenPower _power;
  final Duration _fadeDuration;
  final _stateChangePreparation = StreamController<bool>.broadcast();

  ScreenService(
    this._config, {
    ScreenPower? power,
    Duration preparationOffTime = const Duration(milliseconds: 2000),
  }) : _power = power ?? SystemScreenPower(_config),
       _fadeDuration = preparationOffTime;

  Stream<bool> get onStateChangePreparation => _stateChangePreparation.stream;
  bool get isScreenOn => _confirmedPower == true;
  ScreenPhase get phase => _phase;
  ScreenPhase _phase = ScreenPhase.on;
  bool? _confirmedPower = true;
  bool _desiredOn = true;
  bool _visible = true;
  bool _powerBusy = false;
  bool _disposed = false;
  bool _isScreenOffLock = false;
  int _generation = 0;
  Timer? _timerScreenOff;
  Timer? _fadeOutTimer;
  Timer? _wakeUpTimer;
  Completer<void>? _wakeUpCompletion;
  Timer? _fadeInTimer;
  Completer<void>? _fadeInCompletion;
  Completer<ScreenTransitionResult>? _transition;
  Future<void> _powerQueue = Future.value();
  Future<void>? _disposeFuture;

  bool get isScreenOffLock => _isScreenOffLock;
  set isScreenOffLock(bool value) {
    if (_disposed || value == _isScreenOffLock) return;
    _isScreenOffLock = value;
    // Locking takes effect before the separate ScreenTurnCommand can arrive,
    // including when a wake command is already in flight.
    if (value) unawaited(screenOff());
  }

  Future<ScreenTransitionResult> screenOn() {
    if (_disposed || _isScreenOffLock) {
      return Future.value(ScreenTransitionResult.cancelled);
    }
    if (_desiredOn && _phase != ScreenPhase.failed) {
      return _transition?.future ??
          Future.value(ScreenTransitionResult.applied);
    }
    final completion = _beginTransition(true);
    final generation = _generation;
    if (_confirmedPower == true && !_powerBusy) {
      _waitForDisplay(generation, completion);
    } else {
      _phase = ScreenPhase.wakingUp;
      _enqueuePower(true, generation, completion);
    }
    return completion.future;
  }

  void scheduleScreenOff() {
    if (_disposed || _isScreenOffLock || !_desiredOn) return;
    final completion = _beginTransition(false);
    final generation = _generation;
    _phase = ScreenPhase.waitingOff;
    _timerScreenOff = Timer(
      Duration(seconds: _config.screenPowerOnTimerSec),
      () {
        if (!_isCurrent(generation)) return;
        _timerScreenOff = null;
        _startFadeOut(generation, completion);
      },
    );
  }

  Future<ScreenTransitionResult> screenOff() {
    if (_disposed) return Future.value(ScreenTransitionResult.cancelled);
    if (!_desiredOn &&
        _phase != ScreenPhase.waitingOff &&
        _phase != ScreenPhase.failed) {
      return _transition?.future ??
          Future.value(ScreenTransitionResult.applied);
    }
    final completion = _beginTransition(false);
    _startFadeOut(_generation, completion);
    return completion.future;
  }

  Completer<ScreenTransitionResult> _beginTransition(bool enabled) {
    _generation++;
    _timerScreenOff?.cancel();
    _timerScreenOff = null;
    _fadeOutTimer?.cancel();
    _fadeOutTimer = null;
    final previous = _transition;
    if (previous != null) _complete(previous, ScreenTransitionResult.cancelled);
    _desiredOn = enabled;
    final completion = Completer<ScreenTransitionResult>();
    _transition = completion;
    _log.info('Screen transition $_generation: ${enabled ? "ON" : "OFF"}');
    return completion;
  }

  bool _isCurrent(int generation) => !_disposed && generation == _generation;

  void _startFadeOut(
    int generation,
    Completer<ScreenTransitionResult> completion,
  ) {
    if (!_isCurrent(generation)) return;
    _cancelFadeIn();
    _phase = ScreenPhase.fadingOut;
    _publish(false);
    _fadeOutTimer = Timer(_fadeDuration, () {
      if (!_isCurrent(generation) || _desiredOn) return;
      _fadeOutTimer = null;
      _phase = ScreenPhase.poweringOff;
      _enqueuePower(false, generation, completion);
    });
  }

  void _startFadeIn(
    int generation,
    Completer<ScreenTransitionResult> completion,
  ) {
    if (!_isCurrent(generation)) return;
    if (!_visible) {
      final animation = Completer<void>();
      _fadeInCompletion = animation;
      _fadeInTimer = Timer(_fadeDuration, () {
        if (!identical(_fadeInCompletion, animation)) return;
        _fadeInTimer = null;
        _fadeInCompletion = null;
        animation.complete();
      });
    }
    final animation = _fadeInCompletion;
    if (animation == null) {
      // Cancelling only the absence timeout needs no visual transition.
      _phase = ScreenPhase.on;
      _complete(completion, ScreenTransitionResult.applied);
      return;
    }
    _phase = ScreenPhase.fadingIn;
    _log.info('Screen transition $generation: ${ScreenPhase.fadingIn.name}');
    // Reverse immediately. A new grace period does not reverse the overlay, so
    // presence returning during it must reuse this reveal, not restart it.
    _publish(true);
    unawaited(
      animation.future.then((_) {
        if (!_isCurrent(generation) || !_desiredOn) return;
        _phase = ScreenPhase.on;
        _complete(completion, ScreenTransitionResult.applied);
      }),
    );
  }

  void _waitForDisplay(
    int generation,
    Completer<ScreenTransitionResult> completion,
  ) {
    if (!_isCurrent(generation)) return;
    final ready = _wakeUpCompletion;
    if (ready == null) {
      _startFadeIn(generation, completion);
      return;
    }
    _phase = ScreenPhase.wakingUp;
    unawaited(
      ready.future.then((_) {
        if (!_isCurrent(generation) || !_desiredOn) return;
        _startFadeIn(generation, completion);
      }),
    );
  }

  void _startWakeUpDelay() {
    _cancelWakeUpDelay();
    if (_disposed) return;
    final ready = Completer<void>();
    _wakeUpCompletion = ready;
    // Keep black until the physical display has had time to wake. This deadline
    // belongs to the successful hardware ON, so new intentions cannot skip it.
    _wakeUpTimer = Timer(wakeUpDelay, () {
      if (!identical(_wakeUpCompletion, ready)) return;
      _wakeUpTimer = null;
      _wakeUpCompletion = null;
      ready.complete();
    });
  }

  void _cancelWakeUpDelay() {
    _wakeUpTimer?.cancel();
    _wakeUpTimer = null;
    final ready = _wakeUpCompletion;
    _wakeUpCompletion = null;
    if (ready != null && !ready.isCompleted) ready.complete();
  }

  void _cancelFadeIn() {
    _fadeInTimer?.cancel();
    _fadeInTimer = null;
    final animation = _fadeInCompletion;
    _fadeInCompletion = null;
    if (animation != null && !animation.isCompleted) animation.complete();
  }

  void _enqueuePower(
    bool enabled,
    int generation,
    Completer<ScreenTransitionResult> completion,
  ) {
    // Only hardware work is queued. New intentions and fade cancellation remain
    // synchronous, so they never wait behind a modeset or a script.
    _powerQueue = _powerQueue.then((_) async {
      if (!_isCurrent(generation)) {
        _complete(completion, ScreenTransitionResult.cancelled);
        return;
      }
      try {
        if (_confirmedPower != enabled) {
          _powerBusy = true;
          if (!enabled) _cancelWakeUpDelay();
          _log.info('Screen hardware $generation: ${enabled ? "ON" : "OFF"}');
          await _power.setPower(enabled);
          // Record the actual effect even if the request became stale. The next
          // queued request must reconcile this effect with the latest intention.
          _confirmedPower = enabled;
          if (enabled) _startWakeUpDelay();
        }
        if (_isCurrent(generation)) {
          if (enabled) {
            _waitForDisplay(generation, completion);
          } else {
            _phase = ScreenPhase.off;
            _publish(false);
            _complete(completion, ScreenTransitionResult.applied);
          }
        } else {
          _complete(completion, ScreenTransitionResult.cancelled);
        }
      } catch (error, stack) {
        // A partial script/modeset may have changed power.
        _confirmedPower = null;
        _log.severe('Screen hardware $generation failed', error, stack);
        if (_isCurrent(generation)) {
          _phase = ScreenPhase.failed;
          _complete(completion, ScreenTransitionResult.failed);
        } else {
          _complete(completion, ScreenTransitionResult.cancelled);
        }
      } finally {
        _powerBusy = false;
      }
    });
  }

  void _publish(bool enabled) {
    if (_disposed || _visible == enabled) return;
    _visible = enabled;
    _stateChangePreparation.add(enabled);
  }

  void _complete(
    Completer<ScreenTransitionResult> completion,
    ScreenTransitionResult result,
  ) {
    if (!completion.isCompleted) completion.complete(result);
    if (identical(_transition, completion)) _transition = null;
  }

  Future<void> dispose() => _disposeFuture ??= _dispose();

  Future<void> _dispose() async {
    _disposed = true;
    _generation++;
    _phase = ScreenPhase.disposed;
    _timerScreenOff?.cancel();
    _fadeOutTimer?.cancel();
    _cancelWakeUpDelay();
    _cancelFadeIn();
    final completion = _transition;
    if (completion != null) {
      _complete(completion, ScreenTransitionResult.cancelled);
    }
    await _powerQueue;
    await _stateChangePreparation.close();
  }
}
