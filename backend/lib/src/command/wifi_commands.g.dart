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
      SSID: json['SSID'] as String,
      signal: (json['signal'] as num).toInt(),
      capability: json['capability'] as String,
      freq: (json['freq'] as num).toInt(),
    );

Map<String, dynamic> _$WiFiNetworkInfoToJson(_WiFiNetworkInfo instance) =>
    <String, dynamic>{
      'SSID': instance.SSID,
      'signal': instance.signal,
      'capability': instance.capability,
      'freq': instance.freq,
    };

_WiFiStoredNetworkInfo _$WiFiStoredNetworkInfoFromJson(
        Map<String, dynamic> json) =>
    _WiFiStoredNetworkInfo(
      id: (json['id'] as num).toInt(),
      SSID: json['SSID'] as String,
      disabled: json['disabled'] as bool,
    );

Map<String, dynamic> _$WiFiStoredNetworkInfoToJson(
        _WiFiStoredNetworkInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'SSID': instance.SSID,
      'disabled': instance.disabled,
    };

_WiFiRemoveCommand _$WiFiRemoveCommandFromJson(Map<String, dynamic> json) =>
    _WiFiRemoveCommand(
      wifiId: (json['wifiId'] as num).toInt(),
      id: (json['id'] as num).toInt(),
      type: json['type'] as String? ?? WiFiRemoveCommand.TYPE,
    );

Map<String, dynamic> _$WiFiRemoveCommandToJson(_WiFiRemoveCommand instance) =>
    <String, dynamic>{
      'wifiId': instance.wifiId,
      'id': instance.id,
      'type': instance.type,
    };

_WiFiSaveConfigCommand _$WiFiSaveConfigCommandFromJson(
        Map<String, dynamic> json) =>
    _WiFiSaveConfigCommand(
      id: (json['id'] as num).toInt(),
      type: json['type'] as String? ?? WiFiSaveConfigCommand.TYPE,
    );

Map<String, dynamic> _$WiFiSaveConfigCommandToJson(
        _WiFiSaveConfigCommand instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
    };

_WiFiAddCommand _$WiFiAddCommandFromJson(Map<String, dynamic> json) =>
    _WiFiAddCommand(
      SSID: json['SSID'] as String,
      psk: json['psk'] as String,
      id: (json['id'] as num).toInt(),
      type: json['type'] as String? ?? WiFiAddCommand.TYPE,
    );

Map<String, dynamic> _$WiFiAddCommandToJson(_WiFiAddCommand instance) =>
    <String, dynamic>{
      'SSID': instance.SSID,
      'psk': instance.psk,
      'id': instance.id,
      'type': instance.type,
    };

_WiFiGetStoredCommand _$WiFiGetStoredCommandFromJson(
        Map<String, dynamic> json) =>
    _WiFiGetStoredCommand(
      id: (json['id'] as num).toInt(),
      type: json['type'] as String? ?? WiFiGetStoredCommand.TYPE,
    );

Map<String, dynamic> _$WiFiGetStoredCommandToJson(
        _WiFiGetStoredCommand instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
    };

_WiFiGetStoredResult _$WiFiGetStoredResultFromJson(Map<String, dynamic> json) =>
    _WiFiGetStoredResult(
      networks: (json['networks'] as List<dynamic>)
          .map((e) => WiFiStoredNetworkInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
      id: (json['id'] as num).toInt(),
    );

Map<String, dynamic> _$WiFiGetStoredResultToJson(
        _WiFiGetStoredResult instance) =>
    <String, dynamic>{
      'networks': instance.networks.map((e) => e.toJson()).toList(),
      'id': instance.id,
    };
