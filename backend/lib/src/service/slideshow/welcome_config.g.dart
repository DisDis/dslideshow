// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'welcome_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WelcomeConfig _$WelcomeConfigFromJson(Map<String, dynamic> json) =>
    WelcomeConfig(
      delayMs: (json['delayMs'] as num?)?.toInt() ?? 2000,
      size: (json['size'] as num?)?.toDouble() ?? 300,
      text: json['text'] as String? ?? 'Welcome',
    );

Map<String, dynamic> _$WelcomeConfigToJson(WelcomeConfig instance) =>
    <String, dynamic>{
      'text': instance.text,
      'size': instance.size,
      'delayMs': instance.delayMs,
    };
