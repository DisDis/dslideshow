import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_backend/src/service/hardware/src/night_mode_policy.dart';
import 'package:dslideshow_backend/src/service/hardware/src/screen_service.dart';
import 'package:dslideshow_backend/src/service/hardware/src/hardware_service_config.dart';
import 'package:fake_async/fake_async.dart';
import 'package:test/test.dart';
import 'package:logging/logging.dart';

import 'support/controlled_screen_power.dart';
import 'helpers/capture_logs.dart';

const light = AmbientLightConfig(enabled: true, topic: 'zigbee2mqtt/bedroom', maxAgeSec: 10);

void main() {
  test(
    'policy diagnostics name sleep reason without logging every reading',
    () => captureLogs((records) async {
      fakeAsync((time) {
        var now = DateTime(2026, 11, 1, 12);
        final policy = NightModePolicy(
          const NightModeConfig(enabled: true, mode: NightMode.scheduleOrDarkness, ambientLight: light),
          now: () => now,
        );
        policy.updateAvailability(true);
        policy.updateLight(AmbientLightReading(lux: 1, receivedAt: now));
        final before = records.where((r) => r.level == Level.INFO).length;
        for (var i = 0; i < 10; i++) {
          policy.updateLight(AmbientLightReading(lux: 2, receivedAt: now));
        }
        expect(records.where((r) => r.level == Level.INFO).length, before);
        expect(records.any((r) => r.message.contains('reason=darkness light=dark')), isTrue);
        now = now.add(const Duration(seconds: 10));
        for (var i = 0; i < 10; i++) {
          policy.refresh();
        }
        expect(policy.state.lightStatus, AmbientLightStatus.stale);
        expect(policy.state.automaticWakeBlocked, isTrue);
        expect(records.where((r) => r.level == Level.INFO).length, before + 1);
        expect(records.any((r) => r.message.contains('reason=lightUnavailable light=stale')), isTrue);
        policy.dispose();
        time.flushMicrotasks();
      });
    }),
  );
  test('default settings omit disabled night mode; configured settings round-trip', () {
    final defaults = AppConfig.fromJson({});
    expect(defaults.nightMode.enabled, isFalse);
    expect(defaults.nightMode.ambientLight.maxAgeSec, 1800);
    expect(defaults.toStorageJson(), isNot(contains('nightMode')));
    final config = AppConfig.fromJson({
      'nightMode': {
        'enabled': true,
        'mode': 'scheduleAndDarkness',
        'start': '22:30',
        'end': '07:15',
        'ambientLight': {'enabled': true, 'topic': 'zigbee2mqtt/bedroom', 'maxAgeSec': 300},
      },
    });
    expect(AppConfig.fromJson(config.toStorageJson()).nightMode, config.nightMode);
    expect(config.nightMode.startMinute, 1350);
    expect(
      () => AppConfig.fromJson({
        'nightMode': {'start': '25:00'},
      }),
      throwsFormatException,
    );
    expect(
      () => AppConfig.fromJson({
        'nightMode': {'mode': 'unexpected'},
      }),
      throwsArgumentError,
    );
  });

  test('JSON decoding preserves night settings for validation in config_app', () {
    final config = AppConfig.fromJson({
      'nightMode': {
        'start': '08:00',
        'end': '08:00',
        'ambientLight': {'maxAgeSec': 0, 'darkBelowLux': 20, 'lightAboveLux': 10, 'topic': 'bedroom/#'},
      },
    });
    final restored = AppConfig.fromJson(config.toStorageJson());
    expect(restored.nightMode, config.nightMode);
    expect(restored.nightMode.startMinute, restored.nightMode.endMinute);
    expect(restored.nightMode.ambientLight.maxAgeSec, 0);
    expect(restored.nightMode.ambientLight.darkBelowLux, 20);
    expect(restored.nightMode.ambientLight.topic, 'bedroom/#');
  });

  test('numeric JSON thresholds and telemetry are converted to integer lux', () {
    final config = AmbientLightConfig.fromJson({'darkBelowLux': 3.9, 'lightAboveLux': 9.8});
    expect(config.darkBelowLux, 3);
    expect(config.lightAboveLux, 9);
    expect(config.toJson()['darkBelowLux'], isA<int>());
    expect(config.toJson()['lightAboveLux'], isA<int>());
    final state = NightModeState.fromJson({'illuminance': 6.9});
    expect(state.illuminance, 6);
    expect(state.toJson()['illuminance'], isA<int>());
  });

  // Expected results are independent of the policy's boolean expressions.
  for (final (hour, lux, expected) in <(int, int?, List<bool>)>[
    (23, 1, [true, true, true]),
    (23, 20, [true, true, false]),
    (23, null, [true, true, true]),
    (12, 1, [false, true, false]),
    (12, 20, [false, false, false]),
    (12, null, [false, true, false]),
  ]) {
    for (final mode in NightMode.values) {
      test('$mode hour=$hour lux=$lux applies schedule/light truth table', () {
        fakeAsync((time) {
          final now = DateTime(2026, 11, 1, hour);
          final policy = NightModePolicy(
            NightModeConfig(enabled: true, mode: mode, ambientLight: light),
            now: () => now.add(time.elapsed),
          );
          policy.updateAvailability(true);
          if (lux != null) policy.updateLight(AmbientLightReading(lux: lux, receivedAt: now));
          expect(policy.state.automaticWakeBlocked, expected[mode.index]);
          policy.dispose();
          time.flushMicrotasks();
          expect(time.pendingTimers, isEmpty);
        });
      });
    }
  }

  test('schedule starts inclusively, ends exclusively and reacts to clock corrections', () {
    fakeAsync((time) {
      var now = DateTime(2026, 11, 1, 22, 59, 59);
      final policy = NightModePolicy(const NightModeConfig(enabled: true), now: () => now);
      expect(policy.state.automaticWakeBlocked, isFalse);
      expect(policy.state.nextBoundary, DateTime(2026, 11, 1, 23));
      now = DateTime(2026, 11, 1, 23);
      time.elapse(const Duration(seconds: 1));
      expect(policy.state.automaticWakeBlocked, isTrue);
      now = DateTime(2026, 11, 2, 7, 59, 59);
      policy.refresh();
      expect(policy.state.automaticWakeBlocked, isTrue);
      now = DateTime(2026, 11, 2, 8);
      policy.refresh();
      expect(policy.state.automaticWakeBlocked, isFalse);
      policy.dispose();
      time.flushMicrotasks();
    });
  });

  test('hysteresis, expiration and disconnect remain conservative', () {
    fakeAsync((time) {
      final start = DateTime(2026, 11, 1, 12);
      final policy = NightModePolicy(
        const NightModeConfig(enabled: true, mode: NightMode.scheduleOrDarkness, ambientLight: light),
        now: () => start.add(time.elapsed),
      );
      policy.updateAvailability(true);
      void observe(int lux) => policy.updateLight(AmbientLightReading(lux: lux, receivedAt: start.add(time.elapsed)));
      observe(6);
      expect(policy.state.lightStatus, AmbientLightStatus.unknown);
      expect(policy.state.automaticWakeBlocked, isTrue);
      observe(10);
      expect(policy.state.automaticWakeBlocked, isFalse);
      observe(7);
      expect(policy.state.lightStatus, AmbientLightStatus.light);
      observe(5);
      expect(policy.state.automaticWakeBlocked, isTrue);
      observe(7);
      expect(policy.state.lightStatus, AmbientLightStatus.dark);
      observe(20);
      time.elapse(const Duration(seconds: 9));
      expect(policy.state.automaticWakeBlocked, isFalse);
      time.elapse(const Duration(seconds: 1));
      expect(policy.state.lightStatus, AmbientLightStatus.stale);
      expect(policy.state.automaticWakeBlocked, isTrue);
      observe(7);
      expect(policy.state.lightStatus, AmbientLightStatus.unknown);
      observe(20);
      policy.updateAvailability(false);
      expect(policy.state.lightStatus, AmbientLightStatus.unavailable);
      expect(policy.state.illuminance, isNull);
      policy.updateAvailability(true);
      expect(policy.state.automaticWakeBlocked, isTrue);
      policy.dispose();
      time.flushMicrotasks();
    });
  });

  test('every accepted reception restarts expiry even when illuminance stays the same', () {
    fakeAsync((time) {
      final start = DateTime(2026, 11, 1, 12);
      final policy = NightModePolicy(
        const NightModeConfig(enabled: true, mode: NightMode.scheduleOrDarkness, ambientLight: light),
        now: () => start.add(time.elapsed),
      );
      policy.updateAvailability(true);
      policy.updateLight(AmbientLightReading(lux: 20, receivedAt: start));
      time.elapse(const Duration(seconds: 9));
      policy.updateLight(AmbientLightReading(lux: 20, receivedAt: start.add(time.elapsed)));
      time.elapse(const Duration(seconds: 9));
      expect(policy.state.lightStatus, AmbientLightStatus.light);
      expect(policy.state.automaticWakeBlocked, isFalse);
      expect(policy.state.lightReceivedAt, start.add(const Duration(seconds: 9)));
      time.elapse(const Duration(seconds: 1));
      expect(policy.state.lightStatus, AmbientLightStatus.stale);
      expect(policy.state.automaticWakeBlocked, isTrue);
      policy.dispose();
      time.flushMicrotasks();
      expect(time.pendingTimers, isEmpty);
    });
  });

  for (final initialLux in [1, 20]) {
    test('a reading after expiry cannot inherit hysteresis before the next timer tick ($initialLux lux)', () {
      fakeAsync((time) {
        var now = DateTime(2026, 11, 1, 12);
        final policy = NightModePolicy(
          const NightModeConfig(enabled: true, mode: NightMode.scheduleOrDarkness, ambientLight: light),
          now: () => now,
        );
        policy.updateAvailability(true);
        policy.updateLight(AmbientLightReading(lux: initialLux, receivedAt: now));
        now = now.add(const Duration(seconds: 10));
        // A message can be handled before the next periodic clock check.
        policy.updateLight(AmbientLightReading(lux: 7, receivedAt: now));
        expect(policy.state.lightStatus, AmbientLightStatus.unknown);
        expect(policy.state.automaticWakeBlocked, isTrue);
        expect(policy.state.reason, AutomaticSleepReason.lightUnavailable);
        policy.dispose();
        time.flushMicrotasks();
        expect(time.pendingTimers, isEmpty);
      });
    });
  }

  for (final (hour, expected) in [
    (12, [false, true, false]),
    (23, [true, true, true]),
  ]) {
    for (final mode in NightMode.values) {
      test('$mode at $hour:00 treats expired light conservatively', () {
        fakeAsync((time) {
          final start = DateTime(2026, 11, 1, hour);
          final policy = NightModePolicy(
            NightModeConfig(enabled: true, mode: mode, ambientLight: light),
            now: () => start.add(time.elapsed),
          );
          policy.updateAvailability(true);
          policy.updateLight(AmbientLightReading(lux: 20, receivedAt: start));
          time.elapse(const Duration(seconds: 10));
          expect(policy.state.lightStatus, AmbientLightStatus.stale);
          expect(policy.state.automaticWakeBlocked, expected[mode.index]);
          policy.dispose();
          time.flushMicrotasks();
          expect(time.pendingTimers, isEmpty);
        });
      });
    }
  }

  test('optional light diagnostics expire even while night mode is disabled', () {
    fakeAsync((time) {
      final start = DateTime(2026, 11, 1, 12);
      final policy = NightModePolicy(const NightModeConfig(ambientLight: light), now: () => start.add(time.elapsed));
      policy.updateAvailability(true);
      policy.updateLight(AmbientLightReading(lux: 20, receivedAt: start));
      time.elapse(const Duration(seconds: 10));
      expect(policy.state.lightStatus, AmbientLightStatus.stale);
      expect(policy.state.automaticWakeBlocked, isFalse);
      policy.dispose();
      time.flushMicrotasks();
      expect(time.pendingTimers, isEmpty);
    });
  });

  for (final mode in NightMode.values) {
    test('$mode: manual ON at night sleeps after absence and motion cannot reawaken it', () {
      fakeAsync((time) {
        final start = DateTime(2026, 11, 1, 23);
        final policy = NightModePolicy(
          NightModeConfig(enabled: true, mode: mode, ambientLight: light),
          now: () => start.add(time.elapsed),
        );
        final power = ControlledPower();
        final screen = ScreenService(
          HardwareConfig.fromJson({'screenPowerOnTimerSec': 10}),
          power: power,
          nightMode: policy,
        );
        screen.onPresence(false);
        time.elapse(const Duration(seconds: 2));
        expect(screen.phase, ScreenPhase.off);
        screen.screenOn();
        time.elapse(const Duration(seconds: 4));
        expect(screen.phase, ScreenPhase.on);
        expect(power.calls, [false, true]);
        time.elapse(const Duration(seconds: 5));
        expect(screen.isScreenOn, isTrue);
        time.elapse(const Duration(seconds: 3));
        expect(screen.phase, ScreenPhase.off);
        screen.onPresence(true);
        time.elapse(const Duration(seconds: 5));
        expect(screen.phase, ScreenPhase.off);
        expect(power.calls, [false, true, false]);
        screen.dispose();
        policy.dispose();
        time.flushMicrotasks();
        expect(time.pendingTimers, isEmpty);
      });
    });
  }

  for (final (presence, autoWakeEnabled, shouldWake) in <(bool?, bool, bool)>[
    (true, true, true),
    (true, false, false),
    (false, true, false),
    (null, true, false),
  ]) {
    test('morning reevaluates presence=$presence, auto wake=$autoWakeEnabled', () {
      fakeAsync((time) {
        final start = DateTime(2026, 11, 1, 23);
        final policy = NightModePolicy(
          const NightModeConfig(enabled: true, endMinute: 1381),
          now: () => start.add(time.elapsed),
        );
        final power = ControlledPower();
        final screen = ScreenService(HardwareConfig.fromJson({}), power: power, nightMode: policy);
        if (presence != null) screen.onPresence(presence);
        time.elapse(const Duration(seconds: 2));
        expect(screen.phase, ScreenPhase.off);
        screen.autoWakeEnabled = autoWakeEnabled;
        time.elapse(const Duration(seconds: 62));
        expect(screen.phase, shouldWake ? ScreenPhase.on : ScreenPhase.off);
        expect(power.calls, shouldWake ? [false, true] : [false]);
        screen.dispose();
        policy.dispose();
        time.flushMicrotasks();
        expect(time.pendingTimers, isEmpty);
      });
    });
  }

  test('night boundary cancels a hardware wake before its delayed reveal', () {
    fakeAsync((time) {
      final start = DateTime(2026, 11, 1, 22, 59, 56);
      final policy = NightModePolicy(const NightModeConfig(enabled: true), now: () => start.add(time.elapsed));
      final power = ControlledPower();
      final screen = ScreenService(HardwareConfig.fromJson({}), power: power, nightMode: policy);
      final visibility = <bool>[];
      screen.onStateChangePreparation.listen(visibility.add);
      screen.screenOff();
      time.elapse(const Duration(seconds: 2));
      screen.onPresence(true);
      time.elapse(const Duration(seconds: 1));
      expect(screen.phase, ScreenPhase.wakingUp);
      time.elapse(const Duration(seconds: 4));
      expect(screen.phase, ScreenPhase.off);
      expect(power.calls, [false, true, false]);
      expect(visibility, [false]);
      screen.dispose();
      policy.dispose();
      time.flushMicrotasks();
      expect(time.pendingTimers, isEmpty);
    });
  });

  test('allowing auto wake at night does not bypass the night restriction', () {
    fakeAsync((time) {
      final start = DateTime(2026, 11, 1, 23);
      final policy = NightModePolicy(const NightModeConfig(enabled: true), now: () => start.add(time.elapsed));
      final power = ControlledPower();
      final screen = ScreenService(HardwareConfig.fromJson({}), power: power, nightMode: policy);
      screen.autoWakeEnabled = false;
      screen.onPresence(true);
      time.elapse(const Duration(seconds: 2));
      expect(screen.phase, ScreenPhase.off);
      screen.autoWakeEnabled = true;
      time.elapse(const Duration(seconds: 4));
      expect(screen.autoWakeEnabled, isTrue);
      expect(screen.phase, ScreenPhase.off);
      expect(power.calls, [false]);
      screen.screenOn();
      time.elapse(const Duration(seconds: 4));
      expect(screen.phase, ScreenPhase.on);
      expect(power.calls, [false, true]);
      screen.dispose();
      policy.dispose();
      time.flushMicrotasks();
      expect(time.pendingTimers, isEmpty);
    });
  });

  test('light restoration cannot wake a screen with auto wake disabled', () {
    fakeAsync((time) {
      final start = DateTime(2026, 11, 1, 12);
      final policy = NightModePolicy(
        const NightModeConfig(enabled: true, mode: NightMode.scheduleOrDarkness, ambientLight: light),
        now: () => start.add(time.elapsed),
      );
      final power = ControlledPower();
      final screen = ScreenService(HardwareConfig.fromJson({}), power: power, nightMode: policy);
      policy.updateAvailability(true);
      policy.updateLight(AmbientLightReading(lux: 1, receivedAt: start));
      screen.autoWakeEnabled = false;
      screen.onPresence(true);
      time.elapse(const Duration(seconds: 2));
      expect(screen.phase, ScreenPhase.off);
      policy.updateLight(AmbientLightReading(lux: 20, receivedAt: start.add(time.elapsed)));
      time.elapse(const Duration(seconds: 4));
      expect(policy.state.automaticWakeBlocked, isFalse);
      expect(screen.phase, ScreenPhase.off);
      expect(power.calls, [false]);
      screen.autoWakeEnabled = true;
      time.elapse(const Duration(seconds: 4));
      expect(screen.phase, ScreenPhase.on);
      expect(power.calls, [false, true]);
      screen.dispose();
      policy.dispose();
      time.flushMicrotasks();
      expect(time.pendingTimers, isEmpty);
    });
  });

  test('manual night wake lets presence reverse an absence fade; explicit OFF keeps the auto-wake gate', () {
    fakeAsync((time) {
      final start = DateTime(2026, 11, 1, 22, 59, 58);
      final policy = NightModePolicy(const NightModeConfig(enabled: true), now: () => start.add(time.elapsed));
      final power = ControlledPower();
      final screen = ScreenService(
        HardwareConfig.fromJson({'screenPowerOnTimerSec': 10}),
        power: power,
        nightMode: policy,
      );
      screen.onPresence(true);
      time.elapse(const Duration(seconds: 4));
      expect(screen.phase, ScreenPhase.off);
      screen.screenOn();
      time.elapse(const Duration(seconds: 4));
      screen.onPresence(false);
      time.elapse(const Duration(seconds: 11));
      expect(screen.phase, ScreenPhase.fadingOut);
      screen.onPresence(true);
      time.elapse(const Duration(seconds: 15));
      expect(screen.phase, ScreenPhase.on);
      screen.autoWakeEnabled = false;
      screen.screenOff();
      screen.onPresence(true);
      time.elapse(const Duration(seconds: 2));
      expect(screen.phase, ScreenPhase.off);
      expect(screen.autoWakeEnabled, isFalse);
      screen.dispose();
      policy.dispose();
      time.flushMicrotasks();
    });
  });
}
