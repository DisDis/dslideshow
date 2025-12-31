import 'package:freezed_annotation/freezed_annotation.dart';

part 'sensor_info.g.dart';
part 'sensor_info.freezed.dart';

@freezed
sealed class SensorInfo with _$SensorInfo {
  //String sensorTemp = '62.0\'C';

  const factory SensorInfo({required String name, required String value}) =
      _SensorInfo;

  factory SensorInfo.fromJson(Map<String, dynamic> json) =>
      _$SensorInfoFromJson(json);
}
