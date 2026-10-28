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

MosaicEffectOptions _$MosaicEffectOptionsFromJson(
  Map<String, dynamic> json,
) => MosaicEffectOptions(
  durationMs: json['durationMs'] == null
      ? 0
      : const StrictIntConverter().fromJson(json['durationMs'] as Object),
  gridSize: json['gridSize'] == null
      ? 100
      : const StrictIntConverter().fromJson(json['gridSize'] as Object),
  fadeFraction: json['fadeFraction'] == null
      ? 0.3
      : const FiniteDoubleConverter().fromJson(json['fadeFraction'] as Object),
  direction:
      $enumDecodeNullable(_$MosaicDirectionEnumMap, json['direction']) ??
      MosaicDirection.random,
  randomness: json['randomness'] == null
      ? 0.2
      : const FiniteDoubleConverter().fromJson(json['randomness'] as Object),
);

Map<String, dynamic> _$MosaicEffectOptionsToJson(
  MosaicEffectOptions instance,
) => <String, dynamic>{
  'durationMs': const StrictIntConverter().toJson(instance.durationMs),
  'gridSize': const StrictIntConverter().toJson(instance.gridSize),
  'fadeFraction': const FiniteDoubleConverter().toJson(instance.fadeFraction),
  'direction': _$MosaicDirectionEnumMap[instance.direction]!,
  'randomness': const FiniteDoubleConverter().toJson(instance.randomness),
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
  motionCurve:
      $enumDecodeNullable(_$BlendCurveEnumMap, json['motionCurve']) ??
      BlendCurve.linear,
  blurFraction: json['blurFraction'] == null
      ? 0
      : const FiniteDoubleConverter().fromJson(json['blurFraction'] as Object),
  decoration:
      $enumDecodeNullable(_$SlideDecorationEnumMap, json['decoration']) ??
      SlideDecoration.none,
  edgeWidth: json['edgeWidth'] == null
      ? 0.055
      : const FiniteDoubleConverter().fromJson(json['edgeWidth'] as Object),
  tiltDegrees: json['tiltDegrees'] == null
      ? 0
      : const FiniteDoubleConverter().fromJson(json['tiltDegrees'] as Object),
  shadowStrength: json['shadowStrength'] == null
      ? 0
      : const FiniteDoubleConverter().fromJson(
          json['shadowStrength'] as Object,
        ),
);

Map<String, dynamic> _$SlideEffectOptionsToJson(
  SlideEffectOptions instance,
) => <String, dynamic>{
  'durationMs': const StrictIntConverter().toJson(instance.durationMs),
  'mode': _$SlideModeEnumMap[instance.mode]!,
  'direction': _$EffectDirectionEnumMap[instance.direction]!,
  'motionCurve': _$BlendCurveEnumMap[instance.motionCurve]!,
  'blurFraction': const FiniteDoubleConverter().toJson(instance.blurFraction),
  'decoration': _$SlideDecorationEnumMap[instance.decoration]!,
  'edgeWidth': const FiniteDoubleConverter().toJson(instance.edgeWidth),
  'tiltDegrees': const FiniteDoubleConverter().toJson(instance.tiltDegrees),
  'shadowStrength': const FiniteDoubleConverter().toJson(
    instance.shadowStrength,
  ),
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

const _$BlendCurveEnumMap = {
  BlendCurve.linear: 'linear',
  BlendCurve.easeIn: 'easeIn',
  BlendCurve.easeOut: 'easeOut',
  BlendCurve.easeInOut: 'easeInOut',
};

const _$SlideDecorationEnumMap = {
  SlideDecoration.none: 'none',
  SlideDecoration.filmPerforation: 'filmPerforation',
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
  operation:
      $enumDecodeNullable(_$RevealOperationEnumMap, json['operation']) ??
      RevealOperation.revealIncoming,
  edgeStyle:
      $enumDecodeNullable(_$WipeEdgeStyleEnumMap, json['edgeStyle']) ??
      WipeEdgeStyle.hard,
  featherFraction:
      _$JsonConverterFromJson<Object, double>(
        json['featherFraction'],
        const FiniteDoubleConverter().fromJson,
      ) ??
      null,
  lightStrength: json['lightStrength'] == null
      ? 1
      : const FiniteDoubleConverter().fromJson(json['lightStrength'] as Object),
  frameEnabled: json['frameEnabled'] as bool? ?? false,
  borderWidth: json['borderWidth'] == null
      ? 0.004
      : const FiniteDoubleConverter().fromJson(json['borderWidth'] as Object),
  borderColor: json['borderColor'] == null
      ? 0xFFFFF4DC
      : const StrictIntConverter().fromJson(json['borderColor'] as Object),
  shadowStrength: json['shadowStrength'] == null
      ? 0.8
      : const FiniteDoubleConverter().fromJson(
          json['shadowStrength'] as Object,
        ),
  pointCount: json['pointCount'] == null
      ? 5
      : const StrictIntConverter().fromJson(json['pointCount'] as Object),
  innerRadiusRatio: json['innerRadiusRatio'] == null
      ? 0.42
      : const FiniteDoubleConverter().fromJson(
          json['innerRadiusRatio'] as Object,
        ),
  rotationDegrees: json['rotationDegrees'] == null
      ? 0
      : const FiniteDoubleConverter().fromJson(
          json['rotationDegrees'] as Object,
        ),
  startAngleDegrees: json['startAngleDegrees'] == null
      ? 0
      : const FiniteDoubleConverter().fromJson(
          json['startAngleDegrees'] as Object,
        ),
  circularDirection:
      $enumDecodeNullable(
        _$CircularDirectionEnumMap,
        json['circularDirection'],
      ) ??
      CircularDirection.clockwise,
);

Map<String, dynamic> _$RevealMaskEffectOptionsToJson(
  RevealMaskEffectOptions instance,
) => <String, dynamic>{
  'durationMs': const StrictIntConverter().toJson(instance.durationMs),
  'shape': _$RevealShapeEnumMap[instance.shape]!,
  'direction': _$EffectDirectionEnumMap[instance.direction]!,
  'axis': _$EffectAxisEnumMap[instance.axis]!,
  'origin': _$EffectOriginEnumMap[instance.origin]!,
  'operation': _$RevealOperationEnumMap[instance.operation]!,
  'edgeStyle': _$WipeEdgeStyleEnumMap[instance.edgeStyle]!,
  'featherFraction': _$JsonConverterToJson<Object, double>(
    instance.featherFraction,
    const FiniteDoubleConverter().toJson,
  ),
  'lightStrength': const FiniteDoubleConverter().toJson(instance.lightStrength),
  'frameEnabled': instance.frameEnabled,
  'borderWidth': const FiniteDoubleConverter().toJson(instance.borderWidth),
  'borderColor': const StrictIntConverter().toJson(instance.borderColor),
  'shadowStrength': const FiniteDoubleConverter().toJson(
    instance.shadowStrength,
  ),
  'pointCount': const StrictIntConverter().toJson(instance.pointCount),
  'innerRadiusRatio': const FiniteDoubleConverter().toJson(
    instance.innerRadiusRatio,
  ),
  'rotationDegrees': const FiniteDoubleConverter().toJson(
    instance.rotationDegrees,
  ),
  'startAngleDegrees': const FiniteDoubleConverter().toJson(
    instance.startAngleDegrees,
  ),
  'circularDirection': _$CircularDirectionEnumMap[instance.circularDirection]!,
};

const _$RevealShapeEnumMap = {
  RevealShape.wipe: 'wipe',
  RevealShape.curtain: 'curtain',
  RevealShape.diagonal: 'diagonal',
  RevealShape.iris: 'iris',
  RevealShape.rectangle: 'rectangle',
  RevealShape.star: 'star',
  RevealShape.clock: 'clock',
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

const _$RevealOperationEnumMap = {
  RevealOperation.revealIncoming: 'revealIncoming',
  RevealOperation.hideOutgoing: 'hideOutgoing',
};

const _$WipeEdgeStyleEnumMap = {
  WipeEdgeStyle.hard: 'hard',
  WipeEdgeStyle.soft: 'soft',
  WipeEdgeStyle.lightSweep: 'lightSweep',
  WipeEdgeStyle.neon: 'neon',
};

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) => json == null ? null : fromJson(json as Json);

const _$CircularDirectionEnumMap = {
  CircularDirection.clockwise: 'clockwise',
  CircularDirection.counterclockwise: 'counterclockwise',
};

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) => value == null ? null : toJson(value);

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
      rotationSense:
          $enumDecodeNullable(_$RotationSenseEnumMap, json['rotationSense']) ??
          RotationSense.forward,
      perspectiveStrength: json['perspectiveStrength'] == null
          ? 1
          : const FiniteDoubleConverter().fromJson(
              json['perspectiveStrength'] as Object,
            ),
    );

