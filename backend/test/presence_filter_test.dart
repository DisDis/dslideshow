import 'package:dslideshow_backend/src/service/hardware/src/presence_filter.dart';
import 'package:dslideshow_backend/src/service/hardware/src/gpio_service_impl.dart';
import 'package:dslideshow_backend/src/service/hardware/src/hardware_service_config.dart';
import 'package:fake_async/fake_async.dart';
import 'package:test/test.dart';

void main() {
  test('GPIO cleanup before initialization is safe and idempotent', () async {
    final gpio = GPIOServiceImpl(HardwareConfig.fromJson({}));
    final motionDone = expectLater(gpio.onMotion, emitsDone);
    final buttonsDone = expectLater(gpio.onButtonEvent, emitsDone);
    await gpio.release();
    await gpio.release();
    await motionDone;
    await buttonsDone;
    // The guard runs before any native GPIO access.
    await expectLater(gpio.init(), throwsStateError);
  });

  test(
    'presence is immediate; brief absence and duplicates are suppressed',
    () {
      fakeAsync((time) {
        final events = <bool>[];
        var level = true;
        final filter = PresenceFilter(
          absenceDelay: const Duration(milliseconds: 100),
          readLevel: () => level,
          onChanged: events.add,
        );
        filter.sample();
        expect(events, [true]);
        level = false;
        filter.onLevel(false);
        time.elapse(const Duration(milliseconds: 99));
        level = true;
        filter.onLevel(true);
        filter.onLevel(true);
        time.elapse(const Duration(seconds: 2));
        expect(events, [true]);
        level = false;
        filter.onLevel(false);
        time.elapse(const Duration(milliseconds: 50));
        filter.onLevel(false);
        time.elapse(const Duration(milliseconds: 50));
        expect(events, [true, false]);
        level = true;
        filter.onLevel(true);
        expect(events, [true, false, true]);
        filter.dispose();
        expect(time.pendingTimers, isEmpty);
      });
    },
  );

  test(
    'absence confirmation re-reads actual level even without a rising event',
    () {
      fakeAsync((time) {
        final events = <bool>[];
        final filter = PresenceFilter(
          absenceDelay: const Duration(milliseconds: 100),
          readLevel: () => true,
          onChanged: events.add,
        );
        filter.onLevel(false);
        time.elapse(const Duration(milliseconds: 100));
        expect(events, [true]);
        filter.dispose();
      });
    },
  );

  test(
    'initial low level is published; disposal cancels reads and callbacks',
    () {
      fakeAsync((time) {
        final events = <bool>[];
        var reads = 0;
        final filter = PresenceFilter(
          absenceDelay: const Duration(milliseconds: 100),
          readLevel: () {
            reads++;
            return false;
          },
          onChanged: events.add,
        );
        filter.sample();
        time.elapse(const Duration(milliseconds: 100));
        expect(events, [false]);
        filter.onLevel(true);
        filter.onLevel(false);
        final before = reads;
        filter.dispose();
        filter.dispose();
        filter.sample();
        filter.onLevel(true);
        time.elapse(const Duration(seconds: 5));
        expect(events, [false, true]);
        expect(reads, before);
        expect(time.pendingTimers, isEmpty);
      });
    },
  );
}
