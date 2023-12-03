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
      buttons: SlideShowConfig._parseButtons(json['buttons']),
    );

Map<String, dynamic> _$SlideShowConfigToJson(SlideShowConfig instance) =>
    <String, dynamic>{
      'buttons': instance.buttons.toJson(),
      'displayTimeMs': instance.displayTimeMs,
      'fadeTimeMs': instance.fadeTimeMs,
      'transitionTimeMs': instance.transitionTimeMs,
      'allowedEffects': instance.allowedEffects.toList(),
      'isBlurredBackground': instance.isBlurredBackground,
      'backgroundBlurSigma': instance.backgroundBlurSigma,
      'backgroundOpacity': instance.backgroundOpacity,
      'backgroundColor': SlideShowConfig._colorToJson(instance.backgroundColor),
    };

SlideShowButtonBind _$SlideShowButtonBindFromJson(Map<String, dynamic> json) =>
    SlideShowButtonBind(
      button0: json['button0'] == null
          ? SlideshowAction.pause
          : SlideShowButtonBind._parseAction(json['button0']),
      button1: json['button1'] == null
          ? SlideshowAction.showMenu
          : SlideShowButtonBind._parseAction(json['button1']),
      button2: json['button2'] == null
          ? SlideshowAction.toggleScreen
          : SlideShowButtonBind._parseAction(json['button2']),
      button3: json['button3'] == null
          ? SlideshowAction.showInfo
          : SlideShowButtonBind._parseAction(json['button3']),
    );

Map<String, dynamic> _$SlideShowButtonBindToJson(
        SlideShowButtonBind instance) =>
    <String, dynamic>{
      'button0': SlideShowButtonBind._actionToJson(instance.button0),
      'button1': SlideShowButtonBind._actionToJson(instance.button1),
      'button2': SlideShowButtonBind._actionToJson(instance.button2),
      'button3': SlideShowButtonBind._actionToJson(instance.button3),
    };
