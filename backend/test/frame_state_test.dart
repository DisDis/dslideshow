import 'dart:async';

import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_backend/src/service/hardware/hardware.dart';
import 'package:dslideshow_common/rpc.dart';
import 'package:dslideshow_common/version.dart';
import 'package:fake_async/fake_async.dart';
import 'package:test/test.dart';

import 'hardware_screen_test.dart'
    show
        FakeGPIO,
        FakeMqtt,
        FakeStorage,
        FakeSystemInfo,
        UnusedWiFi,
        UnusedPowerOff;
import 'screen_service_test.dart' show ControlledPower;

class FrameRemote implements RemoteService {
  final commands = <RpcCommand>[];
  FrameFrontendState state = const FrameFrontendState(
    isPaused: false,
    isMenu: false,
    page: FramePage.slideshow,
    frontendVersion: 'running.frontend',
  );
  Completer<RpcResult>? pendingState;
  Completer<RpcResult>? pendingControl;
  Object? failure;
  @override
  Future<RpcResult> send<T extends RpcCommand>(T command) async {
    commands.add(command);
    if (command is GetFrameFrontendStateCommand) {
      if (failure != null) throw failure!;
      if (pendingState != null) return pendingState!.future;
      return GetFrameFrontendStateResult(id: command.id, state: state);
    }
    if (command is SetFrameControlCommand) {
      if (failure != null) throw failure!;
      if (pendingControl != null) return pendingControl!.future;
      state = FrameFrontendState(
        isPaused: command.control == FrameControl.pause
            ? command.enabled
            : state.isPaused,
        isMenu: command.control == FrameControl.menu
            ? command.enabled
            : state.isMenu,
        page: state.page,
        frontendVersion: state.frontendVersion,
      );
    }
    return EmptyResult.respond(command);
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class FrameFixture {
  final gpio = FakeGPIO();
  final mqtt = FakeMqtt();
  final remote = FrameRemote();
  final power = ControlledPower();
  late final ScreenService screen;
  late final ApplicationStateService application;
  late final HardwareService hardware;

  FrameFixture() {
    final config = AppConfig.fromJson({
      'hardware': {'screenPowerOnTimerSec': 10},
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

  Future<FrameState> snapshot() async {
    final result = await hardware.executeCommand(
      const GetFrameStateCommand(id: 5),
    );
    return (result as GetFrameStateResult).state;
  }

  void tearDown() => addTearDown(() async {
    await hardware.dispose();
    await mqtt.close();
  });

  void dispose(FakeAsync time) {
    var done = false;
    hardware.dispose().then((_) => done = true);
    time.flushMicrotasks();
    addTearDown(() async {
      for (var i = 0; i < 20 && !done; i++) {
        await Future<void>.delayed(Duration.zero);
        time.flushMicrotasks();
      }
      expect(done, isTrue);
      await mqtt.close();
      expect(gpio.motion.hasListener, isFalse);
      expect(time.pendingTimers, isEmpty);
    });
  }
}

void main() {
  test(
    'boot presence is unknown while existing MQTT motion default is kept',
    () async {
      final f = FrameFixture()..tearDown();
      final state = await f.snapshot();
      expect(state.presence, FramePresence.unknown);
      expect(state.presenceObservedAt, isNull);
      expect(f.application.state.isMotion, isTrue);
      expect(state.sampledAt.isUtc, isTrue);
      expect(state.backendVersion, ApplicationInfo.backendVersion);
      expect(state.frontend!.frontendVersion, 'running.frontend');
      expect(state.isScreenOn, isTrue);
      expect(state.isScreenLocked, isFalse);
      expect(state.screenPhase, FrameScreenPhase.on);
      for (final present in [false, true]) {
        f.gpio.motion.add(present);
        await Future<void>.delayed(Duration.zero);
        final observed = await f.snapshot();
        expect(
          observed.presence,
          present ? FramePresence.present : FramePresence.absent,
        );
        expect(observed.presenceObservedAt!.isUtc, isTrue);
        expect(f.application.state.isMotion, present);
      }
    },
  );

  test(
    'snapshot reports transitions, manual lock and failed power as unknown',
    () {
      fakeAsync((time) {
        final f = FrameFixture();
        final snapshots = <FrameState>[];
        f.screen.isScreenOffLock = true;
        f.snapshot().then(snapshots.add);
        time.flushMicrotasks();
        expect(snapshots.single.isScreenLocked, isTrue);
        expect(snapshots.single.isScreenOn, isTrue);
        expect(snapshots.single.screenPhase, FrameScreenPhase.fadingOut);
        f.power.fail = true;
        time.elapse(const Duration(seconds: 2));
        f.snapshot().then(snapshots.add);
        time.flushMicrotasks();
        expect(snapshots.last.isScreenOn, isNull);
        expect(snapshots.last.screenPhase, FrameScreenPhase.failed);
        f.dispose(time);
      });
    },
  );

  test('frontend failure preserves available backend telemetry', () async {
    final f = FrameFixture()..tearDown();
    f.remote.failure = StateError('frontend unavailable');
    final state = await f.snapshot();
    expect(state.frontend, isNull);
    expect(state.isScreenOn, isTrue);
    expect(state.backendVersion, ApplicationInfo.backendVersion);
  });

  test(
    'hung frontend is bounded, coalesced and can recover after late reply',
    () {
      fakeAsync((time) {
        final f = FrameFixture();
        final pending = Completer<RpcResult>();
        f.remote.pendingState = pending;
        final snapshots = <FrameState>[];
        for (var i = 0; i < 10; i++) {
          f.snapshot().then(snapshots.add);
        }
        time.elapse(const Duration(seconds: 3));
        expect(snapshots, hasLength(10));
        expect(snapshots.every((state) => state.frontend == null), isTrue);
        for (var i = 0; i < 10; i++) {
          f.snapshot().then(snapshots.add);
        }
        time.flushMicrotasks();
        expect(snapshots, hasLength(20));
        expect(
          f.remote.commands.whereType<GetFrameFrontendStateCommand>(),
          hasLength(1),
        );
        expect(time.pendingTimers, isEmpty);
        pending.complete(
          GetFrameFrontendStateResult(id: 0, state: f.remote.state),
        );
        time.flushMicrotasks();
        f.remote.pendingState = null;
        f.snapshot().then(snapshots.add);
        time.flushMicrotasks();
        expect(snapshots.last.frontend, isNotNull);
        expect(
          f.remote.commands.whereType<GetFrameFrontendStateCommand>(),
          hasLength(2),
        );
        expect(time.pendingTimers, isEmpty);
        f.dispose(time);
      });
    },
  );

  for (final control in FrameControl.values) {
    test(
      'absolute $control intent is forwarded once and returns fresh state',
      () async {
        final f = FrameFixture()..tearDown();
        final command = SetFrameControlCommand(
          id: 31,
          control: control,
          enabled: true,
        );
        final response =
            await f.hardware.executeCommand(command) as GetFrameStateResult;
        expect(response.id, 31);
        expect(
          f.remote.commands.whereType<SetFrameControlCommand>().single,
          same(command),
        );
        expect(f.remote.commands.last, isA<GetFrameFrontendStateCommand>());
        if (control == FrameControl.pause)
          expect(response.state.frontend!.isPaused, isTrue);
        if (control == FrameControl.menu)
          expect(response.state.frontend!.isMenu, isTrue);
      },
    );
  }

  test('control error keeps request id and is not retried', () async {
    final f = FrameFixture()..tearDown();
    f.remote.failure = StateError('frontend rejected control');
    final response = await f.hardware.executeCommand(
      const SetFrameControlCommand(
        id: 32,
        control: FrameControl.pause,
        enabled: true,
      ),
    );
    expect(response, isA<ErrorResult>());
    expect(response.id, 32);
    expect((response as ErrorResult).error, contains('rejected control'));
    expect(f.remote.commands, hasLength(1));
  });

  test('control snapshot does not reuse a poll started before acceptance', () {
    fakeAsync((time) {
      final f = FrameFixture();
      final oldState = f.remote.state;
      final oldPoll = Completer<RpcResult>();
      f.remote.pendingState = oldPoll;
      final polled = <FrameState>[];
      f.snapshot().then(polled.add);
      time.flushMicrotasks();
      f.remote.pendingState = null;
      final controlled = <RpcResult>[];
      f.hardware
          .executeCommand(
            const SetFrameControlCommand(
              id: 40,
              control: FrameControl.pause,
              enabled: true,
            ),
          )
          .then(controlled.add);
      time.flushMicrotasks();
      expect(
        (controlled.single as GetFrameStateResult).state.frontend!.isPaused,
        isTrue,
      );
      expect(polled, isEmpty);
      oldPoll.complete(GetFrameFrontendStateResult(id: 0, state: oldState));
      time.flushMicrotasks();
      expect(polled.single.frontend!.isPaused, isFalse);
      f.snapshot().then(polled.add);
      time.flushMicrotasks();
      expect(polled.last.frontend!.isPaused, isTrue);
      f.dispose(time);
    });
  });

  test('overlapping snapshots preserve each incoming RPC id', () async {
    final f = FrameFixture()..tearDown();
    final pending = Completer<RpcResult>();
    f.remote.pendingState = pending;
    final responses = [
      for (final id in [51, 52, 53])
        f.hardware.executeCommand(GetFrameStateCommand(id: id)),
    ];
    expect(
      f.remote.commands.whereType<GetFrameFrontendStateCommand>(),
      hasLength(1),
    );
    pending.complete(GetFrameFrontendStateResult(id: 0, state: f.remote.state));
    final results = await Future.wait(responses);
    expect(results.map((result) => result.id), [51, 52, 53]);
    expect(results.every((result) => result is GetFrameStateResult), isTrue);
  });

  test('late pre-control poll does not clear a newer pending snapshot', () {
    fakeAsync((time) {
      final f = FrameFixture();
      final oldState = f.remote.state;
      final oldPoll = Completer<RpcResult>();
      f.remote.pendingState = oldPoll;
      final polled = <FrameState>[];
      f.snapshot().then(polled.add);
      time.flushMicrotasks();
      final freshPoll = Completer<RpcResult>();
      f.remote.pendingState = freshPoll;
      final controlled = <RpcResult>[];
      f.hardware
          .executeCommand(
            const SetFrameControlCommand(
              id: 54,
              control: FrameControl.pause,
              enabled: true,
            ),
          )
          .then(controlled.add);
      time.flushMicrotasks();
      expect(
        f.remote.commands.whereType<GetFrameFrontendStateCommand>(),
        hasLength(2),
      );
      expect(controlled, isEmpty);

      oldPoll.complete(GetFrameFrontendStateResult(id: 0, state: oldState));
      time.flushMicrotasks();
      expect(polled.single.frontend!.isPaused, isFalse);
      f.snapshot().then(polled.add);
      time.flushMicrotasks();
      expect(
        f.remote.commands.whereType<GetFrameFrontendStateCommand>(),
        hasLength(2),
      );
      expect(polled, hasLength(1));

      freshPoll.complete(
        GetFrameFrontendStateResult(id: 0, state: f.remote.state),
      );
      time.flushMicrotasks();
      expect(
        (controlled.single as GetFrameStateResult).state.frontend!.isPaused,
        isTrue,
      );
      expect(controlled.single.id, 54);
      expect(polled.last.frontend!.isPaused, isTrue);
      expect(time.pendingTimers, isEmpty);
      f.dispose(time);
    });
  });

  test('dispose cancels a state read after control acknowledgement', () {
    fakeAsync((time) {
      final f = FrameFixture();
      final pending = Completer<RpcResult>();
      f.remote.pendingState = pending;
      final responses = <RpcResult>[];
      f.hardware
          .executeCommand(
            const SetFrameControlCommand(
              id: 55,
              control: FrameControl.menu,
              enabled: true,
            ),
          )
          .then(responses.add);
      time.flushMicrotasks();
      expect(
        f.remote.commands.whereType<SetFrameControlCommand>(),
        hasLength(1),
      );
      expect(
        f.remote.commands.whereType<GetFrameFrontendStateCommand>(),
        hasLength(1),
      );
      expect(responses, isEmpty);
      f.dispose(time);
      expect(responses.single, isA<ErrorResult>());
      expect(responses.single.id, 55);
      expect(
        (responses.single as ErrorResult).error,
        contains('Hardware service disposed'),
      );
      expect(time.pendingTimers, isEmpty);
      pending.completeError(StateError('Late disconnect'));
      time.flushMicrotasks();
    });
  });

  test(
    'dispose cancels a pending control timer and keeps the original RPC id',
    () {
      fakeAsync((time) {
        final f = FrameFixture();
        f.remote.pendingControl = Completer<RpcResult>();
        final responses = <RpcResult>[];
        f.hardware
            .executeCommand(
              const SetFrameControlCommand(
                id: 41,
                control: FrameControl.pause,
                enabled: true,
              ),
            )
            .then(responses.add);
        time.flushMicrotasks();
        f.dispose(time);
        expect(responses.single, isA<ErrorResult>());
        expect(responses.single.id, 41);
        expect(time.pendingTimers, isEmpty);
        f.remote.pendingControl!.completeError(StateError('late disconnect'));
        time.flushMicrotasks();
      });
    },
  );

  test('control timeout returns an error and ignores late acknowledgement', () {
    fakeAsync((time) {
      final f = FrameFixture();
      f.remote.pendingControl = Completer<RpcResult>();
      final responses = <RpcResult>[];
      f.hardware
          .executeCommand(
            const SetFrameControlCommand(
              id: 33,
              control: FrameControl.menu,
              enabled: true,
            ),
          )
          .then(responses.add);
      time.elapse(const Duration(seconds: 3));
      expect(responses.single, isA<ErrorResult>());
      expect(responses.single.id, 33);
      f.remote.pendingControl!.complete(const EmptyResult(id: 33));
      time.flushMicrotasks();
      expect(f.remote.commands, hasLength(1));
      expect(time.pendingTimers, isEmpty);
      f.dispose(time);
    });
  });

  test(
    'dispose releases pending RPC wait and timers without waiting for frontend',
    () async {
      final f = FrameFixture()..tearDown();
      f.remote.pendingState = Completer<RpcResult>();
      final response = f.hardware.executeCommand(
        const GetFrameStateCommand(id: 34),
      );
      await f.hardware.dispose();
      final result = await response;
      expect(result, isA<ErrorResult>());
      expect(result.id, 34);
      f.remote.pendingState!.completeError(StateError('late disconnect'));
      await Future<void>.delayed(Duration.zero);
      expect(
        await f.hardware.executeCommand(const GetFrameStateCommand(id: 35)),
        isA<ErrorResult>(),
      );
    },
  );
}
