// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'system_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SystemInfo _$SystemInfoFromJson(Map<String, dynamic> json) => _SystemInfo(
  cpuInfo: CpuInfo.fromJson(json['cpuInfo'] as Map<String, dynamic>),
  networkInfo: NetworkInfo.fromJson(
    json['networkInfo'] as Map<String, dynamic>,
  ),
  osInfo: OSInfo.fromJson(json['osInfo'] as Map<String, dynamic>),
  updateInfo: UpdateInfo.fromJson(json['updateInfo'] as Map<String, dynamic>),
);

Map<String, dynamic> _$SystemInfoToJson(_SystemInfo instance) =>
    <String, dynamic>{
      'cpuInfo': instance.cpuInfo.toJson(),
      'networkInfo': instance.networkInfo.toJson(),
      'osInfo': instance.osInfo.toJson(),
      'updateInfo': instance.updateInfo.toJson(),
    };
