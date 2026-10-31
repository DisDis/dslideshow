// Freezed forwards factory annotations to the generated implementation class.
// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

import '../disk/disk_storage_config.dart';
import '../storages_config.dart';

part 'yandex_drive_storage_config.freezed.dart';
part 'yandex_drive_storage_config.g.dart';

class YandexSyncPeriodConverter implements JsonConverter<Duration, Object?> {
  const YandexSyncPeriodConverter();
  @override
  Duration fromJson(Object? value) =>
      Duration(seconds: value is int && value >= 60 && value <= 31536000 ? value : 3600);
  @override
  int toJson(Duration value) => value.inSeconds;
}

@freezed
abstract class YandexDriveStorageConfig
    with _$YandexDriveStorageConfig
    implements AbstractStorageConfig, DiskStorageConfig {
  const YandexDriveStorageConfig._();
  @JsonSerializable(explicitToJson: true)
  const factory YandexDriveStorageConfig({
    @YandexSyncPeriodConverter() @Default(Duration(hours: 1)) Duration syncPeriod,
    @Default([]) List<YandexDriveAccountConfig> accounts,
  }) = _YandexDriveStorageConfig;
  @override
  StorageType get name => StorageType.YandexDriveStorage;
  factory YandexDriveStorageConfig.fromJson(Map<String, dynamic> json) => _$YandexDriveStorageConfigFromJson(json);
}

@freezed
abstract class YandexDriveAccountConfig with _$YandexDriveAccountConfig {
  const factory YandexDriveAccountConfig({
    required String accountId,
    @Default('') String label,
    @Default([]) List<String> paths,
    @Default(true) bool enabled,
  }) = _YandexDriveAccountConfig;
  factory YandexDriveAccountConfig.fromJson(Map<String, dynamic> json) => _$YandexDriveAccountConfigFromJson(json);
}
