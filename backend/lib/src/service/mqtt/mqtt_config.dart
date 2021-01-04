import 'package:dslideshow_backend/config.dart';

class MqttConfig  extends BaseConfig {
  int _serverPort;
  int get serverPort => _serverPort ??= readInt("port", 1883);

  bool _enabled;
  bool get enabled => _enabled ??= readValue("enabled", false);

  int _keepAlivePeriod;
  int get keepAlivePeriod => _keepAlivePeriod ??= readInt("keepAlivePeriod", 60*10);

  String _deviceId;
  String get deviceId => _deviceId ??= readValue("deviceId", 'dslideshow1');

  String _user;
  String get user => _user ??= readValue("user", 'user');

  String _pass;
  String get pass => _pass ??= readValue("pass", 'pass');

  String _server;
  String get server => _server ??= readValue("server", 'nuc.lan');

  String _clientId;
  String get clientId => _clientId ??= readValue("clientId", 'dslideshow');

  String _deviceName;
  String get deviceName => _deviceName ??= readValue("deviceName", 'PhotoFrame1');

  String _discovery_prefix;
  String get discovery_prefix => _discovery_prefix ??= readValue("discovery_prefix", 'home/');
  String _configuration_topic;
  String get configuration_topic => _configuration_topic ??= readValue("configuration_topic", 'config');
  String _command_topic;
  String get command_topic => _command_topic ??= readValue("command_topic", 'set');
  String _state_topic;
  String get state_topic => _state_topic ??= readValue("state_topic", 'state');

  String getDiscoveryPrefix(String type, String actionId) => discovery_prefix + '$type/${deviceId}_${actionId}/';

  MqttConfig(Map<String, dynamic> config) :super(config);
}