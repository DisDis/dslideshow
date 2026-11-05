import 'dart:async';

import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_backend/src/service/hardware/hardware.dart';
import 'package:dslideshow_backend/src/service/hardware/src/gpio_service.dart';
import 'package:dslideshow_common/rpc.dart';
import 'package:fake_async/fake_async.dart';
import 'package:logging/logging.dart';
import 'package:test/test.dart';

import 'support/hardware_fixture.dart';
import 'helpers/capture_logs.dart';

import 'package:dslideshow_backend/src/service/hardware/src/night_mode_policy.dart';

void main() {
  test(
    'two toggle RPCs alternate accepted wake intent before UI becomes visible',
    () => captureLogs((records) async {
      fakeAsync((time) {
        final f = HardwareFixture();
        f.hardware.executeCommand(const ScreenTurnCommand(id: 901, enabled: false));
        time.elapse(const Duration(seconds: 2));
        final results = <RpcResult>[];
        f.hardware.executeCommand(const ScreenToggleCommand(id: 902)).then(results.add);
        time.flushMicrotasks();
        expect(f.screen.phase, ScreenPhase.wakingUp);
        expect(f.screen.isVisible, isFalse);
        f.hardware.executeCommand(const ScreenToggleCommand(id: 903)).then(results.add);
        time.elapse(const Duration(seconds: 5));
        expect(results.map((result) => result.id), [902, 903]);
        expect(results.every((result) => result is EmptyResult), isTrue);
        expect(f.screen.phase, ScreenPhase.off);
        expect(f.power.calls, [false, true, false]);
        expect(f.remote.screenCommands.map((command) => command.enabled), [false]);
        expect(
          records
              .where((record) => record.message.startsWith('Screen toggle enabled='))
              .map((record) => record.message),
          ['Screen toggle enabled=true', 'Screen toggle enabled=false'],
        );
        f.dispose(time);
      });
    }),
  );

  test('night startup delivers current OFF even when transition preceded frontend subscriptions', () {
    fakeAsync((time) {
      final now = DateTime(2026, 11, 1, 23);
      final policy = NightModePolicy(const NightModeConfig(enabled: true), now: () => now.add(time.elapsed));
      final fixture = HardwareFixture.withNightMode(policy);
      time.flushMicrotasks();
      expect(fixture.remote.screenCommands.map((c) => c.enabled), [false]);
      fixture.gpio.motion.add(true);
      time.elapse(const Duration(seconds: 3));
      expect(fixture.screen.phase, ScreenPhase.off);
      expect(fixture.power.calls, [false]);
      fixture.dispose(time);
    });
  });
  test('GPIO button fields reach the frontend through the bindings', () async {
    final fixture = HardwareFixture();
    addTearDown(() async {
      await fixture.close();
      await fixture.mqtt.close();
    });
    fixture.gpio.buttons.add(ButtonEvent(button: ButtonType.button2, event: ButtonEventType.released, durationMs: 875));
    await Future<void>.delayed(Duration.zero);
    final command = fixture.remote.commands.whereType<ButtonChangeStateCommand>().single;
    expect(command.button, ButtonType.button2);
    expect(command.event, ButtonEventType.released);
    expect(command.durationMs, 875);
  });

  test('MQTT pause/menu preserve values and screen commands act directly on hardware', () async {
    final fixture = HardwareFixture();
    addTearDown(() async {
      await fixture.close();
      await fixture.mqtt.close();
    });
    for (final value in [true, false]) {
      fixture.mqtt.pause.add(value);
      await Future<void>.delayed(Duration.zero);
      fixture.mqtt.screen.add(value);
      await Future<void>.delayed(Duration.zero);
      fixture.mqtt.menu.add(value);
      await Future<void>.delayed(Duration.zero);
    }
    expect(
      fixture.remote.commands.whereType<ExecuteSSActionCommand>().map((action) {
        return (action.action, action.value);
      }),
      [
        (SlideshowAction.pause, true),
        (SlideshowAction.showMenu, true),
        (SlideshowAction.pause, false),
        (SlideshowAction.showMenu, false),
      ],
    );
    expect(fixture.screen.phase, ScreenPhase.fadingOut);
    expect(fixture.screen.autoWakeEnabled, isTrue);
  });

  test('dispose detaches queued device events before releasing services', () async {
    final fixture = HardwareFixture();
    addTearDown(() async {
      await fixture.close();
      await fixture.mqtt.close();
    });
    fixture.gpio.buttons.add(ButtonEvent(button: ButtonType.button0, event: ButtonEventType.pressed, durationMs: 0));
    fixture.gpio.motion.add(false);
    fixture.mqtt.pause.add(true);
    fixture.mqtt.screen.add(true);
    fixture.mqtt.autoWake.add(false);
    fixture.mqtt.menu.add(true);
    final closing = fixture.close();
    await closing;
    expect(fixture.remote.commands.single, isA<StorageStatusCommand>());
    expect(fixture.gpio.buttons.hasListener, isFalse);
    expect(fixture.gpio.motion.hasListener, isFalse);
    expect(fixture.mqtt.pause.hasListener, isFalse);
    expect(fixture.mqtt.screen.hasListener, isFalse);
    expect(fixture.mqtt.autoWake.hasListener, isFalse);
    expect(fixture.mqtt.menu.hasListener, isFalse);
    expect(fixture.mqtt.pause.isClosed, isTrue);
    expect(fixture.mqtt.screen.isClosed, isTrue);
    expect(fixture.mqtt.autoWake.isClosed, isTrue);
    expect(fixture.mqtt.menu.isClosed, isTrue);
    expect(fixture.storage.released, isTrue);
    expect(fixture.systemInfo.released, isTrue);
  });

  for (final duringDisposal in [false, true]) {
    test('system-info failure returns its RPC id (disposed=$duringDisposal)', () async {
      final fixture = HardwareFixture();
      addTearDown(() async {
        await fixture.close();
        await fixture.mqtt.close();
      });
      final pending = Completer<SystemInfo>();
      fixture.systemInfo.pending = pending;
      final response = fixture.hardware.executeCommand(const GetSystemInfoCommand(id: 543));
      if (duringDisposal) {
        await fixture.close();
        expect(fixture.systemInfo.released, isTrue);
      }
      pending.completeError(StateError('Collection stopped'));
      final result = await response;
      expect(result, isA<ErrorResult>());
      expect(result.id, 543);
      expect((result as ErrorResult).error, contains('Collection stopped'));
      await fixture.close();
      expect(fixture.storage.released, isTrue);
      expect(fixture.systemInfo.released, isTrue);
    });
  }

  test('GPIO presence cancels sleep and restores both UI and application state', () {
    fakeAsync((time) {
      final f = HardwareFixture();
      f.gpio.motion.add(false);
      time.elapse(const Duration(seconds: 1));
      expect(f.remote.screenCommands.map((c) => c.enabled), [false]);
      expect(f.application.state.isScreenOn, isFalse);
      f.gpio.motion.add(true);
      time.flushMicrotasks();
      expect(f.remote.screenCommands.map((c) => c.enabled), [false, true]);
      expect(f.application.state.isScreenOn, isTrue);
      time.elapse(const Duration(seconds: 5));
      expect(f.power.calls, isEmpty);
      f.dispose(time);
    });
  });

  test('MQTT auto-wake OFF does not turn off an active screen and blocks a later GPIO wake', () {
    fakeAsync((time) {
      final f = HardwareFixture();
      f.mqtt.autoWake.add(false);
      time.flushMicrotasks();
      expect(f.screen.autoWakeEnabled, isFalse);
      expect(f.screen.phase, ScreenPhase.on);
      expect(f.power.calls, isEmpty);
      f.mqtt.screen.add(false);
      time.elapse(const Duration(seconds: 1));
      expect(f.screen.phase, ScreenPhase.fadingOut);
      f.gpio.motion.add(true);
      time.elapse(const Duration(seconds: 1));
      expect(f.screen.phase, ScreenPhase.off);
      time.elapse(const Duration(seconds: 4));
      expect(f.power.calls, [false]);
      expect(f.remote.screenCommands.map((c) => c.enabled), [false]);
      f.mqtt.autoWake.add(true);
      time.flushMicrotasks();
      expect(f.screen.autoWakeEnabled, isTrue);
      expect(f.power.calls, [false, true]);
      expect(f.remote.screenCommands.map((c) => c.enabled), [false]);
      time.elapse(ScreenService.wakeUpDelay);
      expect(f.remote.screenCommands.map((c) => c.enabled), [false, true]);
      f.dispose(time);
    });
  });

  test('RPC and MQTT ON re-enable auto wake and turn on the screen during night restriction', () {
    fakeAsync((time) {
      final start = DateTime(2026, 11, 1, 23);
      final policy = NightModePolicy(const NightModeConfig(enabled: true), now: () => start.add(time.elapsed));
      final f = HardwareFixture.withNightMode(policy);
      f.gpio.motion.add(true);
      time.elapse(const Duration(seconds: 2));
      expect(f.screen.phase, ScreenPhase.off);
      expect(f.screen.nightModeState.automaticWakeBlocked, isTrue);

      f.screen.autoWakeEnabled = false;
      f.hardware.executeCommand(const ScreenTurnCommand(id: 71, enabled: true));
      time.elapse(const Duration(seconds: 4));
      expect(f.screen.autoWakeEnabled, isTrue);
      expect(f.screen.phase, ScreenPhase.on);
      f.hardware.executeCommand(const ScreenTurnCommand(id: 72, enabled: false));
      time.elapse(const Duration(seconds: 2));
      expect(f.screen.autoWakeEnabled, isTrue);
      expect(f.screen.phase, ScreenPhase.off);

      f.mqtt.autoWake.add(false);
      time.flushMicrotasks();
      f.mqtt.screen.add(true);
      time.elapse(const Duration(seconds: 4));
      expect(f.screen.autoWakeEnabled, isTrue);
      expect(f.screen.phase, ScreenPhase.on);
      expect(f.power.calls, [false, true, false, true]);
      f.dispose(time);
    });
  });

  test('screen notifications are sent without waiting for earlier acknowledgements', () {
    fakeAsync((time) {
      final f = HardwareFixture();
      f.remote.hold = true;
      f.gpio.motion.add(false);
      time.elapse(const Duration(seconds: 1));
      f.gpio.motion.add(true);
      time.flushMicrotasks();
      expect(f.remote.screenCommands.map((c) => c.enabled), [false, true]);
      f.remote.acknowledge(1);
      f.remote.acknowledge(0);
      time.flushMicrotasks();
      f.dispose(time);
    });
  });

  test('failed notification does not block the subsequent restoration', () {
    fakeAsync((time) {
      final f = HardwareFixture();
      f.remote.hold = true;
      f.screen.screenOff();
      time.flushMicrotasks();
      f.screen.screenOn();
      f.remote.pending[0].completeError(StateError('frontend unavailable'));
      time.flushMicrotasks();
      expect(f.remote.screenCommands.map((c) => c.enabled), [false, true]);
      f.remote.acknowledge(1);
      time.flushMicrotasks();
      f.dispose(time);
    });
  });

  test('dispose is not blocked by a frontend that never acknowledges', () {
    fakeAsync((time) {
      final f = HardwareFixture();
      f.remote.hold = true;
      f.screen.screenOff();
      time.flushMicrotasks();
      f.screen.screenOn();
      time.flushMicrotasks();
      f.dispose(time);
      expect(f.remote.screenCommands.map((c) => c.enabled), [false, true]);
    });
  });

  test('all application fields share the same debounce and rapid storage transitions coalesce', () {
    fakeAsync((time) {
      final f = HardwareFixture();
      final events = <ApplicationState>[];
      f.application.onChangedState.listen(events.add);
      f.application.update(f.application.state.copyWith(isMenu: true, isPaused: true));
      time.elapse(const Duration(milliseconds: 250));
      expect(events, isEmpty);
      f.storage.updateStatus(StorageStatusEnum.download);
      time.flushMicrotasks();
      time.elapse(const Duration(milliseconds: 499));
      expect(events, isEmpty);
      time.elapse(const Duration(milliseconds: 1));
      expect(
        events.single,
        const ApplicationState(storageStatus: StorageStatusEnum.download, isMenu: true, isPaused: true),
      );
      f.storage.updateStatus(StorageStatusEnum.off);
      f.storage.updateStatus(StorageStatusEnum.done);
      time.flushMicrotasks();
      expect(events, hasLength(1));
      time.elapse(const Duration(milliseconds: 499));
      expect(events, hasLength(1));
      time.elapse(const Duration(milliseconds: 1));
      expect(events.map((state) => state.storageStatus), [StorageStatusEnum.download, StorageStatusEnum.done]);
      time.elapse(const Duration(milliseconds: 500));
      expect(events, hasLength(2));
      f.gpio.motion.add(false);
      time.flushMicrotasks();
      time.elapse(const Duration(milliseconds: 499));
      expect(events, hasLength(2));
      time.elapse(const Duration(milliseconds: 1));
      expect(events.last, const ApplicationState(isMenu: true, isPaused: true, isMotion: false));
      expect(f.remote.commands.whereType<StorageStatusCommand>().map((command) => command.status), [
        StorageStatusEnum.done,
        StorageStatusEnum.download,
        StorageStatusEnum.off,
        StorageStatusEnum.done,
      ]);
      f.dispose(time);
    });
  });

  test('storage notifications are sent without waiting for earlier acknowledgements', () {
    fakeAsync((time) {
      final f = HardwareFixture();
      f.remote.holdStorage = true;
      time.flushMicrotasks();
      f.storage.updateStatus(StorageStatusEnum.download);
      f.storage.updateStatus(StorageStatusEnum.off);
      f.storage.updateStatus(StorageStatusEnum.done);
      time.flushMicrotasks();
      expect(f.remote.storageCommands.map((command) => command.status), [
        StorageStatusEnum.done,
        StorageStatusEnum.download,
        StorageStatusEnum.off,
        StorageStatusEnum.done,
      ]);
      f.remote.acknowledgeStorage(2);
      f.remote.acknowledgeStorage(0);
      f.remote.acknowledgeStorage(1);
      time.flushMicrotasks();
      f.dispose(time);
    });
  });

  test(
    'storage delivery failures are safe and the next transition is still delivered',
    () => captureLogs((records) async {
      fakeAsync((time) {
        final f = HardwareFixture();
        f.remote.holdStorage = true;
        time.flushMicrotasks();
        f.storage.updateStatus(StorageStatusEnum.download);
        f.storage.updateStatus(StorageStatusEnum.off);
        time.flushMicrotasks();
        f.remote.storagePending[0].completeError(StateError('private frontend URL'));
        time.flushMicrotasks();
        expect(f.remote.storageCommands.map((command) => command.status), [
          StorageStatusEnum.done,
          StorageStatusEnum.download,
          StorageStatusEnum.off,
        ]);
        f.remote.storagePending[1].complete(
          ErrorResult(id: f.remote.storageCommands[1].id, error: 'private backend error'),
        );
        time.flushMicrotasks();
        f.storage.updateStatus(StorageStatusEnum.done);
        time.flushMicrotasks();
        expect(f.remote.storageCommands.last.status, StorageStatusEnum.done);
        f.remote.acknowledgeStorage(2);
        time.flushMicrotasks();
        final failures = records.where((record) => record.message.startsWith('Storage status delivery failed '));
        expect(failures, hasLength(2));
        expect(
          failures.every(
            (record) => record.level == Level.WARNING && record.error != null && record.stackTrace != null,
          ),
          isTrue,
        );
        expect(records.map((record) => record.message).join(), isNot(contains('private')));
        f.dispose(time);
      });
    }),
  );

  test('dispose detaches storage updates without waiting for frontend acknowledgements', () {
    fakeAsync((time) {
      final f = HardwareFixture();
      f.remote.holdStorage = true;
      time.flushMicrotasks();
      f.storage.updateStatus(StorageStatusEnum.download);
      time.flushMicrotasks();
      f.close().then((_) {
        f.remote.storagePending.single.completeError(StateError('late private transport failure'));
      });
      time.flushMicrotasks();
      f.storage.updateStatus(StorageStatusEnum.off);
      time.flushMicrotasks();
      expect(f.remote.storageCommands.map((command) => command.status), [
        StorageStatusEnum.done,
        StorageStatusEnum.download,
      ]);
      f.dispose(time);
    });
  });

  test('application disposal cancels debounce and detaches all subscriptions', () {
    fakeAsync((time) {
      final f = HardwareFixture();
      final events = <ApplicationState>[];
      f.application.onChangedState.listen(events.add);
      f.gpio.motion.add(false);
      time.flushMicrotasks();
      f.application.dispose();
      f.storage.updateStatus(StorageStatusEnum.off);
      time.flushMicrotasks();
      f.application.update(const ApplicationState(isMenu: true));
      time.elapse(const Duration(milliseconds: 500));
      expect(events, isEmpty);
      f.dispose(time);
    });
  });
}
