import 'dart:async';

import 'package:dslideshow_backend/src/service/hardware/src/hardware_service_config.dart';
import 'package:dslideshow_backend/src/service/hardware/src/screen_power.dart';
import 'package:dslideshow_backend/src/service/hardware/src/screen_service.dart';
import 'package:fake_async/fake_async.dart';
import 'package:test/test.dart';

class ControlledPower implements ScreenPower {
  final calls = <bool>[];
  final pending = <Completer<void>>[];
  bool automatic = true;
  bool fail = false;
  int active = 0;
  int maxActive = 0;

  @override
  Future<void> setPower(bool enabled) async {
    calls.add(enabled);
    active++;
    if (active > maxActive) maxActive = active;
    try {
      if (fail) throw StateError('hardware failure');
      if (!automatic) {
        final completion = Completer<void>();
        pending.add(completion);
        await completion.future;
      }
    } finally {
      active--;
    }
  }
}

class Fixture {
  final power = ControlledPower();
  final events = <bool>[];
  late final ScreenService screen;

  Fixture({Duration fade = const Duration(seconds: 2)}) {
    screen = ScreenService(
      HardwareConfig.fromJson({'screenPowerOnTimerSec': 10}),
      preparationOffTime: fade,
      power: power,
    );
    screen.onStateChangePreparation.listen(events.add);
  }

  void dispose(FakeAsync time) {
    var done = false;
    screen.dispose().then((_) => done = true);
    time.flushMicrotasks();
    expect(done, isTrue);
    expect(time.pendingTimers, isEmpty);
  }
}

