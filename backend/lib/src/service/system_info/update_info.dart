import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:built_collection/built_collection.dart';
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
  DateTime get lastUpdate;

  double get cpuLoad1;

  double get cpuLoad5;

  double get cpuLoad15;

  int get memTotal;

  int get memUsed;

  int get swapTotal;

  int get swapUsed;

  String get diskUsedPercent;

  String get diskUsed;

  String get diskAvail;

  String get uptime;

  BuiltList<SensorInfo> get sensors;


  static Serializer<UpdateInfo> get serializer =>
      _$updateInfoSerializer;

  factory UpdateInfo([void updates(UpdateInfoBuilder b)]) = _$UpdateInfo;

  UpdateInfo._();
}

