import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:dslideshow_backend/src/service/system_info/update_info.dart';

import 'cpu_info.dart';
import 'network_info.dart';
import 'os_info.dart';

part 'system_info.g.dart';

abstract class SystemInfo implements Built<SystemInfo, SystemInfoBuilder> {
  static Serializer<SystemInfo> get serializer => _$systemInfoSerializer;

  factory SystemInfo([void updates(SystemInfoBuilder b)?]) = _$SystemInfo;

  SystemInfo._();

  CpuInfo get cpuInfo;

  NetworkInfo get networkInfo;

  OSInfo get osInfo;

  UpdateInfo? get updateInfo;
}
