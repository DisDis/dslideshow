// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'effects.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BasicEffectOptions _$BasicEffectOptionsFromJson(Map<String, dynamic> json) =>
    BasicEffectOptions(
      durationMs: json['durationMs'] == null
          ? 0
          : const StrictIntConverter().fromJson(json['durationMs'] as Object),
    );

Map<String, dynamic> _$BasicEffectOptionsToJson(BasicEffectOptions instance) =>
    <String, dynamic>{
      'durationMs': const StrictIntConverter().toJson(instance.durationMs),
    };

MosaicEffectOptions _$MosaicEffectOptionsFromJson(Map<String, dynamic> json) =>
    MosaicEffectOptions(
      durationMs: json['durationMs'] == null
          ? 0
          : const StrictIntConverter().fromJson(json['durationMs'] as Object),
      gridSize: json['gridSize'] == null
          ? 100
          : const StrictIntConverter().fromJson(json['gridSize'] as Object),
      fadeFraction: json['fadeFraction'] == null
          ? 0.3
          : const FiniteDoubleConverter().fromJson(
              json['fadeFraction'] as Object,
            ),
      direction:
          $enumDecodeNullable(_$MosaicDirectionEnumMap, json['direction']) ??
          MosaicDirection.random,
    );

Map<String, dynamic> _$MosaicEffectOptionsToJson(
  MosaicEffectOptions instance,
) => <String, dynamic>{
  'durationMs': const StrictIntConverter().toJson(instance.durationMs),
  'gridSize': const StrictIntConverter().toJson(instance.gridSize),
  'fadeFraction': const FiniteDoubleConverter().toJson(instance.fadeFraction),
  'direction': _$MosaicDirectionEnumMap[instance.direction]!,
};

const _$MosaicDirectionEnumMap = {
  MosaicDirection.random: 'random',
  MosaicDirection.topLeft: 'topLeft',
  MosaicDirection.topRight: 'topRight',
  MosaicDirection.bottomLeft: 'bottomLeft',
  MosaicDirection.bottomRight: 'bottomRight',
};

SlideEffectOptions _$SlideEffectOptionsFromJson(
  Map<String, dynamic> json,
) => SlideEffectOptions(
  durationMs: json['durationMs'] == null
      ? 0
      : const StrictIntConverter().fromJson(json['durationMs'] as Object),
  mode: $enumDecodeNullable(_$SlideModeEnumMap, json['mode']) ?? SlideMode.push,
  direction:
      $enumDecodeNullable(_$EffectDirectionEnumMap, json['direction']) ??
      EffectDirection.left,
);

Map<String, dynamic> _$SlideEffectOptionsToJson(SlideEffectOptions instance) =>
    <String, dynamic>{
      'durationMs': const StrictIntConverter().toJson(instance.durationMs),
      'mode': _$SlideModeEnumMap[instance.mode]!,
      'direction': _$EffectDirectionEnumMap[instance.direction]!,
    };

const _$SlideModeEnumMap = {
  SlideMode.push: 'push',
  SlideMode.cover: 'cover',
  SlideMode.reveal: 'reveal',
};

const _$EffectDirectionEnumMap = {
  EffectDirection.left: 'left',
  EffectDirection.right: 'right',
  EffectDirection.up: 'up',
  EffectDirection.down: 'down',
};

RevealMaskEffectOptions _$RevealMaskEffectOptionsFromJson(
  Map<String, dynamic> json,
) => RevealMaskEffectOptions(
  durationMs: json['durationMs'] == null
      ? 0
      : const StrictIntConverter().fromJson(json['durationMs'] as Object),
  shape:
      $enumDecodeNullable(_$RevealShapeEnumMap, json['shape']) ??
      RevealShape.wipe,
  direction:
      $enumDecodeNullable(_$EffectDirectionEnumMap, json['direction']) ??
      EffectDirection.left,
  axis:
      $enumDecodeNullable(_$EffectAxisEnumMap, json['axis']) ??
      EffectAxis.horizontal,
  origin:
      $enumDecodeNullable(_$EffectOriginEnumMap, json['origin']) ??
      EffectOrigin.topLeft,
);

Map<String, dynamic> _$RevealMaskEffectOptionsToJson(
  RevealMaskEffectOptions instance,
) => <String, dynamic>{
  'durationMs': const StrictIntConverter().toJson(instance.durationMs),
  'shape': _$RevealShapeEnumMap[instance.shape]!,
  'direction': _$EffectDirectionEnumMap[instance.direction]!,
  'axis': _$EffectAxisEnumMap[instance.axis]!,
  'origin': _$EffectOriginEnumMap[instance.origin]!,
};

