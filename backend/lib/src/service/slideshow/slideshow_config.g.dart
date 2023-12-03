// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'slideshow_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

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
