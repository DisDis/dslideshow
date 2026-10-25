import 'dart:async';

import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_backend/src/service/hardware/hardware.dart';
import 'package:dslideshow_backend/src/service/hardware/src/gpio_service.dart';
import 'package:dslideshow_backend/src/service/mqtt/mqtt_service.dart';
import 'package:dslideshow_backend/src/service/storage/storage.dart';
import 'package:dslideshow_backend/src/service/system_info/system_info_service.dart';
import 'package:dslideshow_backend/src/service/wifi/wifi_service.dart';
import 'package:dslideshow_common/rpc.dart';
import 'package:fake_async/fake_async.dart';
import 'package:test/test.dart';

import 'screen_service_test.dart' show ControlledPower;

class FakeGPIO implements GPIOService {
  final motion = StreamController<bool>.broadcast();
  final buttons = StreamController<ButtonEvent>.broadcast();
  bool released = false;
  @override
  Stream<bool> get onMotion => motion.stream;
  @override
  Stream<ButtonEvent> get onButtonEvent => buttons.stream;
  @override
  Future<void> init() async {}
  @override
  Future<void> release() async {
    released = true;
    await motion.close();
    await buttons.close();
  }

  @override
  set powerLED(bool? value) {}
}

class FakeRemote implements RemoteService {
  final screenCommands = <ScreenTurnCommand>[];
  final pending = <Completer<RpcResult>>[];
  bool hold = false;
  @override
  Future<RpcResult> send<T extends RpcCommand>(T command) async {
    if (command is ScreenTurnCommand) {
      screenCommands.add(command);
      if (hold) {
        final completion = Completer<RpcResult>();
        pending.add(completion);
        return completion.future;
      }
    }
    return EmptyResult.respond(command);
  }

  void acknowledge(int index) =>
      pending[index].complete(EmptyResult.respond(screenCommands[index]));
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class FakeMqtt implements MqttService {
  final pause = StreamController<bool>.broadcast();
  final screen = StreamController<bool>.broadcast();
  final menu = StreamController<bool>.broadcast();
  @override
  Stream<bool> get onPause => pause.stream;
  @override
  Stream<bool> get onScreen => screen.stream;
  @override
  Stream<bool> get onMenu => menu.stream;
  Future<void> close() async {
    await pause.close();
    await screen.close();
    await menu.close();
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class FakeStorage implements Storage {
  @override
  Future<void> init() async {}
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class FakeSystemInfo implements SystemInfoService {
  @override
  Future<Null> init() async => null;
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class UnusedWiFi implements WiFiService {
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class UnusedPowerOff implements PowerOffService {
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class HardwareFixture {
  final gpio = FakeGPIO();
  final remote = FakeRemote();
  final mqtt = FakeMqtt();
  final power = ControlledPower();
  late final ScreenService screen;
  late final ApplicationStateService application;
  late final HardwareService hardware;
  HardwareFixture() {
    final config = AppConfig.fromJson({
      'hardware': {'screenPowerOnTimerSec': 1},
    });
    screen = ScreenService(config.hardware, power: power);
    application = ApplicationStateService(
      screenService: screen,
      gpioService: gpio,
    );
    hardware = HardwareService(
      config,
      remote,
      FakeStorage(),
      gpio,
      screen,
      FakeSystemInfo(),
      remote,
      mqtt,
      UnusedWiFi(),
      UnusedPowerOff(),
      application,
    );
  }
  void dispose(FakeAsync time) {
    var done = false;
    hardware.dispose().then((_) => done = true);
    time.flushMicrotasks();
    // StreamSubscription.cancel may return a shared future created outside the
    // fake zone. Let its real microtasks finish, then drain virtual callbacks.
    addTearDown(() async {
      for (var i = 0; i < 20 && !done; i++) {
        await Future<void>.delayed(Duration.zero);
        time.flushMicrotasks();
      }
      expect(done, isTrue);
      hardware.dispose();
      await mqtt.close();
      expect(gpio.released, isTrue);
      expect(gpio.motion.hasListener, isFalse);
      expect(mqtt.screen.hasListener, isFalse);
      expect(time.pendingTimers, isEmpty);
    });
  }
}

void main() {
  test(
    'GPIO presence cancels sleep and restores both UI and application state',
    () {
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
    },
  );

  test(
    'manual lock RPC wins over GPIO and direct ON until explicitly unlocked',
    () {
      fakeAsync((time) {
        final f = HardwareFixture();
        f.hardware.executeCommand(ScreenLockCommand(id: 1, isLock: true));
        f.gpio.motion.add(true);
        f.hardware.executeCommand(ScreenTurnCommand(id: 2, enabled: true));
        time.elapse(const Duration(seconds: 2));
        expect(f.power.calls, [false]);
        expect(f.remote.screenCommands.map((c) => c.enabled), [false]);
        f.hardware.executeCommand(ScreenLockCommand(id: 3, isLock: false));
        f.hardware.executeCommand(ScreenTurnCommand(id: 4, enabled: true));
        time.flushMicrotasks();
        expect(f.power.calls, [false, true]);
        expect(f.remote.screenCommands.map((c) => c.enabled), [false]);
        time.elapse(ScreenService.wakeUpDelay);
        expect(f.remote.screenCommands.map((c) => c.enabled), [false, true]);
        f.dispose(time);
      });
    },
  );

  test(
    'screen notifications stay ordered while frontend acknowledges slowly',
    () {
      fakeAsync((time) {
        final f = HardwareFixture();
        f.remote.hold = true;
        f.gpio.motion.add(false);
        time.elapse(const Duration(seconds: 1));
        f.gpio.motion.add(true);
        time.flushMicrotasks();
        expect(f.remote.screenCommands.map((c) => c.enabled), [false]);
        f.remote.acknowledge(0);
        time.flushMicrotasks();
        expect(f.remote.screenCommands.map((c) => c.enabled), [false, true]);
        f.remote.acknowledge(1);
        time.flushMicrotasks();
        f.dispose(time);
      });
    },
  );

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
      expect(f.remote.screenCommands.map((c) => c.enabled), [false]);
    });
  });

  test(
    'application disposal cancels debounce and detaches both subscriptions',
    () {
      fakeAsync((time) {
        final f = HardwareFixture();
        final events = <ApplicationState>[];
        f.application.onChangedState.listen(events.add);
        f.gpio.motion.add(false);
        time.flushMicrotasks();
        f.application.dispose();
        time.flushMicrotasks();
        f.application.update(const ApplicationState(isMenu: true));
        time.elapse(const Duration(milliseconds: 500));
        expect(events, isEmpty);
        f.dispose(time);
      });
    },
  );
}
