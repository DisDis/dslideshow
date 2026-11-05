import 'dart:async';
import 'dart:convert';

import 'package:dslideshow_backend/src/service/hardware/hardware.dart';
import 'package:dslideshow_common/version.dart';
import 'package:logging/logging.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

import 'mqtt_config.dart';
import '../hardware/src/night_mode_config.dart';
import '../hardware/src/night_mode_policy.dart';

enum _MqttAction { pause, screen, autoWake, menu }

class MqttService {
  static final Logger _log = new Logger('MqttService');
  final MqttConfig _config;
  final MqttServerClient _client;
  final String _prefixPauseTopic;
  final String _prefixScreenTopic;
  final String _prefixAutoWakeTopic;
  final String _prefixScreenPhaseTopic;
  final String _prefixMenuTopic;
  final String _prefixMotionTopic;
  final String _prefixStorageStatusTopic;
  final ApplicationStateService applicationStateService;
  final ScreenService screenService;
  final AmbientLightConfig ambientLight;
  bool _deviceLightOnline = false;
  bool _ambientLightAvailable = false;
  // Apply related inputs in arrival order with screen commands. Consumers only
  // accept the decision here; state publication and native work stay deferred.
  final _lightReadings = StreamController<AmbientLightReading>.broadcast(sync: true);
  final _lightAvailability = StreamController<bool>.broadcast(sync: true);

  Stream<AmbientLightReading> get onAmbientLight => _lightReadings.stream;
  Stream<bool> get onAmbientLightAvailability => _lightAvailability.stream;
  bool get isAmbientLightAvailable => _ambientLightAvailable;

  /// The completion of the initial connection attempt, including a safe failure.
  late final Future<void> ready;
  StreamSubscription<List<MqttReceivedMessage<MqttMessage>>>? _updates;
  StreamSubscription<ApplicationState>? _applicationChanges;
  StreamSubscription<ScreenState>? _screenChanges;
  bool _closed = false;
  bool _connectedBefore = false;

  final StreamController<bool> _scPause = new StreamController.broadcast();
  Stream<bool> get onPause => _scPause.stream;

  final StreamController<bool> _scMenu = new StreamController.broadcast();
  Stream<bool> get onMenu => _scMenu.stream;

  // These controls share screen intent. Deliver in MQTT arrival order across
  // both topics; native work is deferred by ScreenService, not these streams.
  final StreamController<bool> _scScreen = StreamController.broadcast(sync: true);
  Stream<bool> get onScreen => _scScreen.stream;

  final StreamController<bool> _scAutoWake = StreamController.broadcast(sync: true);
  Stream<bool> get onAutoWake => _scAutoWake.stream;

  bool get isConnected => !_closed && _client.connectionStatus?.state == MqttConnectionState.connected;

  MqttService(
    this._config, {
    required this.applicationStateService,
    required this.screenService,
    MqttServerClient? client,
    this.ambientLight = const AmbientLightConfig(),
  }) : _client = client ?? MqttServerClient.withPort(_config.server, _config.clientId, _config.serverPort),
       _prefixPauseTopic = _config.getDiscoveryPrefix('switch', 'pause'),
       _prefixScreenTopic = _config.getDiscoveryPrefix('switch', 'screen'),
       _prefixAutoWakeTopic = _config.getDiscoveryPrefix('switch', 'autoWake'),
       _prefixScreenPhaseTopic = _config.getDiscoveryPrefix('sensor', 'screenPhase'),
       _prefixMenuTopic = _config.getDiscoveryPrefix('switch', 'menu'),
       _prefixStorageStatusTopic = _config.getDiscoveryPrefix(SensorType.sensor.value, 'storageStatus'),
       _prefixMotionTopic = _config.getDiscoveryPrefix(SensorType.binarySensor.value, 'motion') {
    ready = _config.enabled ? _init() : Future<void>.value();
  }

