// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'application_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ApplicationState _$ApplicationStateFromJson(Map<String, dynamic> json) =>
    _ApplicationState(
      hasInternet: json['hasInternet'] as bool? ?? true,
      isScreenOn: json['isScreenOn'] as bool? ?? true,
      storageStatus:
          $enumDecodeNullable(
            _$StorageStatusEnumEnumMap,
            json['storageStatus'],
            unknownValue: StorageStatusEnum.off,
          ) ??
          StorageStatusEnum.done,
      isMenu: json['isMenu'] as bool? ?? false,
      isPaused: json['isPaused'] as bool? ?? false,
      isMotion: json['isMotion'] as bool? ?? true,
    );

Map<String, dynamic> _$ApplicationStateToJson(_ApplicationState instance) =>
    <String, dynamic>{
      'hasInternet': instance.hasInternet,
      'isScreenOn': instance.isScreenOn,
      'storageStatus': _$StorageStatusEnumEnumMap[instance.storageStatus]!,
      'isMenu': instance.isMenu,
      'isPaused': instance.isPaused,
      'isMotion': instance.isMotion,
    };

const _$StorageStatusEnumEnumMap = {
  StorageStatusEnum.download: 'download',
  StorageStatusEnum.off: 'off',
  StorageStatusEnum.done: 'done',
};
