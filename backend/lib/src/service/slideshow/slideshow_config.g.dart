// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'slideshow_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SlideShowConfig _$SlideShowConfigFromJson(Map<String, dynamic> json) =>
    SlideShowConfig(
      allowedEffects: SlideShowConfig._parseAllowedEffects(
        json['allowedEffects'],
      ),
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
      menu: SlideShowConfig._parseMenu(json['menu']),
    );

Map<String, dynamic> _$SlideShowConfigToJson(SlideShowConfig instance) =>
    <String, dynamic>{
      'buttons': instance.buttons.toJson(),
      'menu': instance.menu.toJson(),
      'displayTimeMs': instance.displayTimeMs,
      'fadeTimeMs': instance.fadeTimeMs,
      'transitionTimeMs': instance.transitionTimeMs,
      'allowedEffects': instance.allowedEffects.toList(),
      'isBlurredBackground': instance.isBlurredBackground,
      'backgroundBlurSigma': instance.backgroundBlurSigma,
      'backgroundOpacity': instance.backgroundOpacity,
      'backgroundColor': SlideShowConfig._colorToJson(instance.backgroundColor),
    };

SlideShowButtons _$SlideShowButtonsFromJson(Map<String, dynamic> json) =>
    SlideShowButtons(
      button0: SlideShowButtonConfig.fromJson(
        json['button0'] as Map<String, dynamic>,
      ),
      button1: SlideShowButtonConfig.fromJson(
        json['button1'] as Map<String, dynamic>,
      ),
      button2: SlideShowButtonConfig.fromJson(
        json['button2'] as Map<String, dynamic>,
      ),
      button3: SlideShowButtonConfig.fromJson(
        json['button3'] as Map<String, dynamic>,
      ),
      hintOffsetX: (json['hintOffsetX'] as num?)?.toInt() ?? 320,
      hintOffsetY: (json['hintOffsetY'] as num?)?.toInt() ?? 20,
    );

Map<String, dynamic> _$SlideShowButtonsToJson(SlideShowButtons instance) =>
    <String, dynamic>{
      'button0': instance.button0.toJson(),
      'button1': instance.button1.toJson(),
      'button2': instance.button2.toJson(),
      'button3': instance.button3.toJson(),
      'hintOffsetX': instance.hintOffsetX,
      'hintOffsetY': instance.hintOffsetY,
    };

SlideShowButtonConfig _$SlideShowButtonConfigFromJson(
  Map<String, dynamic> json,
) => SlideShowButtonConfig(
  action: json['action'] == null
      ? SlideshowAction.pause
      : SlideShowButtonConfig._parseAction(json['action']),
  minPressingMs: (json['minPressingMs'] as num?)?.toInt() ?? 200,
);

Map<String, dynamic> _$SlideShowButtonConfigToJson(
  SlideShowButtonConfig instance,
) => <String, dynamic>{
  'action': SlideShowButtonConfig._actionToJson(instance.action),
  'minPressingMs': instance.minPressingMs,
};

SlideShowMenuConfig _$SlideShowMenuConfigFromJson(Map<String, dynamic> json) =>
    SlideShowMenuConfig(
      minPressingMs: (json['minPressingMs'] as num?)?.toInt() ?? 200,
    );

Map<String, dynamic> _$SlideShowMenuConfigToJson(
  SlideShowMenuConfig instance,
) => <String, dynamic>{'minPressingMs': instance.minPressingMs};