Map<String, dynamic> _$FlipEffectOptionsToJson(FlipEffectOptions instance) =>
    <String, dynamic>{
      'durationMs': const StrictIntConverter().toJson(instance.durationMs),
      'axis': _$EffectAxisEnumMap[instance.axis]!,
      'rotationSense': _$RotationSenseEnumMap[instance.rotationSense]!,
      'perspectiveStrength': const FiniteDoubleConverter().toJson(
        instance.perspectiveStrength,
      ),
    };

const _$RotationSenseEnumMap = {
  RotationSense.forward: 'forward',
  RotationSense.backward: 'backward',
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
      direction:
          $enumDecodeNullable(_$EffectDirectionEnumMap, json['direction']) ??
          EffectDirection.left,
    );

Map<String, dynamic> _$RotateEffectOptionsToJson(
  RotateEffectOptions instance,
) => <String, dynamic>{
  'durationMs': const StrictIntConverter().toJson(instance.durationMs),
  'edge': _$RotationEdgeEnumMap[instance.edge]!,
  'angleDegrees': const FiniteDoubleConverter().toJson(instance.angleDegrees),
  'direction': _$EffectDirectionEnumMap[instance.direction]!,
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
      axis:
          $enumDecodeNullable(_$EffectAxisEnumMap, json['axis']) ??
          EffectAxis.horizontal,
      order:
          $enumDecodeNullable(_$SequenceOrderEnumMap, json['order']) ??
          SequenceOrder.forward,
      staggerFraction: json['staggerFraction'] == null
          ? 0.5
          : const FiniteDoubleConverter().fromJson(
              json['staggerFraction'] as Object,
            ),
    );

Map<String, dynamic> _$BlindsEffectOptionsToJson(
  BlindsEffectOptions instance,
) => <String, dynamic>{
  'durationMs': const StrictIntConverter().toJson(instance.durationMs),
  'stripCount': const StrictIntConverter().toJson(instance.stripCount),
  'axis': _$EffectAxisEnumMap[instance.axis]!,
  'order': _$SequenceOrderEnumMap[instance.order]!,
  'staggerFraction': const FiniteDoubleConverter().toJson(
    instance.staggerFraction,
  ),
};

const _$SequenceOrderEnumMap = {
  SequenceOrder.forward: 'forward',
  SequenceOrder.backward: 'backward',
};

SliceEffectOptions _$SliceEffectOptionsFromJson(Map<String, dynamic> json) =>
    SliceEffectOptions(
      durationMs: json['durationMs'] == null
          ? 0
          : const StrictIntConverter().fromJson(json['durationMs'] as Object),
      stripCount: json['stripCount'] == null
          ? 8
          : const StrictIntConverter().fromJson(json['stripCount'] as Object),
      mode:
          $enumDecodeNullable(_$SliceModeEnumMap, json['mode']) ??
          SliceMode.slide,
      axis:
          $enumDecodeNullable(_$EffectAxisEnumMap, json['axis']) ??
          EffectAxis.horizontal,
      staggerFraction: json['staggerFraction'] == null
          ? 0.32
          : const FiniteDoubleConverter().fromJson(
              json['staggerFraction'] as Object,
            ),
      pattern:
          $enumDecodeNullable(_$StripPatternEnumMap, json['pattern']) ??
          StripPattern.alternating,
    );

Map<String, dynamic> _$SliceEffectOptionsToJson(SliceEffectOptions instance) =>
    <String, dynamic>{
      'durationMs': const StrictIntConverter().toJson(instance.durationMs),
      'stripCount': const StrictIntConverter().toJson(instance.stripCount),
      'mode': _$SliceModeEnumMap[instance.mode]!,
      'axis': _$EffectAxisEnumMap[instance.axis]!,
      'staggerFraction': const FiniteDoubleConverter().toJson(
        instance.staggerFraction,
      ),
      'pattern': _$StripPatternEnumMap[instance.pattern]!,
    };

const _$SliceModeEnumMap = {
  SliceMode.slide: 'slide',
  SliceMode.reveal: 'reveal',
};

const _$StripPatternEnumMap = {
  StripPattern.alternating: 'alternating',
  StripPattern.sameDirection: 'sameDirection',
};

