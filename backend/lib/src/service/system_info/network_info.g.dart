// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'network_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NetworkInfoImpl _$$NetworkInfoImplFromJson(Map<String, dynamic> json) =>
    _$NetworkInfoImpl(
      lastUpdate: json['lastUpdate'] as int,
      hasInternet: json['hasInternet'] as bool,
      interfaces: (json['interfaces'] as List<dynamic>?)
          ?.map((e) => NetworkInterfaceInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$NetworkInfoImplToJson(_$NetworkInfoImpl instance) =>
    <String, dynamic>{
      'lastUpdate': instance.lastUpdate,
      'hasInternet': instance.hasInternet,
      'interfaces': instance.interfaces?.map((e) => e.toJson()).toList(),
    };

_$NetworkInterfaceInfoImpl _$$NetworkInterfaceInfoImplFromJson(
        Map<String, dynamic> json) =>
    _$NetworkInterfaceInfoImpl(
      name: json['name'] as String,
      status: $enumDecode(_$NetworkInterfaceStatusEnumMap, json['status']),
      ip4: json['ip4'] as String,
      ip6: json['ip6'] as String,
    );

Map<String, dynamic> _$$NetworkInterfaceInfoImplToJson(
        _$NetworkInterfaceInfoImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'status': _$NetworkInterfaceStatusEnumMap[instance.status]!,
      'ip4': instance.ip4,
      'ip6': instance.ip6,
    };

const _$NetworkInterfaceStatusEnumMap = {
  NetworkInterfaceStatus.running: 'running',
  NetworkInterfaceStatus.offline: 'offline',
};
