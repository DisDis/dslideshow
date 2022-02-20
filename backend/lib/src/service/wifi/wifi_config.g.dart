// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wifi_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WiFiConfig _$WiFiConfigFromJson(Map<String, dynamic> json) => WiFiConfig(
      devId: json['devId'] as String? ?? 'wlan0',
      scanWiFiScript:
          json['scanWiFiScript'] as String? ?? './scripts/scanWiFi.sh',
    );

Map<String, dynamic> _$WiFiConfigToJson(WiFiConfig instance) =>
    <String, dynamic>{
      'devId': instance.devId,
      'scanWiFiScript': instance.scanWiFiScript,
    };
