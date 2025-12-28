// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'network_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NetworkInfo _$NetworkInfoFromJson(Map<String, dynamic> json) => _NetworkInfo(
  lastUpdate: (json['lastUpdate'] as num).toInt(),
  hasInternet: json['hasInternet'] as bool,
  interfaces: (json['interfaces'] as List<dynamic>?)
      ?.map((e) => NetworkInterfaceInfo.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$NetworkInfoToJson(_NetworkInfo instance) =>
    <String, dynamic>{
      'lastUpdate': instance.lastUpdate,
      'hasInternet': instance.hasInternet,
      'interfaces': instance.interfaces?.map((e) => e.toJson()).toList(),
    };

_NetworkInterfaceInfo _$NetworkInterfaceInfoFromJson(
  Map<String, dynamic> json,
) => _NetworkInterfaceInfo(
  name: json['name'] as String,
  status: $enumDecode(_$NetworkInterfaceStatusEnumMap, json['status']),
  ip4: json['ip4'] as String,
  ip6: json['ip6'] as String,
);

Map<String, dynamic> _$NetworkInterfaceInfoToJson(
  _NetworkInterfaceInfo instance,
) => <String, dynamic>{
  'name': instance.name,
  'status': _$NetworkInterfaceStatusEnumMap[instance.status]!,
  'ip4': instance.ip4,
  'ip6': instance.ip6,
};

const _$NetworkInterfaceStatusEnumMap = {
  NetworkInterfaceStatus.running: 'running',
  NetworkInterfaceStatus.offline: 'offline',
};
