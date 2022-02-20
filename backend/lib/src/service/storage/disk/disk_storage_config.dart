import 'package:dslideshow_backend/config.dart';
import 'package:json_annotation/json_annotation.dart';
part 'disk_storage_config.g.dart';

@JsonSerializable()
class DiskStorageConfig {
  @JsonKey(defaultValue: "test")
  String test1;

  DiskStorageConfig({required this.test1});

  factory DiskStorageConfig.fromJson(Map<String, dynamic> json) => _$DiskStorageConfigFromJson(json);

  Map<String, dynamic> toJson() => _$DiskStorageConfigToJson(this);
}
