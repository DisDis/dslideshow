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
      webServer: AppConfig._parseWebServer(json['webServer']),
      mqtt: AppConfig._parseMQTT(json['mqtt']),
      storageSection: AppConfig._parseStorageSection(json['storageSection']),
    );

Map<String, dynamic> _$AppConfigToJson(AppConfig instance) => <String, dynamic>{
      'log': instance.log,
      'hardware': instance.hardware,
      'slideshow': instance.slideshow,
      'welcome': instance.welcome,
      'webServer': instance.webServer,
      'mqtt': instance.mqtt,
      'storageSection': instance.storageSection,
    };

SlideShowConfig _$SlideShowConfigFromJson(Map<String, dynamic> json) =>
    SlideShowConfig(
      allowedEffects:
          SlideShowConfig._parseAllowedEffects(json['allowedEffects']),
      backgroundBlurSigma: json['backgroundBlurSigma'] as int? ?? 20,
      backgroundColor: json['backgroundColor'] == null
          ? 4294967295
          : SlideShowConfig._parseColor(json['backgroundColor']),
      backgroundOpacity: (json['backgroundOpacity'] as num?)?.toDouble() ?? 0.9,
      displayTimeMs: json['displayTimeMs'] as int? ?? 5000,
      fadeTimeMs: json['fadeTimeMs'] as int? ?? 2000,
      isBlurredBackground: json['isBlurredBackground'] as bool? ?? true,
      transitionTimeMs: json['transitionTimeMs'] as int? ?? 1000,
    );

Map<String, dynamic> _$SlideShowConfigToJson(SlideShowConfig instance) =>
    <String, dynamic>{
      'displayTimeMs': instance.displayTimeMs,
      'fadeTimeMs': instance.fadeTimeMs,
      'transitionTimeMs': instance.transitionTimeMs,
      'allowedEffects': instance.allowedEffects.toList(),
      'isBlurredBackground': instance.isBlurredBackground,
      'backgroundBlurSigma': instance.backgroundBlurSigma,
      'backgroundOpacity': instance.backgroundOpacity,
      'backgroundColor': SlideShowConfig._colorToJson(instance.backgroundColor),
    };

WelcomeConfig _$WelcomeConfigFromJson(Map<String, dynamic> json) =>
    WelcomeConfig(
      delayMs: json['delayMs'] as int? ?? 2000,
      size: (json['size'] as num?)?.toDouble() ?? 100,
      text: json['text'] as String? ?? 'Welcome',
    );

Map<String, dynamic> _$WelcomeConfigToJson(WelcomeConfig instance) =>
    <String, dynamic>{
      'text': instance.text,
      'size': instance.size,
      'delayMs': instance.delayMs,
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