void main() {
  test('wake waits for hardware, then fades in before becoming on', () {
    fakeAsync((time) {
      final f = Fixture();
      f.screen.screenOff();
      time.elapse(const Duration(seconds: 2));
      expect(f.screen.phase, ScreenPhase.off);
      f.power.automatic = false;
      final results = <ScreenTransitionResult>[];
      final wake = f.screen.screenOn()..then(results.add);
      expect(f.screen.phase, ScreenPhase.wakingUp);
      time.flushMicrotasks();
      expect(f.events, [false]);
      f.power.pending.single.complete();
      time.flushMicrotasks();
      expect(f.screen.phase, ScreenPhase.fadingIn);
      expect(f.screen.isScreenOn, isTrue);
      expect(f.events, [false, true]);
      expect(results, isEmpty);
      time.elapse(const Duration(milliseconds: 1000));
      expect(identical(f.screen.screenOn(), wake), isTrue);
      time.elapse(const Duration(milliseconds: 999));
      expect(f.screen.phase, ScreenPhase.fadingIn);
      expect(results, isEmpty);
      time.elapse(const Duration(milliseconds: 1));
      expect(f.screen.phase, ScreenPhase.on);
      expect(results, [ScreenTransitionResult.applied]);
      expect(f.power.calls, [false, true]);
      f.dispose(time);
    });
  });

  test('reversing fade-out enters fadingIn without another hardware call', () {
    fakeAsync((time) {
      final f = Fixture(fade: const Duration(milliseconds: 3500));
      f.screen.screenOff();
      time.elapse(const Duration(seconds: 1));
      f.screen.screenOn();
      expect(f.screen.phase, ScreenPhase.fadingIn);
      time.elapse(const Duration(milliseconds: 3499));
      expect(f.screen.phase, ScreenPhase.fadingIn);
      expect(f.power.calls, isEmpty);
      time.elapse(const Duration(milliseconds: 1));
      expect(f.screen.phase, ScreenPhase.on);
      expect(f.events, [false, true]);
      f.dispose(time);
    });
  });

  test('new OFF cancels fade-in and ignores its old completion', () {
    fakeAsync((time) {
      final f = Fixture();
      f.screen.screenOff();
      time.elapse(const Duration(milliseconds: 500));
      final results = <ScreenTransitionResult>[];
      f.screen.screenOn().then(results.add);
      time.elapse(const Duration(seconds: 1));
      f.screen.screenOff();
      time.elapse(const Duration(seconds: 1));
      expect(results, [ScreenTransitionResult.cancelled]);
      expect(f.screen.phase, ScreenPhase.fadingOut);
      expect(f.power.calls, isEmpty);
      time.elapse(const Duration(seconds: 1));
      expect(f.screen.phase, ScreenPhase.off);
      expect(f.power.calls, [false]);
      expect(f.events, [false, true, false]);
      f.dispose(time);
    });
  });

  test('manual lock interrupts fade-in and keeps priority over presence', () {
    fakeAsync((time) {
      final f = Fixture();
      f.screen.screenOff();
      time.elapse(const Duration(seconds: 2));
      f.screen.screenOn();
      time.elapse(const Duration(seconds: 1));
      expect(f.screen.phase, ScreenPhase.fadingIn);
      f.screen.isScreenOffLock = true;
      f.screen.screenOn();
      time.elapse(const Duration(seconds: 1));
      expect(f.screen.phase, ScreenPhase.fadingOut);
      time.elapse(const Duration(seconds: 1));
      expect(f.screen.phase, ScreenPhase.off);
      expect(f.power.calls, [false, true, false]);
      f.dispose(time);
    });
  });

  test('absence during fade-in keeps its own grace deadline', () {
    fakeAsync((time) {
      final f = Fixture();
      f.screen.screenOff();
      time.elapse(const Duration(seconds: 2));
      f.screen.screenOn();
      time.elapse(const Duration(seconds: 1));
      f.screen.scheduleScreenOff();
      time.elapse(const Duration(seconds: 1));
      expect(f.screen.phase, ScreenPhase.waitingOff);
      time.elapse(const Duration(seconds: 9));
      expect(f.screen.phase, ScreenPhase.fadingOut);
      time.elapse(const Duration(seconds: 2));
      expect(f.screen.phase, ScreenPhase.off);
      expect(f.power.calls, [false, true, false]);
      f.dispose(time);
    });
  });

  test('presence after a brief absence reuses the unfinished fade-in', () {
    fakeAsync((time) {
      final f = Fixture();
      f.screen.screenOff();
      time.elapse(const Duration(seconds: 2));
      f.screen.screenOn();
      time.elapse(const Duration(seconds: 1));
      f.screen.scheduleScreenOff();
      time.elapse(const Duration(milliseconds: 250));
      final results = <ScreenTransitionResult>[];
      f.screen.screenOn().then(results.add);
      expect(f.screen.phase, ScreenPhase.fadingIn);
      time.elapse(const Duration(milliseconds: 749));
      expect(results, isEmpty);
      time.elapse(const Duration(milliseconds: 1));
      expect(f.screen.phase, ScreenPhase.on);
      expect(results, [ScreenTransitionResult.applied]);
      expect(f.events, [false, true]);
      expect(f.power.calls, [false, true]);
      f.dispose(time);
    });
  });

  test('disposing during fade-in cancels the pending ON completion', () {
    fakeAsync((time) {
      final f = Fixture();
      f.screen.screenOff();
      time.elapse(const Duration(seconds: 2));
      final results = <ScreenTransitionResult>[];
      f.screen.screenOn().then(results.add);
      time.flushMicrotasks();
      expect(f.screen.phase, ScreenPhase.fadingIn);
      f.dispose(time);
      time.elapse(const Duration(seconds: 3));
      expect(results, [ScreenTransitionResult.cancelled]);
      expect(f.screen.phase, ScreenPhase.disposed);
      expect(f.power.calls, [false, true]);
    });
  });

  for (final milliseconds in [0, 500, 1999]) {
    test(
      'presence at ${milliseconds}ms cancels fade and restores visibility',
      () {
        fakeAsync((time) {
          final f = Fixture();
          final results = <ScreenTransitionResult>[];
          f.screen.screenOff().then(results.add);
          time.elapse(Duration(milliseconds: milliseconds));
          f.screen.screenOn();
          time.elapse(const Duration(seconds: 5));
          expect(f.events, [false, true]);
          expect(f.power.calls, isEmpty);
          expect(f.screen.isScreenOn, isTrue);
          expect(f.screen.phase, ScreenPhase.on);
          expect(results, [ScreenTransitionResult.cancelled]);
          f.dispose(time);
        });
      },
    );
  }

  test('presence cancels grace period without starting fade', () {
    fakeAsync((time) {
      final f = Fixture();
      f.screen.scheduleScreenOff();
      time.elapse(const Duration(seconds: 9));
      f.screen.screenOn();
      time.elapse(const Duration(seconds: 20));
      expect(f.events, isEmpty);
      expect(f.power.calls, isEmpty);
      f.dispose(time);
    });
  });

  test('duplicate absence does not extend grace or restart fade', () {
    fakeAsync((time) {
      final f = Fixture();
      f.screen.scheduleScreenOff();
      time.elapse(const Duration(seconds: 5));
      f.screen.scheduleScreenOff();
      time.elapse(const Duration(seconds: 5));
      expect(f.screen.phase, ScreenPhase.fadingOut);
      time.elapse(const Duration(seconds: 1));
      f.screen.scheduleScreenOff();
      f.screen.screenOff();
      time.elapse(const Duration(seconds: 1));
      expect(f.power.calls, [false]);
      expect(f.screen.phase, ScreenPhase.off);
      f.screen.scheduleScreenOff();
      f.screen.screenOff();
      time.elapse(const Duration(seconds: 20));
      expect(f.events, [false]);
      expect(f.power.calls, [false]);
      f.dispose(time);
    });
  });

  test('cancelled fade A cannot complete fade B early', () {
    fakeAsync((time) {
      final f = Fixture();
      f.screen.screenOff();
      time.elapse(const Duration(seconds: 1));
      f.screen.screenOn();
      f.screen.screenOff();
      time.elapse(const Duration(seconds: 1));
      expect(f.screen.phase, ScreenPhase.fadingOut);
      expect(f.power.calls, isEmpty);
      time.elapse(const Duration(seconds: 1));
      expect(f.power.calls, [false]);
      expect(f.events, [false, true, false]);
      f.dispose(time);
    });
  });

  test('new absence after presence gets a full grace period', () {
    fakeAsync((time) {
      final f = Fixture();
      f.screen.scheduleScreenOff();
      time.elapse(const Duration(seconds: 9));
      f.screen.screenOn();
      f.screen.scheduleScreenOff();
      time.elapse(const Duration(seconds: 9));
      expect(f.events, isEmpty);
      time.elapse(const Duration(seconds: 3));
      expect(f.power.calls, [false]);
      f.dispose(time);
    });
  });

  test(
    'rapid changes and duplicate presence do not create extra hardware work',
    () {
      fakeAsync((time) {
        final f = Fixture();
        for (var i = 0; i < 20; i++) {
          f.screen.screenOff();
          time.elapse(const Duration(milliseconds: 20));
          f.screen.screenOn();
          f.screen.screenOn();
        }
        time.elapse(const Duration(seconds: 20));
        expect(f.power.calls, isEmpty);
        expect(f.events.length, 40);
        expect(f.screen.phase, ScreenPhase.on);
        f.dispose(time);
      });
    },
  );

  test('custom fade duration is used before powering off', () {
    fakeAsync((time) {
      final f = Fixture(fade: const Duration(milliseconds: 3500));
      f.screen.screenOff();
      time.elapse(const Duration(milliseconds: 3499));
      expect(f.power.calls, isEmpty);
      time.elapse(const Duration(milliseconds: 1));
      expect(f.power.calls, [false]);
      f.dispose(time);
    });
  });

  test(
    'presence on the fade deadline before hardware starts still cancels',
    () {
      fakeAsync((time) {
        final f = Fixture();
        Timer(const Duration(seconds: 2), f.screen.screenOn);
        f.screen.screenOff();
        time.elapse(const Duration(seconds: 4));
        expect(f.power.calls, isEmpty);
        expect(f.events, [false, true]);
        f.dispose(time);
      });
    },
  );

  test('in-flight OFF is followed by ON, without overlapping commands', () {
    fakeAsync((time) {
      final f = Fixture();
      f.power.automatic = false;
      f.screen.screenOff();
      time.elapse(const Duration(seconds: 2));
      expect(f.power.calls, [false]);
      f.screen.screenOn();
      f.screen.screenOn();
      time.flushMicrotasks();
      expect(f.events, [false]);
      expect(f.power.calls, [false]);
      f.power.pending[0].complete();
      time.flushMicrotasks();
      expect(f.power.calls, [false, true]);
      expect(f.events, [false]);
      f.power.pending[1].complete();
      time.flushMicrotasks();
      expect(f.events, [false, true]);
      expect(f.screen.phase, ScreenPhase.fadingIn);
      time.elapse(const Duration(seconds: 2));
      expect(f.screen.phase, ScreenPhase.on);
      expect(f.screen.isScreenOn, isTrue);
      expect(f.power.maxActive, 1);
      f.dispose(time);
    });
  });

  test('a stale OFF failure still reconciles the latest ON request', () {
    fakeAsync((time) {
      final f = Fixture();
      f.power.automatic = false;
      f.screen.screenOff();
      time.elapse(const Duration(seconds: 2));
      f.screen.screenOn();
      f.power.pending[0].completeError(StateError('late OFF failure'));
      time.flushMicrotasks();
      expect(f.power.calls, [false, true]);
      expect(f.events, [false]);
      f.power.pending[1].complete();
      time.flushMicrotasks();
      expect(f.screen.phase, ScreenPhase.fadingIn);
      time.elapse(const Duration(seconds: 2));
      expect(f.screen.phase, ScreenPhase.on);
      expect(f.events, [false, true]);
      expect(f.power.maxActive, 1);
      f.dispose(time);
    });
  });

  test('new OFF supersedes queued wake while old OFF is still running', () {
    fakeAsync((time) {
      final f = Fixture();
      f.power.automatic = false;
      f.screen.screenOff();
      time.elapse(const Duration(seconds: 2));
      f.screen.screenOn();
      f.screen.screenOff();
      time.elapse(const Duration(seconds: 2));
      f.power.pending.single.complete();
      time.flushMicrotasks();
      expect(f.power.calls, [false]);
      expect(f.events, [false]);
      expect(f.screen.phase, ScreenPhase.off);
      f.dispose(time);
    });
  });

  test('manual lock immediately starts sleep and ignores sensor presence', () {
    fakeAsync((time) {
      final f = Fixture();
      final results = <ScreenTransitionResult>[];
      f.screen.scheduleScreenOff();
      f.screen.isScreenOffLock = true;
      f.screen.screenOn().then(results.add);
      f.screen.scheduleScreenOff();
      time.elapse(const Duration(seconds: 2));
      expect(results, [ScreenTransitionResult.cancelled]);
      expect(f.power.calls, [false]);
      expect(f.events, [false]);
      f.screen.isScreenOffLock = false;
      f.screen.screenOn();
      time.flushMicrotasks();
      expect(f.power.calls, [false, true]);
      expect(f.events, [false, true]);
      f.dispose(time);
    });
  });

  test('manual lock supersedes an in-flight wake without a stale ON event', () {
    fakeAsync((time) {
      final f = Fixture();
      f.screen.screenOff();
      time.elapse(const Duration(seconds: 2));
      f.power.automatic = false;
      f.screen.screenOn();
      time.flushMicrotasks();
      f.screen.isScreenOffLock = true;
      f.screen.screenOn();
      time.elapse(const Duration(seconds: 2));
      f.power.pending[0].complete();
      time.flushMicrotasks();
      expect(f.power.calls, [false, true, false]);
      expect(f.events, [false]);
      f.power.pending[1].complete();
      time.flushMicrotasks();
      expect(f.screen.phase, ScreenPhase.off);
      expect(f.screen.isScreenOn, isFalse);
      expect(f.power.maxActive, 1);
      f.dispose(time);
    });
  });

  test(
    'failed hardware is not confirmed and does not poison later requests',
    () {
      fakeAsync((time) {
        final f = Fixture();
        final results = <ScreenTransitionResult>[];
        f.power.fail = true;
        f.screen.screenOff().then(results.add);
        time.elapse(const Duration(seconds: 2));
        expect(results, [ScreenTransitionResult.failed]);
        expect(f.screen.phase, ScreenPhase.failed);
        expect(f.screen.isScreenOn, isFalse);
        f.power.fail = false;
        f.screen.screenOn().then(results.add);
        time.flushMicrotasks();
        expect(f.screen.phase, ScreenPhase.fadingIn);
        expect(results, [ScreenTransitionResult.failed]);
        time.elapse(const Duration(seconds: 2));
        expect(results.last, ScreenTransitionResult.applied);
        expect(f.screen.phase, ScreenPhase.on);
        expect(f.events, [false, true]);
        f.dispose(time);
      });
    },
  );

  for (final waiting in [true, false]) {
    test('dispose cancels ${waiting ? "grace" : "fade"} and is idempotent', () {
      fakeAsync((time) {
        final f = Fixture();
        if (waiting) {
          f.screen.scheduleScreenOff();
        } else {
          f.screen.screenOff();
        }
        f.dispose(time);
        f.dispose(time);
        f.screen.screenOn();
        f.screen.screenOff();
        f.screen.scheduleScreenOff();
        time.elapse(const Duration(seconds: 20));
        expect(f.power.calls, isEmpty);
        expect(f.screen.phase, ScreenPhase.disposed);
      });
    });
  }

  test(
    'dispose waits for active hardware and skips queued work and events',
    () {
      fakeAsync((time) {
        final f = Fixture();
        f.power.automatic = false;
        f.screen.screenOff();
        time.elapse(const Duration(seconds: 2));
        f.screen.screenOn();
        var done = false;
        f.screen.dispose().then((_) => done = true);
        time.flushMicrotasks();
        expect(done, isFalse);
        f.power.pending.single.complete();
        time.flushMicrotasks();
        expect(done, isTrue);
        expect(f.power.calls, [false]);
        expect(f.events, [false]);
        expect(f.screen.phase, ScreenPhase.disposed);
        expect(time.pendingTimers, isEmpty);
      });
    },
  );
}
