// Freezed forwards constructor annotations to the generated implementation.
// ignore_for_file: invalid_annotation_target
import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';

import 'night_mode_config.dart';

part 'night_mode_policy.freezed.dart';
part 'night_mode_policy.g.dart';

enum AmbientLightStatus { disabled, unavailable, unknown, stale, dark, light }

enum AutomaticSleepReason { none, schedule, darkness, scheduleAndDarkness, lightUnavailable }

@freezed
sealed class NightModeState with _$NightModeState {
  @JsonSerializable()
  const factory NightModeState({
    @Default(false) bool enabled,
    @Default(NightMode.scheduleOnly) NightMode mode,
    @Default(false) bool inSchedule,
    @Default(false) bool automaticWakeBlocked,
    @Default(AutomaticSleepReason.none) AutomaticSleepReason reason,
    @Default(AmbientLightStatus.disabled) AmbientLightStatus lightStatus,
    int? illuminance,
    DateTime? lightReceivedAt,
    DateTime? nextBoundary,
  }) = _NightModeState;

  factory NightModeState.fromJson(Map<String, dynamic> json) => _$NightModeStateFromJson(json);
}

@freezed
sealed class AmbientLightReading with _$AmbientLightReading {
  const factory AmbientLightReading({required int lux, required DateTime receivedAt}) = _AmbientLightReading;
}

/// Owns schedule/light decisions; transport, screen power and presence live elsewhere.
class NightModePolicy {
  NightModePolicy(this.config, {DateTime Function()? now}) : _now = now ?? DateTime.now {
    refresh();
    if (config.enabled || config.ambientLight.enabled) {
      _timer = Timer.periodic(const Duration(seconds: 1), (_) => refresh());
    }
  }

  static final _log = Logger('NightModePolicy');
  final NightModeConfig config;
  final DateTime Function() _now;
  final _changes = StreamController<NightModeState>.broadcast(sync: true);
  Timer? _timer;
  NightModeState _state = const NightModeState();
  AmbientLightReading? _reading;
  bool _available = false;
  AmbientLightStatus _lightLevel = AmbientLightStatus.unknown;

  NightModeState get state => _state;
  // Computed decisions change with time and MQTT; config is fixed until restart.
  Stream<NightModeState> get changes => _changes.stream;

  void updateAvailability(bool available) {
    if (_available && available) return;
    _available = available;
    if (!available) {
      _reading = null;
      _lightLevel = AmbientLightStatus.unknown;
    }
    refresh();
  }

  void updateLight(AmbientLightReading reading) {
    if (reading.lux < 0) {
      _log.warning('Light reading rejected: negative lux');
      return;
    }
    final previous = _reading;
    if (previous != null && _isStale(previous, reading.receivedAt)) _lightLevel = AmbientLightStatus.unknown;
    _reading = reading;
    if (reading.lux <= config.ambientLight.darkBelowLux) {
      _lightLevel = AmbientLightStatus.dark;
    } else if (reading.lux >= config.ambientLight.lightAboveLux) {
      _lightLevel = AmbientLightStatus.light;
    }
    refresh();
  }

  /// Also called before automatic ON, so a clock correction cannot use an old decision.
  void refresh() {
    final now = _now();
    final light = config.ambientLight;
    final reading = _reading;
    final lightStatus = !light.enabled
        ? AmbientLightStatus.disabled
        : !_available
        ? AmbientLightStatus.unavailable
        : reading == null
        ? AmbientLightStatus.unknown
        : _isStale(reading, now)
        ? AmbientLightStatus.stale
        : _lightLevel;
    if (lightStatus == AmbientLightStatus.stale) _lightLevel = AmbientLightStatus.unknown;
    final scheduled = config.contains(now);
    final uncertain = lightStatus != AmbientLightStatus.dark && lightStatus != AmbientLightStatus.light;
    final darkOrUnknown = lightStatus != AmbientLightStatus.light;
    final blocked =
        config.enabled &&
        switch (config.mode) {
          NightMode.scheduleOnly => scheduled,
          NightMode.scheduleOrDarkness => scheduled || darkOrUnknown,
          NightMode.scheduleAndDarkness => scheduled && darkOrUnknown,
        };
    final reason = !blocked
        ? AutomaticSleepReason.none
        : config.mode == NightMode.scheduleOnly || (config.mode == NightMode.scheduleOrDarkness && scheduled)
        ? AutomaticSleepReason.schedule
        : uncertain
        ? AutomaticSleepReason.lightUnavailable
        : config.mode == NightMode.scheduleAndDarkness
        ? AutomaticSleepReason.scheduleAndDarkness
        : AutomaticSleepReason.darkness;
    final next = NightModeState(
      enabled: config.enabled,
      mode: config.mode,
      inSchedule: scheduled,
      automaticWakeBlocked: blocked,
      reason: reason,
      lightStatus: lightStatus,
      illuminance: reading?.lux,
      lightReceivedAt: reading?.receivedAt,
      nextBoundary: config.enabled ? config.nextBoundary(now) : null,
    );
    if (next == _state) return;
    if (next.automaticWakeBlocked != _state.automaticWakeBlocked ||
        next.reason != _state.reason ||
        next.lightStatus != _state.lightStatus) {
      _log.info('Night policy blocked=$blocked reason=${reason.name} light=${lightStatus.name}');
    }
    _state = next;
    _changes.add(next);
  }

  bool _isStale(AmbientLightReading reading, DateTime now) =>
      now.isBefore(reading.receivedAt) ||
      now.difference(reading.receivedAt) >= Duration(seconds: config.ambientLight.maxAgeSec);

  Future<void> dispose() async {
    _timer?.cancel();
    await _changes.close();
  }
}