GlassEffectOptions _$GlassEffectOptionsFromJson(Map<String, dynamic> json) =>
    GlassEffectOptions(
      durationMs: json['durationMs'] == null
          ? 0
          : const StrictIntConverter().fromJson(json['durationMs'] as Object),
      paneCount: json['paneCount'] == null
          ? 8
          : const StrictIntConverter().fromJson(json['paneCount'] as Object),
      axis:
          $enumDecodeNullable(_$EffectAxisEnumMap, json['axis']) ??
          EffectAxis.vertical,
      refractionStrength: json['refractionStrength'] == null
          ? 1
          : const FiniteDoubleConverter().fromJson(
              json['refractionStrength'] as Object,
            ),
      glintStrength: json['glintStrength'] == null
          ? 1
          : const FiniteDoubleConverter().fromJson(
              json['glintStrength'] as Object,
            ),
    );

Map<String, dynamic> _$GlassEffectOptionsToJson(
  GlassEffectOptions instance,
) => <String, dynamic>{
  'durationMs': const StrictIntConverter().toJson(instance.durationMs),
  'paneCount': const StrictIntConverter().toJson(instance.paneCount),
  'axis': _$EffectAxisEnumMap[instance.axis]!,
  'refractionStrength': const FiniteDoubleConverter().toJson(
    instance.refractionStrength,
  ),
  'glintStrength': const FiniteDoubleConverter().toJson(instance.glintStrength),
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
      axis:
          $enumDecodeNullable(_$EffectAxisEnumMap, json['axis']) ??
          EffectAxis.vertical,
      staggerFraction: json['staggerFraction'] == null
          ? 0.25
          : const FiniteDoubleConverter().fromJson(
              json['staggerFraction'] as Object,
            ),
      shadowIntensity: json['shadowIntensity'] == null
          ? 0.35
          : const FiniteDoubleConverter().fromJson(
              json['shadowIntensity'] as Object,
            ),
      rotationSense:
          $enumDecodeNullable(_$RotationSenseEnumMap, json['rotationSense']) ??
          RotationSense.forward,
    );

Map<String, dynamic> _$LouverEffectOptionsToJson(
  LouverEffectOptions instance,
) => <String, dynamic>{
  'durationMs': const StrictIntConverter().toJson(instance.durationMs),
  'slatCount': const StrictIntConverter().toJson(instance.slatCount),
  'axis': _$EffectAxisEnumMap[instance.axis]!,
  'staggerFraction': const FiniteDoubleConverter().toJson(
    instance.staggerFraction,
  ),
  'shadowIntensity': const FiniteDoubleConverter().toJson(
    instance.shadowIntensity,
  ),
  'rotationSense': _$RotationSenseEnumMap[instance.rotationSense]!,
};

FadeEffectOptions _$FadeEffectOptionsFromJson(
  Map<String, dynamic> json,
) => FadeEffectOptions(
  durationMs: json['durationMs'] == null
      ? 0
      : const StrictIntConverter().fromJson(json['durationMs'] as Object),
  style:
      $enumDecodeNullable(_$FadeStyleEnumMap, json['style']) ?? FadeStyle.plain,
  blendCurve:
      $enumDecodeNullable(_$BlendCurveEnumMap, json['blendCurve']) ??
      BlendCurve.linear,
  maxSigma: json['maxSigma'] == null
      ? 10
      : const FiniteDoubleConverter().fromJson(json['maxSigma'] as Object),
  blurTarget:
      $enumDecodeNullable(_$BlurTargetEnumMap, json['blurTarget']) ??
      BlurTarget.outgoing,
  color: json['color'] == null
      ? 0xFF000000
      : const StrictIntConverter().fromJson(json['color'] as Object),
  holdFraction: json['holdFraction'] == null
      ? 0
      : const FiniteDoubleConverter().fromJson(json['holdFraction'] as Object),
  fadeOutShare: json['fadeOutShare'] == null
      ? 0.5
      : const FiniteDoubleConverter().fromJson(json['fadeOutShare'] as Object),
);

Map<String, dynamic> _$FadeEffectOptionsToJson(
  FadeEffectOptions instance,
) => <String, dynamic>{
  'durationMs': const StrictIntConverter().toJson(instance.durationMs),
  'style': _$FadeStyleEnumMap[instance.style]!,
  'blendCurve': _$BlendCurveEnumMap[instance.blendCurve]!,
  'maxSigma': const FiniteDoubleConverter().toJson(instance.maxSigma),
  'blurTarget': _$BlurTargetEnumMap[instance.blurTarget]!,
  'color': const StrictIntConverter().toJson(instance.color),
  'holdFraction': const FiniteDoubleConverter().toJson(instance.holdFraction),
  'fadeOutShare': const FiniteDoubleConverter().toJson(instance.fadeOutShare),
};

const _$FadeStyleEnumMap = {
  FadeStyle.plain: 'plain',
  FadeStyle.linearLight: 'linearLight',
  FadeStyle.blur: 'blur',
  FadeStyle.throughColor: 'throughColor',
};

const _$BlurTargetEnumMap = {
  BlurTarget.outgoing: 'outgoing',
  BlurTarget.incoming: 'incoming',
  BlurTarget.both: 'both',
};

LumaFadeEffectOptions _$LumaFadeEffectOptionsFromJson(
  Map<String, dynamic> json,
) => LumaFadeEffectOptions(
  durationMs: json['durationMs'] == null
      ? 0
      : const StrictIntConverter().fromJson(json['durationMs'] as Object),
  order:
      $enumDecodeNullable(_$LumaOrderEnumMap, json['order']) ??
      LumaOrder.brightFirst,
  softness: json['softness'] == null
      ? 0.18
      : const FiniteDoubleConverter().fromJson(json['softness'] as Object),
);

Map<String, dynamic> _$LumaFadeEffectOptionsToJson(
  LumaFadeEffectOptions instance,
) => <String, dynamic>{
  'durationMs': const StrictIntConverter().toJson(instance.durationMs),
  'order': _$LumaOrderEnumMap[instance.order]!,
  'softness': const FiniteDoubleConverter().toJson(instance.softness),
};

const _$LumaOrderEnumMap = {
  LumaOrder.brightFirst: 'brightFirst',
  LumaOrder.darkFirst: 'darkFirst',
};

