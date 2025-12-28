// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppConfig _$AppConfigFromJson(Map<String, dynamic> json) => AppConfig(
  hardware: AppConfig._parseHardware(json['hardware']),
  log: AppConfig._parseLog(json['log']),
  slideshow: AppConfig._parseSlideshow(json['slideshow']),
  welcome: AppConfig._parseWelcome(json['welcome']),
  webServer: AppConfig._parseWebServer(json['web']),
  mqtt: AppConfig._parseMQTT(json['mqtt']),
  storages: AppConfig._parseStorages(json['storages']),
  wifi: AppConfig._parseWifi(json['wifi']),
);

Map<String, dynamic> _$AppConfigToJson(AppConfig instance) => <String, dynamic>{
  'log': instance.log.toJson(),
  'hardware': instance.hardware.toJson(),
  'slideshow': instance.slideshow.toJson(),
  'welcome': instance.welcome.toJson(),
  'web': instance.webServer.toJson(),
  'mqtt': instance.mqtt.toJson(),
  'storages': instance.storages.toJson(),
  'wifi': instance.wifi.toJson(),
};

LogConfig _$LogConfigFromJson(Map<String, dynamic> json) => LogConfig(
  levelHwFrame: LogConfig._parseLogLevel(json['hw_frame']),
  levelMain: LogConfig._parseLogLevel(json['main']),
  levelOTA: LogConfig._parseLogLevel(json['ota']),
  levelWeb: LogConfig._parseLogLevel(json['web']),
);

Map<String, dynamic> _$LogConfigToJson(LogConfig instance) => <String, dynamic>{
  'web': LogConfig._logLevelToJson(instance.levelWeb),
  'main': LogConfig._logLevelToJson(instance.levelMain),
  'ota': LogConfig._logLevelToJson(instance.levelOTA),
  'hw_frame': LogConfig._logLevelToJson(instance.levelHwFrame),
};
