import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_backend/src/service/hardware/hardware.dart';
import 'package:dslideshow_backend/src/service/hardware/src/device_event_bindings.dart';
import 'package:dslideshow_backend/src/service/hardware/src/night_mode_policy.dart';
import 'package:dslideshow_backend/src/service/mqtt/mqtt_service.dart';
import 'package:logging/logging.dart';

import 'controlled_mqtt_client.dart';
import 'controlled_screen_power.dart';
import 'hardware_fixture.dart' show FakeGPIO;

class MqttScreenFixture {
  MqttScreenFixture(NightModeConfig config) {
    policy = NightModePolicy(config);
    screen = ScreenService(
      HardwareConfig.fromJson({}),
      power: power,
      nightMode: policy,
      preparationOffTime: Duration.zero,
    );
    mqtt = MqttService(
      MqttConfig.fromJson({'enabled': true}),
      applicationStateService: application,
      screenService: screen,
      client: client,
      ambientLight: config.ambientLight,
    );
    bindings = DeviceEventBindings(
      gpioService: gpio,
      mqttService: mqtt,
      screenService: screen,
      onButtonEvent: (_) {},
      onScreenPreparation: (_) {},
      onAction: (_, _) => throw StateError('Unexpected frontend action in screen MQTT scenario'),
      logger: _log,
      nightMode: policy,
    );
  }

  static final _log = Logger('MqttScreenFixture');
  final gpio = FakeGPIO();
  final power = ControlledPower();
  final application = ControlledMqttApplicationState();
  final client = ControlledMqttClient();
  late final NightModePolicy policy;
  late final ScreenService screen;
  late final MqttService mqtt;
  late final DeviceEventBindings bindings;

  Future<void> connect() async {
    await client.connecting.future;
    client.connected();
    await mqtt.ready;
  }

  Future<void> close() async {
    await bindings.dispose();
    await mqtt.close();
    await screen.dispose();
    await policy.dispose();
    await gpio.release();
    await client.messages.close();
    await application.changes.close();
  }
}
