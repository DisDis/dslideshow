// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hardware_commands.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AreYouReadyCommandImpl _$$AreYouReadyCommandImplFromJson(
        Map<String, dynamic> json) =>
    _$AreYouReadyCommandImpl(
      id: json['id'] as int,
      type: json['type'] as String? ?? AreYouReadyCommand.TYPE,
    );

Map<String, dynamic> _$$AreYouReadyCommandImplToJson(
        _$AreYouReadyCommandImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
    };

_$PushButtonCommandImpl _$$PushButtonCommandImplFromJson(
        Map<String, dynamic> json) =>
    _$PushButtonCommandImpl(
      button: $enumDecode(_$ButtonTypeEnumMap, json['button']),
      id: json['id'] as int,
      type: json['type'] as String? ?? PushButtonCommand.TYPE,
    );

Map<String, dynamic> _$$PushButtonCommandImplToJson(
        _$PushButtonCommandImpl instance) =>
    <String, dynamic>{
      'button': _$ButtonTypeEnumMap[instance.button]!,
      'id': instance.id,
      'type': instance.type,
    };

const _$ButtonTypeEnumMap = {
  ButtonType.button0: 'button0',
  ButtonType.button1: 'button1',
  ButtonType.button2: 'button2',
  ButtonType.button3: 'button3',
};

_$ExecuteSSActionCommandImpl _$$ExecuteSSActionCommandImplFromJson(
        Map<String, dynamic> json) =>
    _$ExecuteSSActionCommandImpl(
      action: $enumDecode(_$SlideshowActionEnumMap, json['action']),
      value: json['value'] as bool,
      id: json['id'] as int,
      type: json['type'] as String? ?? ExecuteSSActionCommand.TYPE,
    );

Map<String, dynamic> _$$ExecuteSSActionCommandImplToJson(
        _$ExecuteSSActionCommandImpl instance) =>
    <String, dynamic>{
      'action': _$SlideshowActionEnumMap[instance.action]!,
      'value': instance.value,
      'id': instance.id,
      'type': instance.type,
    };

const _$SlideshowActionEnumMap = {
  SlideshowAction.pause: 'pause',
  SlideshowAction.toggleScreen: 'toggleScreen',
  SlideshowAction.showMenu: 'showMenu',
  SlideshowAction.showInfo: 'showInfo',
};

_$LEDControlCommandImpl _$$LEDControlCommandImplFromJson(
        Map<String, dynamic> json) =>
    _$LEDControlCommandImpl(
      led: $enumDecode(_$LEDTypeEnumMap, json['led']),
      value: json['value'] as bool,
      id: json['id'] as int,
      type: json['type'] as String? ?? LEDControlCommand.TYPE,
    );

Map<String, dynamic> _$$LEDControlCommandImplToJson(
        _$LEDControlCommandImpl instance) =>
    <String, dynamic>{
      'led': _$LEDTypeEnumMap[instance.led]!,
      'value': instance.value,
      'id': instance.id,
      'type': instance.type,
    };

const _$LEDTypeEnumMap = {
  LEDType.power: 'power',
};
