import 'package:dslideshow_backend/src/service/system_info/update_info.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'cpu_info.dart';
import 'network_info.dart';
import 'os_info.dart';

part 'system_info.g.dart';
part 'system_info.freezed.dart';

@freezed
sealed class SystemInfo with _$SystemInfo {
  const factory SystemInfo({
    required CpuInfo cpuInfo,
    required NetworkInfo networkInfo,
    required OSInfo osInfo,
    required UpdateInfo updateInfo,
  }) = _SystemInfo;

  factory SystemInfo.fromJson(Map<String, dynamic> json) =>
      _$SystemInfoFromJson(json);
}
