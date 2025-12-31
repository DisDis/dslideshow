import 'package:freezed_annotation/freezed_annotation.dart';

part 'cpu_info.freezed.dart';
part 'cpu_info.g.dart';

//String cpuModel = "Raspberry Pi 4 Model B Rev 1.1";
//String cpuHardware = "BCM2835";
//String cpuRevision	= "c03111";
//int cpuCores = 4;
@freezed
sealed class CpuInfo with _$CpuInfo {
  const factory CpuInfo({
    required int cores,
    required String hardware,
    required String model,
    required String revision,
  }) = _CpuInfo;

  factory CpuInfo.fromJson(Map<String, dynamic> json) =>
      _$CpuInfoFromJson(json);
}
