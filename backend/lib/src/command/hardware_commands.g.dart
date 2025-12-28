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
    <String, dynamic>{'id': instance.id, 'type': instance.type};

_ButtonChangeStateCommand _$ButtonChangeStateCommandFromJson(
  Map<String, dynamic> json,
) => _ButtonChangeStateCommand(
  button: $enumDecode(_$ButtonTypeEnumMap, json['button']),
  event: $enumDecode(_$ButtonEventTypeEnumMap, json['event']),
  durationMs: (json['durationMs'] as num).toInt(),
  id: (json['id'] as num).toInt(),
  type: json['type'] as String? ?? ButtonChangeStateCommand.TYPE,
);

Map<String, dynamic> _$ButtonChangeStateCommandToJson(
  _ButtonChangeStateCommand instance,
) => <String, dynamic>{
  'button': _$ButtonTypeEnumMap[instance.button]!,
  'event': _$ButtonEventTypeEnumMap[instance.event]!,
  'durationMs': instance.durationMs,
  'id': instance.id,
  'type': instance.type,
};

const _$ButtonTypeEnumMap = {
  ButtonType.button0: 'button0',
  ButtonType.button1: 'button1',
  ButtonType.button2: 'button2',
  ButtonType.button3: 'button3',
};

const _$ButtonEventTypeEnumMap = {
  ButtonEventType.pressed: 'pressed',
  ButtonEventType.released: 'released',
};

_EmulatePushButtonCommand _$EmulatePushButtonCommandFromJson(
  Map<String, dynamic> json,
) => _EmulatePushButtonCommand(
  button: $enumDecode(_$ButtonTypeEnumMap, json['button']),
  durationMs: (json['durationMs'] as num).toInt(),
  id: (json['id'] as num).toInt(),
  type: json['type'] as String? ?? EmulatePushButtonCommand.TYPE,
);

Map<String, dynamic> _$EmulatePushButtonCommandToJson(
  _EmulatePushButtonCommand instance,
) => <String, dynamic>{
  'button': _$ButtonTypeEnumMap[instance.button]!,
  'durationMs': instance.durationMs,
  'id': instance.id,
  'type': instance.type,
};

_ExecuteSSActionCommand _$ExecuteSSActionCommandFromJson(
  Map<String, dynamic> json,
) => _ExecuteSSActionCommand(
  action: $enumDecode(_$SlideshowActionEnumMap, json['action']),
  value: json['value'] as bool,
  id: (json['id'] as num).toInt(),
  type: json['type'] as String? ?? ExecuteSSActionCommand.TYPE,
);

Map<String, dynamic> _$ExecuteSSActionCommandToJson(
  _ExecuteSSActionCommand instance,
) => <String, dynamic>{
  'action': _$SlideshowActionEnumMap[instance.action]!,
  'value': instance.value,
  'id': instance.id,
  'type': instance.type,
};

const _$SlideshowActionEnumMap = {
  SlideshowAction.none: 'none',
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

const _$LEDTypeEnumMap = {LEDType.power: 'power'};

_PowerOffCommand _$PowerOffCommandFromJson(Map<String, dynamic> json) =>
    _PowerOffCommand(
      type: json['type'] as String? ?? PowerOffCommand.TYPE,
      id: (json['id'] as num).toInt(),
    );

Map<String, dynamic> _$PowerOffCommandToJson(_PowerOffCommand instance) =>
    <String, dynamic>{'type': instance.type, 'id': instance.id};

_RestartAppCommand _$RestartAppCommandFromJson(Map<String, dynamic> json) =>
    _RestartAppCommand(
      type: json['type'] as String? ?? RestartAppCommand.TYPE,
      id: (json['id'] as num).toInt(),
    );

Map<String, dynamic> _$RestartAppCommandToJson(_RestartAppCommand instance) =>
    <String, dynamic>{'type': instance.type, 'id': instance.id};
