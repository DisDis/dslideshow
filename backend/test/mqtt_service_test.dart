import 'dart:convert';

import 'package:dslideshow_backend/src/service/hardware/hardware.dart';
import 'package:dslideshow_backend/src/service/mqtt/mqtt_service.dart';
import 'package:dslideshow_backend/src/service/hardware/src/device_event_bindings.dart';
import 'package:fake_async/fake_async.dart';
import 'package:logging/logging.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:test/test.dart';

import 'helpers/capture_logs.dart';
import 'support/controlled_mqtt_client.dart';
import 'support/mqtt_screen_fixture.dart';
import 'support/hardware_fixture.dart';
import 'support/controlled_screen_power.dart';

import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_backend/src/service/hardware/src/night_mode_policy.dart';

void main() {
  late ControlledMqttClient client;
  late ControlledMqttApplicationState application;
  late ControlledMqttScreen screen;
  late MqttService service;
  Future<void>? serviceClosing;

  void create({
    bool enabled = true,
    bool cancelFailure = false,
    AmbientLightConfig light = const AmbientLightConfig(),
  }) {
    serviceClosing = null;
    client = ControlledMqttClient();
    if (cancelFailure) {
      client.updateStream = CancellationFailureStream(client.messages.stream);
    }
    application = ControlledMqttApplicationState();
    screen = ControlledMqttScreen();
    service = MqttService(
      MqttConfig.fromJson({'enabled': enabled}),
      applicationStateService: application,
      screenService: screen,
      client: client,
      ambientLight: light,
    );
    addTearDown(() async {
      await (serviceClosing ?? service.close());
      await client.messages.close();
      await application.changes.close();
      await screen.changes.close();
    });
  }

  Future<void> closeService() => serviceClosing = service.close();

  Future<void> connect() async {
    await client.connecting.future;
    client.connected();
    await service.ready;
  }

  test('disabled MQTT owns no connection or state subscription', () async {
    create(enabled: false);
    await service.ready;
    expect(client.connectCalls, 0);
    expect(client.updateListeners, 0);
    expect(application.listeners, 0);
    expect(screen.listeners, 0);
    expect(client.publications, isEmpty);
  });

  test('optional light accepts exact JSON topic and invalidates on reconnect', () async {
    create(
      light: const AmbientLightConfig(
        enabled: true,
        topic: 'zigbee2mqtt/bedroom',
        availabilityTopic: 'zigbee2mqtt/bedroom/availability',
      ),
    );
    final readings = <AmbientLightReading>[];
    final availability = <bool>[];
    final subscriptions = [
      service.onAmbientLight.listen(readings.add),
      service.onAmbientLightAvailability.listen(availability.add),
    ];
    await connect();
    expect(service.isAmbientLightAvailable, isFalse);
    expect(
      client.subscriptions.map((e) => e.$1),
      containsAll(['zigbee2mqtt/bedroom', 'zigbee2mqtt/bedroom/availability']),
    );
    final delivered = service.onAmbientLight.first;
    client.receive([
      ('zigbee2mqtt/bedroom/availability', ' \n {"state":"online"} \n'),
      (
        'zigbee2mqtt/bedroom',
        '{"battery":100,"device_temperature":25,"illuminance":6,"linkquality":144,"occupancy":true,"power_outage_count":20,"voltage":3025}',
      ),
    ]);
    expect((await delivered).lux, 6);
    expect(service.isAmbientLightAvailable, isTrue);
    expect(availability, [false, true]);
    final disconnected = service.onAmbientLightAvailability.first;
    client.onAutoReconnect!();
    expect(await disconnected, isFalse);
    expect(service.isAmbientLightAvailable, isFalse);
    client.onAutoReconnected!();
    expect(service.isAmbientLightAvailable, isFalse);
    final onlineAgain = service.onAmbientLightAvailability.first;
    client.receive([('zigbee2mqtt/bedroom/availability', 'online')]);
    expect(await onlineAgain, isTrue);
    expect(readings, hasLength(1));
    for (final sub in subscriptions) {
      await sub.cancel();
    }
  });

  test('light MQTT JSON numbers are converted to int without rounding', () async {
    create(light: const AmbientLightConfig(enabled: true, topic: 'light'));
    await connect();
    for (final value in <num>[6, 6.0, 6.9]) {
      final delivered = service.onAmbientLight.first;
      client.receive([
        ('light', jsonEncode({'illuminance': value})),
      ]);
      final reading = await delivered;
      expect(reading.lux, 6);
      expect(reading.lux, isA<int>());
    }
  });

  test('reconnect clears a reading received before sensor availability was known', () async {
    const light = AmbientLightConfig(enabled: true, topic: 'light', availabilityTopic: 'light/availability');
    create(light: light);
    final policy = NightModePolicy(
      const NightModeConfig(enabled: true, mode: NightMode.scheduleOrDarkness, ambientLight: light),
    );
    addTearDown(policy.dispose);
    final subscriptions = [
      service.onAmbientLight.listen(policy.updateLight),
      service.onAmbientLightAvailability.listen(policy.updateAvailability),
    ];
    addTearDown(() async {
      for (final subscription in subscriptions) {
        await subscription.cancel();
      }
    });
    await connect();
    client.receive([('light', '{"illuminance":20}')], retained: true);
    await pumpEventQueue();
    expect(policy.state.lightStatus, AmbientLightStatus.unavailable);
    expect(policy.state.illuminance, 20);

    client.onAutoReconnect!();
    await pumpEventQueue();
    expect(policy.state.illuminance, isNull);
    client.onAutoReconnected!();
    client.receive([('light/availability', 'online')]);
    await pumpEventQueue();
    expect(policy.state.lightStatus, AmbientLightStatus.unknown);
    expect(policy.state.automaticWakeBlocked, isTrue);

    client.receive([('light', '{"illuminance":20}')], retained: true);
    await pumpEventQueue();
    expect(policy.state.lightStatus, AmbientLightStatus.light);
  });

  for (final splitBatches in [false, true]) {
    test('light then offline preserves MQTT order across ${splitBatches ? 'adjacent batches' : 'one batch'}', () async {
      final fixture = MqttScreenFixture(
        const NightModeConfig(
          enabled: true,
          mode: NightMode.scheduleOrDarkness,
          ambientLight: AmbientLightConfig(enabled: true, topic: 'light', availabilityTopic: 'light/availability'),
        ),
      );
      addTearDown(fixture.close);
      await fixture.connect();
      fixture.client.receive([('light/availability', 'online')]);
      await pumpEventQueue();
      final readings = [('light', '{"illuminance":1}'), ('light', '{"illuminance":20}')];
      if (splitBatches) {
        fixture.client.receive(readings);
        fixture.client.receive([('light/availability', 'offline')]);
      } else {
        fixture.client.receive([...readings, ('light/availability', 'offline')]);
      }
      await pumpEventQueue();
      expect(fixture.policy.state.lightStatus, AmbientLightStatus.unavailable);
      expect(fixture.policy.state.illuminance, isNull);
      fixture.client.receive([('light/availability', 'online')]);
      await pumpEventQueue();
      expect(fixture.policy.state.lightStatus, AmbientLightStatus.unknown);
      expect(fixture.policy.state.illuminance, isNull);
      expect(fixture.policy.state.automaticWakeBlocked, isTrue);
      expect(fixture.screen.isScreenOn, isFalse);
    });
  }

  for (final splitBatches in [false, true]) {
    for (final explicitOnLast in [false, true]) {
      test('AND light and screen commands preserve order in ${splitBatches ? 'adjacent batches' : 'one batch'} '
          'ending with ${explicitOnLast ? 'screen ON' : 'darkness'}', () async {
        final now = DateTime.now();
        final minute = now.hour * 60 + now.minute;
        // Keep a valid schedule around the reception clock, with both
        // boundaries about twelve hours away from this short local scenario.
        final fixture = MqttScreenFixture(
          NightModeConfig(
            enabled: true,
            mode: NightMode.scheduleAndDarkness,
            startMinute: (minute + 720) % 1440,
            endMinute: (minute + 719) % 1440,
            ambientLight: const AmbientLightConfig(enabled: true, topic: 'light'),
          ),
        );
        addTearDown(fixture.close);
        await fixture.connect();
        fixture.screen.onPresence(true);
        fixture.client.receive([('light', '{"illuminance":20}')]);
        await pumpEventQueue();
        expect(fixture.policy.state.inSchedule, isTrue);
        expect(fixture.policy.state.lightStatus, AmbientLightStatus.light);
        expect(fixture.screen.isScreenOn, isTrue);

        const dark = ('light', '{"illuminance":1}');
        const screenOn = ('homeassistant/switch/dslideshow_screen/set', 'ON');
        final commands = explicitOnLast ? [dark, screenOn] : [screenOn, dark];
        if (splitBatches) {
          for (final command in commands) {
            fixture.client.receive([command]);
          }
        } else {
          fixture.client.receive(commands);
        }
        await pumpEventQueue();
        expect(fixture.policy.state.lightStatus, AmbientLightStatus.dark);
        expect(fixture.policy.state.automaticWakeBlocked, isTrue);
        expect(fixture.screen.isScreenOn, explicitOnLast);
        expect(fixture.screen.phase, explicitOnLast ? ScreenPhase.on : ScreenPhase.off);
      });
    }
  }

  test(
    'partial sensor packets do not refresh light age or produce warnings',
    () => captureLogs((records) async {
      create(light: const AmbientLightConfig(enabled: true, topic: 'light'));
      await connect();
      final readings = <AmbientLightReading>[];
      final subscription = service.onAmbientLight.listen(readings.add);
      addTearDown(subscription.cancel);
      client.receive([('light', '{"illuminance":6}')]);
      await pumpEventQueue();
      final receivedAt = readings.single.receivedAt;
      client.receive([('light', '{"occupancy":true,"battery":100}')]);
      await pumpEventQueue();
      expect(readings.single.receivedAt, receivedAt);
      expect(records.where((record) => record.level >= Level.WARNING), isEmpty);
    }),
  );

  test(
    'light parser rejects malformed readings with original errors and stacks',
    () => captureLogs((records) async {
      create(light: const AmbientLightConfig(enabled: true, topic: 'light'));
      await connect();
      final readings = <AmbientLightReading>[];
      final sub = service.onAmbientLight.listen(readings.add);
      client.receive([('light', '{'), ('light', '{"illuminance":-1}'), ('light', '{"illuminance":"bright"}')]);
      final received = service.onAmbientLight.first;
      client.receive([('light', '{"illuminance":7}')]);
      await received;
      expect(readings.map((e) => e.lux), [7]);
      final errors = records.where((e) => e.message.startsWith('Light MQTT message rejected')).toList();
      expect(errors, hasLength(3));
      expect(errors.every((e) => e.error is FormatException && e.stackTrace.toString().contains('_onUpdate')), isTrue);
      expect(errors.last.error.toString(), contains('Expected nonnegative lux'));
      await sub.cancel();
    }),
  );

  test('live and retained readings use reception time regardless of source timestamps', () async {
    create(light: const AmbientLightConfig(enabled: true, topic: 'light'));
    await connect();
    for (final retained in [false, true]) {
      final before = DateTime.now();
      final received = service.onAmbientLight.first;
      client.receive([
        ('light', jsonEncode({'illuminance': 6, if (!retained) 'measured_at': '2000-01-01T00:00:00Z'})),
      ], retained: retained);
      final reading = await received;
      final after = DateTime.now();
      expect(reading.lux, 6);
      expect(reading.receivedAt.isUtc, isTrue);
      expect(reading.receivedAt.isBefore(before), isFalse);
      expect(reading.receivedAt.isAfter(after), isFalse);
    }
  });

  test('connect subscribes commands and publishes discovery plus current state', () async {
    create();
    await connect();
    expect(service.isConnected, isTrue);
    expect(client.subscriptions, [
      ('homeassistant/switch/dslideshow_pause/set', MqttQos.atMostOnce),
      ('homeassistant/switch/dslideshow_screen/set', MqttQos.atMostOnce),
      ('homeassistant/switch/dslideshow_autoWake/set', MqttQos.atMostOnce),
      ('homeassistant/switch/dslideshow_menu/set', MqttQos.atMostOnce),
    ]);
    final configs = client.publications.where((p) => p.topic.endsWith('/config'));
    expect(configs, hasLength(7));
    final pause = jsonDecode(configs.first.payload) as Map<String, dynamic>;
    expect(pause['command_topic'], 'homeassistant/switch/dslideshow_pause/set');
    expect(pause['state_topic'], 'homeassistant/switch/dslideshow_pause/state');
    expect(pause['unique_id'], 'dslideshow_action_pause');
    expect((pause['device'] as Map)['ids'], ['dslideshow']);
    final storage = jsonDecode(
      configs.singleWhere((p) => p.topic == 'homeassistant/sensor/dslideshow_storageStatus/config').payload,
    ) as Map<String, dynamic>;
    expect(storage['state_topic'], 'homeassistant/sensor/dslideshow_storageStatus/state');
    expect(storage['unique_id'], 'dslideshow_action_storageStatus');
    expect(storage, isNot(contains('command_topic')));
    for (final (id, name) in [('screen', 'Экран'), ('autoWake', 'Автопробуждение экрана')]) {
      final discovery = configs.singleWhere((p) => p.topic == 'homeassistant/switch/dslideshow_$id/config');
      final value = jsonDecode(discovery.payload) as Map<String, dynamic>;
      expect(value['name'], name);
      expect(value['command_topic'], 'homeassistant/switch/dslideshow_$id/set');
      expect(value['retain'], isFalse);
      expect(value['optimistic'], isFalse);
      expect(discovery.retain, isTrue);
    }
    final phase = configs.singleWhere((p) => p.topic == 'homeassistant/sensor/dslideshow_screenPhase/config');
    expect((jsonDecode(phase.payload) as Map)['name'], 'Состояние экрана');
    expect(phase.retain, isTrue);
    expect(client.publications.where((p) => p.topic.endsWith('/state')).map((p) => p.payload), [
      'OFF',
      'OFF',
      'ON',
      'done',
      'ON',
      'ON',
      'on',
    ]);
    expect(client.updateListeners, 1);
    expect(application.listeners, 1);
    expect(screen.listeners, 1);
  });

  test(
    'commands emit bool values; screen controls wait for actual state and invalid commands do not act',
    () => captureLogs((records) async {
      create();
      await connect();
      client.publications.clear();
      final pause = <bool>[];
      final screen = <bool>[];
      final autoWake = <bool>[];
      final menu = <bool>[];
      final subscriptions = [
        service.onPause.listen(pause.add),
        service.onScreen.listen(screen.add),
        service.onAutoWake.listen(autoWake.add),
        service.onMenu.listen(menu.add),
      ];
      final delivered = service.onMenu.first;
      client.receive([
        ('homeassistant/switch/dslideshow_pause/set', 'ON'),
        ('homeassistant/switch/dslideshow_screen/set', 'OFF'),
        ('homeassistant/switch/dslideshow_autoWake/set', 'OFF'),
        ('homeassistant/switch/dslideshow_menu/set', 'ON'),
        ('homeassistant/switch/dslideshow_pause/state', 'ON'),
        ('homeassistant/switch/dslideshow_menu/set/suffix', 'ON'),
        ('homeassistant/switch/dslideshow_pause/set', 'private-payload'),
      ]);
      await delivered;
      expect(pause, [true]);
      expect(screen, [false]);
      expect(autoWake, [false]);
      expect(menu, [true]);
      expect(client.publications.map((p) => (p.topic, p.payload)), [
        ('homeassistant/switch/dslideshow_pause/state', 'ON'),
        ('homeassistant/switch/dslideshow_menu/state', 'ON'),
      ]);
      final summary = records.singleWhere((r) => r.message.startsWith('event=commands '));
      expect(summary.message, contains('received=7 accepted=4 rejected=1 ignored=2'));
      expect(records.map((r) => '${r.message} ${r.error ?? ''}').join(), isNot(contains('private-payload')));
      for (final subscription in subscriptions) {
        await subscription.cancel();
      }
    }),
  );

  test('reconnect republishes current state without duplicating subscriptions', () async {
    create();
    await connect();
    application.update(
      const ApplicationState(
        isPaused: true,
        isMenu: true,
        isScreenOn: false,
        isMotion: false,
        storageStatus: StorageStatusEnum.off,
      ),
    );
    screen.update(const ScreenState(isScreenOn: false, autoWakeEnabled: false, phase: ScreenPhase.off));
    client.publications.clear();
    // mqtt_client calls both callbacks for a successful automatic reconnect.
    client.onConnected!();
    client.onAutoReconnected!();
    expect(client.publications.where((p) => p.topic.endsWith('/config')), hasLength(7));
    expect(client.publications.where((p) => p.topic.endsWith('/state')).map((p) => p.payload), [
      'ON',
      'ON',
      'OFF',
      'off',
      'OFF',
      'OFF',
      'off',
    ]);
    expect(client.subscriptions, hasLength(4));
    expect(client.updateListeners, 1);
    expect(application.listeners, 1);
    expect(screen.listeners, 1);
    client.publications.clear();
    final changed = service.onPause.first;
    client.receive([('homeassistant/switch/dslideshow_pause/set', 'OFF')]);
    expect(await changed, isFalse);
    expect(client.publications, hasLength(1));
  });

  test('screen changes between onConnected and connect completion cannot leave stale retained state', () async {
    create();
    await client.connecting.future;
    client.status.state = MqttConnectionState.connected;
    client.onConnected!();
    screen.update(const ScreenState(isScreenOn: false, autoWakeEnabled: false, phase: ScreenPhase.off));
    client.connection.complete(client.status);
    await service.ready;
    expect(
      client.publications.lastWhere((p) => p.topic == 'homeassistant/switch/dslideshow_screen/state').payload,
      'OFF',
    );
    expect(
      client.publications.lastWhere((p) => p.topic == 'homeassistant/switch/dslideshow_autoWake/state').payload,
      'OFF',
    );
    expect(
      client.publications.lastWhere((p) => p.topic == 'homeassistant/sensor/dslideshow_screenPhase/state').payload,
      'off',
    );
    expect(screen.listeners, 1);
  });

  test('retained screen and auto-wake commands cannot replay old control intent', () async {
    create();
    await connect();
    client.publications.clear();
    final screenCommands = <bool>[];
    final wakeCommands = <bool>[];
    final subscriptions = [service.onScreen.listen(screenCommands.add), service.onAutoWake.listen(wakeCommands.add)];
    addTearDown(() async {
      for (final subscription in subscriptions) {
        await subscription.cancel();
      }
    });
    client.receive([
      ('homeassistant/switch/dslideshow_screen/set', 'ON'),
      ('homeassistant/switch/dslideshow_autoWake/set', 'ON'),
    ], retained: true);
    await pumpEventQueue();
    expect(screenCommands, isEmpty);
    expect(wakeCommands, isEmpty);
    expect(client.publications, isEmpty);

    client.receive([
      ('homeassistant/switch/dslideshow_screen/set', 'ON'),
      ('homeassistant/switch/dslideshow_autoWake/set', 'OFF'),
    ]);
    await pumpEventQueue();
    expect(screenCommands, [true]);
    expect(wakeCommands, [false]);
    expect(client.publications, isEmpty);
  });

  for (final (name, batches, expectedGate) in <(String, List<List<(String, String)>>, bool)>[
    (
      'one batch ending with auto wake OFF',
      [
        [
          ('homeassistant/switch/dslideshow_screen/set', 'OFF'),
          ('homeassistant/switch/dslideshow_screen/set', 'ON'),
          ('homeassistant/switch/dslideshow_autoWake/set', 'OFF'),
        ],
      ],
      false,
    ),
    (
      'adjacent batches ending with auto wake OFF',
      [
        [('homeassistant/switch/dslideshow_screen/set', 'OFF'), ('homeassistant/switch/dslideshow_screen/set', 'ON')],
        [('homeassistant/switch/dslideshow_autoWake/set', 'OFF')],
      ],
      false,
    ),
    (
      'adjacent batches ending with explicit screen ON',
      [
        [('homeassistant/switch/dslideshow_autoWake/set', 'OFF')],
        [('homeassistant/switch/dslideshow_screen/set', 'OFF'), ('homeassistant/switch/dslideshow_screen/set', 'ON')],
      ],
      true,
    ),
  ]) {
    test('MQTT arrival order is preserved across screen and wake controls: $name', () async {
      final gpio = FakeGPIO();
      final policy = NightModePolicy(const NightModeConfig());
      final actualScreen = ScreenService(
        HardwareConfig.fromJson({}),
        power: ControlledPower(),
        nightMode: policy,
        preparationOffTime: Duration.zero,
      );
      final mqttApplication = ControlledMqttApplicationState();
      final mqttClient = ControlledMqttClient();
      final mqtt = MqttService(
        MqttConfig.fromJson({'enabled': true}),
        applicationStateService: mqttApplication,
        screenService: actualScreen,
        client: mqttClient,
      );
      final bindings = DeviceEventBindings(
        gpioService: gpio,
        mqttService: mqtt,
        screenService: actualScreen,
        onButtonEvent: (_) {},
        onScreenPreparation: (_) {},
        onAction: (_, _) => fail('Screen controls must not be sent through the frontend'),
        logger: Logger('mqtt-control-order'),
        nightMode: policy,
      );
      addTearDown(() async {
        await bindings.dispose();
        await mqtt.close();
        await actualScreen.dispose();
        await policy.dispose();
        await gpio.release();
        await mqttClient.messages.close();
        await mqttApplication.changes.close();
      });
      await mqttClient.connecting.future;
      mqttClient.connected();
      await mqtt.ready;
      for (final batch in batches) {
        mqttClient.receive(batch);
      }
      await pumpEventQueue();
      expect(actualScreen.autoWakeEnabled, expectedGate);
      expect(actualScreen.phase, ScreenPhase.on);
      expect(actualScreen.isScreenOn, isTrue);
    });
  }

  test('screen state follows confirmed power and phase immediately rather than command or application echo', () async {
    create();
    await connect();
    client.publications.clear();
    screen.update(const ScreenState(isScreenOn: false, autoWakeEnabled: false, phase: ScreenPhase.off));
    expect(client.publications.map((p) => (p.topic, p.payload)), [
      ('homeassistant/switch/dslideshow_screen/state', 'OFF'),
      ('homeassistant/switch/dslideshow_autoWake/state', 'OFF'),
      ('homeassistant/sensor/dslideshow_screenPhase/state', 'off'),
    ]);
    expect(client.publications.every((p) => p.retain), isTrue);
    client.publications.clear();

    application.update(const ApplicationState(isScreenOn: true));
    expect(client.publications.any((p) => p.topic == 'homeassistant/switch/dslideshow_screen/state'), isFalse);
    client.publications.clear();
    client.receive([('homeassistant/switch/dslideshow_screen/set', 'ON')]);
    await pumpEventQueue();
    expect(client.publications, isEmpty);

    screen.update(const ScreenState(isScreenOn: false, autoWakeEnabled: true, phase: ScreenPhase.wakingUp));
    expect(client.publications.first.payload, 'OFF');
    expect(client.publications.last.payload, 'wakingUp');
    client.publications.clear();
    screen.update(const ScreenState(isScreenOn: true, autoWakeEnabled: true, phase: ScreenPhase.wakingUp));
    expect(client.publications.first.payload, 'ON');
    expect(client.publications.last.payload, 'wakingUp');
  });

  test('all reported phases use telemetry names and unknown power resets the switch state', () async {
    create();
    await connect();
    client.publications.clear();
    for (final phase in ScreenPhase.values) {
      screen.update(ScreenState(isScreenOn: true, autoWakeEnabled: true, phase: phase));
    }
    expect(
      client.publications
          .where((p) => p.topic == 'homeassistant/sensor/dslideshow_screenPhase/state')
          .map((p) => p.payload),
      ['on', 'waitingOff', 'fadingOut', 'poweringOff', 'off', 'wakingUp', 'fadingIn', 'failed', 'unknown'],
    );
    client.publications.clear();
    screen.update(const ScreenState(isScreenOn: null, autoWakeEnabled: true, phase: ScreenPhase.failed));
    expect(client.publications.first.payload, 'None');
    expect(client.publications.first.retain, isTrue);
    expect(client.publications.last.payload, 'failed');
  });

  test('real screen transitions publish power only after hardware confirmation and explicit ON restores auto wake', () {
    fakeAsync((time) {
      final fixture = HardwareFixture();
      final mqttClient = ControlledMqttClient();
      final mqtt = MqttService(
        MqttConfig.fromJson({'enabled': true}),
        applicationStateService: fixture.application,
        screenService: fixture.screen,
        client: mqttClient,
      );
      mqttClient.connected();
      time.flushMicrotasks();
      mqttClient.publications.clear();
      Iterable<String> values(String suffix) => mqttClient.publications
          .where((publication) => publication.topic.endsWith(suffix))
          .map((publication) => publication.payload);

      fixture.screen.screenOff();
      time.flushMicrotasks();
      expect(values('screen/state').last, 'ON');
      expect(values('screenPhase/state').last, 'fadingOut');
      time.elapse(const Duration(milliseconds: 1999));
      expect(values('screen/state').last, 'ON');
      time.elapse(const Duration(milliseconds: 1));
      expect(values('screen/state').last, 'OFF');
      expect(values('screenPhase/state').last, 'off');

      fixture.screen.autoWakeEnabled = false;
      time.flushMicrotasks();
      expect(values('autoWake/state').last, 'OFF');
      fixture.screen.screenOn();
      time.flushMicrotasks();
      expect(values('autoWake/state').last, 'ON');
      expect(values('screen/state').last, 'ON');
      expect(values('screenPhase/state').last, 'wakingUp');
      time.elapse(const Duration(seconds: 4));
      expect(
        values('screenPhase/state'),
        containsAllInOrder(['fadingOut', 'poweringOff', 'off', 'wakingUp', 'fadingIn', 'on']),
      );
      expect(
        mqttClient.publications
            .where(
              (publication) =>
                  publication.topic.endsWith('autoWake/state') ||
                  publication.topic.endsWith('screen/state') ||
                  publication.topic.endsWith('screenPhase/state'),
            )
            .every((publication) => publication.retain),
        isTrue,
      );
      addTearDown(mqttClient.messages.close);
      fixture.dispose(time, additionalCleanup: mqtt.close());
    });
  });

  test(
    'application changes publish each storage status on the sensor state topic',
    () => captureLogs((records) async {
      create();
      await connect();
      client.publications.clear();
      for (final status in StorageStatusEnum.values) {
        application.update(ApplicationState(storageStatus: status));
      }
      expect(
        client.publications
            .where((p) => p.topic == 'homeassistant/sensor/dslideshow_storageStatus/state')
            .map((p) => (p.payload, p.qos)),
        [
          ('download', MqttQos.atMostOnce),
          ('off', MqttQos.atMostOnce),
          ('done', MqttQos.atMostOnce),
          ('error', MqttQos.atMostOnce),
        ],
      );
      expect(
        records.any(
          (record) => record.level == Level.FINE && record.message == 'event=statePublished storageStatus=off',
        ),
        isTrue,
      );
    }),
  );

  test(
    'connection failure logs the original error and stack',
    () => captureLogs((records) async {
      create();
      await client.connecting.future;
      final error = StateError('private connection URL');
      final stack = StackTrace.fromString('#0 mqtt-connect-source\n#1 mqtt-connect-caller');
      client.connection.completeError(error, stack);
      await service.ready;
      expect(service.isConnected, isFalse);
      expect(client.disconnectCalls, 1);
      expect(application.listeners, 0);
      final failure = records.singleWhere((r) => r.message.startsWith('event=connectFailed '));
      expect(failure.level, Level.WARNING);
      expect(failure.message, contains('type=StateError'));
      expect(failure.error, isA<StateError>());
      expect(failure.stackTrace, isNotNull);
      expect(failure.error, same(error));
      expect(failure.stackTrace, same(stack));
    }),
  );

  test('MQTT storage publication uses the shared trailing application debounce', () {
    fakeAsync((time) {
      final fixture = HardwareFixture();
      final mqttClient = ControlledMqttClient();
      final mqtt = MqttService(
        MqttConfig.fromJson({'enabled': true}),
        applicationStateService: fixture.application,
        screenService: fixture.screen,
        client: mqttClient,
      );
      mqttClient.connected();
      time.flushMicrotasks();
      mqttClient.publications.clear();
      fixture.application.update(fixture.application.state.copyWith(isMenu: true));
      time.elapse(const Duration(milliseconds: 250));
      fixture.storage.updateStatus(StorageStatusEnum.download);
      time.flushMicrotasks();
      time.elapse(const Duration(milliseconds: 499));
      expect(mqttClient.publications, isEmpty);
      time.elapse(const Duration(milliseconds: 1));
      expect(
        mqttClient.publications
            .where((publication) => publication.topic.endsWith('storageStatus/state'))
            .map((p) => p.payload),
        ['download'],
      );
      expect(
        mqttClient.publications.singleWhere((p) => p.topic == 'homeassistant/switch/dslideshow_menu/state').payload,
        'ON',
      );
      mqttClient.publications.clear();
      fixture.storage.updateStatus(StorageStatusEnum.off);
      fixture.storage.updateStatus(StorageStatusEnum.done);
      time.flushMicrotasks();
      expect(mqttClient.publications, isEmpty);
      time.elapse(const Duration(milliseconds: 500));
      expect(
        mqttClient.publications
            .where((publication) => publication.topic.endsWith('storageStatus/state'))
            .map((p) => p.payload),
        ['done'],
      );
      addTearDown(mqttClient.messages.close);
      fixture.dispose(time, additionalCleanup: mqtt.close());
    });
  });

  test(
    'publish failure does not escape the stream and later commands recover',
    () => captureLogs((records) async {
      create();
      await connect();
      client.publications.clear();
      client.publishError = StateError('private publish payload');
      client.receive([('homeassistant/switch/dslideshow_pause/set', 'ON')]);
      application.update(const ApplicationState(isPaused: true));
      screen.update(const ScreenState(isScreenOn: null, autoWakeEnabled: true, phase: ScreenPhase.failed));
      expect(client.publications, isEmpty);
      expect(
        records.map((r) => r.message),
        containsAll([
          startsWith('event=commandFailed action=pause type=StateError'),
          startsWith('event=statePublishFailed type=StateError'),
          startsWith('event=screenStatePublishFailed phase=failed type=StateError'),
        ]),
      );
      expect(records.where((r) => r.error != null), isNotEmpty);
      expect(
        records
            .where((r) => r.error != null)
            .every((r) => identical(r.error, client.publishError) && r.stackTrace != null),
        isTrue,
      );
      expect(records.map((r) => r.message).join(), isNot(contains('private publish payload')));
      client.publishError = null;
      final changed = service.onPause.first;
      client.receive([('homeassistant/switch/dslideshow_pause/set', 'OFF')]);
      expect(await changed, isFalse);
      expect(client.publications.single.payload, 'OFF');
    }),
  );

  test(
    'failed cancellation still disconnects and closes all owned streams',
    () => captureLogs((records) async {
      create(cancelFailure: true);
      await connect();
      final pauseDone = service.onPause.drain<void>();
      final screenDone = service.onScreen.drain<void>();
      final autoWakeDone = service.onAutoWake.drain<void>();
      final menuDone = service.onMenu.drain<void>();
      await closeService();
      await Future.wait([pauseDone, screenDone, autoWakeDone, menuDone]);
      expect(client.updateListeners, 0);
      expect(application.listeners, 0);
      expect(screen.listeners, 0);
      expect(client.disconnectCalls, 1);
      expect(service.isConnected, isFalse);
      final failure = records.singleWhere((record) => record.message.startsWith('event=cancelFailed '));
      expect(failure.level, Level.WARNING);
      expect(failure.message, contains('type=StateError'));
      expect(failure.message, isNot(contains('private cancellation URL')));
      expect(failure.error, isA<StateError>());
      expect(failure.stackTrace, isNotNull);
    }),
  );

  test('close releases subscriptions and ignores queued callbacks and state', () async {
    create();
    await connect();
    final lateConnected = client.onConnected!;
    final lateReconnected = client.onAutoReconnected!;
    final done = service.onPause.drain<void>();
    final closing = closeService();
    await closing;
    await done;
    expect(client.updateListeners, 0);
    expect(application.listeners, 0);
    expect(screen.listeners, 0);
    expect(client.autoReconnect, isFalse);
    expect(service.isConnected, isFalse);
    final count = client.publications.length;
    application.update(const ApplicationState(isPaused: true));
    screen.update(const ScreenState(isScreenOn: false, autoWakeEnabled: false, phase: ScreenPhase.off));
    lateConnected();
    lateReconnected();
    client.receive([('homeassistant/switch/dslideshow_pause/set', 'ON')]);
    expect(client.publications, hasLength(count));
  });

  test('close during connect prevents late subscriptions and publication', () async {
    create();
    await client.connecting.future;
    expect(screen.listeners, 1);
    await closeService();
    client.connected();
    await service.ready;
    expect(client.subscriptions, isEmpty);
    expect(client.publications, isEmpty);
    expect(client.updateListeners, 0);
    expect(application.listeners, 0);
    expect(screen.listeners, 0);
    expect(service.isConnected, isFalse);
  });
}
