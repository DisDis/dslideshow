import 'dart:async';

import 'package:logging/logging.dart';

import 'hardware_service_config.dart';
import 'screen_power.dart';
import 'night_mode_policy.dart';
import 'screen_state.dart';
export 'screen_state.dart';

enum ScreenTransitionResult { applied, cancelled, failed }

class ScreenService {
  static const Duration wakeUpDelay = Duration(milliseconds: 2000);
  static final _log = Logger('ScreenService');
  final HardwareConfig _config;
  final ScreenPower _power;
  final Duration _fadeDuration;
  final NightModePolicy _nightMode;
  late final StreamSubscription<NightModeState> _nightModeSubscription;
  bool _automaticWakeBlocked = false;
  bool _manualWake = false;
  bool? _presence;
  final _stateChangePreparation = StreamController<bool>.broadcast();
  final _stateChanges = StreamController<ScreenState>.broadcast();

  ScreenService(
    this._config, {
    required ScreenPower power,
    required NightModePolicy nightMode,
    Duration preparationOffTime = const Duration(milliseconds: 2000),
  }) : _power = power,
       _fadeDuration = preparationOffTime,
       _nightMode = nightMode {
    _nightModeSubscription = nightMode.changes.listen(_applyNightMode);
    _applyNightMode(nightMode.state);
  }

  bool get isVisible => _visible;
  NightModeState get nightModeState => _nightMode.state;
  Stream<ScreenState> get onStateChanged => _stateChanges.stream;
  ScreenState get state => ScreenState(isScreenOn: _confirmedPower, autoWakeEnabled: _autoWakeEnabled, phase: _phase);

  void _applyNightMode(NightModeState state) {
    if (_disposed || _automaticWakeBlocked == state.automaticWakeBlocked) return;
    _automaticWakeBlocked = state.automaticWakeBlocked;
    if (_automaticWakeBlocked) {
      unawaited(screenOff());
    } else if (_presence == true) {
      unawaited(_screenOn());
    }
  }

  void onPresence(bool present) {
    if (_disposed) return;
    final changed = _presence != present;
    _presence = present;
    _nightMode.refresh();
    if (!changed) return;
    if (present) {
      if (_automaticWakeBlocked && !_manualWake) return;
      _timerScreenOff?.cancel();
      _timerScreenOff = null;
      unawaited(_screenOn());
    } else {
      scheduleScreenOff();
    }
  }

  Stream<bool> get onStateChangePreparation => _stateChangePreparation.stream;
  bool get isScreenOn => _confirmedPower == true;

  /// Last successfully commanded power; a failed command may have partly run.
  bool? get confirmedPower => _confirmedPower;
  ScreenPhase get phase => _phase;
  ScreenPhase _phase = ScreenPhase.on;
  bool? _confirmedPower = true;
  bool _desiredOn = true;
  bool _visible = true;
  bool _powerBusy = false;
  bool _disposed = false;
  bool _autoWakeEnabled = true;
  int _generation = 0;
  Timer? _timerScreenOff;
  Timer? _fadeOutTimer;
  Timer? _wakeUpTimer;
  Completer<void>? _wakeUpCompletion;
  Timer? _fadeInTimer;
  Completer<void>? _fadeInCompletion;
  Completer<ScreenTransitionResult>? _transition;
  Future<void> _powerQueue = Future.value();

  bool get autoWakeEnabled => _autoWakeEnabled;
  set autoWakeEnabled(bool enabled) {
    if (!_setAutoWakeEnabled(enabled) || !enabled) return;
    _nightMode.refresh();
    if (_presence == true && !_automaticWakeBlocked) unawaited(_screenOn());
  }

  bool _setAutoWakeEnabled(bool enabled) {
    if (_disposed || _autoWakeEnabled == enabled) return false;
    _autoWakeEnabled = enabled;
    _log.info('Screen auto wake enabled=$enabled');
    _publishState();
    return true;
  }

  Future<ScreenTransitionResult> toggleScreen() {
    if (_disposed) return Future.value(ScreenTransitionResult.cancelled);
    // During the absence grace the display is still on. Once a transition has
    // started, toggle its accepted intent even if visibility is still delayed.
    final enabled = _phase == ScreenPhase.waitingOff ? false : !_desiredOn;
    _log.info('Screen toggle enabled=$enabled');
    return enabled ? screenOn() : screenOff();
  }

  Future<ScreenTransitionResult> screenOn() {
    if (_disposed) return Future.value(ScreenTransitionResult.cancelled);
    _setAutoWakeEnabled(true);
    _nightMode.refresh();
    _manualWake = true;
    _log.info('Screen manual ON nightBlocked=$_automaticWakeBlocked');
    final result = _screenOn();
    // An already absent sensor will not produce another falling edge. Start
    // its normal deadline now without cancelling an in-flight hardware ON.
    if (_presence == false && _timerScreenOff == null) {
      _timerScreenOff = Timer(Duration(seconds: _config.screenPowerOnTimerSec), () {
        _timerScreenOff = null;
        if (!_disposed) unawaited(screenOff());
      });
    }
    return result;
  }

