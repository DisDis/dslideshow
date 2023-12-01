// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'os_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OSInfoImpl _$$OSInfoImplFromJson(Map<String, dynamic> json) => _$OSInfoImpl(
      name: json['name'] as String,
      osType: $enumDecode(_$OSTypeEnumMap, json['osType']),
    );

Map<String, dynamic> _$$OSInfoImplToJson(_$OSInfoImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'osType': _$OSTypeEnumMap[instance.osType]!,
    };

const _$OSTypeEnumMap = {
  OSType.linux: 'linux',
  OSType.android: 'android',
  OSType.ios: 'ios',
  OSType.unknown: 'unknown',
};
