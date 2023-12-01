// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wifi_commands.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WiFiScanCommandImpl _$$WiFiScanCommandImplFromJson(
        Map<String, dynamic> json) =>
    _$WiFiScanCommandImpl(
      id: json['id'] as int,
      type: json['type'] as String? ?? WiFiScanCommand.TYPE,
    );

Map<String, dynamic> _$$WiFiScanCommandImplToJson(
        _$WiFiScanCommandImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
    };

_$WiFiScanResultImpl _$$WiFiScanResultImplFromJson(Map<String, dynamic> json) =>
    _$WiFiScanResultImpl(
      networks: (json['networks'] as List<dynamic>)
          .map((e) => WiFiNetworkInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
      id: json['id'] as int,
    );

Map<String, dynamic> _$$WiFiScanResultImplToJson(
        _$WiFiScanResultImpl instance) =>
    <String, dynamic>{
      'networks': instance.networks.map((e) => e.toJson()).toList(),
      'id': instance.id,
    };

_$WiFiNetworkInfoImpl _$$WiFiNetworkInfoImplFromJson(
        Map<String, dynamic> json) =>
    _$WiFiNetworkInfoImpl(
      SSID: json['SSID'] as String,
      signal: json['signal'] as int,
      capability: json['capability'] as String,
      freq: json['freq'] as int,
    );

Map<String, dynamic> _$$WiFiNetworkInfoImplToJson(
        _$WiFiNetworkInfoImpl instance) =>
    <String, dynamic>{
      'SSID': instance.SSID,
      'signal': instance.signal,
      'capability': instance.capability,
      'freq': instance.freq,
    };

_$WiFiStoredNetworkInfoImpl _$$WiFiStoredNetworkInfoImplFromJson(
        Map<String, dynamic> json) =>
    _$WiFiStoredNetworkInfoImpl(
      id: json['id'] as int,
      SSID: json['SSID'] as String,
      disabled: json['disabled'] as bool,
    );

Map<String, dynamic> _$$WiFiStoredNetworkInfoImplToJson(
        _$WiFiStoredNetworkInfoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'SSID': instance.SSID,
      'disabled': instance.disabled,
    };

_$WiFiRemoveCommandImpl _$$WiFiRemoveCommandImplFromJson(
        Map<String, dynamic> json) =>
    _$WiFiRemoveCommandImpl(
      wifiId: json['wifiId'] as int,
      id: json['id'] as int,
      type: json['type'] as String? ?? WiFiRemoveCommand.TYPE,
    );

Map<String, dynamic> _$$WiFiRemoveCommandImplToJson(
        _$WiFiRemoveCommandImpl instance) =>
    <String, dynamic>{
      'wifiId': instance.wifiId,
      'id': instance.id,
      'type': instance.type,
    };

_$WiFiSaveConfigCommandImpl _$$WiFiSaveConfigCommandImplFromJson(
        Map<String, dynamic> json) =>
    _$WiFiSaveConfigCommandImpl(
      id: json['id'] as int,
      type: json['type'] as String? ?? WiFiSaveConfigCommand.TYPE,
    );

Map<String, dynamic> _$$WiFiSaveConfigCommandImplToJson(
        _$WiFiSaveConfigCommandImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
    };

_$WiFiAddCommandImpl _$$WiFiAddCommandImplFromJson(Map<String, dynamic> json) =>
    _$WiFiAddCommandImpl(
      SSID: json['SSID'] as String,
      psk: json['psk'] as String,
      id: json['id'] as int,
      type: json['type'] as String? ?? WiFiAddCommand.TYPE,
    );

Map<String, dynamic> _$$WiFiAddCommandImplToJson(
        _$WiFiAddCommandImpl instance) =>
    <String, dynamic>{
      'SSID': instance.SSID,
      'psk': instance.psk,
      'id': instance.id,
      'type': instance.type,
    };

_$WiFiGetStoredCommandImpl _$$WiFiGetStoredCommandImplFromJson(
        Map<String, dynamic> json) =>
    _$WiFiGetStoredCommandImpl(
      id: json['id'] as int,
      type: json['type'] as String? ?? WiFiGetStoredCommand.TYPE,
    );

Map<String, dynamic> _$$WiFiGetStoredCommandImplToJson(
        _$WiFiGetStoredCommandImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
    };

_$WiFiGetStoredResultImpl _$$WiFiGetStoredResultImplFromJson(
        Map<String, dynamic> json) =>
    _$WiFiGetStoredResultImpl(
      networks: (json['networks'] as List<dynamic>)
          .map((e) => WiFiStoredNetworkInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
      id: json['id'] as int,
    );

Map<String, dynamic> _$$WiFiGetStoredResultImplToJson(
        _$WiFiGetStoredResultImpl instance) =>
    <String, dynamic>{
      'networks': instance.networks.map((e) => e.toJson()).toList(),
      'id': instance.id,
    };
