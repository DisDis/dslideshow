// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wifi_commands.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WiFiScanCommand _$WiFiScanCommandFromJson(Map<String, dynamic> json) =>
    _WiFiScanCommand(
      id: (json['id'] as num).toInt(),
      type: json['type'] as String? ?? WiFiScanCommand.TYPE,
    );

Map<String, dynamic> _$WiFiScanCommandToJson(_WiFiScanCommand instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
    };

_WiFiScanResult _$WiFiScanResultFromJson(Map<String, dynamic> json) =>
    _WiFiScanResult(
      networks: (json['networks'] as List<dynamic>)
          .map((e) => WiFiNetworkInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
      id: (json['id'] as num).toInt(),
    );

Map<String, dynamic> _$WiFiScanResultToJson(_WiFiScanResult instance) =>
    <String, dynamic>{
      'networks': instance.networks.map((e) => e.toJson()).toList(),
      'id': instance.id,
    };

_WiFiNetworkInfo _$WiFiNetworkInfoFromJson(Map<String, dynamic> json) =>
    _WiFiNetworkInfo(
      BSSID: json['BSSID'] as String,
      SSID: json['SSID'] as String,
      signal: (json['signal'] as num).toInt(),
      channel: (json['channel'] as num).toInt(),
      rate: (json['rate'] as num).toInt(),
      security: json['security'] as String,
    );

Map<String, dynamic> _$WiFiNetworkInfoToJson(_WiFiNetworkInfo instance) =>
    <String, dynamic>{
      'BSSID': instance.BSSID,
      'SSID': instance.SSID,
      'signal': instance.signal,
      'channel': instance.channel,
      'rate': instance.rate,
      'security': instance.security,
    };

_WiFiConnectionInfo _$WiFiConnectionInfoFromJson(Map<String, dynamic> json) =>
    _WiFiConnectionInfo(
      name: json['name'] as String,
      UUID: json['UUID'] as String,
      type: json['type'] as String,
      device: json['device'] as String,
    );

Map<String, dynamic> _$WiFiConnectionInfoToJson(_WiFiConnectionInfo instance) =>
    <String, dynamic>{
      'name': instance.name,
      'UUID': instance.UUID,
      'type': instance.type,
      'device': instance.device,
    };

_WiFiRemoveCommand _$WiFiRemoveCommandFromJson(Map<String, dynamic> json) =>
    _WiFiRemoveCommand(
      connectionId: json['connectionId'] as String,
      id: (json['id'] as num).toInt(),
      type: json['type'] as String? ?? WiFiRemoveCommand.TYPE,
    );

Map<String, dynamic> _$WiFiRemoveCommandToJson(_WiFiRemoveCommand instance) =>
    <String, dynamic>{
      'connectionId': instance.connectionId,
      'id': instance.id,
      'type': instance.type,
    };

_WiFiAddCommand _$WiFiAddCommandFromJson(Map<String, dynamic> json) =>
    _WiFiAddCommand(
      name: json['name'] as String,
      SSID: json['SSID'] as String,
      psk: json['psk'] as String,
      id: (json['id'] as num).toInt(),
      type: json['type'] as String? ?? WiFiAddCommand.TYPE,
    );

Map<String, dynamic> _$WiFiAddCommandToJson(_WiFiAddCommand instance) =>
    <String, dynamic>{
      'name': instance.name,
      'SSID': instance.SSID,
      'psk': instance.psk,
      'id': instance.id,
      'type': instance.type,
    };

_WiFiGetConnectionsCommand _$WiFiGetConnectionsCommandFromJson(
        Map<String, dynamic> json) =>
    _WiFiGetConnectionsCommand(
      id: (json['id'] as num).toInt(),
      type: json['type'] as String? ?? WiFiGetConnectionsCommand.TYPE,
    );

Map<String, dynamic> _$WiFiGetConnectionsCommandToJson(
        _WiFiGetConnectionsCommand instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
    };

_WiFiGetConnectionsResult _$WiFiGetConnectionsResultFromJson(
        Map<String, dynamic> json) =>
    _WiFiGetConnectionsResult(
      networks: (json['networks'] as List<dynamic>)
          .map((e) => WiFiConnectionInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
      id: (json['id'] as num).toInt(),
    );

Map<String, dynamic> _$WiFiGetConnectionsResultToJson(
        _WiFiGetConnectionsResult instance) =>
    <String, dynamic>{
      'networks': instance.networks.map((e) => e.toJson()).toList(),
      'id': instance.id,
    };
