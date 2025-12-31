import 'package:dslideshow_backend/src/service/system_info/sensor_info.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_info.g.dart';
part 'update_info.freezed.dart';

//String cpuLoad = '30%';
//int memTotal = 3817056;
//int memUsed = 385624;
//int swapTotal = 102396;
//int swapUsed = 0;
//String diskUsedPercent = '35%';
//String diskUsed = '4.8G';
//String diskAvail = '9.0G';
//String uptime = printDuration( new Duration(days: 1, hours: 13, minutes: 46, seconds: 30));

@freezed
sealed class UpdateInfo with _$UpdateInfo {
  const factory UpdateInfo({
    required double cpuLoad1,
    required double cpuLoad15,
    required double cpuLoad5,
    required int diskAvailable,
    required int diskUsed,
    required int diskUsedPercent,
    required int lastUpdate,
    required int memTotal,
    required int memUsed,
    required List<SensorInfo> sensors,
    required int swapTotal,
    required int swapUsed,
    required String uptime,
  }) = _UpdateInfo;

  factory UpdateInfo.fromJson(Map<String, dynamic> json) =>
      _$UpdateInfoFromJson(json);
}
