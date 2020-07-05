import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'cpu_info.g.dart';

abstract class CpuInfo implements Built<CpuInfo, CpuInfoBuilder> {
  //String cpuModel = "Raspberry Pi 4 Model B Rev 1.1";
  //String cpuHardware = "BCM2835";
  //String cpuRevision	= "c03111";
  //int cpuCores = 4;

  static Serializer<CpuInfo> get serializer => _$cpuInfoSerializer;

  factory CpuInfo([void updates(CpuInfoBuilder b)]) = _$CpuInfo;

  CpuInfo._();

  int get cores;
  String get hardware;
  String get model;
  String get revision;
}
