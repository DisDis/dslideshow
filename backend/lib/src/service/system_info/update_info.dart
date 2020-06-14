import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:dslideshow_backend/src/service/system_info/sensor_info.dart';

part 'update_info.g.dart';

//String cpuLoad = '30%';
//int memTotal = 3817056;
//int memUsed = 385624;
//int swapTotal = 102396;
//int swapUsed = 0;
//String diskUsedPercent = '35%';
//String diskUsed = '4.8G';
//String diskAvail = '9.0G';
//String uptime = printDuration( new Duration(days: 1, hours: 13, minutes: 46, seconds: 30));

abstract class UpdateInfo implements Built<UpdateInfo, UpdateInfoBuilder> {
  static Serializer<UpdateInfo> get serializer => _$updateInfoSerializer;

  factory UpdateInfo([void updates(UpdateInfoBuilder b)]) = _$UpdateInfo;

  UpdateInfo._();

  double get cpuLoad1;

  double get cpuLoad15;

  double get cpuLoad5;

  int get diskAvailable;

  int get diskUsed;

  int get diskUsedPercent;

  int get lastUpdate;

  int get memTotal;

  int get memUsed;

  BuiltList<SensorInfo> get sensors;

  int get swapTotal;

  int get swapUsed;

  String get uptime;
}
