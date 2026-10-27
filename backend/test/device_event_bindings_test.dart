import 'dart:async';

import 'package:dslideshow_backend/src/service/hardware/src/device_event_bindings.dart';
import 'package:dslideshow_backend/src/service/hardware/src/gpio_service.dart';
import 'package:dslideshow_backend/src/service/hardware/src/hardware_service_config.dart';
import 'package:dslideshow_backend/src/service/hardware/src/screen_service.dart';
import 'package:logging/logging.dart';
import 'package:test/test.dart';

import 'hardware_screen_test.dart' show FakeGPIO, FakeMqtt;
import 'screen_service_test.dart' show ControlledPower;

class _SlowCancelGPIO extends FakeGPIO {
  final cancellation = Completer<void>();
  bool cancellationStarted = false;
  late final input = StreamController<ButtonEvent>(
    onCancel: () {
      cancellationStarted = true;
      return cancellation.future;
    },
  );

  @override
  Stream<ButtonEvent> get onButtonEvent => input.stream;
}

void main() {
  test(
    'dispose waits for cancellation and leaves service ownership to caller',
    () async {
      final gpio = _SlowCancelGPIO();
      final mqtt = FakeMqtt();
      final screen = ScreenService(
        HardwareConfig.fromJson({}),
        power: ControlledPower(),
      );
      final notifications = <bool>[];
      final bindings = DeviceEventBindings(
        gpioService: gpio,
        mqttService: mqtt,
        screenService: screen,
        onButtonEvent: (_) => fail('Button delivered after cancellation'),
        onScreenPreparation: notifications.add,
        onAction: (_, _) => fail('MQTT action delivered after cancellation'),
        logger: Logger('bindings-test'),
      );
      addTearDown(() async {
        if (!gpio.cancellation.isCompleted) gpio.cancellation.complete();
        await bindings.dispose();
        await screen.dispose();
        await gpio.input.close();
        await gpio.release();
        await mqtt.close();
      });

      var disposed = false;
      final closing = bindings.dispose();
      closing.then((_) => disposed = true);
      expect(identical(bindings.dispose(), closing), isTrue);
      await Future<void>.delayed(Duration.zero);
      expect(gpio.cancellationStarted, isTrue);
      expect(disposed, isFalse);
      expect(gpio.released, isFalse);
      expect(mqtt.pause.hasListener, isFalse);
      expect(mqtt.screen.hasListener, isFalse);
      expect(mqtt.menu.hasListener, isFalse);
      gpio.cancellation.complete();
      await closing;
      expect(disposed, isTrue);

      mqtt.pause.add(true);
      mqtt.screen.add(true);
      mqtt.menu.add(true);
      gpio.motion.add(false);
      unawaited(screen.screenOff());
      await Future<void>.delayed(Duration.zero);
      expect(notifications, isEmpty);
      expect(screen.phase, ScreenPhase.fadingOut);
      expect(gpio.released, isFalse);
    },
  );
}
