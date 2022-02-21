// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'web_server_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WebServerConfig _$WebServerConfigFromJson(Map<String, dynamic> json) =>
    WebServerConfig(
      port: json['port'] as int? ?? 8080,
      enabled: json['enabled'] as bool? ?? false,
    );

Map<String, dynamic> _$WebServerConfigToJson(WebServerConfig instance) =>
    <String, dynamic>{
      'port': instance.port,
      'enabled': instance.enabled,
    };