NoiseDissolveEffectOptions _$NoiseDissolveEffectOptionsFromJson(
  Map<String, dynamic> json,
) => NoiseDissolveEffectOptions(
  durationMs: json['durationMs'] == null
      ? 0
      : const StrictIntConverter().fromJson(json['durationMs'] as Object),
  noiseScale: json['noiseScale'] == null
      ? 28
      : const FiniteDoubleConverter().fromJson(json['noiseScale'] as Object),
  softness: json['softness'] == null
      ? 0.08
      : const FiniteDoubleConverter().fromJson(json['softness'] as Object),
);

Map<String, dynamic> _$NoiseDissolveEffectOptionsToJson(
  NoiseDissolveEffectOptions instance,
) => <String, dynamic>{
  'durationMs': const StrictIntConverter().toJson(instance.durationMs),
  'noiseScale': const FiniteDoubleConverter().toJson(instance.noiseScale),
  'softness': const FiniteDoubleConverter().toJson(instance.softness),
};

RippleRevealEffectOptions _$RippleRevealEffectOptionsFromJson(
  Map<String, dynamic> json,
) => RippleRevealEffectOptions(
  durationMs: json['durationMs'] == null
      ? 0
      : const StrictIntConverter().fromJson(json['durationMs'] as Object),
  origin:
      $enumDecodeNullable(_$EffectOriginEnumMap, json['origin']) ??
      EffectOrigin.center,
  waveAmplitude: json['waveAmplitude'] == null
      ? 0.045
      : const FiniteDoubleConverter().fromJson(json['waveAmplitude'] as Object),
  waveFrequency: json['waveFrequency'] == null
      ? 82
      : const FiniteDoubleConverter().fromJson(json['waveFrequency'] as Object),
  softness: json['softness'] == null
      ? 0.025
      : const FiniteDoubleConverter().fromJson(json['softness'] as Object),
);

Map<String, dynamic> _$RippleRevealEffectOptionsToJson(
  RippleRevealEffectOptions instance,
) => <String, dynamic>{
  'durationMs': const StrictIntConverter().toJson(instance.durationMs),
  'origin': _$EffectOriginEnumMap[instance.origin]!,
  'waveAmplitude': const FiniteDoubleConverter().toJson(instance.waveAmplitude),
  'waveFrequency': const FiniteDoubleConverter().toJson(instance.waveFrequency),
  'softness': const FiniteDoubleConverter().toJson(instance.softness),
};

WaterRefractionEffectOptions _$WaterRefractionEffectOptionsFromJson(
  Map<String, dynamic> json,
) => WaterRefractionEffectOptions(
  durationMs: json['durationMs'] == null
      ? 0
      : const StrictIntConverter().fromJson(json['durationMs'] as Object),
  origin:
      $enumDecodeNullable(_$EffectOriginEnumMap, json['origin']) ??
      EffectOrigin.center,
  refractionStrength: json['refractionStrength'] == null
      ? 0.012
      : const FiniteDoubleConverter().fromJson(
          json['refractionStrength'] as Object,
        ),
  waveFrequency: json['waveFrequency'] == null
      ? 92
      : const FiniteDoubleConverter().fromJson(json['waveFrequency'] as Object),
  bandWidth: json['bandWidth'] == null
      ? 1
      : const FiniteDoubleConverter().fromJson(json['bandWidth'] as Object),
);

Map<String, dynamic> _$WaterRefractionEffectOptionsToJson(
  WaterRefractionEffectOptions instance,
) => <String, dynamic>{
  'durationMs': const StrictIntConverter().toJson(instance.durationMs),
  'origin': _$EffectOriginEnumMap[instance.origin]!,
  'refractionStrength': const FiniteDoubleConverter().toJson(
    instance.refractionStrength,
  ),
  'waveFrequency': const FiniteDoubleConverter().toJson(instance.waveFrequency),
  'bandWidth': const FiniteDoubleConverter().toJson(instance.bandWidth),
};

LiquidMorphEffectOptions _$LiquidMorphEffectOptionsFromJson(
  Map<String, dynamic> json,
) => LiquidMorphEffectOptions(
  durationMs: json['durationMs'] == null
      ? 0
      : const StrictIntConverter().fromJson(json['durationMs'] as Object),
  waveCount: json['waveCount'] == null
      ? 12
      : const StrictIntConverter().fromJson(json['waveCount'] as Object),
  waveIntensity: json['waveIntensity'] == null
      ? 15
      : const FiniteDoubleConverter().fromJson(json['waveIntensity'] as Object),
  outgoingScale: json['outgoingScale'] == null
      ? 1.1
      : const FiniteDoubleConverter().fromJson(json['outgoingScale'] as Object),
  origin:
      $enumDecodeNullable(_$EffectOriginEnumMap, json['origin']) ??
      EffectOrigin.center,
);

Map<String, dynamic> _$LiquidMorphEffectOptionsToJson(
  LiquidMorphEffectOptions instance,
) => <String, dynamic>{
  'durationMs': const StrictIntConverter().toJson(instance.durationMs),
  'waveCount': const StrictIntConverter().toJson(instance.waveCount),
  'waveIntensity': const FiniteDoubleConverter().toJson(instance.waveIntensity),
  'outgoingScale': const FiniteDoubleConverter().toJson(instance.outgoingScale),
  'origin': _$EffectOriginEnumMap[instance.origin]!,
};

CubeEffectOptions _$CubeEffectOptionsFromJson(Map<String, dynamic> json) =>
    CubeEffectOptions(
      durationMs: json['durationMs'] == null
          ? 0
          : const StrictIntConverter().fromJson(json['durationMs'] as Object),
      direction:
          $enumDecodeNullable(_$EffectDirectionEnumMap, json['direction']) ??
          EffectDirection.left,
      shadowIntensity: json['shadowIntensity'] == null
          ? 0.5
          : const FiniteDoubleConverter().fromJson(
              json['shadowIntensity'] as Object,
            ),
      perspectiveStrength: json['perspectiveStrength'] == null
          ? 1
          : const FiniteDoubleConverter().fromJson(
              json['perspectiveStrength'] as Object,
            ),
    );

Map<String, dynamic> _$CubeEffectOptionsToJson(CubeEffectOptions instance) =>
    <String, dynamic>{
      'durationMs': const StrictIntConverter().toJson(instance.durationMs),
      'direction': _$EffectDirectionEnumMap[instance.direction]!,
      'shadowIntensity': const FiniteDoubleConverter().toJson(
        instance.shadowIntensity,
      ),
      'perspectiveStrength': const FiniteDoubleConverter().toJson(
        instance.perspectiveStrength,
      ),
    };

