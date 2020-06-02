import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:built_collection/built_collection.dart';
import 'package:dslideshow_backend/src/service/system_info/update_info.dart';

import 'cpu_info.dart';
import 'network_info.dart';
import 'os_info.dart';

part 'system_info.g.dart';

abstract class SystemInfo implements Built<SystemInfo, SystemInfoBuilder> {
  UpdateInfo get updateInfo;

  CpuInfo get cpuInfo;

  OSInfo get osInfo;

  NetworkInfo get networkInfo;

  static Serializer<SystemInfo> get serializer =>
      _$systemInfoSerializer;

  factory SystemInfo([void updates(SystemInfoBuilder b)]) = _$SystemInfo;

  SystemInfo._();
}