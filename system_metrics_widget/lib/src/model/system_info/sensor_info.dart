import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'sensor_info.g.dart';

abstract class SensorInfo implements Built<SensorInfo, SensorInfoBuilder> {
  String get name;
  //String sensorTemp = '62.0\'C';
  String get value;

  static Serializer<SensorInfo> get serializer =>
      _$sensorInfoSerializer;

  factory SensorInfo([void updates(SensorInfoBuilder b)]) = _$SensorInfo;
  SensorInfo._();
}