// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'slideshow_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SlideShowConfig _$SlideShowConfigFromJson(Map<String, dynamic> json) =>
    SlideShowConfig(
      allowedEffects:
          SlideShowConfig._parseAllowedEffects(json['allowedEffects']),
      backgroundBlurSigma: (json['backgroundBlurSigma'] as num?)?.toInt() ?? 20,
      backgroundColor: json['backgroundColor'] == null
          ? 4294967295
          : SlideShowConfig._parseColor(json['backgroundColor']),
      backgroundOpacity: (json['backgroundOpacity'] as num?)?.toDouble() ?? 0.9,
      displayTimeMs: (json['displayTimeMs'] as num?)?.toInt() ?? 5000,
      fadeTimeMs: (json['fadeTimeMs'] as num?)?.toInt() ?? 2000,
      isBlurredBackground: json['isBlurredBackground'] as bool? ?? true,
      transitionTimeMs: (json['transitionTimeMs'] as num?)?.toInt() ?? 1000,
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

SlideShowButton _$SlideShowButtonFromJson(Map<String, dynamic> json) =>
    SlideShowButton(
      button0: json['button0'] == null
          ? SlideshowAction.showInfo
          : SlideShowButton._parseAction(json['button0']),
      button1: json['button1'] == null
          ? SlideshowAction.toggleScreen
          : SlideShowButton._parseAction(json['button1']),
      button2: json['button2'] == null
          ? SlideshowAction.showMenu
          : SlideShowButton._parseAction(json['button2']),
      button3: json['button3'] == null
          ? SlideshowAction.pause
          : SlideShowButton._parseAction(json['button3']),
      hintOffsetX: (json['hintOffsetX'] as num?)?.toInt() ?? 320,
      hintOffsetY: (json['hintOffsetY'] as num?)?.toInt() ?? 20,
    );

Map<String, dynamic> _$SlideShowButtonToJson(SlideShowButton instance) =>
    <String, dynamic>{
      'button0': SlideShowButton._actionToJson(instance.button0),
      'button1': SlideShowButton._actionToJson(instance.button1),
      'button2': SlideShowButton._actionToJson(instance.button2),
      'button3': SlideShowButton._actionToJson(instance.button3),
      'hintOffsetX': instance.hintOffsetX,
      'hintOffsetY': instance.hintOffsetY,
    };