  Future<void> _init() async {
    _client.logging(on: false);
    _client.setProtocolV311();
    _client.keepAlivePeriod = _config.keepAlivePeriod;
    _client.onDisconnected = _onDisconnected;
    _client.onConnected = _onConnected;
    _client.onAutoReconnected = _onAutoReconnected;
    _client.onAutoReconnect = _onDisconnected;
    _client.autoReconnect = true;
    _client.resubscribeOnAutoReconnect = true;

    final discovery_topic = _config.getDiscoveryPrefix('info', "device");
    final connMess = MqttConnectMessage()
        .withClientIdentifier(_config.clientId) // Must agree with the keep alive set above or not set
        // .withWillTopic(mqttConfig.discovery_prefix + mqttConfig.configuration_topic) // If you set this you must set a will message
        // .withWillMessage(configPayload)
        .withWillTopic(discovery_topic) // If you set this you must set a will message
        .withWillMessage(' ')
        .startClean() // Non persistent session for testing
        .withWillQos(MqttQos.atLeastOnce);

    _log.info('event=connecting');
    _client.connectionMessage = connMess;
    _screenChanges = screenService.onStateChanged.listen(_publishScreenState);

    /// Connect the client, any errors here are communicated by raising of the appropriate exception. Note
    /// in some circumstances the broker will just disconnect us, see the spec about this, we however eill
    /// never send malformed messages.
    try {
      await _client.connect(_config.user, _config.pass);
    } catch (error, stack) {
      if (!_closed) {
        _log.warning('event=connectFailed type=${error.runtimeType}', error, stack);
      }
      _client.disconnect();
      return;
    }

    if (_closed) {
      _client.disconnect();
      return;
    }

    /// Check we are connected
    if (isConnected) {
      _log.info('event=connected');
      _updates = _client.updates?.listen(
        _onUpdate,
        onError: (Object error, StackTrace stack) =>
            _log.warning('event=updatesFailed type=${error.runtimeType}', error, stack),
      );
      _applicationChanges = applicationStateService.onChangedState.listen(_onApplicationChangeState);
    } else {
      _log.warning('event=connectRejected state=${_client.connectionStatus?.state.name}');
      _client.disconnect();
    }
  }

  void _onUpdate(List<MqttReceivedMessage<MqttMessage>> msgs) {
    if (_closed || !isConnected) return;
    var accepted = 0;
    var rejected = 0;
    var ignored = 0;
    var lightMessages = 0;
    for (final element in msgs) {
      if (ambientLight.enabled &&
          (element.topic == ambientLight.topic || element.topic == ambientLight.availabilityTopic)) {
        lightMessages++;
        try {
          final payload = element.payload;
          if (payload is! MqttPublishMessage) throw const FormatException('Expected light MQTT publish');
          final value = MqttPublishPayload.bytesToStringAsString(payload.payload.message).trim();
          if (element.topic == ambientLight.availabilityTopic) {
            final raw = value.startsWith('{') ? jsonDecode(value) : value;
            final status = raw is Map ? raw['state'] : raw;
            if (status != 'online' && status != 'offline') {
              throw const FormatException('Expected light availability online/offline');
            }
            _deviceLightOnline = status == 'online';
            _updateLightAvailability();
          } else {
            final raw = jsonDecode(value);
            if (raw is! Map<String, dynamic>) throw const FormatException('Expected light JSON object');
            if (!raw.containsKey(ambientLight.valueField)) {
              _log.fine('Light MQTT message ignored: no ${ambientLight.valueField} topic=${element.topic}');
              continue;
            }
            final lux = raw[ambientLight.valueField];
            if (lux is! num || !lux.isFinite || lux < 0) throw const FormatException('Expected nonnegative lux');
            _lightReadings.add(AmbientLightReading(lux: lux.toInt(), receivedAt: DateTime.now().toUtc()));
          }
          _log.fine('Light MQTT message accepted topic=${element.topic}');
        } catch (error, stack) {
          _log.warning('Light MQTT message rejected topic=${element.topic}', error, stack);
        }
        continue;
      }
      final action = _actionForTopic(element.topic);
      if (action == null) {
        ignored++;
        continue;
      }
      final payload = element.payload;
      if (payload is! MqttPublishMessage) {
        rejected++;
        continue;
      }
      if ((action == _MqttAction.screen || action == _MqttAction.autoWake) && (payload.header?.retain ?? false)) {
        rejected++;
        _log.fine('event=retainedCommandRejected action=${action.name}');
        continue;
      }
      final value = MqttPublishPayload.bytesToStringAsString(payload.payload.message);
      if (value != 'ON' && value != 'OFF') {
        rejected++;
        continue;
      }
      try {
        final (prefix, controller) = switch (action) {
          _MqttAction.pause => (_prefixPauseTopic, _scPause),
          _MqttAction.screen => (_prefixScreenTopic, _scScreen),
          _MqttAction.autoWake => (_prefixAutoWakeTopic, _scAutoWake),
          _MqttAction.menu => (_prefixMenuTopic, _scMenu),
        };
        if (action != _MqttAction.screen && action != _MqttAction.autoWake) {
          _client.publishMessage(
            '$prefix/${_config.state_topic}',
            MqttQos.atLeastOnce,
            (MqttClientPayloadBuilder()..addUTF8String(value)).payload!,
          );
        }
        controller.add(value == 'ON');
        accepted++;
      } catch (error, stack) {
        rejected++;
        _log.warning('event=commandFailed action=${action.name} type=${error.runtimeType}', error, stack);
      }
    }
    if (msgs.length != lightMessages) {
      _log.info(
        'event=commands received=${msgs.length - lightMessages} accepted=$accepted rejected=$rejected ignored=$ignored',
      );
    }
  }

