import 'package:dslideshow_backend/config.dart';
import 'package:json_annotation/json_annotation.dart';
part 'disk_storage_config.g.dart';

@JsonSerializable()
class DiskStorageConfig implements AbstractStorageConfig {
  // @JsonKey(defaultValue: "test")
  // String test1;

  DiskStorageConfig();

  factory DiskStorageConfig.fromJson(Map<String, dynamic> json) => _$DiskStorageConfigFromJson(json);

  Map<String, dynamic> toJson() => _$DiskStorageConfigToJson(this);

  @override
  final StorageType name = StorageType.DiskStorage;
}
