// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mqtt_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MqttConfig _$MqttConfigFromJson(Map<String, dynamic> json) => MqttConfig(
      clientId: json['clientId'] as String? ?? 'dslideshow',
      command_topic: json['command_topic'] as String? ?? 'set',
      configuration_topic: json['configuration_topic'] as String? ?? 'config',
      deviceId: json['deviceId'] as String? ?? 'dslideshow',
      deviceName: json['deviceName'] as String? ?? 'PhotoFrame1',
      discovery_prefix: json['discovery_prefix'] as String? ?? 'home/',
      enabled: json['enabled'] as bool? ?? false,
      keepAlivePeriod: json['keepAlivePeriod'] as int? ?? 600,
      pass: json['pass'] as String? ?? 'pass',
      server: json['server'] as String? ?? 'smarthome.local',
      serverPort: json['port'] as int? ?? 1883,
      state_topic: json['state_topic'] as String? ?? 'state',
      user: json['user'] as String? ?? 'user',
    );

Map<String, dynamic> _$MqttConfigToJson(MqttConfig instance) =>
    <String, dynamic>{
      'port': instance.serverPort,
      'enabled': instance.enabled,
      'keepAlivePeriod': instance.keepAlivePeriod,
      'deviceId': instance.deviceId,
      'user': instance.user,
      'pass': instance.pass,
      'server': instance.server,
      'clientId': instance.clientId,
      'deviceName': instance.deviceName,
      'discovery_prefix': instance.discovery_prefix,
      'configuration_topic': instance.configuration_topic,
      'command_topic': instance.command_topic,
      'state_topic': instance.state_topic,
    };