AccordionEffectOptions _$AccordionEffectOptionsFromJson(
  Map<String, dynamic> json,
) => AccordionEffectOptions(
  durationMs: json['durationMs'] == null
      ? 0
      : const StrictIntConverter().fromJson(json['durationMs'] as Object),
  direction:
      $enumDecodeNullable(_$EffectDirectionEnumMap, json['direction']) ??
      EffectDirection.left,
  shadowIntensity: json['shadowIntensity'] == null
      ? 0.5
      : const FiniteDoubleConverter().fromJson(
          json['shadowIntensity'] as Object,
        ),
);

Map<String, dynamic> _$AccordionEffectOptionsToJson(
  AccordionEffectOptions instance,
) => <String, dynamic>{
  'durationMs': const StrictIntConverter().toJson(instance.durationMs),
  'direction': _$EffectDirectionEnumMap[instance.direction]!,
  'shadowIntensity': const FiniteDoubleConverter().toJson(
    instance.shadowIntensity,
  ),
};

DepthEffectOptions _$DepthEffectOptionsFromJson(Map<String, dynamic> json) =>
    DepthEffectOptions(
      durationMs: json['durationMs'] == null
          ? 0
          : const StrictIntConverter().fromJson(json['durationMs'] as Object),
      mode:
          $enumDecodeNullable(_$DepthModeEnumMap, json['mode']) ??
          DepthMode.recedeStill,
      scale: json['scale'] == null
          ? 0.5
          : const FiniteDoubleConverter().fromJson(json['scale'] as Object),
      shadowIntensity: json['shadowIntensity'] == null
          ? 0.5
          : const FiniteDoubleConverter().fromJson(
              json['shadowIntensity'] as Object,
            ),
      direction:
          $enumDecodeNullable(_$EffectDirectionEnumMap, json['direction']) ??
          EffectDirection.left,
    );

Map<String, dynamic> _$DepthEffectOptionsToJson(DepthEffectOptions instance) =>
    <String, dynamic>{
      'durationMs': const StrictIntConverter().toJson(instance.durationMs),
      'mode': _$DepthModeEnumMap[instance.mode]!,
      'scale': const FiniteDoubleConverter().toJson(instance.scale),
      'shadowIntensity': const FiniteDoubleConverter().toJson(
        instance.shadowIntensity,
      ),
      'direction': _$EffectDirectionEnumMap[instance.direction]!,
    };

const _$DepthModeEnumMap = {
  DepthMode.recedeStill: 'recedeStill',
  DepthMode.recedeSlide: 'recedeSlide',
  DepthMode.approach: 'approach',
};

ParallaxEffectOptions _$ParallaxEffectOptionsFromJson(
  Map<String, dynamic> json,
) => ParallaxEffectOptions(
  durationMs: json['durationMs'] == null
      ? 0
      : const StrictIntConverter().fromJson(json['durationMs'] as Object),
  clipAmount: json['clipAmount'] == null
      ? 200
      : const FiniteDoubleConverter().fromJson(json['clipAmount'] as Object),
  direction:
      $enumDecodeNullable(_$EffectDirectionEnumMap, json['direction']) ??
      EffectDirection.left,
);

Map<String, dynamic> _$ParallaxEffectOptionsToJson(
  ParallaxEffectOptions instance,
) => <String, dynamic>{
  'durationMs': const StrictIntConverter().toJson(instance.durationMs),
  'clipAmount': const FiniteDoubleConverter().toJson(instance.clipAmount),
  'direction': _$EffectDirectionEnumMap[instance.direction]!,
};

TabletEffectOptions _$TabletEffectOptionsFromJson(Map<String, dynamic> json) =>
    TabletEffectOptions(
      durationMs: json['durationMs'] == null
          ? 0
          : const StrictIntConverter().fromJson(json['durationMs'] as Object),
      direction:
          $enumDecodeNullable(_$EffectDirectionEnumMap, json['direction']) ??
          EffectDirection.left,
      tiltDegrees: json['tiltDegrees'] == null
          ? 45
          : const FiniteDoubleConverter().fromJson(
              json['tiltDegrees'] as Object,
            ),
      perspectiveStrength: json['perspectiveStrength'] == null
          ? 1
          : const FiniteDoubleConverter().fromJson(
              json['perspectiveStrength'] as Object,
            ),
    );

Map<String, dynamic> _$TabletEffectOptionsToJson(
  TabletEffectOptions instance,
) => <String, dynamic>{
  'durationMs': const StrictIntConverter().toJson(instance.durationMs),
  'direction': _$EffectDirectionEnumMap[instance.direction]!,
  'tiltDegrees': const FiniteDoubleConverter().toJson(instance.tiltDegrees),
  'perspectiveStrength': const FiniteDoubleConverter().toJson(
    instance.perspectiveStrength,
  ),
};

ZoomOutEffectOptions _$ZoomOutEffectOptionsFromJson(
  Map<String, dynamic> json,
) => ZoomOutEffectOptions(
  durationMs: json['durationMs'] == null
      ? 0
      : const StrictIntConverter().fromJson(json['durationMs'] as Object),
  zoomOutScale: json['zoomOutScale'] == null
      ? 0.8
      : const FiniteDoubleConverter().fromJson(json['zoomOutScale'] as Object),
  enableOpacity: json['enableOpacity'] as bool? ?? true,
  direction:
      $enumDecodeNullable(_$EffectDirectionEnumMap, json['direction']) ??
      EffectDirection.left,
);

Map<String, dynamic> _$ZoomOutEffectOptionsToJson(
  ZoomOutEffectOptions instance,
) => <String, dynamic>{
  'durationMs': const StrictIntConverter().toJson(instance.durationMs),
  'zoomOutScale': const FiniteDoubleConverter().toJson(instance.zoomOutScale),
  'enableOpacity': instance.enableOpacity,
  'direction': _$EffectDirectionEnumMap[instance.direction]!,
};

ZoomOverEffectOptions _$ZoomOverEffectOptionsFromJson(
  Map<String, dynamic> json,
) => ZoomOverEffectOptions(
  durationMs: json['durationMs'] == null
      ? 0
      : const StrictIntConverter().fromJson(json['durationMs'] as Object),
  mode: $enumDecodeNullable(_$ZoomModeEnumMap, json['mode']) ?? ZoomMode.over,
  startScale: json['startScale'] == null
      ? 1.5
      : const FiniteDoubleConverter().fromJson(json['startScale'] as Object),
  outgoingScale: json['outgoingScale'] == null
      ? 0.9
      : const FiniteDoubleConverter().fromJson(json['outgoingScale'] as Object),
  blurFraction: json['blurFraction'] == null
      ? 0
      : const FiniteDoubleConverter().fromJson(json['blurFraction'] as Object),
  origin:
      $enumDecodeNullable(_$EffectOriginEnumMap, json['origin']) ??
      EffectOrigin.center,
);

