import 'dart:async';

import 'package:dslideshow_common/version.dart';
import 'package:logging/logging.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:typed_data/typed_data.dart' as typed;

import 'mqtt_config.dart';

class MqttService {
  static final Logger _log = new Logger('MqttService');
  final MqttConfig _config;
  final MqttServerClient _client;
  final String _prefixPauseTopic;
  final String _prefixScreenTopic;
  final String _prefixMenuTopic;

  final StreamController<bool> _scPause = new StreamController.broadcast();
  Stream<bool> get onPause => _scPause.stream;

  final StreamController<bool> _scMenu = new StreamController.broadcast();
  Stream<bool> get onMenu => _scMenu.stream;

  final StreamController<bool> _scScreenToggle = new StreamController.broadcast();
  Stream<bool> get onScreenToggle => _scScreenToggle.stream;

  bool get isConnected => _client.connectionStatus?.state == MqttConnectionState.connected;

  MqttService(this._config)
      : _client = MqttServerClient.withPort(_config.server, _config.clientId, _config.serverPort),
        _prefixPauseTopic = _config.getDiscoveryPrefix('switch', 'pause'),
        _prefixScreenTopic = _config.getDiscoveryPrefix('switch', 'screen'),
        _prefixMenuTopic = _config.getDiscoveryPrefix('switch', 'menu') {
    if (_config.enabled) {
      _init();
    }
  }

  void _init() async {
    _client.logging(on: false);
    _client.keepAlivePeriod = _config.keepAlivePeriod;
    _client.onDisconnected = _onDisconnected;
    _client.onConnected = _onConnected;
    _client.onAutoReconnected = _onAutoReconnected;
    _client.autoReconnect = true;
    _client.resubscribeOnAutoReconnect = true;

    final connMess = MqttConnectMessage()
        .withClientIdentifier(_config.clientId) // Must agree with the keep alive set above or not set
        // .withWillTopic(mqttConfig.discovery_prefix+mqttConfig.configuration_topic) // If you set this you must set a will message
        // .withWillMessage(configPayload)
        .startClean() // Non persistent session for testing
        .withWillQos(MqttQos.atLeastOnce);
    _log.info('Mosquitto client connecting....');
    _client.connectionMessage = connMess;

    /// Connect the client, any errors here are communicated by raising of the appropriate exception. Note
    /// in some circumstances the broker will just disconnect us, see the spec about this, we however eill
    /// never send malformed messages.
    try {
      await _client.connect(_config.user, _config.pass);
    } on Exception catch (e) {
      _log.warning('client exception', e);
      _client.disconnect();
    }

    /// Check we are connected
    if (isConnected) {
      _log.info('Mosquitto client connected "${_config.server}" port:${_config.serverPort}');
      _client.updates?.listen(_onUpdate);
    } else {
      _log.warning('Mosquitto client connection failed - disconnecting, state is ${_client.connectionStatus?.state}');
      _client.disconnect();
    }
  }

  void _onUpdate(List<MqttReceivedMessage<MqttMessage>> msgs) {
    msgs.forEach((element) {
      final MqttPublishMessage recMess = element.payload as MqttPublishMessage;
      final pt = MqttPublishPayload.bytesToStringAsString(recMess.payload.message);

      _log.info('topic is <${element.topic}>, payload is <-- $pt -->');
      if (element.topic.startsWith(_prefixPauseTopic)) {
        _client.publishMessage(_prefixPauseTopic + _config.state_topic, MqttQos.atMostOnce, (MqttClientPayloadBuilder()..addUTF8String(pt)).payload!);
        _scPause.add(pt == 'ON');
      } else if (element.topic.startsWith(_prefixScreenTopic)) {
        _client.publishMessage(_prefixScreenTopic + _config.state_topic, MqttQos.atMostOnce, (MqttClientPayloadBuilder()..addUTF8String(pt)).payload!);
        _scScreenToggle.add(pt == 'ON');
      } else if (element.topic.startsWith(_prefixMenuTopic)) {
        _client.publishMessage(_prefixMenuTopic + _config.state_topic, MqttQos.atMostOnce, (MqttClientPayloadBuilder()..addUTF8String(pt)).payload!);
        _scMenu.add(pt == 'ON');
      }
    });
  }

  // ignore: unused_element
  void _unpublishSwitchConfig(MqttServerClient client, String id) {
    final discovery_prefix = _config.getDiscoveryPrefix('switch', id);
    client.publishMessage(discovery_prefix + _config.configuration_topic, MqttQos.atMostOnce, typed.Uint8Buffer());
  }

  void _publishSwitchConfig(MqttServerClient client, String id, String name) {
    final discovery_prefix = _config.getDiscoveryPrefix('switch', id);
    final configPayload = '{'
        '"name": "$name"'
        ',"command_topic": "${discovery_prefix + _config.command_topic}"'
        ',"state_topic": "${discovery_prefix + _config.state_topic}"'
        ',"unique_id": "${_config.deviceId}_action_${id}"'
        ',"device":{ "ids": ["${_config.deviceId}"], "name":"${_config.deviceName}", "sw": "f:${ApplicationInfo.frontendVersion}, b:${ApplicationInfo.backendVersion}", "mdl": "Proto 1", "mf": "DIY" }'
        '}';
    _client.publishMessage(
        discovery_prefix + _config.configuration_topic, MqttQos.atMostOnce, (MqttClientPayloadBuilder()..addUTF8String(configPayload)).payload!);
  }

  /// The unsolicited disconnect callback
  void _onDisconnected() {
    _log.info('Client onDisconnected');
  }

  void _onConnected() {
    _client.subscribe(_prefixPauseTopic + _config.command_topic, MqttQos.atMostOnce);
    _client.subscribe(_prefixScreenTopic + _config.command_topic, MqttQos.atMostOnce);
    _client.subscribe(_prefixMenuTopic + _config.command_topic, MqttQos.atMostOnce);
    _publishSwitchConfig(_client, 'pause', 'Pause');
    _publishSwitchConfig(_client, 'screen', 'Screen turn');
    _publishSwitchConfig(_client, 'menu', 'Menu');

    _client.publishMessage(_prefixPauseTopic + _config.state_topic, MqttQos.atMostOnce, (MqttClientPayloadBuilder()..addUTF8String('ON')).payload!);
    _client.publishMessage(_prefixScreenTopic + _config.state_topic, MqttQos.atMostOnce, (MqttClientPayloadBuilder()..addUTF8String('ON')).payload!);
    _client.publishMessage(_prefixMenuTopic + _config.state_topic, MqttQos.atMostOnce, (MqttClientPayloadBuilder()..addUTF8String('OFF')).payload!);
  }

  void _onAutoReconnected() {
    _log.info('Client onAutoReconnected');
  }
}
