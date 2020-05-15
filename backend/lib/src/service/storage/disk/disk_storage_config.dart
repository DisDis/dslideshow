import 'package:dslideshow_backend/config.dart';

class DiskStorageConfig  extends BaseConfig {
  int _value1;
  int get value1 => _value1 ??= readInt("value1", 4500);

  DiskStorageConfig(Map<String, dynamic> config) :super(config);
}