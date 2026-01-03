// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'web_server_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WebServerConfig _$WebServerConfigFromJson(Map<String, dynamic> json) =>
    WebServerConfig(
      port: (json['port'] as num?)?.toInt() ?? 8080,
      alwaysEnabled: json['alwaysEnabled'] as bool? ?? false,
      permanentCode: json['permanentCode'] as String? ?? '',
    );

Map<String, dynamic> _$WebServerConfigToJson(WebServerConfig instance) =>
    <String, dynamic>{
      'port': instance.port,
      'alwaysEnabled': instance.alwaysEnabled,
      'permanentCode': instance.permanentCode,
    };
