// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'yandex_drive_storage_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_YandexDriveStorageConfig _$YandexDriveStorageConfigFromJson(
  Map<String, dynamic> json,
) => _YandexDriveStorageConfig(
  syncPeriod: json['syncPeriod'] == null
      ? const Duration(hours: 1)
      : const YandexSyncPeriodConverter().fromJson(json['syncPeriod']),
  accounts:
      (json['accounts'] as List<dynamic>?)
          ?.map(
            (e) => YandexDriveAccountConfig.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const [],
);

Map<String, dynamic> _$YandexDriveStorageConfigToJson(
  _YandexDriveStorageConfig instance,
) => <String, dynamic>{
  'syncPeriod': const YandexSyncPeriodConverter().toJson(instance.syncPeriod),
  'accounts': instance.accounts.map((e) => e.toJson()).toList(),
};

_YandexDriveAccountConfig _$YandexDriveAccountConfigFromJson(
  Map<String, dynamic> json,
) => _YandexDriveAccountConfig(
  accountId: json['accountId'] as String,
  label: json['label'] as String? ?? '',
  paths:
      (json['paths'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  enabled: json['enabled'] as bool? ?? true,
);

Map<String, dynamic> _$YandexDriveAccountConfigToJson(
  _YandexDriveAccountConfig instance,
) => <String, dynamic>{
  'accountId': instance.accountId,
  'label': instance.label,
  'paths': instance.paths,
  'enabled': instance.enabled,
};