const _$RevealShapeEnumMap = {
  RevealShape.wipe: 'wipe',
  RevealShape.curtain: 'curtain',
  RevealShape.diagonal: 'diagonal',
  RevealShape.iris: 'iris',
};

const _$EffectAxisEnumMap = {
  EffectAxis.horizontal: 'horizontal',
  EffectAxis.vertical: 'vertical',
};

const _$EffectOriginEnumMap = {
  EffectOrigin.center: 'center',
  EffectOrigin.topLeft: 'topLeft',
  EffectOrigin.topRight: 'topRight',
  EffectOrigin.bottomLeft: 'bottomLeft',
  EffectOrigin.bottomRight: 'bottomRight',
};

FadeThroughColorEffectOptions _$FadeThroughColorEffectOptionsFromJson(
  Map<String, dynamic> json,
) => FadeThroughColorEffectOptions(
  durationMs: json['durationMs'] == null
      ? 0
      : const StrictIntConverter().fromJson(json['durationMs'] as Object),
  color: json['color'] == null
      ? 0xFF000000
      : const StrictIntConverter().fromJson(json['color'] as Object),
);

Map<String, dynamic> _$FadeThroughColorEffectOptionsToJson(
  FadeThroughColorEffectOptions instance,
) => <String, dynamic>{
  'durationMs': const StrictIntConverter().toJson(instance.durationMs),
  'color': const StrictIntConverter().toJson(instance.color),
};

SoftWipeEffectOptions _$SoftWipeEffectOptionsFromJson(
  Map<String, dynamic> json,
) => SoftWipeEffectOptions(
  durationMs: json['durationMs'] == null
      ? 0
      : const StrictIntConverter().fromJson(json['durationMs'] as Object),
  style:
      $enumDecodeNullable(_$SoftWipeStyleEnumMap, json['style']) ??
      SoftWipeStyle.soft,
);

Map<String, dynamic> _$SoftWipeEffectOptionsToJson(
  SoftWipeEffectOptions instance,
) => <String, dynamic>{
  'durationMs': const StrictIntConverter().toJson(instance.durationMs),
  'style': _$SoftWipeStyleEnumMap[instance.style]!,
};

const _$SoftWipeStyleEnumMap = {
  SoftWipeStyle.soft: 'soft',
  SoftWipeStyle.lightSweep: 'lightSweep',
  SoftWipeStyle.neon: 'neon',
};

FlipEffectOptions _$FlipEffectOptionsFromJson(Map<String, dynamic> json) =>
    FlipEffectOptions(
      durationMs: json['durationMs'] == null
          ? 0
          : const StrictIntConverter().fromJson(json['durationMs'] as Object),
      axis:
          $enumDecodeNullable(_$EffectAxisEnumMap, json['axis']) ??
          EffectAxis.horizontal,
    );

Map<String, dynamic> _$FlipEffectOptionsToJson(FlipEffectOptions instance) =>
    <String, dynamic>{
      'durationMs': const StrictIntConverter().toJson(instance.durationMs),
      'axis': _$EffectAxisEnumMap[instance.axis]!,
    };

RotateEffectOptions _$RotateEffectOptionsFromJson(Map<String, dynamic> json) =>
    RotateEffectOptions(
      durationMs: json['durationMs'] == null
          ? 0
          : const StrictIntConverter().fromJson(json['durationMs'] as Object),
      edge:
          $enumDecodeNullable(_$RotationEdgeEnumMap, json['edge']) ??
          RotationEdge.top,
      angleDegrees: json['angleDegrees'] == null
          ? 45
          : const FiniteDoubleConverter().fromJson(
              json['angleDegrees'] as Object,
            ),
    );

Map<String, dynamic> _$RotateEffectOptionsToJson(
  RotateEffectOptions instance,
) => <String, dynamic>{
  'durationMs': const StrictIntConverter().toJson(instance.durationMs),
  'edge': _$RotationEdgeEnumMap[instance.edge]!,
  'angleDegrees': const FiniteDoubleConverter().toJson(instance.angleDegrees),
};

const _$RotationEdgeEnumMap = {
  RotationEdge.top: 'top',
  RotationEdge.bottom: 'bottom',
};

BlindsEffectOptions _$BlindsEffectOptionsFromJson(Map<String, dynamic> json) =>
    BlindsEffectOptions(
      durationMs: json['durationMs'] == null
          ? 0
          : const StrictIntConverter().fromJson(json['durationMs'] as Object),
      stripCount: json['stripCount'] == null
          ? 10
          : const StrictIntConverter().fromJson(json['stripCount'] as Object),
    );

