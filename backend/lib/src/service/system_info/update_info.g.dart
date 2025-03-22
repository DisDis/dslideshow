// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UpdateInfo _$UpdateInfoFromJson(Map<String, dynamic> json) => _UpdateInfo(
      cpuLoad1: (json['cpuLoad1'] as num).toDouble(),
      cpuLoad15: (json['cpuLoad15'] as num).toDouble(),
      cpuLoad5: (json['cpuLoad5'] as num).toDouble(),
      diskAvailable: (json['diskAvailable'] as num).toInt(),
      diskUsed: (json['diskUsed'] as num).toInt(),
      diskUsedPercent: (json['diskUsedPercent'] as num).toInt(),
      lastUpdate: (json['lastUpdate'] as num).toInt(),
      memTotal: (json['memTotal'] as num).toInt(),
      memUsed: (json['memUsed'] as num).toInt(),
      sensors: (json['sensors'] as List<dynamic>)
          .map((e) => SensorInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
      swapTotal: (json['swapTotal'] as num).toInt(),
      swapUsed: (json['swapUsed'] as num).toInt(),
      uptime: json['uptime'] as String,
    );

Map<String, dynamic> _$UpdateInfoToJson(_UpdateInfo instance) =>
    <String, dynamic>{
      'cpuLoad1': instance.cpuLoad1,
      'cpuLoad15': instance.cpuLoad15,
      'cpuLoad5': instance.cpuLoad5,
      'diskAvailable': instance.diskAvailable,
      'diskUsed': instance.diskUsed,
      'diskUsedPercent': instance.diskUsedPercent,
      'lastUpdate': instance.lastUpdate,
      'memTotal': instance.memTotal,
      'memUsed': instance.memUsed,
      'sensors': instance.sensors.map((e) => e.toJson()).toList(),
      'swapTotal': instance.swapTotal,
      'swapUsed': instance.swapUsed,
      'uptime': instance.uptime,
    };
