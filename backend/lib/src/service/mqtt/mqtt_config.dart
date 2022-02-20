import 'package:json_annotation/json_annotation.dart';
part 'mqtt_config.g.dart';

@JsonSerializable()
class MqttConfig {
  @JsonKey(defaultValue: 1883, name: 'port')
  int serverPort;

  @JsonKey(defaultValue: false)
  bool enabled;

  @JsonKey(defaultValue: 60 * 10)
  int keepAlivePeriod;
  @JsonKey(defaultValue: 'dslideshow')
  String deviceId;

  @JsonKey(defaultValue: 'user')
  String user;
  @JsonKey(defaultValue: 'pass')
  String pass;

  @JsonKey(defaultValue: 'smarthome.local')
  String server;
  @JsonKey(defaultValue: 'dslideshow')
  String clientId;
  @JsonKey(defaultValue: 'PhotoFrame1')
  String deviceName;

  @JsonKey(defaultValue: 'home/')
  String discovery_prefix;
  @JsonKey(defaultValue: 'config')
  String configuration_topic;
  @JsonKey(defaultValue: 'set')
  String command_topic;
  @JsonKey(defaultValue: 'state')
  String state_topic;

  String getDiscoveryPrefix(String type, String actionId) => discovery_prefix + '$type/${deviceId}_${actionId}/';

  MqttConfig(
      {required this.clientId,
      required this.command_topic,
      required this.configuration_topic,
      required this.deviceId,
      required this.deviceName,
      required this.discovery_prefix,
      required this.enabled,
      required this.keepAlivePeriod,
      required this.pass,
      required this.server,
      required this.serverPort,
      required this.state_topic,
      required this.user});

  factory MqttConfig.fromJson(Map<String, dynamic> json) => _$MqttConfigFromJson(json);

  Map<String, dynamic> toJson() => _$MqttConfigToJson(this);
}
