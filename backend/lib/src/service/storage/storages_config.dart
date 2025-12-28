import 'package:dslideshow_backend/src/service/storage/disk/disk_storage_config.dart';
import 'package:dslideshow_backend/src/service/storage/googlephoto/gphoto_storage_config.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:logging/logging.dart';

part 'storages_config.g.dart';

@JsonSerializable()
class StoragesConfig {
  static final Logger _log = new Logger('StoragesConfig');
  @JsonKey(defaultValue: StorageType.DiskStorage)
  StorageType selected;

  @JsonKey(fromJson: _parseStorages, toJson: _storagesToJson)
  Map<StorageType, AbstractStorageConfig> storages;

  StoragesConfig({required this.selected, required this.storages});

  factory StoragesConfig.fromJson(Map<String, dynamic> json) => _$StoragesConfigFromJson(json);

  Map<String, dynamic> toJson() => _$StoragesConfigToJson(this);

  T getOrCreateEmpty<T extends AbstractStorageConfig>(StorageType type) {
    return storages.putIfAbsent(type, () {
      switch (type) {
        case StorageType.GPhotoStorage:
          return GPhotoStorageConfig.fromJson(<String, dynamic>{});
        case StorageType.DiskStorage:
          return DiskStorageConfig.fromJson(<String, dynamic>{});
      }
    }) as T;
  }

  static Map<String, Map<String, dynamic>> _storagesToJson(Map<StorageType, AbstractStorageConfig> value) {
    final result = Map<String, Map<String, dynamic>>();
    value.forEach((key, value) {
      result[key.name] = value.toJson();
    });
    return result;
  }

  static Map<StorageType, AbstractStorageConfig> _parseStorages(dynamic valueI) {
    var result = Map<StorageType, AbstractStorageConfig>();
    if (valueI is Map<String, dynamic>) {
      var nameToType = StorageType.values.asNameMap();
      valueI.forEach((key, dynamic value) {
        try {
          var k = key.toString();
          StorageType? targetT = nameToType[k];
          if (targetT == null || !(value is Map)) {
            return;
          }
          AbstractStorageConfig? valueT;
          switch (targetT) {
            case StorageType.DiskStorage:
              valueT = DiskStorageConfig.fromJson(value as Map<String, dynamic>);
              break;
            case StorageType.GPhotoStorage:
              valueT = GPhotoStorageConfig.fromJson(value as Map<String, dynamic>);
              break;
            default:
              valueT = null;
              break;
          }
          if (valueT != null) {
            result[targetT] = valueT;
          }
        } catch (e, st) {
          _log.info(e.toString(), e, st);
        }
      });
    }

    return result;
  }
}

enum StorageType {
  @JsonValue('DiskStorage')
  DiskStorage,
  @JsonValue('GPhotoStorage')
  GPhotoStorage,
}

abstract class AbstractStorageConfig {
  StorageType get name;
  Map<String, dynamic> toJson();
}
