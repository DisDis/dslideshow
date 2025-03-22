// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hardware_commands.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AreYouReadyCommand _$AreYouReadyCommandFromJson(Map<String, dynamic> json) =>
    _AreYouReadyCommand(
      id: (json['id'] as num).toInt(),
      type: json['type'] as String? ?? AreYouReadyCommand.TYPE,
    );

Map<String, dynamic> _$AreYouReadyCommandToJson(_AreYouReadyCommand instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
    };

_PushButtonCommand _$PushButtonCommandFromJson(Map<String, dynamic> json) =>
    _PushButtonCommand(
      button: $enumDecode(_$ButtonTypeEnumMap, json['button']),
      id: (json['id'] as num).toInt(),
      type: json['type'] as String? ?? PushButtonCommand.TYPE,
    );

Map<String, dynamic> _$PushButtonCommandToJson(_PushButtonCommand instance) =>
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

_ExecuteSSActionCommand _$ExecuteSSActionCommandFromJson(
        Map<String, dynamic> json) =>
    _ExecuteSSActionCommand(
      action: $enumDecode(_$SlideshowActionEnumMap, json['action']),
      value: json['value'] as bool,
      id: (json['id'] as num).toInt(),
      type: json['type'] as String? ?? ExecuteSSActionCommand.TYPE,
    );

Map<String, dynamic> _$ExecuteSSActionCommandToJson(
        _ExecuteSSActionCommand instance) =>
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

_LEDControlCommand _$LEDControlCommandFromJson(Map<String, dynamic> json) =>
    _LEDControlCommand(
      led: $enumDecode(_$LEDTypeEnumMap, json['led']),
      value: json['value'] as bool,
      id: (json['id'] as num).toInt(),
      type: json['type'] as String? ?? LEDControlCommand.TYPE,
    );

Map<String, dynamic> _$LEDControlCommandToJson(_LEDControlCommand instance) =>
    <String, dynamic>{
      'led': _$LEDTypeEnumMap[instance.led]!,
      'value': instance.value,
      'id': instance.id,
      'type': instance.type,
    };

const _$LEDTypeEnumMap = {
  LEDType.power: 'power',
};
