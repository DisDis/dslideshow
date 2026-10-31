import 'dart:convert';

import 'package:dslideshow_backend/src/service/hardware/hardware.dart';
import 'package:dslideshow_backend/src/service/mqtt/mqtt_config.dart';
import 'package:dslideshow_backend/src/service/mqtt/mqtt_service.dart';
import 'package:fake_async/fake_async.dart';
import 'package:logging/logging.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:test/test.dart';

import 'helpers/capture_logs.dart';
import 'support/controlled_mqtt_client.dart';
import 'support/hardware_fixture.dart';

void main() {
  late ControlledMqttClient client;
  late ControlledMqttApplicationState application;
  late MqttService service;

  void create({bool enabled = true, bool cancelFailure = false}) {
    client = ControlledMqttClient();
    if (cancelFailure) {
      client.updateStream = CancellationFailureStream(client.messages.stream);
    }
    application = ControlledMqttApplicationState();
    service = MqttService(
      MqttConfig.fromJson({'enabled': enabled}),
      applicationStateService: application,
      client: client,
    );
    addTearDown(() async {
      await service.close();
      await client.messages.close();
      await application.changes.close();
    });
  }

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
    expect(client.publications, isEmpty);
  });

  test('connect subscribes commands and publishes discovery plus current state', () async {
    create();
    await connect();
    expect(service.isConnected, isTrue);
    expect(client.subscriptions, [
      ('homeassistant/switch/dslideshow_pause/set', MqttQos.atMostOnce),
      ('homeassistant/switch/dslideshow_screen/set', MqttQos.atMostOnce),
      ('homeassistant/switch/dslideshow_menu/set', MqttQos.atMostOnce),
    ]);
    final configs = client.publications.where((p) => p.topic.endsWith('/config'));
    expect(configs, hasLength(5));
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
    expect(client.publications.where((p) => p.topic.endsWith('/state')).map((p) => p.payload), [
      'OFF',
      'ON',
      'OFF',
      'ON',
      'done',
    ]);
    expect(client.updateListeners, 1);
    expect(application.listeners, 1);
  });

  test(
    'commands emit bool values and echo state; other topics and payloads do not act',
    () => captureLogs((records) async {
      create();
      await connect();
      client.publications.clear();
      final pause = <bool>[];
      final screen = <bool>[];
      final menu = <bool>[];
      final subscriptions = [
        service.onPause.listen(pause.add),
        service.onScreen.listen(screen.add),
        service.onMenu.listen(menu.add),
      ];
      final delivered = service.onMenu.first;
      client.receive([
        ('homeassistant/switch/dslideshow_pause/set', 'ON'),
        ('homeassistant/switch/dslideshow_screen/set', 'OFF'),
        ('homeassistant/switch/dslideshow_menu/set', 'ON'),
        ('homeassistant/switch/dslideshow_pause/state', 'ON'),
        ('homeassistant/switch/dslideshow_menu/set/suffix', 'ON'),
        ('homeassistant/switch/dslideshow_pause/set', 'private-payload'),
      ]);
      await delivered;
      expect(pause, [true]);
      expect(screen, [false]);
      expect(menu, [true]);
      expect(client.publications.map((p) => (p.topic, p.payload)), [
        ('homeassistant/switch/dslideshow_pause/state', 'ON'),
        ('homeassistant/switch/dslideshow_screen/state', 'OFF'),
        ('homeassistant/switch/dslideshow_menu/state', 'ON'),
      ]);
      final summary = records.singleWhere((r) => r.message.startsWith('event=commands '));
      expect(summary.message, contains('received=6 accepted=3 rejected=1 ignored=2'));
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
    client.publications.clear();
    // mqtt_client calls both callbacks for a successful automatic reconnect.
    client.onConnected!();
    client.onAutoReconnected!();
    expect(client.publications.where((p) => p.topic.endsWith('/config')), hasLength(5));
    expect(client.publications.where((p) => p.topic.endsWith('/state')).map((p) => p.payload), [
      'ON',
      'OFF',
      'ON',
      'OFF',
      'off',
    ]);
    expect(client.subscriptions, hasLength(3));
    expect(client.updateListeners, 1);
    expect(application.listeners, 1);
    client.publications.clear();
    final changed = service.onPause.first;
    client.receive([('homeassistant/switch/dslideshow_pause/set', 'OFF')]);
    expect(await changed, isFalse);
    expect(client.publications, hasLength(1));
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
        [('download', MqttQos.atMostOnce), ('off', MqttQos.atMostOnce), ('done', MqttQos.atMostOnce)],
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
      expect(client.publications, isEmpty);
      expect(
        records.map((r) => r.message),
        containsAll([
          startsWith('event=commandFailed action=pause type=StateError'),
          startsWith('event=statePublishFailed type=StateError'),
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
      final menuDone = service.onMenu.drain<void>();
      await service.close();
      await Future.wait([pauseDone, screenDone, menuDone]);
      expect(client.updateListeners, 0);
      expect(application.listeners, 0);
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
    final closing = service.close();
    expect(identical(service.close(), closing), isTrue);
    await closing;
    await done;
    expect(client.updateListeners, 0);
    expect(application.listeners, 0);
    expect(client.autoReconnect, isFalse);
    expect(service.isConnected, isFalse);
    final count = client.publications.length;
    application.update(const ApplicationState(isPaused: true));
    lateConnected();
    lateReconnected();
    client.receive([('homeassistant/switch/dslideshow_pause/set', 'ON')]);
    expect(client.publications, hasLength(count));
  });

  test('close during connect prevents late subscriptions and publication', () async {
    create();
    await client.connecting.future;
    await service.close();
    client.connected();
    await service.ready;
    expect(client.subscriptions, isEmpty);
    expect(client.publications, isEmpty);
    expect(client.updateListeners, 0);
    expect(application.listeners, 0);
    expect(service.isConnected, isFalse);
  });
}