  _MqttAction? _actionForTopic(String topic) {
    if (topic == '$_prefixPauseTopic/${_config.command_topic}') {
      return _MqttAction.pause;
    }
    if (topic == '$_prefixScreenTopic/${_config.command_topic}') {
      return _MqttAction.screen;
    }
    if (topic == '$_prefixAutoWakeTopic/${_config.command_topic}') {
      return _MqttAction.autoWake;
    }
    if (topic == '$_prefixMenuTopic/${_config.command_topic}') {
      return _MqttAction.menu;
    }
    return null;
  }

  void _publishSwitchConfig(String id, String name, {bool retain = false}) {
    final discovery_prefix = _config.getDiscoveryPrefix('switch', id);
    final configPayload =
        '{'
        '"name": "$name"'
        ',"command_topic": "$discovery_prefix/${_config.command_topic}"'
        ',"state_topic": "$discovery_prefix/${_config.state_topic}"'
        ',"unique_id": "${_config.deviceId}_action_${id}"'
        ',"retain":false,"optimistic":false'
        ',"device":{ "ids": ["${_config.deviceId}"], "name":"${_config.deviceName}", "sw": "f:${ApplicationInfo.frontendVersion}, b:${ApplicationInfo.backendVersion}", "mdl": "Proto 1", "mf": "DIY" }'
        '}';
    _client.publishMessage(
      "$discovery_prefix/${_config.configuration_topic}",
      MqttQos.atMostOnce,
      (MqttClientPayloadBuilder()..addUTF8String(configPayload)).payload!,
      retain: retain,
    );
  }

  void _publishSensorConfig(String id, String name, {SensorType sensorType = SensorType.sensor, bool retain = false}) {
    final discovery_prefix = _config.getDiscoveryPrefix(sensorType.value, id);
    final configPayload =
        '{'
        '"name": "$name"'
        ',"state_topic": "$discovery_prefix/${_config.state_topic}"'
        ',"unique_id": "${_config.deviceId}_action_${id}"'
        ',"device":{ "ids": ["${_config.deviceId}"], "name":"${_config.deviceName}", "sw": "f:${ApplicationInfo.frontendVersion}, b:${ApplicationInfo.backendVersion}", "mdl": "Proto 1", "mf": "DIY" }'
        '}';
    _client.publishMessage(
      "$discovery_prefix/${_config.configuration_topic}",
      MqttQos.atMostOnce,
      (MqttClientPayloadBuilder()..addUTF8String(configPayload)).payload!,
      retain: retain,
    );
  }

  /// The unsolicited disconnect callback
  void _onDisconnected() {
    if (!_closed) _log.info('event=disconnected');
    _deviceLightOnline = false;
    _setLightAvailability(false);
  }

  void _setLightAvailability(bool available) {
    // Repeated OFF also invalidates readings received while availability was
    // unknown, including a retained reading delivered before a disconnect.
    if (_closed || (_ambientLightAvailable && available)) return;
    _ambientLightAvailable = available;
    _lightAvailability.add(available);
  }

  void _updateLightAvailability() => _setLightAvailability(ambientLight.enabled && isConnected && _deviceLightOnline);

  void _onConnected() {
    // The SDK invokes this callback again before onAutoReconnected. Its
    // existing subscription manager resubscribes on that path.
    if (_closed || _connectedBefore) return;
    try {
      _client.subscribe("$_prefixPauseTopic/${_config.command_topic}", MqttQos.atMostOnce);
      _client.subscribe("$_prefixScreenTopic/${_config.command_topic}", MqttQos.atMostOnce);
      _client.subscribe("$_prefixAutoWakeTopic/${_config.command_topic}", MqttQos.atMostOnce);
      _client.subscribe("$_prefixMenuTopic/${_config.command_topic}", MqttQos.atMostOnce);
      if (ambientLight.enabled) {
        _client.subscribe(ambientLight.topic, MqttQos.atMostOnce);
        if (ambientLight.availabilityTopic.isNotEmpty) {
          _client.subscribe(ambientLight.availabilityTopic, MqttQos.atMostOnce);
        }
        _deviceLightOnline = ambientLight.availabilityTopic.isEmpty;
        _updateLightAvailability();
      }
      _connectedBefore = true;
      _publishAllConfig();

      _onApplicationChangeState(applicationStateService.state);
      _publishScreenState(screenService.state);
    } catch (error, stack) {
      _log.warning('event=connectedSetupFailed type=${error.runtimeType}', error, stack);
    }
  }