Map<String, dynamic> _$BlindsEffectOptionsToJson(
  BlindsEffectOptions instance,
) => <String, dynamic>{
  'durationMs': const StrictIntConverter().toJson(instance.durationMs),
  'stripCount': const StrictIntConverter().toJson(instance.stripCount),
};

SliceEffectOptions _$SliceEffectOptionsFromJson(Map<String, dynamic> json) =>
    SliceEffectOptions(
      durationMs: json['durationMs'] == null
          ? 0
          : const StrictIntConverter().fromJson(json['durationMs'] as Object),
      stripCount: json['stripCount'] == null
          ? 8
          : const StrictIntConverter().fromJson(json['stripCount'] as Object),
    );

Map<String, dynamic> _$SliceEffectOptionsToJson(SliceEffectOptions instance) =>
    <String, dynamic>{
      'durationMs': const StrictIntConverter().toJson(instance.durationMs),
      'stripCount': const StrictIntConverter().toJson(instance.stripCount),
    };

GlassEffectOptions _$GlassEffectOptionsFromJson(Map<String, dynamic> json) =>
    GlassEffectOptions(
      durationMs: json['durationMs'] == null
          ? 0
          : const StrictIntConverter().fromJson(json['durationMs'] as Object),
      paneCount: json['paneCount'] == null
          ? 8
          : const StrictIntConverter().fromJson(json['paneCount'] as Object),
    );

Map<String, dynamic> _$GlassEffectOptionsToJson(GlassEffectOptions instance) =>
    <String, dynamic>{
      'durationMs': const StrictIntConverter().toJson(instance.durationMs),
      'paneCount': const StrictIntConverter().toJson(instance.paneCount),
    };

PanelWipeEffectOptions _$PanelWipeEffectOptionsFromJson(
  Map<String, dynamic> json,
) => PanelWipeEffectOptions(
  durationMs: json['durationMs'] == null
      ? 0
      : const StrictIntConverter().fromJson(json['durationMs'] as Object),
  panelCount: json['panelCount'] == null
      ? 8
      : const StrictIntConverter().fromJson(json['panelCount'] as Object),
);

Map<String, dynamic> _$PanelWipeEffectOptionsToJson(
  PanelWipeEffectOptions instance,
) => <String, dynamic>{
  'durationMs': const StrictIntConverter().toJson(instance.durationMs),
  'panelCount': const StrictIntConverter().toJson(instance.panelCount),
};

LouverEffectOptions _$LouverEffectOptionsFromJson(Map<String, dynamic> json) =>
    LouverEffectOptions(
      durationMs: json['durationMs'] == null
          ? 0
          : const StrictIntConverter().fromJson(json['durationMs'] as Object),
      slatCount: json['slatCount'] == null
          ? 8
          : const StrictIntConverter().fromJson(json['slatCount'] as Object),
    );

Map<String, dynamic> _$LouverEffectOptionsToJson(
  LouverEffectOptions instance,
) => <String, dynamic>{
  'durationMs': const StrictIntConverter().toJson(instance.durationMs),
  'slatCount': const StrictIntConverter().toJson(instance.slatCount),
};

EffectConfig _$EffectConfigFromJson(Map<String, dynamic> json) =>
    EffectConfig(enabled: json['enabled'] as bool? ?? false);

Map<String, dynamic> _$EffectConfigToJson(EffectConfig instance) =>
    <String, dynamic>{
      'enabled': instance.enabled,
      'options': instance.options.toJson(),
    };

InvalidEffectData _$InvalidEffectDataFromJson(Map<String, dynamic> json) =>
    InvalidEffectData(
      json['raw'] as Map<String, dynamic>,
      json['error'] as String,
    );

Map<String, dynamic> _$InvalidEffectDataToJson(InvalidEffectData instance) =>
    <String, dynamic>{'raw': instance.raw, 'error': instance.error};

EffectsConfig _$EffectsConfigFromJson(Map<String, dynamic> json) =>
    EffectsConfig(
      schemaVersion: json['schemaVersion'] == null
          ? 1
          : const StrictIntConverter().fromJson(
              json['schemaVersion'] as Object,
            ),
      defaultDurationMs: json['defaultDurationMs'] == null
          ? 1000
          : const StrictIntConverter().fromJson(
              json['defaultDurationMs'] as Object,
            ),
      items: _parseEffects(json['items']),
    );

Map<String, dynamic> _$EffectsConfigToJson(
  EffectsConfig instance,
) => <String, dynamic>{
  'schemaVersion': const StrictIntConverter().toJson(instance.schemaVersion),
  'defaultDurationMs': const StrictIntConverter().toJson(
    instance.defaultDurationMs,
  ),
  'items': _effectsToJson(instance.items),
};
