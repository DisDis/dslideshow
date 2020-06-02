import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:built_collection/built_collection.dart';

part 'cpu_info.g.dart';


abstract class CpuInfo implements Built<CpuInfo, CpuInfoBuilder> {
  //String cpuModel = "Raspberry Pi 4 Model B Rev 1.1";
  //String cpuHardware = "BCM2835";
  //String cpuRevision	= "c03111";
  //int cpuCores = 4;
  String get model;
  String get hardware;
  String get revision;
  int get cores;

  static Serializer<CpuInfo> get serializer =>
      _$cpuInfoSerializer;

  factory CpuInfo([void updates(CpuInfoBuilder b)]) = _$CpuInfo;
  CpuInfo._();
}