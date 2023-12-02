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
  ButtonType.menu: 'menu',
  ButtonType.screentoggle: 'screentoggle',
  ButtonType.pause: 'pause',
  ButtonType.back: 'back',
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