Map<String, dynamic> _$ZoomOverEffectOptionsToJson(
  ZoomOverEffectOptions instance,
) => <String, dynamic>{
  'durationMs': const StrictIntConverter().toJson(instance.durationMs),
  'mode': _$ZoomModeEnumMap[instance.mode]!,
  'startScale': const FiniteDoubleConverter().toJson(instance.startScale),
  'outgoingScale': const FiniteDoubleConverter().toJson(instance.outgoingScale),
  'blurFraction': const FiniteDoubleConverter().toJson(instance.blurFraction),
  'origin': _$EffectOriginEnumMap[instance.origin]!,
};

const _$ZoomModeEnumMap = {ZoomMode.over: 'over', ZoomMode.cross: 'cross'};

PagePeelEffectOptions _$PagePeelEffectOptionsFromJson(
  Map<String, dynamic> json,
) => PagePeelEffectOptions(
  durationMs: json['durationMs'] == null
      ? 0
      : const StrictIntConverter().fromJson(json['durationMs'] as Object),
  corner:
      $enumDecodeNullable(_$EffectOriginEnumMap, json['corner']) ??
      EffectOrigin.topRight,
  foldWidth: json['foldWidth'] == null
      ? 0.12
      : const FiniteDoubleConverter().fromJson(json['foldWidth'] as Object),
  paperColor: json['paperColor'] == null
      ? 0xFFFFFDF5
      : const StrictIntConverter().fromJson(json['paperColor'] as Object),
  shadowStrength: json['shadowStrength'] == null
      ? 0.55
      : const FiniteDoubleConverter().fromJson(
          json['shadowStrength'] as Object,
        ),
);

Map<String, dynamic> _$PagePeelEffectOptionsToJson(
  PagePeelEffectOptions instance,
) => <String, dynamic>{
  'durationMs': const StrictIntConverter().toJson(instance.durationMs),
  'corner': _$EffectOriginEnumMap[instance.corner]!,
  'foldWidth': const FiniteDoubleConverter().toJson(instance.foldWidth),
  'paperColor': const StrictIntConverter().toJson(instance.paperColor),
  'shadowStrength': const FiniteDoubleConverter().toJson(
    instance.shadowStrength,
  ),
};

SplitEffectOptions _$SplitEffectOptionsFromJson(Map<String, dynamic> json) =>
    SplitEffectOptions(
      durationMs: json['durationMs'] == null
          ? 0
          : const StrictIntConverter().fromJson(json['durationMs'] as Object),
      axis:
          $enumDecodeNullable(_$EffectAxisEnumMap, json['axis']) ??
          EffectAxis.horizontal,
      splitPosition: json['splitPosition'] == null
          ? 0.5
          : const FiniteDoubleConverter().fromJson(
              json['splitPosition'] as Object,
            ),
    );

Map<String, dynamic> _$SplitEffectOptionsToJson(
  SplitEffectOptions instance,
) => <String, dynamic>{
  'durationMs': const StrictIntConverter().toJson(instance.durationMs),
  'axis': _$EffectAxisEnumMap[instance.axis]!,
  'splitPosition': const FiniteDoubleConverter().toJson(instance.splitPosition),
};

StretchEffectOptions _$StretchEffectOptionsFromJson(
  Map<String, dynamic> json,
) => StretchEffectOptions(
  durationMs: json['durationMs'] == null
      ? 0
      : const StrictIntConverter().fromJson(json['durationMs'] as Object),
  axis:
      $enumDecodeNullable(_$EffectAxisEnumMap, json['axis']) ??
      EffectAxis.horizontal,
  maxScale: json['maxScale'] == null
      ? 3
      : const FiniteDoubleConverter().fromJson(json['maxScale'] as Object),
);

Map<String, dynamic> _$StretchEffectOptionsToJson(
  StretchEffectOptions instance,
) => <String, dynamic>{
  'durationMs': const StrictIntConverter().toJson(instance.durationMs),
  'axis': _$EffectAxisEnumMap[instance.axis]!,
  'maxScale': const FiniteDoubleConverter().toJson(instance.maxScale),
};

MirrorEffectOptions _$MirrorEffectOptionsFromJson(Map<String, dynamic> json) =>
    MirrorEffectOptions(
      durationMs: json['durationMs'] == null
          ? 0
          : const StrictIntConverter().fromJson(json['durationMs'] as Object),
      axis:
          $enumDecodeNullable(_$EffectAxisEnumMap, json['axis']) ??
          EffectAxis.vertical,
      side:
          $enumDecodeNullable(_$MirrorSideEnumMap, json['side']) ??
          MirrorSide.leading,
      strength: json['strength'] == null
          ? 1
          : const FiniteDoubleConverter().fromJson(json['strength'] as Object),
    );

Map<String, dynamic> _$MirrorEffectOptionsToJson(
  MirrorEffectOptions instance,
) => <String, dynamic>{
  'durationMs': const StrictIntConverter().toJson(instance.durationMs),
  'axis': _$EffectAxisEnumMap[instance.axis]!,
  'side': _$MirrorSideEnumMap[instance.side]!,
  'strength': const FiniteDoubleConverter().toJson(instance.strength),
};

const _$MirrorSideEnumMap = {
  MirrorSide.leading: 'leading',
  MirrorSide.trailing: 'trailing',
};

LightLeakEffectOptions _$LightLeakEffectOptionsFromJson(
  Map<String, dynamic> json,
) => LightLeakEffectOptions(
  durationMs: json['durationMs'] == null
      ? 0
      : const StrictIntConverter().fromJson(json['durationMs'] as Object),
  direction:
      $enumDecodeNullable(_$EffectDirectionEnumMap, json['direction']) ??
      EffectDirection.right,
  strength: json['strength'] == null
      ? 1
      : const FiniteDoubleConverter().fromJson(json['strength'] as Object),
  radius: json['radius'] == null
      ? 0.8
      : const FiniteDoubleConverter().fromJson(json['radius'] as Object),
  warmColor: json['warmColor'] == null
      ? 0xFFFFC26B
      : const StrictIntConverter().fromJson(json['warmColor'] as Object),
);

