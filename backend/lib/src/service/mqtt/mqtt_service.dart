import 'dart:async';

import 'package:dslideshow_backend/src/service/hardware/hardware.dart';
import 'package:dslideshow_common/version.dart';
import 'package:logging/logging.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

import 'mqtt_config.dart';

enum _MqttAction { pause, screen, menu }

class MqttService {
  static final Logger _log = new Logger('MqttService');
  final MqttConfig _config;
  final MqttServerClient _client;
  final String _prefixPauseTopic;
  final String _prefixScreenTopic;
  final String _prefixMenuTopic;
  final String _prefixMotionTopic;
  final String _prefixStorageStatusTopic;
  final ApplicationStateService applicationStateService;

  /// The completion of the initial connection attempt, including a safe failure.
  late final Future<void> ready;
  StreamSubscription<List<MqttReceivedMessage<MqttMessage>>>? _updates;
  StreamSubscription<ApplicationState>? _applicationChanges;
  bool _closed = false;
  bool _connectedBefore = false;
  Future<void>? _closing;

  final StreamController<bool> _scPause = new StreamController.broadcast();
  Stream<bool> get onPause => _scPause.stream;

  final StreamController<bool> _scMenu = new StreamController.broadcast();
  Stream<bool> get onMenu => _scMenu.stream;

  final StreamController<bool> _scScreen = new StreamController.broadcast();
  Stream<bool> get onScreen => _scScreen.stream;

  bool get isConnected => !_closed && _client.connectionStatus?.state == MqttConnectionState.connected;

  MqttService(this._config, {required this.applicationStateService, MqttServerClient? client})
    : _client = client ?? MqttServerClient.withPort(_config.server, _config.clientId, _config.serverPort),
      _prefixPauseTopic = _config.getDiscoveryPrefix('switch', 'pause'),
      _prefixScreenTopic = _config.getDiscoveryPrefix('switch', 'screen'),
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
    for (final element in msgs) {
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
      final value = MqttPublishPayload.bytesToStringAsString(payload.payload.message);
      if (value != 'ON' && value != 'OFF') {
        rejected++;
        continue;
      }
      try {
        final (prefix, controller) = switch (action) {
          _MqttAction.pause => (_prefixPauseTopic, _scPause),
          _MqttAction.screen => (_prefixScreenTopic, _scScreen),
          _MqttAction.menu => (_prefixMenuTopic, _scMenu),
        };
        _client.publishMessage(
          '$prefix/${_config.state_topic}',
          MqttQos.atLeastOnce,
          (MqttClientPayloadBuilder()..addUTF8String(value)).payload!,
        );
        controller.add(value == 'ON');
        accepted++;
      } catch (error, stack) {
        rejected++;
        _log.warning('event=commandFailed action=${action.name} type=${error.runtimeType}', error, stack);
      }
    }
    _log.info('event=commands received=${msgs.length} accepted=$accepted rejected=$rejected ignored=$ignored');
  }

  _MqttAction? _actionForTopic(String topic) {
    if (topic == '$_prefixPauseTopic/${_config.command_topic}') {
      return _MqttAction.pause;
    }
    if (topic == '$_prefixScreenTopic/${_config.command_topic}') {
      return _MqttAction.screen;
    }
    if (topic == '$_prefixMenuTopic/${_config.command_topic}') {
      return _MqttAction.menu;
    }
    return null;
  }

  void _publishSwitchConfig(MqttServerClient client, String id, String name) {
    final discovery_prefix = _config.getDiscoveryPrefix('switch', id);
    final configPayload =
        '{'
        '"name": "$name"'
        ',"command_topic": "$discovery_prefix/${_config.command_topic}"'
        ',"state_topic": "$discovery_prefix/${_config.state_topic}"'
        ',"unique_id": "${_config.deviceId}_action_${id}"'
        ',"device":{ "ids": ["${_config.deviceId}"], "name":"${_config.deviceName}", "sw": "f:${ApplicationInfo.frontendVersion}, b:${ApplicationInfo.backendVersion}", "mdl": "Proto 1", "mf": "DIY" }'
        '}';
    _client.publishMessage(
      "$discovery_prefix/${_config.configuration_topic}",
      MqttQos.atMostOnce,
      (MqttClientPayloadBuilder()..addUTF8String(configPayload)).payload!,
    );
  }

  void _publishSensorConfig(
    MqttServerClient client,
    String id,
    String name, [
    SensorType sensorType = SensorType.sensor,
  ]) {
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
    );
  }

  /// The unsolicited disconnect callback
  void _onDisconnected() {
    if (!_closed) _log.info('event=disconnected');
  }

  void _onConnected() {
    // The SDK invokes this callback again before onAutoReconnected. Its
    // existing subscription manager resubscribes on that path.
    if (_closed || _connectedBefore) return;
    try {
      _client.subscribe("$_prefixPauseTopic/${_config.command_topic}", MqttQos.atMostOnce);
      _client.subscribe("$_prefixScreenTopic/${_config.command_topic}", MqttQos.atMostOnce);
      _client.subscribe("$_prefixMenuTopic/${_config.command_topic}", MqttQos.atMostOnce);
      _connectedBefore = true;
      _publishAllConfig();

      _onApplicationChangeState(applicationStateService.state);
    } catch (error, stack) {
      _log.warning('event=connectedSetupFailed type=${error.runtimeType}', error, stack);
    }
  }

  void _publishAllConfig() {
    _publishSwitchConfig(_client, 'pause', 'Pause');
    _publishSwitchConfig(_client, 'screen', 'Screen');
    _publishSwitchConfig(_client, 'menu', 'Menu');
    _publishSensorConfig(_client, 'motion', 'Motion', SensorType.binarySensor);
    _publishSensorConfig(_client, 'storageStatus', 'Storage Status');
  }

  void _onAutoReconnected() {
    if (_closed) return;
    _log.info('event=reconnected');
    try {
      _publishAllConfig();
      _onApplicationChangeState(applicationStateService.state);
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
        "$_prefixScreenTopic/${_config.state_topic}",
        MqttQos.atMostOnce,
        (MqttClientPayloadBuilder()..addUTF8String(state.isScreenOn ? 'ON' : 'OFF')).payload!,
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

  /// Detaches subscriptions, disables reconnection and closes owned streams.
  Future<void> close() => _closing ??= _close();

  Future<void> _close() async {
    _closed = true;
    _client.autoReconnect = false;
    _client.onConnected = null;
    _client.onDisconnected = null;
    _client.onAutoReconnected = null;
    try {
      await Future.wait<void>([
        if (_updates != null) _cancel(_updates!),
        if (_applicationChanges != null) _cancel(_applicationChanges!),
      ]);
    } finally {
      try {
        _client.disconnect();
      } catch (error, stack) {
        _log.warning('event=disconnectFailed type=${error.runtimeType}', error, stack);
      } finally {
        await Future.wait<void>([_scPause.close(), _scScreen.close(), _scMenu.close()]);
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
