// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'storages_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoragesConfig _$StoragesConfigFromJson(Map<String, dynamic> json) =>
    StoragesConfig(
      selected:
          $enumDecodeNullable(_$StorageTypeEnumMap, json['selected']) ??
          StorageType.DiskStorage,
      storages: StoragesConfig._parseStorages(json['storages']),
    );

Map<String, dynamic> _$StoragesConfigToJson(StoragesConfig instance) =>
    <String, dynamic>{
      'selected': _$StorageTypeEnumMap[instance.selected]!,
      'storages': StoragesConfig._storagesToJson(instance.storages),
    };

const _$StorageTypeEnumMap = {
  StorageType.DiskStorage: 'DiskStorage',
  StorageType.GPhotoStorage: 'GPhotoStorage',
};