Map<String, dynamic> _$LightLeakEffectOptionsToJson(
  LightLeakEffectOptions instance,
) => <String, dynamic>{
  'durationMs': const StrictIntConverter().toJson(instance.durationMs),
  'direction': _$EffectDirectionEnumMap[instance.direction]!,
  'strength': const FiniteDoubleConverter().toJson(instance.strength),
  'radius': const FiniteDoubleConverter().toJson(instance.radius),
  'warmColor': const StrictIntConverter().toJson(instance.warmColor),
};

BurnAlphaEffectOptions _$BurnAlphaEffectOptionsFromJson(
  Map<String, dynamic> json,
) => BurnAlphaEffectOptions(
  durationMs: json['durationMs'] == null
      ? 0
      : const StrictIntConverter().fromJson(json['durationMs'] as Object),
  direction:
      $enumDecodeNullable(_$EffectDirectionEnumMap, json['direction']) ??
      EffectDirection.right,
  roughness: json['roughness'] == null
      ? 0.065
      : const FiniteDoubleConverter().fromJson(json['roughness'] as Object),
  edgeWidth: json['edgeWidth'] == null
      ? 0.065
      : const FiniteDoubleConverter().fromJson(json['edgeWidth'] as Object),
  emberColor: json['emberColor'] == null
      ? 0xFFFF4B00
      : const StrictIntConverter().fromJson(json['emberColor'] as Object),
);

Map<String, dynamic> _$BurnAlphaEffectOptionsToJson(
  BurnAlphaEffectOptions instance,
) => <String, dynamic>{
  'durationMs': const StrictIntConverter().toJson(instance.durationMs),
  'direction': _$EffectDirectionEnumMap[instance.direction]!,
  'roughness': const FiniteDoubleConverter().toJson(instance.roughness),
  'edgeWidth': const FiniteDoubleConverter().toJson(instance.edgeWidth),
  'emberColor': const StrictIntConverter().toJson(instance.emberColor),
};

FoldMotionEffectOptions _$FoldMotionEffectOptionsFromJson(
  Map<String, dynamic> json,
) => FoldMotionEffectOptions(
  durationMs: json['durationMs'] == null
      ? 0
      : const StrictIntConverter().fromJson(json['durationMs'] as Object),
  axis:
      $enumDecodeNullable(_$EffectAxisEnumMap, json['axis']) ??
      EffectAxis.vertical,
  shadowIntensity: json['shadowIntensity'] == null
      ? 0.65
      : const FiniteDoubleConverter().fromJson(
          json['shadowIntensity'] as Object,
        ),
  perspectiveStrength: json['perspectiveStrength'] == null
      ? 1
      : const FiniteDoubleConverter().fromJson(
          json['perspectiveStrength'] as Object,
        ),
);

Map<String, dynamic> _$FoldMotionEffectOptionsToJson(
  FoldMotionEffectOptions instance,
) => <String, dynamic>{
  'durationMs': const StrictIntConverter().toJson(instance.durationMs),
  'axis': _$EffectAxisEnumMap[instance.axis]!,
  'shadowIntensity': const FiniteDoubleConverter().toJson(
    instance.shadowIntensity,
  ),
  'perspectiveStrength': const FiniteDoubleConverter().toJson(
    instance.perspectiveStrength,
  ),
};

GlowEffectOptions _$GlowEffectOptionsFromJson(Map<String, dynamic> json) =>
    GlowEffectOptions(
      durationMs: json['durationMs'] == null
          ? 0
          : const StrictIntConverter().fromJson(json['durationMs'] as Object),
      strength: json['strength'] == null
          ? 0.7
          : const FiniteDoubleConverter().fromJson(json['strength'] as Object),
      radius: json['radius'] == null
          ? 0.045
          : const FiniteDoubleConverter().fromJson(json['radius'] as Object),
      gain: json['gain'] == null
          ? 2.4
          : const FiniteDoubleConverter().fromJson(json['gain'] as Object),
    );

Map<String, dynamic> _$GlowEffectOptionsToJson(GlowEffectOptions instance) =>
    <String, dynamic>{
      'durationMs': const StrictIntConverter().toJson(instance.durationMs),
      'strength': const FiniteDoubleConverter().toJson(instance.strength),
      'radius': const FiniteDoubleConverter().toJson(instance.radius),
      'gain': const FiniteDoubleConverter().toJson(instance.gain),
    };

KaleidoscopeEffectOptions _$KaleidoscopeEffectOptionsFromJson(
  Map<String, dynamic> json,
) => KaleidoscopeEffectOptions(
  durationMs: json['durationMs'] == null
      ? 0
      : const StrictIntConverter().fromJson(json['durationMs'] as Object),
  sectorCount: json['sectorCount'] == null
      ? 6
      : const StrictIntConverter().fromJson(json['sectorCount'] as Object),
  rotationDegrees: json['rotationDegrees'] == null
      ? 54
      : const FiniteDoubleConverter().fromJson(
          json['rotationDegrees'] as Object,
        ),
  origin:
      $enumDecodeNullable(_$EffectOriginEnumMap, json['origin']) ??
      EffectOrigin.center,
);

Map<String, dynamic> _$KaleidoscopeEffectOptionsToJson(
  KaleidoscopeEffectOptions instance,
) => <String, dynamic>{
  'durationMs': const StrictIntConverter().toJson(instance.durationMs),
  'sectorCount': const StrictIntConverter().toJson(instance.sectorCount),
  'rotationDegrees': const FiniteDoubleConverter().toJson(
    instance.rotationDegrees,
  ),
  'origin': _$EffectOriginEnumMap[instance.origin]!,
};

TvPowerEffectOptions _$TvPowerEffectOptionsFromJson(
  Map<String, dynamic> json,
) => TvPowerEffectOptions(
  durationMs: json['durationMs'] == null
      ? 0
      : const StrictIntConverter().fromJson(json['durationMs'] as Object),
  lineAxis:
      $enumDecodeNullable(_$EffectAxisEnumMap, json['lineAxis']) ??
      EffectAxis.horizontal,
  glowStrength: json['glowStrength'] == null
      ? 1
      : const FiniteDoubleConverter().fromJson(json['glowStrength'] as Object),
  glowColor: json['glowColor'] == null
      ? 0xFF80EDFF
      : const StrictIntConverter().fromJson(json['glowColor'] as Object),
);

Map<String, dynamic> _$TvPowerEffectOptionsToJson(
  TvPowerEffectOptions instance,
) => <String, dynamic>{
  'durationMs': const StrictIntConverter().toJson(instance.durationMs),
  'lineAxis': _$EffectAxisEnumMap[instance.lineAxis]!,
  'glowStrength': const FiniteDoubleConverter().toJson(instance.glowStrength),
  'glowColor': const StrictIntConverter().toJson(instance.glowColor),
};

