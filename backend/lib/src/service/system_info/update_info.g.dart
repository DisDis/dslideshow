// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UpdateInfoImpl _$$UpdateInfoImplFromJson(Map<String, dynamic> json) =>
    _$UpdateInfoImpl(
      cpuLoad1: (json['cpuLoad1'] as num).toDouble(),
      cpuLoad15: (json['cpuLoad15'] as num).toDouble(),
      cpuLoad5: (json['cpuLoad5'] as num).toDouble(),
      diskAvailable: json['diskAvailable'] as int,
      diskUsed: json['diskUsed'] as int,
      diskUsedPercent: json['diskUsedPercent'] as int,
      lastUpdate: json['lastUpdate'] as int,
      memTotal: json['memTotal'] as int,
      memUsed: json['memUsed'] as int,
      sensors: (json['sensors'] as List<dynamic>)
          .map((e) => SensorInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
      swapTotal: json['swapTotal'] as int,
      swapUsed: json['swapUsed'] as int,
      uptime: json['uptime'] as String,
    );

Map<String, dynamic> _$$UpdateInfoImplToJson(_$UpdateInfoImpl instance) =>
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
