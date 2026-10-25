// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photo_motion_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PhotoMotionConfig _$PhotoMotionConfigFromJson(Map<String, dynamic> json) =>
    PhotoMotionConfig(
      mode:
          $enumDecodeNullable(
            _$PhotoMotionModeEnumMap,
            json['mode'],
            unknownValue: PhotoMotionMode.off,
          ) ??
          PhotoMotionMode.off,
      maxZoom: json['maxZoom'] == null
          ? 1.06
          : PhotoMotionConfig._parseZoom(json['maxZoom']),
    );

Map<String, dynamic> _$PhotoMotionConfigToJson(PhotoMotionConfig instance) =>
    <String, dynamic>{
      'mode': _$PhotoMotionModeEnumMap[instance.mode]!,
      'maxZoom': instance.maxZoom,
    };

const _$PhotoMotionModeEnumMap = {
  PhotoMotionMode.off: 'off',
  PhotoMotionMode.kenBurns: 'kenBurns',
};