SpringMotionEffectOptions _$SpringMotionEffectOptionsFromJson(
  Map<String, dynamic> json,
) => SpringMotionEffectOptions(
  durationMs: json['durationMs'] == null
      ? 0
      : const StrictIntConverter().fromJson(json['durationMs'] as Object),
  direction:
      $enumDecodeNullable(_$EffectDirectionEnumMap, json['direction']) ??
      EffectDirection.left,
  springStrength: json['springStrength'] == null
      ? 1
      : const FiniteDoubleConverter().fromJson(
          json['springStrength'] as Object,
        ),
  startScale: json['startScale'] == null
      ? 0.85
      : const FiniteDoubleConverter().fromJson(json['startScale'] as Object),
);

Map<String, dynamic> _$SpringMotionEffectOptionsToJson(
  SpringMotionEffectOptions instance,
) => <String, dynamic>{
  'durationMs': const StrictIntConverter().toJson(instance.durationMs),
  'direction': _$EffectDirectionEnumMap[instance.direction]!,
  'springStrength': const FiniteDoubleConverter().toJson(
    instance.springStrength,
  ),
  'startScale': const FiniteDoubleConverter().toJson(instance.startScale),
};

ShapeDissolveEffectOptions _$ShapeDissolveEffectOptionsFromJson(
  Map<String, dynamic> json,
) => ShapeDissolveEffectOptions(
  durationMs: json['durationMs'] == null
      ? 0
      : const StrictIntConverter().fromJson(json['durationMs'] as Object),
  shape:
      $enumDecodeNullable(_$CellShapeEnumMap, json['shape']) ??
      CellShape.hexagon,
  cellsAcross: json['cellsAcross'] == null
      ? 12
      : const StrictIntConverter().fromJson(json['cellsAcross'] as Object),
  staggerFraction: json['staggerFraction'] == null
      ? 0.28
      : const FiniteDoubleConverter().fromJson(
          json['staggerFraction'] as Object,
        ),
);

Map<String, dynamic> _$ShapeDissolveEffectOptionsToJson(
  ShapeDissolveEffectOptions instance,
) => <String, dynamic>{
  'durationMs': const StrictIntConverter().toJson(instance.durationMs),
  'shape': _$CellShapeEnumMap[instance.shape]!,
  'cellsAcross': const StrictIntConverter().toJson(instance.cellsAcross),
  'staggerFraction': const FiniteDoubleConverter().toJson(
    instance.staggerFraction,
  ),
};

const _$CellShapeEnumMap = {
  CellShape.hexagon: 'hexagon',
  CellShape.circle: 'circle',
  CellShape.diamond: 'diamond',
  CellShape.square: 'square',
};

VhsDamageEffectOptions _$VhsDamageEffectOptionsFromJson(
  Map<String, dynamic> json,
) => VhsDamageEffectOptions(
  durationMs: json['durationMs'] == null
      ? 0
      : const StrictIntConverter().fromJson(json['durationMs'] as Object),
  colorShiftFraction: json['colorShiftFraction'] == null
      ? 0.035
      : const FiniteDoubleConverter().fromJson(
          json['colorShiftFraction'] as Object,
        ),
  trackingStrength: json['trackingStrength'] == null
      ? 1
      : const FiniteDoubleConverter().fromJson(
          json['trackingStrength'] as Object,
        ),
  noiseStrength: json['noiseStrength'] == null
      ? 1
      : const FiniteDoubleConverter().fromJson(json['noiseStrength'] as Object),
);

Map<String, dynamic> _$VhsDamageEffectOptionsToJson(
  VhsDamageEffectOptions instance,
) => <String, dynamic>{
  'durationMs': const StrictIntConverter().toJson(instance.durationMs),
  'colorShiftFraction': const FiniteDoubleConverter().toJson(
    instance.colorShiftFraction,
  ),
  'trackingStrength': const FiniteDoubleConverter().toJson(
    instance.trackingStrength,
  ),
  'noiseStrength': const FiniteDoubleConverter().toJson(instance.noiseStrength),
};

RadialBlurEffectOptions _$RadialBlurEffectOptionsFromJson(
  Map<String, dynamic> json,
) => RadialBlurEffectOptions(
  durationMs: json['durationMs'] == null
      ? 0
      : const StrictIntConverter().fromJson(json['durationMs'] as Object),
  angleDegrees: json['angleDegrees'] == null
      ? 0.2 * 180 / math.pi
      : const FiniteDoubleConverter().fromJson(json['angleDegrees'] as Object),
  origin:
      $enumDecodeNullable(_$EffectOriginEnumMap, json['origin']) ??
      EffectOrigin.center,
);

Map<String, dynamic> _$RadialBlurEffectOptionsToJson(
  RadialBlurEffectOptions instance,
) => <String, dynamic>{
  'durationMs': const StrictIntConverter().toJson(instance.durationMs),
  'angleDegrees': const FiniteDoubleConverter().toJson(instance.angleDegrees),
  'origin': _$EffectOriginEnumMap[instance.origin]!,
};

PhosphorEffectOptions _$PhosphorEffectOptionsFromJson(
  Map<String, dynamic> json,
) => PhosphorEffectOptions(
  durationMs: json['durationMs'] == null
      ? 0
      : const StrictIntConverter().fromJson(json['durationMs'] as Object),
  trailCount: json['trailCount'] == null
      ? 3
      : const StrictIntConverter().fromJson(json['trailCount'] as Object),
  driftFraction: json['driftFraction'] == null
      ? 0.32
      : const FiniteDoubleConverter().fromJson(json['driftFraction'] as Object),
  trailStrength: json['trailStrength'] == null
      ? 1
      : const FiniteDoubleConverter().fromJson(json['trailStrength'] as Object),
  trailColor: json['trailColor'] == null
      ? 0xFF50FFC8
      : const StrictIntConverter().fromJson(json['trailColor'] as Object),
);

Map<String, dynamic> _$PhosphorEffectOptionsToJson(
  PhosphorEffectOptions instance,
) => <String, dynamic>{
  'durationMs': const StrictIntConverter().toJson(instance.durationMs),
  'trailCount': const StrictIntConverter().toJson(instance.trailCount),
  'driftFraction': const FiniteDoubleConverter().toJson(instance.driftFraction),
  'trailStrength': const FiniteDoubleConverter().toJson(instance.trailStrength),
  'trailColor': const StrictIntConverter().toJson(instance.trailColor),
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
