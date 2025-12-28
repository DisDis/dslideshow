// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'os_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_OSInfo _$OSInfoFromJson(Map<String, dynamic> json) => _OSInfo(
  name: json['name'] as String,
  osType: $enumDecode(_$OSTypeEnumMap, json['osType']),
);

Map<String, dynamic> _$OSInfoToJson(_OSInfo instance) => <String, dynamic>{
  'name': instance.name,
  'osType': _$OSTypeEnumMap[instance.osType]!,
};

const _$OSTypeEnumMap = {
  OSType.linux: 'linux',
  OSType.android: 'android',
  OSType.ios: 'ios',
  OSType.unknown: 'unknown',
};