  Future<ScreenTransitionResult> _screenOn() {
    // Presence may keep a powered display awake while automatic wake is
    // disabled. It cannot start another ON after power has gone off.
    if (_disposed || (!_autoWakeEnabled && ((!_visible && !_desiredOn) || _confirmedPower != true || _powerBusy))) {
      return Future.value(ScreenTransitionResult.cancelled);
    }
    if (_desiredOn && _phase != ScreenPhase.failed) {
      return _transition?.future ?? Future.value(ScreenTransitionResult.applied);
    }
    final completion = _beginTransition(true);
    final generation = _generation;
    if (_confirmedPower == true && !_powerBusy) {
      _waitForDisplay(generation, completion);
    } else {
      _setPhase(ScreenPhase.wakingUp);
      _enqueuePower(true, generation, completion);
    }
    return completion.future;
  }

  void scheduleScreenOff() {
    if (_disposed || !_desiredOn) return;
    final completion = _beginTransition(false);
    final generation = _generation;
    _setPhase(ScreenPhase.waitingOff);
    _timerScreenOff = Timer(Duration(seconds: _config.screenPowerOnTimerSec), () {
      if (!_isCurrent(generation)) return;
      _timerScreenOff = null;
      _startFadeOut(generation, completion);
    });
  }

  Future<ScreenTransitionResult> screenOff() {
    _manualWake = false;
    if (_disposed) return Future.value(ScreenTransitionResult.cancelled);
    if (!_desiredOn && _phase != ScreenPhase.waitingOff && _phase != ScreenPhase.failed) {
      return _transition?.future ?? Future.value(ScreenTransitionResult.applied);
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

  void _startFadeOut(int generation, Completer<ScreenTransitionResult> completion) {
    if (!_isCurrent(generation)) return;
    _cancelFadeIn();
    _setPhase(ScreenPhase.fadingOut);
    _publish(false);
    _fadeOutTimer = Timer(_fadeDuration, () {
      if (!_isCurrent(generation) || _desiredOn) return;
      _fadeOutTimer = null;
      _setPhase(ScreenPhase.poweringOff);
      _enqueuePower(false, generation, completion);
    });
  }

  void _startFadeIn(int generation, Completer<ScreenTransitionResult> completion) {
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
      _setPhase(ScreenPhase.on);
      _complete(completion, ScreenTransitionResult.applied);
      return;
    }
    _setPhase(ScreenPhase.fadingIn);
    _log.info('Screen transition $generation: ${ScreenPhase.fadingIn.name}');
    // Reverse immediately. A new grace period does not reverse the overlay, so
    // presence returning during it must reuse this reveal, not restart it.
    _publish(true);
    unawaited(
      animation.future.then((_) {
        if (!_isCurrent(generation) || !_desiredOn) return;
        _setPhase(ScreenPhase.on);
        _complete(completion, ScreenTransitionResult.applied);
      }),
    );
  }

  void _waitForDisplay(int generation, Completer<ScreenTransitionResult> completion) {
    if (!_isCurrent(generation)) return;
    final ready = _wakeUpCompletion;
    if (ready == null) {
      _startFadeIn(generation, completion);
      return;
    }
    _setPhase(ScreenPhase.wakingUp);
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

  void _enqueuePower(bool enabled, int generation, Completer<ScreenTransitionResult> completion) {
    // Only hardware work is queued. New intentions and fade cancellation remain
    // synchronous, so they never wait behind a modeset or a script.
    _powerQueue = _powerQueue.then((_) async {
      if (!_isCurrent(generation)) {
        _complete(completion, ScreenTransitionResult.cancelled);
        return;
      }
      try {
        if (_confirmedPower != enabled) {
          if (!enabled) _manualWake = false;
          _powerBusy = true;
          if (!enabled) _cancelWakeUpDelay();
          _log.info('Screen hardware $generation: ${enabled ? "ON" : "OFF"}');
          await _power.setPower(enabled);
          // Record the actual effect even if the request became stale. The next
          // queued request must reconcile this effect with the latest intention.
          _confirmedPower = enabled;
          _publishState();
          if (enabled) _startWakeUpDelay();
        }
        if (_isCurrent(generation)) {
          if (enabled) {
            _waitForDisplay(generation, completion);
          } else {
            _setPhase(ScreenPhase.off);
            _publish(false);
            _complete(completion, ScreenTransitionResult.applied);
          }
        } else {
          _complete(completion, ScreenTransitionResult.cancelled);
        }
      } catch (error, stack) {
        // A partial script/modeset may have changed power.
        _confirmedPower = null;
        _publishState();
        _log.severe('Screen hardware $generation failed', error, stack);
        if (_isCurrent(generation)) {
          _setPhase(ScreenPhase.failed);
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

  void _setPhase(ScreenPhase phase) {
    if (_phase == phase) return;
    _phase = phase;
    _publishState();
  }

  void _publishState() {
    if (!_disposed) _stateChanges.add(state);
  }

  void _complete(Completer<ScreenTransitionResult> completion, ScreenTransitionResult result) {
    if (!completion.isCompleted) completion.complete(result);
    if (identical(_transition, completion)) _transition = null;
  }

  Future<void> dispose() async {
    _disposed = true;
    _generation++;
    _phase = ScreenPhase.disposed;
    _timerScreenOff?.cancel();
    _fadeOutTimer?.cancel();
    _cancelWakeUpDelay();
    _cancelFadeIn();
    final policyCancelled = _nightModeSubscription.cancel();
    final completion = _transition;
    if (completion != null) {
      _complete(completion, ScreenTransitionResult.cancelled);
    }
    await _powerQueue;
    await policyCancelled;
    await _stateChangePreparation.close();
    await _stateChanges.close();
  }
}