  void _publishAllConfig() {
    _publishSwitchConfig('pause', 'Pause');
    _publishSwitchConfig('screen', 'Экран', retain: true);
    _publishSwitchConfig('autoWake', 'Автопробуждение экрана', retain: true);
    _publishSwitchConfig('menu', 'Menu');
    _publishSensorConfig('motion', 'Motion', sensorType: SensorType.binarySensor);
    _publishSensorConfig('storageStatus', 'Storage Status');
    _publishSensorConfig('screenPhase', 'Состояние экрана', retain: true);
  }

  void _onAutoReconnected() {
    if (_closed) return;
    _log.info('event=reconnected');
    _deviceLightOnline = ambientLight.availabilityTopic.isEmpty;
    _updateLightAvailability();
    try {
      _publishAllConfig();
      _onApplicationChangeState(applicationStateService.state);
      _publishScreenState(screenService.state);
    } catch (error, stack) {
      _log.warning('event=reconnectSetupFailed type=${error.runtimeType}', error, stack);
    }
  }

  void _onApplicationChangeState(ApplicationState newState) {
    if (_closed || !isConnected) return;
    try {
      final state = newState;
      _client.publishMessage(
        "$_prefixPauseTopic/${_config.state_topic}",
        MqttQos.atMostOnce,
        (MqttClientPayloadBuilder()..addUTF8String(state.isPaused ? 'ON' : 'OFF')).payload!,
      );
      _client.publishMessage(
        "$_prefixMenuTopic/${_config.state_topic}",
        MqttQos.atMostOnce,
        (MqttClientPayloadBuilder()..addUTF8String(state.isMenu ? 'ON' : 'OFF')).payload!,
      );
      _client.publishMessage(
        "$_prefixMotionTopic/${_config.state_topic}",
        MqttQos.atMostOnce,
        (MqttClientPayloadBuilder()..addUTF8String(state.isMotion ? 'ON' : 'OFF')).payload!,
      );
      _client.publishMessage(
        "$_prefixStorageStatusTopic/${_config.state_topic}",
        MqttQos.atMostOnce,
        (MqttClientPayloadBuilder()..addUTF8String(state.storageStatus.name)).payload!,
      );
      _log.fine('event=statePublished storageStatus=${state.storageStatus.name}');
    } catch (error, stack) {
      _log.warning('event=statePublishFailed type=${error.runtimeType}', error, stack);
    }
  }

  void _publishScreenState(ScreenState state) {
    if (_closed || !isConnected) return;
    final phase = state.phase == ScreenPhase.disposed ? 'unknown' : state.phase.name;
    try {
      for (final (prefix, payload) in [
        (
          _prefixScreenTopic,
          switch (state.isScreenOn) {
            true => 'ON',
            false => 'OFF',
            null => 'None',
          },
        ),
        (_prefixAutoWakeTopic, state.autoWakeEnabled ? 'ON' : 'OFF'),
        (_prefixScreenPhaseTopic, phase),
      ]) {
        _client.publishMessage(
          '$prefix/${_config.state_topic}',
          MqttQos.atMostOnce,
          (MqttClientPayloadBuilder()..addUTF8String(payload)).payload!,
          retain: true,
        );
      }
      _log.fine('event=screenStatePublished phase=$phase autoWake=${state.autoWakeEnabled}');
    } catch (error, stack) {
      _log.warning('event=screenStatePublishFailed phase=$phase type=${error.runtimeType}', error, stack);
    }
  }

  /// Detaches subscriptions, disables reconnection and closes owned streams.
  Future<void> close() async {
    _closed = true;
    _client.autoReconnect = false;
    _client.onConnected = null;
    _client.onDisconnected = null;
    _client.onAutoReconnected = null;
    _client.onAutoReconnect = null;
    try {
      await Future.wait<void>([
        if (_updates != null) _cancel(_updates!),
        if (_applicationChanges != null) _cancel(_applicationChanges!),
        if (_screenChanges != null) _cancel(_screenChanges!),
      ]);
    } finally {
      try {
        _client.disconnect();
      } catch (error, stack) {
        _log.warning('event=disconnectFailed type=${error.runtimeType}', error, stack);
      } finally {
        await Future.wait<void>([
          _scPause.close(),
          _scScreen.close(),
          _scAutoWake.close(),
          _scMenu.close(),
          _lightReadings.close(),
          _lightAvailability.close(),
        ]);
        _log.info('event=closed');
      }
    }
  }

  Future<void> _cancel(StreamSubscription<dynamic> subscription) async {
    try {
      await subscription.cancel();
    } catch (error, stack) {
      _log.warning('event=cancelFailed type=${error.runtimeType}', error, stack);
    }
  }
}

enum SensorType {
  binarySensor('binary_sensor'),
  sensor('sensor');

  final String value;
  const SensorType(this.value);
}
