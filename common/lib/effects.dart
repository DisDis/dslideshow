import 'dart:math' as math;

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';

part 'effects.g.dart';
part 'effects.freezed.dart';

/// Persistent identifiers. Algorithm variants belong to typed options.
enum EffectType {
  @JsonValue('burnAlpha')
  burnAlpha,
  @JsonValue('foldMotion')
  foldMotion,
  @JsonValue('glow')
  glow,
  @JsonValue('kaleidoscope')
  kaleidoscope,
  @JsonValue('tvPower')
  tvPower,
  @JsonValue('springMotion')
  springMotion,
  @JsonValue('shapeDissolve')
  shapeDissolve,
  @JsonValue('vhsDamage')
  vhsDamage,
  @JsonValue('radialBlur')
  radialBlur,
  @JsonValue('phosphor')
  phosphor,
  @JsonValue('filmDissolve')
  filmDissolve,
  @JsonValue('frame')
  frame,
  @JsonValue('louver')
  louver,
  @JsonValue('mirror')
  mirror,
  @JsonValue('clockWipe')
  clockWipe,
  @JsonValue('split')
  split,
  @JsonValue('panelWipe')
  panelWipe,
  @JsonValue('stretch')
  stretch,
  @JsonValue('starWipe')
  starWipe,
  @JsonValue('lightLeak')
  lightLeak,
  @JsonValue('filmRoll')
  filmRoll,
  @JsonValue('crossZoom')
  crossZoom,
  @JsonValue('whip')
  whip,
  @JsonValue('glass')
  glass,
  @JsonValue('softWipe')
  softWipe,
  @JsonValue('slice')
  slice,
  @JsonValue('lumaFade')
  lumaFade,
  @JsonValue('pagePeel')
  pagePeel,
  @JsonValue('noiseDissolve')
  noiseDissolve,
  @JsonValue('rippleReveal')
  rippleReveal,
  @JsonValue('waterRefraction')
  waterRefraction,
  @JsonValue('cube')
  cube,
  @JsonValue('accordion')
  accordion,
  @JsonValue('backgroundToForeground')
  backgroundToForeground,
  @JsonValue('foregroundToBackground')
  foregroundToBackground,
  @JsonValue('depth')
  depth,
  @JsonValue('parallax')
  parallax,
  @JsonValue('stack')
  stack,
  @JsonValue('tablet')
  tablet,
  @JsonValue('zoomOut')
  zoomOut,
  @JsonValue('fade')
  fade,
  @JsonValue('mosaic')
  mosaic,
  @JsonValue('liquidMorph')
  liquidMorph,
  @JsonValue('blinds')
  blinds,
  @JsonValue('blurFade')
  blurFade,
  @JsonValue('zoomOver')
  zoomOver,
  @JsonValue('slide')
  slide,
  @JsonValue('revealMask')
  revealMask,
  @JsonValue('fadeThroughColor')
  fadeThroughColor,
  @JsonValue('flip')
  flip,
  @JsonValue('rotate')
  rotate,
  unknown,
}

enum EffectDirection { left, right, up, down }

enum MosaicDirection { random, topLeft, topRight, bottomLeft, bottomRight }

enum EffectAxis { horizontal, vertical }

enum EffectOrigin { center, topLeft, topRight, bottomLeft, bottomRight }

enum SlideMode { push, cover, reveal }

enum RevealShape { wipe, curtain, diagonal, iris, rectangle, star, clock }

enum SoftWipeStyle { soft, lightSweep, neon }

enum RotationEdge { top, bottom }

enum EffectGroup { fades, movement, masks, geometric, cinematic, creative }

enum FadeStyle { plain, linearLight, blur, throughColor }

enum BlendCurve { linear, easeIn, easeOut, easeInOut }

enum BlurTarget { outgoing, incoming, both }

enum DepthMode { recedeStill, recedeSlide, approach }

enum ZoomMode { over, cross }

enum WipeEdgeStyle { hard, soft, lightSweep, neon }

enum RevealOperation { revealIncoming, hideOutgoing }

enum SliceMode { slide, reveal }

enum StripPattern { alternating, sameDirection }

enum SequenceOrder { forward, backward }

enum RotationSense { forward, backward }

enum CircularDirection { clockwise, counterclockwise }

enum LumaOrder { brightFirst, darkFirst }

enum CellShape { hexagon, circle, diamond, square }

enum MirrorSide { leading, trailing }

enum SlideDecoration { none, filmPerforation }

class StrictIntConverter implements JsonConverter<int, Object> {
  const StrictIntConverter();
  @override
  int fromJson(Object value) {
    if (value is! int) throw const FormatException('Expected an integer');
    return value;
  }

  @override
  int toJson(int value) => value;
}

class FiniteDoubleConverter implements JsonConverter<double, Object> {
  const FiniteDoubleConverter();
  @override
  double fromJson(Object value) {
    if (value is! num || !value.isFinite) {
      throw const FormatException('Expected a finite number');
    }
    return value.toDouble();
  }

  @override
  Object toJson(double value) => value.isFinite ? value : value.toString();
}

/// Scalar defaults are removed after generated JSON serialization.
Map<String, dynamic> _withoutDefaults(
  Map<String, dynamic> json,
  Map<String, dynamic> defaults,
) => json
  ..removeWhere(
    (key, value) => defaults.containsKey(key) && defaults[key] == value,
  );

/// Common contract; data, equality and copyWith belong to Freezed models.
abstract class EffectOptions {
  const EffectOptions();
  int get durationMs;
  Map<String, dynamic> toJson();
  EffectOptions withDuration(int durationMs);
}

@freezed
@JsonSerializable()
class BasicEffectOptions extends EffectOptions with _$BasicEffectOptions {
  @override
  @StrictIntConverter()
  final int durationMs;
  const BasicEffectOptions({this.durationMs = 0});
  factory BasicEffectOptions.fromJson(Map<String, dynamic> json) =>
      _$BasicEffectOptionsFromJson(json);
  @override
  Map<String, dynamic> toJson() => _withoutDefaults(
    _$BasicEffectOptionsToJson(this),
    _$BasicEffectOptionsToJson(const BasicEffectOptions()),
  );
  @override
  BasicEffectOptions withDuration(int durationMs) =>
      copyWith(durationMs: durationMs);
}

@freezed
@JsonSerializable()
class MosaicEffectOptions extends EffectOptions with _$MosaicEffectOptions {
  @override
  @StrictIntConverter()
  final int durationMs;
  @StrictIntConverter()
  final int gridSize;
  @FiniteDoubleConverter()
  final double fadeFraction;
  final MosaicDirection direction;
  @FiniteDoubleConverter()
  final double randomness;
  const MosaicEffectOptions({
    this.durationMs = 0,
    this.gridSize = 100,
    this.fadeFraction = 0.3,
    this.direction = MosaicDirection.random,
    this.randomness = 0.2,
  });
  factory MosaicEffectOptions.fromJson(Map<String, dynamic> json) =>
      _$MosaicEffectOptionsFromJson(json);
  @override
  Map<String, dynamic> toJson() => _withoutDefaults(
    _$MosaicEffectOptionsToJson(this),
    _$MosaicEffectOptionsToJson(const MosaicEffectOptions()),
  );
  @override
  MosaicEffectOptions withDuration(int durationMs) =>
      copyWith(durationMs: durationMs);
}

@freezed
@JsonSerializable()
class SlideEffectOptions extends EffectOptions with _$SlideEffectOptions {
  @override
  @StrictIntConverter()
  final int durationMs;
  final SlideMode mode;
  final EffectDirection direction;
  final BlendCurve motionCurve;
  @FiniteDoubleConverter()
  final double blurFraction;
  final SlideDecoration decoration;
  @FiniteDoubleConverter()
  final double edgeWidth;
  @FiniteDoubleConverter()
  final double tiltDegrees;
  @FiniteDoubleConverter()
  final double shadowStrength;
  const SlideEffectOptions({
    this.durationMs = 0,
    this.mode = SlideMode.push,
    this.direction = EffectDirection.left,
    this.motionCurve = BlendCurve.linear,
    this.blurFraction = 0,
    this.decoration = SlideDecoration.none,
    this.edgeWidth = 0.055,
    this.tiltDegrees = 0,
    this.shadowStrength = 0,
  });
  factory SlideEffectOptions.fromJson(Map<String, dynamic> json) =>
      _$SlideEffectOptionsFromJson(json);
  @override
  Map<String, dynamic> toJson() => _withoutDefaults(
    _$SlideEffectOptionsToJson(this),
    _$SlideEffectOptionsToJson(const SlideEffectOptions()),
  );
  @override
  SlideEffectOptions withDuration(int durationMs) =>
      copyWith(durationMs: durationMs);
}

@freezed
@JsonSerializable()
class RevealMaskEffectOptions extends EffectOptions
    with _$RevealMaskEffectOptions {
  @override
  @StrictIntConverter()
  final int durationMs;
  final RevealShape shape;
  final EffectDirection direction;
  final EffectAxis axis;
  final EffectOrigin origin;
  final RevealOperation operation;
  final WipeEdgeStyle edgeStyle;
  @FiniteDoubleConverter()
  final double? featherFraction;
  @FiniteDoubleConverter()
  final double lightStrength;
  final bool frameEnabled;
  @FiniteDoubleConverter()
  final double borderWidth;
  @StrictIntConverter()
  final int borderColor;
  @FiniteDoubleConverter()
  final double shadowStrength;
  @StrictIntConverter()
  final int pointCount;
  @FiniteDoubleConverter()
  final double innerRadiusRatio;
  @FiniteDoubleConverter()
  final double rotationDegrees;
  @FiniteDoubleConverter()
  final double startAngleDegrees;
  final CircularDirection circularDirection;
  const RevealMaskEffectOptions({
    this.durationMs = 0,
    this.shape = RevealShape.wipe,
    this.direction = EffectDirection.left,
    this.axis = EffectAxis.horizontal,
    this.origin = EffectOrigin.topLeft,
    this.operation = RevealOperation.revealIncoming,
    this.edgeStyle = WipeEdgeStyle.hard,
    this.featherFraction = null,
    this.lightStrength = 1,
    this.frameEnabled = false,
    this.borderWidth = 0.004,
    this.borderColor = 0xFFFFF4DC,
    this.shadowStrength = 0.8,
    this.pointCount = 5,
    this.innerRadiusRatio = 0.42,
    this.rotationDegrees = 0,
    this.startAngleDegrees = 0,
    this.circularDirection = CircularDirection.clockwise,
  });
  factory RevealMaskEffectOptions.fromJson(Map<String, dynamic> json) =>
      _$RevealMaskEffectOptionsFromJson(json);
  @override
  Map<String, dynamic> toJson() => _withoutDefaults(
    _$RevealMaskEffectOptionsToJson(this),
    _$RevealMaskEffectOptionsToJson(const RevealMaskEffectOptions()),
  );
  @override
  RevealMaskEffectOptions withDuration(int durationMs) =>
      copyWith(durationMs: durationMs);
}

@freezed
@JsonSerializable()
class FadeThroughColorEffectOptions extends EffectOptions
    with _$FadeThroughColorEffectOptions {
  @override
  @StrictIntConverter()
  final int durationMs;
  @StrictIntConverter()
  final int color;
  const FadeThroughColorEffectOptions({
    this.durationMs = 0,
    this.color = 0xFF000000,
  });
  factory FadeThroughColorEffectOptions.fromJson(Map<String, dynamic> json) =>
      _$FadeThroughColorEffectOptionsFromJson(json);
  @override
  Map<String, dynamic> toJson() => _withoutDefaults(
    _$FadeThroughColorEffectOptionsToJson(this),
    _$FadeThroughColorEffectOptionsToJson(
      const FadeThroughColorEffectOptions(),
    ),
  );
  @override
  FadeThroughColorEffectOptions withDuration(int durationMs) =>
      copyWith(durationMs: durationMs);
}

@freezed
@JsonSerializable()
class SoftWipeEffectOptions extends EffectOptions with _$SoftWipeEffectOptions {
  @override
  @StrictIntConverter()
  final int durationMs;
  final SoftWipeStyle style;
  const SoftWipeEffectOptions({
    this.durationMs = 0,
    this.style = SoftWipeStyle.soft,
  });
  factory SoftWipeEffectOptions.fromJson(Map<String, dynamic> json) =>
      _$SoftWipeEffectOptionsFromJson(json);
  @override
  Map<String, dynamic> toJson() => _withoutDefaults(
    _$SoftWipeEffectOptionsToJson(this),
    _$SoftWipeEffectOptionsToJson(const SoftWipeEffectOptions()),
  );
  @override
  SoftWipeEffectOptions withDuration(int durationMs) =>
      copyWith(durationMs: durationMs);
}

@freezed
@JsonSerializable()
class FlipEffectOptions extends EffectOptions with _$FlipEffectOptions {
  @override
  @StrictIntConverter()
  final int durationMs;
  final EffectAxis axis;
  final RotationSense rotationSense;
  @FiniteDoubleConverter()
  final double perspectiveStrength;
  const FlipEffectOptions({
    this.durationMs = 0,
    this.axis = EffectAxis.horizontal,
    this.rotationSense = RotationSense.forward,
    this.perspectiveStrength = 1,
  });
  factory FlipEffectOptions.fromJson(Map<String, dynamic> json) =>
      _$FlipEffectOptionsFromJson(json);
  @override
  Map<String, dynamic> toJson() => _withoutDefaults(
    _$FlipEffectOptionsToJson(this),
    _$FlipEffectOptionsToJson(const FlipEffectOptions()),
  );
  @override
  FlipEffectOptions withDuration(int durationMs) =>
      copyWith(durationMs: durationMs);
}

@freezed
@JsonSerializable()
class RotateEffectOptions extends EffectOptions with _$RotateEffectOptions {
  @override
  @StrictIntConverter()
  final int durationMs;
  final RotationEdge edge;
  @FiniteDoubleConverter()
  final double angleDegrees;
  final EffectDirection direction;
  const RotateEffectOptions({
    this.durationMs = 0,
    this.edge = RotationEdge.top,
    this.angleDegrees = 45,
    this.direction = EffectDirection.left,
  });
  factory RotateEffectOptions.fromJson(Map<String, dynamic> json) =>
      _$RotateEffectOptionsFromJson(json);
  @override
  Map<String, dynamic> toJson() => _withoutDefaults(
    _$RotateEffectOptionsToJson(this),
    _$RotateEffectOptionsToJson(const RotateEffectOptions()),
  );
  @override
  RotateEffectOptions withDuration(int durationMs) =>
      copyWith(durationMs: durationMs);
}

@freezed
@JsonSerializable()
class BlindsEffectOptions extends EffectOptions with _$BlindsEffectOptions {
  @override
  @StrictIntConverter()
  final int durationMs;
  @StrictIntConverter()
  final int stripCount;
  final EffectAxis axis;
  final SequenceOrder order;
  @FiniteDoubleConverter()
  final double staggerFraction;
  const BlindsEffectOptions({
    this.durationMs = 0,
    this.stripCount = 10,
    this.axis = EffectAxis.horizontal,
    this.order = SequenceOrder.forward,
    this.staggerFraction = 0.5,
  });
  factory BlindsEffectOptions.fromJson(Map<String, dynamic> json) =>
      _$BlindsEffectOptionsFromJson(json);
  @override
  Map<String, dynamic> toJson() => _withoutDefaults(
    _$BlindsEffectOptionsToJson(this),
    _$BlindsEffectOptionsToJson(const BlindsEffectOptions()),
  );
  @override
  BlindsEffectOptions withDuration(int durationMs) =>
      copyWith(durationMs: durationMs);
}

@freezed
@JsonSerializable()
class SliceEffectOptions extends EffectOptions with _$SliceEffectOptions {
  @override
  @StrictIntConverter()
  final int durationMs;
  @StrictIntConverter()
  final int stripCount;
  final SliceMode mode;
  final EffectAxis axis;
  @FiniteDoubleConverter()
  final double staggerFraction;
  final StripPattern pattern;
  const SliceEffectOptions({
    this.durationMs = 0,
    this.stripCount = 8,
    this.mode = SliceMode.slide,
    this.axis = EffectAxis.horizontal,
    this.staggerFraction = 0.32,
    this.pattern = StripPattern.alternating,
  });
  factory SliceEffectOptions.fromJson(Map<String, dynamic> json) =>
      _$SliceEffectOptionsFromJson(json);
  @override
  Map<String, dynamic> toJson() => _withoutDefaults(
    _$SliceEffectOptionsToJson(this),
    _$SliceEffectOptionsToJson(const SliceEffectOptions()),
  );
  @override
  SliceEffectOptions withDuration(int durationMs) =>
      copyWith(durationMs: durationMs);
}

@freezed
@JsonSerializable()
class GlassEffectOptions extends EffectOptions with _$GlassEffectOptions {
  @override
  @StrictIntConverter()
  final int durationMs;
  @StrictIntConverter()
  final int paneCount;
  final EffectAxis axis;
  @FiniteDoubleConverter()
  final double refractionStrength;
  @FiniteDoubleConverter()
  final double glintStrength;
  const GlassEffectOptions({
    this.durationMs = 0,
    this.paneCount = 8,
    this.axis = EffectAxis.vertical,
    this.refractionStrength = 1,
    this.glintStrength = 1,
  });
  factory GlassEffectOptions.fromJson(Map<String, dynamic> json) =>
      _$GlassEffectOptionsFromJson(json);
  @override
  Map<String, dynamic> toJson() => _withoutDefaults(
    _$GlassEffectOptionsToJson(this),
    _$GlassEffectOptionsToJson(const GlassEffectOptions()),
  );
  @override
  GlassEffectOptions withDuration(int durationMs) =>
      copyWith(durationMs: durationMs);
}

@freezed
@JsonSerializable()
class PanelWipeEffectOptions extends EffectOptions
    with _$PanelWipeEffectOptions {
  @override
  @StrictIntConverter()
  final int durationMs;
  @StrictIntConverter()
  final int panelCount;
  const PanelWipeEffectOptions({this.durationMs = 0, this.panelCount = 8});
  factory PanelWipeEffectOptions.fromJson(Map<String, dynamic> json) =>
      _$PanelWipeEffectOptionsFromJson(json);
  @override
  Map<String, dynamic> toJson() => _withoutDefaults(
    _$PanelWipeEffectOptionsToJson(this),
    _$PanelWipeEffectOptionsToJson(const PanelWipeEffectOptions()),
  );
  @override
  PanelWipeEffectOptions withDuration(int durationMs) =>
      copyWith(durationMs: durationMs);
}

@freezed
@JsonSerializable()
class LouverEffectOptions extends EffectOptions with _$LouverEffectOptions {
  @override
  @StrictIntConverter()
  final int durationMs;
  @StrictIntConverter()
  final int slatCount;
  final EffectAxis axis;
  @FiniteDoubleConverter()
  final double staggerFraction;
  @FiniteDoubleConverter()
  final double shadowIntensity;
  final RotationSense rotationSense;
  const LouverEffectOptions({
    this.durationMs = 0,
    this.slatCount = 8,
    this.axis = EffectAxis.vertical,
    this.staggerFraction = 0.25,
    this.shadowIntensity = 0.35,
    this.rotationSense = RotationSense.forward,
  });
  factory LouverEffectOptions.fromJson(Map<String, dynamic> json) =>
      _$LouverEffectOptionsFromJson(json);
  @override
  Map<String, dynamic> toJson() => _withoutDefaults(
    _$LouverEffectOptionsToJson(this),
    _$LouverEffectOptionsToJson(const LouverEffectOptions()),
  );
  @override
  LouverEffectOptions withDuration(int durationMs) =>
      copyWith(durationMs: durationMs);
}

@freezed
@JsonSerializable()
class FadeEffectOptions extends EffectOptions with _$FadeEffectOptions {
  @override
  @StrictIntConverter()
  final int durationMs;
  final FadeStyle style;
  final BlendCurve blendCurve;
  @FiniteDoubleConverter()
  final double maxSigma;
  final BlurTarget blurTarget;
  @StrictIntConverter()
  final int color;
  @FiniteDoubleConverter()
  final double holdFraction;
  @FiniteDoubleConverter()
  final double fadeOutShare;
  const FadeEffectOptions({
    this.durationMs = 0,
    this.style = FadeStyle.plain,
    this.blendCurve = BlendCurve.linear,
    this.maxSigma = 10,
    this.blurTarget = BlurTarget.outgoing,
    this.color = 0xFF000000,
    this.holdFraction = 0,
    this.fadeOutShare = 0.5,
  });
  factory FadeEffectOptions.fromJson(Map<String, dynamic> json) =>
      _$FadeEffectOptionsFromJson(json);
  @override
  Map<String, dynamic> toJson() => _withoutDefaults(
    _$FadeEffectOptionsToJson(this),
    _$FadeEffectOptionsToJson(const FadeEffectOptions()),
  );
  @override
  FadeEffectOptions withDuration(int durationMs) =>
      copyWith(durationMs: durationMs);
}

@freezed
@JsonSerializable()
class LumaFadeEffectOptions extends EffectOptions with _$LumaFadeEffectOptions {
  @override
  @StrictIntConverter()
  final int durationMs;
  final LumaOrder order;
  @FiniteDoubleConverter()
  final double softness;
  const LumaFadeEffectOptions({
    this.durationMs = 0,
    this.order = LumaOrder.brightFirst,
    this.softness = 0.18,
  });
  factory LumaFadeEffectOptions.fromJson(Map<String, dynamic> json) =>
      _$LumaFadeEffectOptionsFromJson(json);
  @override
  Map<String, dynamic> toJson() => _withoutDefaults(
    _$LumaFadeEffectOptionsToJson(this),
    _$LumaFadeEffectOptionsToJson(const LumaFadeEffectOptions()),
  );
  @override
  LumaFadeEffectOptions withDuration(int durationMs) =>
      copyWith(durationMs: durationMs);
}

@freezed
@JsonSerializable()
class NoiseDissolveEffectOptions extends EffectOptions
    with _$NoiseDissolveEffectOptions {
  @override
  @StrictIntConverter()
  final int durationMs;
  @FiniteDoubleConverter()
  final double noiseScale;
  @FiniteDoubleConverter()
  final double softness;
  const NoiseDissolveEffectOptions({
    this.durationMs = 0,
    this.noiseScale = 28,
    this.softness = 0.08,
  });
  factory NoiseDissolveEffectOptions.fromJson(Map<String, dynamic> json) =>
      _$NoiseDissolveEffectOptionsFromJson(json);
  @override
  Map<String, dynamic> toJson() => _withoutDefaults(
    _$NoiseDissolveEffectOptionsToJson(this),
    _$NoiseDissolveEffectOptionsToJson(const NoiseDissolveEffectOptions()),
  );
  @override
  NoiseDissolveEffectOptions withDuration(int durationMs) =>
      copyWith(durationMs: durationMs);
}

@freezed
@JsonSerializable()
class RippleRevealEffectOptions extends EffectOptions
    with _$RippleRevealEffectOptions {
  @override
  @StrictIntConverter()
  final int durationMs;
  final EffectOrigin origin;
  @FiniteDoubleConverter()
  final double waveAmplitude;
  @FiniteDoubleConverter()
  final double waveFrequency;
  @FiniteDoubleConverter()
  final double softness;
  const RippleRevealEffectOptions({
    this.durationMs = 0,
    this.origin = EffectOrigin.center,
    this.waveAmplitude = 0.045,
    this.waveFrequency = 82,
    this.softness = 0.025,
  });
  factory RippleRevealEffectOptions.fromJson(Map<String, dynamic> json) =>
      _$RippleRevealEffectOptionsFromJson(json);
  @override
  Map<String, dynamic> toJson() => _withoutDefaults(
    _$RippleRevealEffectOptionsToJson(this),
    _$RippleRevealEffectOptionsToJson(const RippleRevealEffectOptions()),
  );
  @override
  RippleRevealEffectOptions withDuration(int durationMs) =>
      copyWith(durationMs: durationMs);
}

@freezed
@JsonSerializable()
class WaterRefractionEffectOptions extends EffectOptions
    with _$WaterRefractionEffectOptions {
  @override
  @StrictIntConverter()
  final int durationMs;
  final EffectOrigin origin;
  @FiniteDoubleConverter()
  final double refractionStrength;
  @FiniteDoubleConverter()
  final double waveFrequency;
  @FiniteDoubleConverter()
  final double bandWidth;
  const WaterRefractionEffectOptions({
    this.durationMs = 0,
    this.origin = EffectOrigin.center,
    this.refractionStrength = 0.012,
    this.waveFrequency = 92,
    this.bandWidth = 1,
  });
  factory WaterRefractionEffectOptions.fromJson(Map<String, dynamic> json) =>
      _$WaterRefractionEffectOptionsFromJson(json);
  @override
  Map<String, dynamic> toJson() => _withoutDefaults(
    _$WaterRefractionEffectOptionsToJson(this),
    _$WaterRefractionEffectOptionsToJson(const WaterRefractionEffectOptions()),
  );
  @override
  WaterRefractionEffectOptions withDuration(int durationMs) =>
      copyWith(durationMs: durationMs);
}

@freezed
@JsonSerializable()
class LiquidMorphEffectOptions extends EffectOptions
    with _$LiquidMorphEffectOptions {
  @override
  @StrictIntConverter()
  final int durationMs;
  @StrictIntConverter()
  final int waveCount;
  @FiniteDoubleConverter()
  final double waveIntensity;
  @FiniteDoubleConverter()
  final double outgoingScale;
  final EffectOrigin origin;
  const LiquidMorphEffectOptions({
    this.durationMs = 0,
    this.waveCount = 12,
    this.waveIntensity = 15,
    this.outgoingScale = 1.1,
    this.origin = EffectOrigin.center,
  });
  factory LiquidMorphEffectOptions.fromJson(Map<String, dynamic> json) =>
      _$LiquidMorphEffectOptionsFromJson(json);
  @override
  Map<String, dynamic> toJson() => _withoutDefaults(
    _$LiquidMorphEffectOptionsToJson(this),
    _$LiquidMorphEffectOptionsToJson(const LiquidMorphEffectOptions()),
  );
  @override
  LiquidMorphEffectOptions withDuration(int durationMs) =>
      copyWith(durationMs: durationMs);
}

@freezed
@JsonSerializable()
class CubeEffectOptions extends EffectOptions with _$CubeEffectOptions {
  @override
  @StrictIntConverter()
  final int durationMs;
  final EffectDirection direction;
  @FiniteDoubleConverter()
  final double shadowIntensity;
  @FiniteDoubleConverter()
  final double perspectiveStrength;
  const CubeEffectOptions({
    this.durationMs = 0,
    this.direction = EffectDirection.left,
    this.shadowIntensity = 0.5,
    this.perspectiveStrength = 1,
  });
  factory CubeEffectOptions.fromJson(Map<String, dynamic> json) =>
      _$CubeEffectOptionsFromJson(json);
  @override
  Map<String, dynamic> toJson() => _withoutDefaults(
    _$CubeEffectOptionsToJson(this),
    _$CubeEffectOptionsToJson(const CubeEffectOptions()),
  );
  @override
  CubeEffectOptions withDuration(int durationMs) =>
      copyWith(durationMs: durationMs);
}

@freezed
@JsonSerializable()
class AccordionEffectOptions extends EffectOptions
    with _$AccordionEffectOptions {
  @override
  @StrictIntConverter()
  final int durationMs;
  final EffectDirection direction;
  @FiniteDoubleConverter()
  final double shadowIntensity;
  const AccordionEffectOptions({
    this.durationMs = 0,
    this.direction = EffectDirection.left,
    this.shadowIntensity = 0.5,
  });
  factory AccordionEffectOptions.fromJson(Map<String, dynamic> json) =>
      _$AccordionEffectOptionsFromJson(json);
  @override
  Map<String, dynamic> toJson() => _withoutDefaults(
    _$AccordionEffectOptionsToJson(this),
    _$AccordionEffectOptionsToJson(const AccordionEffectOptions()),
  );
  @override
  AccordionEffectOptions withDuration(int durationMs) =>
      copyWith(durationMs: durationMs);
}

@freezed
@JsonSerializable()
class DepthEffectOptions extends EffectOptions with _$DepthEffectOptions {
  @override
  @StrictIntConverter()
  final int durationMs;
  final DepthMode mode;
  @FiniteDoubleConverter()
  final double scale;
  @FiniteDoubleConverter()
  final double shadowIntensity;
  final EffectDirection direction;
  const DepthEffectOptions({
    this.durationMs = 0,
    this.mode = DepthMode.recedeStill,
    this.scale = 0.5,
    this.shadowIntensity = 0.5,
    this.direction = EffectDirection.left,
  });
  factory DepthEffectOptions.fromJson(Map<String, dynamic> json) =>
      _$DepthEffectOptionsFromJson(json);
  @override
  Map<String, dynamic> toJson() => _withoutDefaults(
    _$DepthEffectOptionsToJson(this),
    _$DepthEffectOptionsToJson(const DepthEffectOptions()),
  );
  @override
  DepthEffectOptions withDuration(int durationMs) =>
      copyWith(durationMs: durationMs);
}

@freezed
@JsonSerializable()
class ParallaxEffectOptions extends EffectOptions with _$ParallaxEffectOptions {
  @override
  @StrictIntConverter()
  final int durationMs;
  @FiniteDoubleConverter()
  final double clipAmount;
  final EffectDirection direction;
  const ParallaxEffectOptions({
    this.durationMs = 0,
    this.clipAmount = 200,
    this.direction = EffectDirection.left,
  });
  factory ParallaxEffectOptions.fromJson(Map<String, dynamic> json) =>
      _$ParallaxEffectOptionsFromJson(json);
  @override
  Map<String, dynamic> toJson() => _withoutDefaults(
    _$ParallaxEffectOptionsToJson(this),
    _$ParallaxEffectOptionsToJson(const ParallaxEffectOptions()),
  );
  @override
  ParallaxEffectOptions withDuration(int durationMs) =>
      copyWith(durationMs: durationMs);
}

@freezed
@JsonSerializable()
class TabletEffectOptions extends EffectOptions with _$TabletEffectOptions {
  @override
  @StrictIntConverter()
  final int durationMs;
  final EffectDirection direction;
  @FiniteDoubleConverter()
  final double tiltDegrees;
  @FiniteDoubleConverter()
  final double perspectiveStrength;
  const TabletEffectOptions({
    this.durationMs = 0,
    this.direction = EffectDirection.left,
    this.tiltDegrees = 45,
    this.perspectiveStrength = 1,
  });
  factory TabletEffectOptions.fromJson(Map<String, dynamic> json) =>
      _$TabletEffectOptionsFromJson(json);
  @override
  Map<String, dynamic> toJson() => _withoutDefaults(
    _$TabletEffectOptionsToJson(this),
    _$TabletEffectOptionsToJson(const TabletEffectOptions()),
  );
  @override
  TabletEffectOptions withDuration(int durationMs) =>
      copyWith(durationMs: durationMs);
}

@freezed
@JsonSerializable()
class ZoomOutEffectOptions extends EffectOptions with _$ZoomOutEffectOptions {
  @override
  @StrictIntConverter()
  final int durationMs;
  @FiniteDoubleConverter()
  final double zoomOutScale;
  final bool enableOpacity;
  final EffectDirection direction;
  const ZoomOutEffectOptions({
    this.durationMs = 0,
    this.zoomOutScale = 0.8,
    this.enableOpacity = true,
    this.direction = EffectDirection.left,
  });
  factory ZoomOutEffectOptions.fromJson(Map<String, dynamic> json) =>
      _$ZoomOutEffectOptionsFromJson(json);
  @override
  Map<String, dynamic> toJson() => _withoutDefaults(
    _$ZoomOutEffectOptionsToJson(this),
    _$ZoomOutEffectOptionsToJson(const ZoomOutEffectOptions()),
  );
  @override
  ZoomOutEffectOptions withDuration(int durationMs) =>
      copyWith(durationMs: durationMs);
}

@freezed
@JsonSerializable()
class ZoomOverEffectOptions extends EffectOptions with _$ZoomOverEffectOptions {
  @override
  @StrictIntConverter()
  final int durationMs;
  final ZoomMode mode;
  @FiniteDoubleConverter()
  final double startScale;
  @FiniteDoubleConverter()
  final double outgoingScale;
  @FiniteDoubleConverter()
  final double blurFraction;
  final EffectOrigin origin;
  const ZoomOverEffectOptions({
    this.durationMs = 0,
    this.mode = ZoomMode.over,
    this.startScale = 1.5,
    this.outgoingScale = 0.9,
    this.blurFraction = 0,
    this.origin = EffectOrigin.center,
  });
  factory ZoomOverEffectOptions.fromJson(Map<String, dynamic> json) =>
      _$ZoomOverEffectOptionsFromJson(json);
  @override
  Map<String, dynamic> toJson() => _withoutDefaults(
    _$ZoomOverEffectOptionsToJson(this),
    _$ZoomOverEffectOptionsToJson(const ZoomOverEffectOptions()),
  );
  @override
  ZoomOverEffectOptions withDuration(int durationMs) =>
      copyWith(durationMs: durationMs);
}

@freezed
@JsonSerializable()
class PagePeelEffectOptions extends EffectOptions with _$PagePeelEffectOptions {
  @override
  @StrictIntConverter()
  final int durationMs;
  final EffectOrigin corner;
  @FiniteDoubleConverter()
  final double foldWidth;
  @StrictIntConverter()
  final int paperColor;
  @FiniteDoubleConverter()
  final double shadowStrength;
  const PagePeelEffectOptions({
    this.durationMs = 0,
    this.corner = EffectOrigin.topRight,
    this.foldWidth = 0.12,
    this.paperColor = 0xFFFFFDF5,
    this.shadowStrength = 0.55,
  });
  factory PagePeelEffectOptions.fromJson(Map<String, dynamic> json) =>
      _$PagePeelEffectOptionsFromJson(json);
  @override
  Map<String, dynamic> toJson() => _withoutDefaults(
    _$PagePeelEffectOptionsToJson(this),
    _$PagePeelEffectOptionsToJson(const PagePeelEffectOptions()),
  );
  @override
  PagePeelEffectOptions withDuration(int durationMs) =>
      copyWith(durationMs: durationMs);
}

@freezed
@JsonSerializable()
class SplitEffectOptions extends EffectOptions with _$SplitEffectOptions {
  @override
  @StrictIntConverter()
  final int durationMs;
  final EffectAxis axis;
  @FiniteDoubleConverter()
  final double splitPosition;
  const SplitEffectOptions({
    this.durationMs = 0,
    this.axis = EffectAxis.horizontal,
    this.splitPosition = 0.5,
  });
  factory SplitEffectOptions.fromJson(Map<String, dynamic> json) =>
      _$SplitEffectOptionsFromJson(json);
  @override
  Map<String, dynamic> toJson() => _withoutDefaults(
    _$SplitEffectOptionsToJson(this),
    _$SplitEffectOptionsToJson(const SplitEffectOptions()),
  );
  @override
  SplitEffectOptions withDuration(int durationMs) =>
      copyWith(durationMs: durationMs);
}

@freezed
@JsonSerializable()
class StretchEffectOptions extends EffectOptions with _$StretchEffectOptions {
  @override
  @StrictIntConverter()
  final int durationMs;
  final EffectAxis axis;
  @FiniteDoubleConverter()
  final double maxScale;
  const StretchEffectOptions({
    this.durationMs = 0,
    this.axis = EffectAxis.horizontal,
    this.maxScale = 3,
  });
  factory StretchEffectOptions.fromJson(Map<String, dynamic> json) =>
      _$StretchEffectOptionsFromJson(json);
  @override
  Map<String, dynamic> toJson() => _withoutDefaults(
    _$StretchEffectOptionsToJson(this),
    _$StretchEffectOptionsToJson(const StretchEffectOptions()),
  );
  @override
  StretchEffectOptions withDuration(int durationMs) =>
      copyWith(durationMs: durationMs);
}

@freezed
@JsonSerializable()
class MirrorEffectOptions extends EffectOptions with _$MirrorEffectOptions {
  @override
  @StrictIntConverter()
  final int durationMs;
  final EffectAxis axis;
  final MirrorSide side;
  @FiniteDoubleConverter()
  final double strength;
  const MirrorEffectOptions({
    this.durationMs = 0,
    this.axis = EffectAxis.vertical,
    this.side = MirrorSide.leading,
    this.strength = 1,
  });
  factory MirrorEffectOptions.fromJson(Map<String, dynamic> json) =>
      _$MirrorEffectOptionsFromJson(json);
  @override
  Map<String, dynamic> toJson() => _withoutDefaults(
    _$MirrorEffectOptionsToJson(this),
    _$MirrorEffectOptionsToJson(const MirrorEffectOptions()),
  );
  @override
  MirrorEffectOptions withDuration(int durationMs) =>
      copyWith(durationMs: durationMs);
}

@freezed
@JsonSerializable()
class LightLeakEffectOptions extends EffectOptions
    with _$LightLeakEffectOptions {
  @override
  @StrictIntConverter()
  final int durationMs;
  final EffectDirection direction;
  @FiniteDoubleConverter()
  final double strength;
  @FiniteDoubleConverter()
  final double radius;
  @StrictIntConverter()
  final int warmColor;
  const LightLeakEffectOptions({
    this.durationMs = 0,
    this.direction = EffectDirection.right,
    this.strength = 1,
    this.radius = 0.8,
    this.warmColor = 0xFFFFC26B,
  });
  factory LightLeakEffectOptions.fromJson(Map<String, dynamic> json) =>
      _$LightLeakEffectOptionsFromJson(json);
  @override
  Map<String, dynamic> toJson() => _withoutDefaults(
    _$LightLeakEffectOptionsToJson(this),
    _$LightLeakEffectOptionsToJson(const LightLeakEffectOptions()),
  );
  @override
  LightLeakEffectOptions withDuration(int durationMs) =>
      copyWith(durationMs: durationMs);
}

@freezed
@JsonSerializable()
class BurnAlphaEffectOptions extends EffectOptions
    with _$BurnAlphaEffectOptions {
  @override
  @StrictIntConverter()
  final int durationMs;
  final EffectDirection direction;
  @FiniteDoubleConverter()
  final double roughness;
  @FiniteDoubleConverter()
  final double edgeWidth;
  @StrictIntConverter()
  final int emberColor;
  const BurnAlphaEffectOptions({
    this.durationMs = 0,
    this.direction = EffectDirection.right,
    this.roughness = 0.065,
    this.edgeWidth = 0.065,
    this.emberColor = 0xFFFF4B00,
  });
  factory BurnAlphaEffectOptions.fromJson(Map<String, dynamic> json) =>
      _$BurnAlphaEffectOptionsFromJson(json);
  @override
  Map<String, dynamic> toJson() => _withoutDefaults(
    _$BurnAlphaEffectOptionsToJson(this),
    _$BurnAlphaEffectOptionsToJson(const BurnAlphaEffectOptions()),
  );
  @override
  BurnAlphaEffectOptions withDuration(int durationMs) =>
      copyWith(durationMs: durationMs);
}

@freezed
@JsonSerializable()
class FoldMotionEffectOptions extends EffectOptions
    with _$FoldMotionEffectOptions {
  @override
  @StrictIntConverter()
  final int durationMs;
  final EffectAxis axis;
  @FiniteDoubleConverter()
  final double shadowIntensity;
  @FiniteDoubleConverter()
  final double perspectiveStrength;
  const FoldMotionEffectOptions({
    this.durationMs = 0,
    this.axis = EffectAxis.vertical,
    this.shadowIntensity = 0.65,
    this.perspectiveStrength = 1,
  });
  factory FoldMotionEffectOptions.fromJson(Map<String, dynamic> json) =>
      _$FoldMotionEffectOptionsFromJson(json);
  @override
  Map<String, dynamic> toJson() => _withoutDefaults(
    _$FoldMotionEffectOptionsToJson(this),
    _$FoldMotionEffectOptionsToJson(const FoldMotionEffectOptions()),
  );
  @override
  FoldMotionEffectOptions withDuration(int durationMs) =>
      copyWith(durationMs: durationMs);
}

@freezed
@JsonSerializable()
class GlowEffectOptions extends EffectOptions with _$GlowEffectOptions {
  @override
  @StrictIntConverter()
  final int durationMs;
  @FiniteDoubleConverter()
  final double strength;
  @FiniteDoubleConverter()
  final double radius;
  @FiniteDoubleConverter()
  final double gain;
  const GlowEffectOptions({
    this.durationMs = 0,
    this.strength = 0.7,
    this.radius = 0.045,
    this.gain = 2.4,
  });
  factory GlowEffectOptions.fromJson(Map<String, dynamic> json) =>
      _$GlowEffectOptionsFromJson(json);
  @override
  Map<String, dynamic> toJson() => _withoutDefaults(
    _$GlowEffectOptionsToJson(this),
    _$GlowEffectOptionsToJson(const GlowEffectOptions()),
  );
  @override
  GlowEffectOptions withDuration(int durationMs) =>
      copyWith(durationMs: durationMs);
}

@freezed
@JsonSerializable()
class KaleidoscopeEffectOptions extends EffectOptions
    with _$KaleidoscopeEffectOptions {
  @override
  @StrictIntConverter()
  final int durationMs;
  @StrictIntConverter()
  final int sectorCount;
  @FiniteDoubleConverter()
  final double rotationDegrees;
  final EffectOrigin origin;
  const KaleidoscopeEffectOptions({
    this.durationMs = 0,
    this.sectorCount = 6,
    this.rotationDegrees = 54,
    this.origin = EffectOrigin.center,
  });
  factory KaleidoscopeEffectOptions.fromJson(Map<String, dynamic> json) =>
      _$KaleidoscopeEffectOptionsFromJson(json);
  @override
  Map<String, dynamic> toJson() => _withoutDefaults(
    _$KaleidoscopeEffectOptionsToJson(this),
    _$KaleidoscopeEffectOptionsToJson(const KaleidoscopeEffectOptions()),
  );
  @override
  KaleidoscopeEffectOptions withDuration(int durationMs) =>
      copyWith(durationMs: durationMs);
}

@freezed
@JsonSerializable()
class TvPowerEffectOptions extends EffectOptions with _$TvPowerEffectOptions {
  @override
  @StrictIntConverter()
  final int durationMs;
  final EffectAxis lineAxis;
  @FiniteDoubleConverter()
  final double glowStrength;
  @StrictIntConverter()
  final int glowColor;
  const TvPowerEffectOptions({
    this.durationMs = 0,
    this.lineAxis = EffectAxis.horizontal,
    this.glowStrength = 1,
    this.glowColor = 0xFF80EDFF,
  });
  factory TvPowerEffectOptions.fromJson(Map<String, dynamic> json) =>
      _$TvPowerEffectOptionsFromJson(json);
  @override
  Map<String, dynamic> toJson() => _withoutDefaults(
    _$TvPowerEffectOptionsToJson(this),
    _$TvPowerEffectOptionsToJson(const TvPowerEffectOptions()),
  );
  @override
  TvPowerEffectOptions withDuration(int durationMs) =>
      copyWith(durationMs: durationMs);
}

@freezed
@JsonSerializable()
class SpringMotionEffectOptions extends EffectOptions
    with _$SpringMotionEffectOptions {
  @override
  @StrictIntConverter()
  final int durationMs;
  final EffectDirection direction;
  @FiniteDoubleConverter()
  final double springStrength;
  @FiniteDoubleConverter()
  final double startScale;
  const SpringMotionEffectOptions({
    this.durationMs = 0,
    this.direction = EffectDirection.left,
    this.springStrength = 1,
    this.startScale = 0.85,
  });
  factory SpringMotionEffectOptions.fromJson(Map<String, dynamic> json) =>
      _$SpringMotionEffectOptionsFromJson(json);
  @override
  Map<String, dynamic> toJson() => _withoutDefaults(
    _$SpringMotionEffectOptionsToJson(this),
    _$SpringMotionEffectOptionsToJson(const SpringMotionEffectOptions()),
  );
  @override
  SpringMotionEffectOptions withDuration(int durationMs) =>
      copyWith(durationMs: durationMs);
}

@freezed
@JsonSerializable()
class ShapeDissolveEffectOptions extends EffectOptions
    with _$ShapeDissolveEffectOptions {
  @override
  @StrictIntConverter()
  final int durationMs;
  final CellShape shape;
  @StrictIntConverter()
  final int cellsAcross;
  @FiniteDoubleConverter()
  final double staggerFraction;
  const ShapeDissolveEffectOptions({
    this.durationMs = 0,
    this.shape = CellShape.hexagon,
    this.cellsAcross = 12,
    this.staggerFraction = 0.28,
  });
  factory ShapeDissolveEffectOptions.fromJson(Map<String, dynamic> json) =>
      _$ShapeDissolveEffectOptionsFromJson(json);
  @override
  Map<String, dynamic> toJson() => _withoutDefaults(
    _$ShapeDissolveEffectOptionsToJson(this),
    _$ShapeDissolveEffectOptionsToJson(const ShapeDissolveEffectOptions()),
  );
  @override
  ShapeDissolveEffectOptions withDuration(int durationMs) =>
      copyWith(durationMs: durationMs);
}

@freezed
@JsonSerializable()
class VhsDamageEffectOptions extends EffectOptions
    with _$VhsDamageEffectOptions {
  @override
  @StrictIntConverter()
  final int durationMs;
  @FiniteDoubleConverter()
  final double colorShiftFraction;
  @FiniteDoubleConverter()
  final double trackingStrength;
  @FiniteDoubleConverter()
  final double noiseStrength;
  const VhsDamageEffectOptions({
    this.durationMs = 0,
    this.colorShiftFraction = 0.035,
    this.trackingStrength = 1,
    this.noiseStrength = 1,
  });
  factory VhsDamageEffectOptions.fromJson(Map<String, dynamic> json) =>
      _$VhsDamageEffectOptionsFromJson(json);
  @override
  Map<String, dynamic> toJson() => _withoutDefaults(
    _$VhsDamageEffectOptionsToJson(this),
    _$VhsDamageEffectOptionsToJson(const VhsDamageEffectOptions()),
  );
  @override
  VhsDamageEffectOptions withDuration(int durationMs) =>
      copyWith(durationMs: durationMs);
}

@freezed
@JsonSerializable()
class RadialBlurEffectOptions extends EffectOptions
    with _$RadialBlurEffectOptions {
  @override
  @StrictIntConverter()
  final int durationMs;
  @FiniteDoubleConverter()
  final double angleDegrees;
  final EffectOrigin origin;
  const RadialBlurEffectOptions({
    this.durationMs = 0,
    this.angleDegrees = 0.2 * 180 / math.pi,
    this.origin = EffectOrigin.center,
  });
  factory RadialBlurEffectOptions.fromJson(Map<String, dynamic> json) =>
      _$RadialBlurEffectOptionsFromJson(json);
  @override
  Map<String, dynamic> toJson() => _withoutDefaults(
    _$RadialBlurEffectOptionsToJson(this),
    _$RadialBlurEffectOptionsToJson(const RadialBlurEffectOptions()),
  );
  @override
  RadialBlurEffectOptions withDuration(int durationMs) =>
      copyWith(durationMs: durationMs);
}

@freezed
@JsonSerializable()
class PhosphorEffectOptions extends EffectOptions with _$PhosphorEffectOptions {
  @override
  @StrictIntConverter()
  final int durationMs;
  @StrictIntConverter()
  final int trailCount;
  @FiniteDoubleConverter()
  final double driftFraction;
  @FiniteDoubleConverter()
  final double trailStrength;
  @StrictIntConverter()
  final int trailColor;
  const PhosphorEffectOptions({
    this.durationMs = 0,
    this.trailCount = 3,
    this.driftFraction = 0.32,
    this.trailStrength = 1,
    this.trailColor = 0xFF50FFC8,
  });
  factory PhosphorEffectOptions.fromJson(Map<String, dynamic> json) =>
      _$PhosphorEffectOptionsFromJson(json);
  @override
  Map<String, dynamic> toJson() => _withoutDefaults(
    _$PhosphorEffectOptionsToJson(this),
    _$PhosphorEffectOptionsToJson(const PhosphorEffectOptions()),
  );
  @override
  PhosphorEffectOptions withDuration(int durationMs) =>
      copyWith(durationMs: durationMs);
}

EffectOptions defaultEffectOptions(EffectType type) => switch (type) {
  EffectType.mosaic => const MosaicEffectOptions(),
  EffectType.slide => const SlideEffectOptions(),
  EffectType.revealMask => const RevealMaskEffectOptions(),
  EffectType.fadeThroughColor => const FadeThroughColorEffectOptions(),
  EffectType.softWipe => const SoftWipeEffectOptions(),
  EffectType.flip => const FlipEffectOptions(),
  EffectType.rotate => const RotateEffectOptions(),
  EffectType.blinds => const BlindsEffectOptions(),
  EffectType.slice => const SliceEffectOptions(),
  EffectType.glass => const GlassEffectOptions(),
  EffectType.panelWipe => const PanelWipeEffectOptions(),
  EffectType.louver => const LouverEffectOptions(),
  EffectType.fade => const FadeEffectOptions(),
  EffectType.lumaFade => const LumaFadeEffectOptions(),
  EffectType.noiseDissolve => const NoiseDissolveEffectOptions(),
  EffectType.rippleReveal => const RippleRevealEffectOptions(),
  EffectType.waterRefraction => const WaterRefractionEffectOptions(),
  EffectType.liquidMorph => const LiquidMorphEffectOptions(),
  EffectType.cube => const CubeEffectOptions(),
  EffectType.accordion => const AccordionEffectOptions(),
  EffectType.depth => const DepthEffectOptions(),
  EffectType.parallax => const ParallaxEffectOptions(),
  EffectType.tablet => const TabletEffectOptions(),
  EffectType.zoomOut => const ZoomOutEffectOptions(),
  EffectType.zoomOver => const ZoomOverEffectOptions(),
  EffectType.pagePeel => const PagePeelEffectOptions(),
  EffectType.split => const SplitEffectOptions(),
  EffectType.stretch => const StretchEffectOptions(),
  EffectType.mirror => const MirrorEffectOptions(),
  EffectType.lightLeak => const LightLeakEffectOptions(),
  EffectType.burnAlpha => const BurnAlphaEffectOptions(),
  EffectType.foldMotion => const FoldMotionEffectOptions(),
  EffectType.glow => const GlowEffectOptions(),
  EffectType.kaleidoscope => const KaleidoscopeEffectOptions(),
  EffectType.tvPower => const TvPowerEffectOptions(),
  EffectType.springMotion => const SpringMotionEffectOptions(),
  EffectType.shapeDissolve => const ShapeDissolveEffectOptions(),
  EffectType.vhsDamage => const VhsDamageEffectOptions(),
  EffectType.radialBlur => const RadialBlurEffectOptions(),
  EffectType.phosphor => const PhosphorEffectOptions(),
  _ => const BasicEffectOptions(),
};

EffectOptions _readOptions(EffectType type, Object? value) {
  final data = value == null
      ? <String, dynamic>{}
      : Map<String, dynamic>.from(value as Map);
  return switch (type) {
    EffectType.mosaic => MosaicEffectOptions.fromJson(data),
    EffectType.slide => SlideEffectOptions.fromJson(data),
    EffectType.revealMask => RevealMaskEffectOptions.fromJson(data),
    EffectType.fadeThroughColor => FadeThroughColorEffectOptions.fromJson(data),
    EffectType.softWipe => SoftWipeEffectOptions.fromJson(data),
    EffectType.flip => FlipEffectOptions.fromJson(data),
    EffectType.rotate => RotateEffectOptions.fromJson(data),
    EffectType.blinds => BlindsEffectOptions.fromJson(data),
    EffectType.slice => SliceEffectOptions.fromJson(data),
    EffectType.glass => GlassEffectOptions.fromJson(data),
    EffectType.panelWipe => PanelWipeEffectOptions.fromJson(data),
    EffectType.louver => LouverEffectOptions.fromJson(data),
    EffectType.fade => FadeEffectOptions.fromJson(data),
    EffectType.lumaFade => LumaFadeEffectOptions.fromJson(data),
    EffectType.noiseDissolve => NoiseDissolveEffectOptions.fromJson(data),
    EffectType.rippleReveal => RippleRevealEffectOptions.fromJson(data),
    EffectType.waterRefraction => WaterRefractionEffectOptions.fromJson(data),
    EffectType.liquidMorph => LiquidMorphEffectOptions.fromJson(data),
    EffectType.cube => CubeEffectOptions.fromJson(data),
    EffectType.accordion => AccordionEffectOptions.fromJson(data),
    EffectType.depth => DepthEffectOptions.fromJson(data),
    EffectType.parallax => ParallaxEffectOptions.fromJson(data),
    EffectType.tablet => TabletEffectOptions.fromJson(data),
    EffectType.zoomOut => ZoomOutEffectOptions.fromJson(data),
    EffectType.zoomOver => ZoomOverEffectOptions.fromJson(data),
    EffectType.pagePeel => PagePeelEffectOptions.fromJson(data),
    EffectType.split => SplitEffectOptions.fromJson(data),
    EffectType.stretch => StretchEffectOptions.fromJson(data),
    EffectType.mirror => MirrorEffectOptions.fromJson(data),
    EffectType.lightLeak => LightLeakEffectOptions.fromJson(data),
    EffectType.burnAlpha => BurnAlphaEffectOptions.fromJson(data),
    EffectType.foldMotion => FoldMotionEffectOptions.fromJson(data),
    EffectType.glow => GlowEffectOptions.fromJson(data),
    EffectType.kaleidoscope => KaleidoscopeEffectOptions.fromJson(data),
    EffectType.tvPower => TvPowerEffectOptions.fromJson(data),
    EffectType.springMotion => SpringMotionEffectOptions.fromJson(data),
    EffectType.shapeDissolve => ShapeDissolveEffectOptions.fromJson(data),
    EffectType.vhsDamage => VhsDamageEffectOptions.fromJson(data),
    EffectType.radialBlur => RadialBlurEffectOptions.fromJson(data),
    EffectType.phosphor => PhosphorEffectOptions.fromJson(data),
    _ => BasicEffectOptions.fromJson(data),
  };
}

@freezed
@JsonSerializable(explicitToJson: true)
class EffectConfig with _$EffectConfig {
  final bool enabled;
  // The enclosing map key supplies the polymorphic type in fromJson.
  @JsonKey(includeFromJson: false, includeToJson: true)
  final EffectOptions options;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final InvalidEffectData? invalid;

  const EffectConfig({
    this.enabled = false,
    this.options = const BasicEffectOptions(),
    this.invalid,
  });

  factory EffectConfig.defaults(EffectType type) =>
      EffectConfig(options: defaultEffectOptions(type));

  factory EffectConfig.fromJson(EffectType type, Map<String, dynamic> json) {
    try {
      return _$EffectConfigFromJson(json)
          .copyWith(options: _readOptions(type, json['options']));
    } catch (error) {
      return EffectConfig(
        enabled: json['enabled'] is bool ? json['enabled'] as bool : false,
        options: defaultEffectOptions(type),
        invalid: InvalidEffectData(json, error.toString()),
      );
    }
  }
  // Retain malformed known entries for repair in config_app.
  Map<String, dynamic> toJson() {
    if (invalid case final invalid?) return invalid.raw;
    final json = _withoutDefaults(_$EffectConfigToJson(this), {
      'enabled': false,
    });
    if ((json['options'] as Map).isEmpty) json.remove('options');
    return json;
  }
}

@freezed
@JsonSerializable()
class InvalidEffectData with _$InvalidEffectData {
  final Map<String, dynamic> raw;
  final String error;
  InvalidEffectData(Map<String, dynamic> raw, this.error)
    : raw = _freeze(raw) as Map<String, dynamic>;

  static Object? _freeze(Object? value) => switch (value) {
    Map() => Map<String, dynamic>.unmodifiable(
      value.map((key, item) => MapEntry(key as String, _freeze(item))),
    ),
    List() => List<Object?>.unmodifiable(value.map(_freeze)),
    num() when !value.isFinite => value.toString(),
    _ => value,
  };
  factory InvalidEffectData.fromJson(Map<String, dynamic> json) =>
      _$InvalidEffectDataFromJson(json);
  Map<String, dynamic> toJson() => _$InvalidEffectDataToJson(this);
}

Map<EffectType, EffectConfig> _parseEffects(Object? value) {
  final result = <EffectType, EffectConfig>{};
  if (value == null) return result;
  if (value is! Map<String, dynamic>) {
    EffectsConfig._log.warning('effects.items must be an object');
    return result;
  }
  final types = EffectType.values.asNameMap();
  for (final entry in value.entries) {
    final type = types[entry.key];
    if (type == null || type == EffectType.unknown) {
      EffectsConfig._log.warning('Unknown effect: ${entry.key}');
      continue;
    }
    if (entry.value is! Map<String, dynamic>) {
      EffectsConfig._log.warning(
        'effects.items.${entry.key} must be an object',
      );
      continue;
    }
    final config = EffectConfig.fromJson(
      type,
      entry.value as Map<String, dynamic>,
    );
    if (config.invalid case final invalid?) {
      EffectsConfig._log.warning(
        'Cannot read effects.items.${entry.key}: ${invalid.error}',
      );
    }
    result[type] = config;
  }
  return result;
}

/// A family has one selected mode. Explicit canonical entries win, then an
/// enabled former entry, then enum order, independent of JSON property order.
Map<EffectType, EffectConfig> _normalizeEffectEntries(
  Map<EffectType, EffectConfig> items,
) {
  final entries = items.entries.toList();
  int rank(MapEntry<EffectType, EffectConfig> entry) =>
      canonicalEffectType(entry.key) == entry.key
      ? 0
      : entry.value.enabled
      ? 1
      : 2;
  entries.sort((a, b) {
    final priority = rank(a).compareTo(rank(b));
    return priority != 0 ? priority : a.key.index.compareTo(b.key.index);
  });
  final result = <EffectType, EffectConfig>{};
  for (final entry in entries) {
    final type = canonicalEffectType(entry.key);
    if (result.containsKey(type)) {
      EffectsConfig._log.warning(
        'Multiple entries for effect family ${type.name}; retained the canonical entry or first enabled preset, omitted ${entry.key.name}.',
      );
      continue;
    }
    result[type] = canonicalEffectConfig(entry.key, entry.value);
  }
  return {
    for (final key in items.keys)
      canonicalEffectType(key): result[canonicalEffectType(key)]!,
  };
}

Map<String, dynamic> _effectsToJson(Map<EffectType, EffectConfig> value) {
  final result = <String, dynamic>{};
  for (final entry in value.entries) {
    final json = entry.value.toJson();
    if (json.isNotEmpty) result[entry.key.name] = json;
  }
  return result;
}

@freezed
@JsonSerializable(explicitToJson: true)
class EffectsConfig with _$EffectsConfig {
  static final _log = Logger('EffectsConfig');
  @StrictIntConverter()
  final int schemaVersion;
  @StrictIntConverter()
  final int defaultDurationMs;
  @JsonKey(fromJson: _parseEffects, toJson: _effectsToJson)
  final Map<EffectType, EffectConfig> items;
  EffectsConfig({
    this.schemaVersion = 1,
    this.defaultDurationMs = 1000,
    Map<EffectType, EffectConfig>? items,
  }) : items = Map.unmodifiable(_normalizeEffectEntries(items ?? {}));
  factory EffectsConfig.fromJson(Map<String, dynamic> json) =>
      _$EffectsConfigFromJson(json);
  Map<String, dynamic> toJson() {
    final json = _withoutDefaults(_$EffectsConfigToJson(this), {
      'schemaVersion': 1,
      'defaultDurationMs': 1000,
    });
    if ((json['items'] as Map).isEmpty) json.remove('items');
    return json;
  }

  int durationFor(EffectOptions options) =>
      options.durationMs == 0 ? defaultDurationMs : options.durationMs;
  EffectConfig get(EffectType type) =>
      items[type] ?? EffectConfig.defaults(type);
  EffectsConfig put(EffectType type, EffectConfig value) =>
      copyWith(items: {...items, type: value});

  Iterable<MapEntry<EffectType, EffectConfig>> get playable =>
      schemaVersion == 1
      ? items.entries.where(
          (entry) =>
              entry.key != EffectType.unknown &&
              entry.value.invalid == null &&
              entry.value.enabled,
        )
      : const [];
}

EffectsConfig parseEffectsConfig(Object? value) {
  if (value == null) return EffectsConfig();
  try {
    return EffectsConfig.fromJson(Map<String, dynamic>.from(value as Map));
  } catch (error, stack) {
    EffectsConfig._log.warning(
      'Cannot read effects configuration',
      error,
      stack,
    );
    return EffectsConfig(schemaVersion: -1);
  }
}

/// Stable built-in presets; only their resulting options are persisted.
enum EffectPresetId {
  burnAlpha,
  foldMotion,
  glow,
  kaleidoscope,
  tvPower,
  springMotion,
  shapeDissolve,
  vhsDamage,
  radialBlur,
  phosphor,
  filmDissolve,
  frame,
  louver,
  mirror,
  clockWipe,
  split,
  panelWipe,
  stretch,
  starWipe,
  lightLeak,
  filmRoll,
  crossZoom,
  whip,
  glass,
  softWipe,
  slice,
  lumaFade,
  pagePeel,
  noiseDissolve,
  rippleReveal,
  waterRefraction,
  cube,
  accordion,
  backgroundToForeground,
  foregroundToBackground,
  depth,
  parallax,
  stack,
  tablet,
  zoomOut,
  fade,
  mosaic,
  liquidMorph,
  blinds,
  blurFade,
  zoomOver,
  slide,
  revealMask,
  fadeThroughColor,
  flip,
  rotate,
  softWipeLightSweep,
  softWipeNeon,
  fadeThroughWhite,
  flipVertical,
  rotateBottom,
  mosaicBinary,
  mosaicTopLeft,
  mosaicTopRight,
  mosaicBottomLeft,
  mosaicBottomRight,
  slidePushRight,
  slidePushUp,
  slidePushDown,
  slideCoverLeft,
  slideCoverRight,
  slideCoverUp,
  slideCoverDown,
  slideRevealLeft,
  slideRevealRight,
  slideRevealUp,
  slideRevealDown,
  wipeRight,
  wipeUp,
  wipeDown,
  curtainHorizontal,
  curtainVertical,
  diagonalTopRight,
  diagonalBottomLeft,
  diagonalBottomRight,
  diagonalTopLeft,
  irisCenter,
}

@freezed
class EffectPreset with _$EffectPreset {
  final EffectPresetId id;
  final EffectType sourceType;
  final EffectType type;
  final EffectOptions options;
  const EffectPreset({
    required this.id,
    required this.sourceType,
    required this.type,
    required this.options,
  });
}

EffectType canonicalEffectType(EffectType type) => switch (type) {
  EffectType.filmDissolve => EffectType.fade,
  EffectType.blurFade => EffectType.fade,
  EffectType.fadeThroughColor => EffectType.fade,
  EffectType.stack => EffectType.slide,
  EffectType.whip => EffectType.slide,
  EffectType.filmRoll => EffectType.slide,
  EffectType.backgroundToForeground => EffectType.depth,
  EffectType.foregroundToBackground => EffectType.depth,
  EffectType.crossZoom => EffectType.zoomOver,
  EffectType.softWipe => EffectType.revealMask,
  EffectType.frame => EffectType.revealMask,
  EffectType.starWipe => EffectType.revealMask,
  EffectType.clockWipe => EffectType.revealMask,
  EffectType.panelWipe => EffectType.slice,
  _ => type,
};

const catalogEffectTypes = <EffectType>[
  EffectType.burnAlpha,
  EffectType.foldMotion,
  EffectType.glow,
  EffectType.kaleidoscope,
  EffectType.tvPower,
  EffectType.springMotion,
  EffectType.shapeDissolve,
  EffectType.vhsDamage,
  EffectType.radialBlur,
  EffectType.phosphor,
  EffectType.louver,
  EffectType.mirror,
  EffectType.split,
  EffectType.stretch,
  EffectType.lightLeak,
  EffectType.glass,
  EffectType.slice,
  EffectType.lumaFade,
  EffectType.pagePeel,
  EffectType.noiseDissolve,
  EffectType.rippleReveal,
  EffectType.waterRefraction,
  EffectType.cube,
  EffectType.accordion,
  EffectType.depth,
  EffectType.parallax,
  EffectType.tablet,
  EffectType.zoomOut,
  EffectType.fade,
  EffectType.mosaic,
  EffectType.liquidMorph,
  EffectType.blinds,
  EffectType.zoomOver,
  EffectType.slide,
  EffectType.revealMask,
  EffectType.flip,
  EffectType.rotate,
];

final effectPresets = List<EffectPreset>.unmodifiable([
  EffectPreset(
    id: EffectPresetId.burnAlpha,
    sourceType: EffectType.burnAlpha,
    type: EffectType.burnAlpha,
    options: defaultEffectOptions(EffectType.burnAlpha),
  ),
  EffectPreset(
    id: EffectPresetId.foldMotion,
    sourceType: EffectType.foldMotion,
    type: EffectType.foldMotion,
    options: defaultEffectOptions(EffectType.foldMotion),
  ),
  EffectPreset(
    id: EffectPresetId.glow,
    sourceType: EffectType.glow,
    type: EffectType.glow,
    options: defaultEffectOptions(EffectType.glow),
  ),
  EffectPreset(
    id: EffectPresetId.kaleidoscope,
    sourceType: EffectType.kaleidoscope,
    type: EffectType.kaleidoscope,
    options: defaultEffectOptions(EffectType.kaleidoscope),
  ),
  EffectPreset(
    id: EffectPresetId.tvPower,
    sourceType: EffectType.tvPower,
    type: EffectType.tvPower,
    options: defaultEffectOptions(EffectType.tvPower),
  ),
  EffectPreset(
    id: EffectPresetId.springMotion,
    sourceType: EffectType.springMotion,
    type: EffectType.springMotion,
    options: defaultEffectOptions(EffectType.springMotion),
  ),
  EffectPreset(
    id: EffectPresetId.shapeDissolve,
    sourceType: EffectType.shapeDissolve,
    type: EffectType.shapeDissolve,
    options: defaultEffectOptions(EffectType.shapeDissolve),
  ),
  EffectPreset(
    id: EffectPresetId.vhsDamage,
    sourceType: EffectType.vhsDamage,
    type: EffectType.vhsDamage,
    options: defaultEffectOptions(EffectType.vhsDamage),
  ),
  EffectPreset(
    id: EffectPresetId.radialBlur,
    sourceType: EffectType.radialBlur,
    type: EffectType.radialBlur,
    options: defaultEffectOptions(EffectType.radialBlur),
  ),
  EffectPreset(
    id: EffectPresetId.phosphor,
    sourceType: EffectType.phosphor,
    type: EffectType.phosphor,
    options: defaultEffectOptions(EffectType.phosphor),
  ),
  EffectPreset(
    id: EffectPresetId.filmDissolve,
    sourceType: EffectType.filmDissolve,
    type: EffectType.fade,
    options: const FadeEffectOptions(style: FadeStyle.linearLight),
  ),
  EffectPreset(
    id: EffectPresetId.frame,
    sourceType: EffectType.frame,
    type: EffectType.revealMask,
    options: const RevealMaskEffectOptions(
      shape: RevealShape.rectangle,
      origin: EffectOrigin.center,
      frameEnabled: true,
    ),
  ),
  EffectPreset(
    id: EffectPresetId.louver,
    sourceType: EffectType.louver,
    type: EffectType.louver,
    options: defaultEffectOptions(EffectType.louver),
  ),
  EffectPreset(
    id: EffectPresetId.mirror,
    sourceType: EffectType.mirror,
    type: EffectType.mirror,
    options: defaultEffectOptions(EffectType.mirror),
  ),
  EffectPreset(
    id: EffectPresetId.clockWipe,
    sourceType: EffectType.clockWipe,
    type: EffectType.revealMask,
    options: const RevealMaskEffectOptions(
      shape: RevealShape.clock,
      origin: EffectOrigin.center,
    ),
  ),
  EffectPreset(
    id: EffectPresetId.split,
    sourceType: EffectType.split,
    type: EffectType.split,
    options: defaultEffectOptions(EffectType.split),
  ),
  EffectPreset(
    id: EffectPresetId.panelWipe,
    sourceType: EffectType.panelWipe,
    type: EffectType.slice,
    options: const SliceEffectOptions(
      mode: SliceMode.reveal,
      staggerFraction: .28,
    ),
  ),
  EffectPreset(
    id: EffectPresetId.stretch,
    sourceType: EffectType.stretch,
    type: EffectType.stretch,
    options: defaultEffectOptions(EffectType.stretch),
  ),
  EffectPreset(
    id: EffectPresetId.starWipe,
    sourceType: EffectType.starWipe,
    type: EffectType.revealMask,
    options: const RevealMaskEffectOptions(
      shape: RevealShape.star,
      origin: EffectOrigin.center,
    ),
  ),
  EffectPreset(
    id: EffectPresetId.lightLeak,
    sourceType: EffectType.lightLeak,
    type: EffectType.lightLeak,
    options: defaultEffectOptions(EffectType.lightLeak),
  ),
  EffectPreset(
    id: EffectPresetId.filmRoll,
    sourceType: EffectType.filmRoll,
    type: EffectType.slide,
    options: const SlideEffectOptions(
      direction: EffectDirection.up,
      motionCurve: BlendCurve.easeInOut,
      blurFraction: .018,
      decoration: SlideDecoration.filmPerforation,
    ),
  ),
  EffectPreset(
    id: EffectPresetId.crossZoom,
    sourceType: EffectType.crossZoom,
    type: EffectType.zoomOver,
    options: const ZoomOverEffectOptions(
      mode: ZoomMode.cross,
      startScale: 1.6,
      outgoingScale: 1.6,
      blurFraction: .012,
    ),
  ),
  EffectPreset(
    id: EffectPresetId.whip,
    sourceType: EffectType.whip,
    type: EffectType.slide,
    options: const SlideEffectOptions(
      motionCurve: BlendCurve.easeInOut,
      blurFraction: .045,
    ),
  ),
  EffectPreset(
    id: EffectPresetId.glass,
    sourceType: EffectType.glass,
    type: EffectType.glass,
    options: defaultEffectOptions(EffectType.glass),
  ),
  EffectPreset(
    id: EffectPresetId.softWipe,
    sourceType: EffectType.softWipe,
    type: EffectType.revealMask,
    options: const RevealMaskEffectOptions(
      direction: EffectDirection.right,
      edgeStyle: WipeEdgeStyle.soft,
    ),
  ),
  EffectPreset(
    id: EffectPresetId.slice,
    sourceType: EffectType.slice,
    type: EffectType.slice,
    options: defaultEffectOptions(EffectType.slice),
  ),
  EffectPreset(
    id: EffectPresetId.lumaFade,
    sourceType: EffectType.lumaFade,
    type: EffectType.lumaFade,
    options: defaultEffectOptions(EffectType.lumaFade),
  ),
  EffectPreset(
    id: EffectPresetId.pagePeel,
    sourceType: EffectType.pagePeel,
    type: EffectType.pagePeel,
    options: defaultEffectOptions(EffectType.pagePeel),
  ),
  EffectPreset(
    id: EffectPresetId.noiseDissolve,
    sourceType: EffectType.noiseDissolve,
    type: EffectType.noiseDissolve,
    options: defaultEffectOptions(EffectType.noiseDissolve),
  ),
  EffectPreset(
    id: EffectPresetId.rippleReveal,
    sourceType: EffectType.rippleReveal,
    type: EffectType.rippleReveal,
    options: defaultEffectOptions(EffectType.rippleReveal),
  ),
  EffectPreset(
    id: EffectPresetId.waterRefraction,
    sourceType: EffectType.waterRefraction,
    type: EffectType.waterRefraction,
    options: defaultEffectOptions(EffectType.waterRefraction),
  ),
  EffectPreset(
    id: EffectPresetId.cube,
    sourceType: EffectType.cube,
    type: EffectType.cube,
    options: defaultEffectOptions(EffectType.cube),
  ),
  EffectPreset(
    id: EffectPresetId.accordion,
    sourceType: EffectType.accordion,
    type: EffectType.accordion,
    options: defaultEffectOptions(EffectType.accordion),
  ),
  EffectPreset(
    id: EffectPresetId.backgroundToForeground,
    sourceType: EffectType.backgroundToForeground,
    type: EffectType.depth,
    options: const DepthEffectOptions(mode: DepthMode.approach),
  ),
  EffectPreset(
    id: EffectPresetId.foregroundToBackground,
    sourceType: EffectType.foregroundToBackground,
    type: EffectType.depth,
    options: const DepthEffectOptions(mode: DepthMode.recedeSlide, scale: .4),
  ),
  EffectPreset(
    id: EffectPresetId.depth,
    sourceType: EffectType.depth,
    type: EffectType.depth,
    options: defaultEffectOptions(EffectType.depth),
  ),
  EffectPreset(
    id: EffectPresetId.parallax,
    sourceType: EffectType.parallax,
    type: EffectType.parallax,
    options: defaultEffectOptions(EffectType.parallax),
  ),
  EffectPreset(
    id: EffectPresetId.stack,
    sourceType: EffectType.stack,
    type: EffectType.slide,
    options: const SlideEffectOptions(mode: SlideMode.cover),
  ),
  EffectPreset(
    id: EffectPresetId.tablet,
    sourceType: EffectType.tablet,
    type: EffectType.tablet,
    options: defaultEffectOptions(EffectType.tablet),
  ),
  EffectPreset(
    id: EffectPresetId.zoomOut,
    sourceType: EffectType.zoomOut,
    type: EffectType.zoomOut,
    options: defaultEffectOptions(EffectType.zoomOut),
  ),
  EffectPreset(
    id: EffectPresetId.fade,
    sourceType: EffectType.fade,
    type: EffectType.fade,
    options: defaultEffectOptions(EffectType.fade),
  ),
  EffectPreset(
    id: EffectPresetId.mosaic,
    sourceType: EffectType.mosaic,
    type: EffectType.mosaic,
    options: defaultEffectOptions(EffectType.mosaic),
  ),
  EffectPreset(
    id: EffectPresetId.liquidMorph,
    sourceType: EffectType.liquidMorph,
    type: EffectType.liquidMorph,
    options: defaultEffectOptions(EffectType.liquidMorph),
  ),
  EffectPreset(
    id: EffectPresetId.blinds,
    sourceType: EffectType.blinds,
    type: EffectType.blinds,
    options: defaultEffectOptions(EffectType.blinds),
  ),
  EffectPreset(
    id: EffectPresetId.blurFade,
    sourceType: EffectType.blurFade,
    type: EffectType.fade,
    options: const FadeEffectOptions(style: FadeStyle.blur),
  ),
  EffectPreset(
    id: EffectPresetId.zoomOver,
    sourceType: EffectType.zoomOver,
    type: EffectType.zoomOver,
    options: defaultEffectOptions(EffectType.zoomOver),
  ),
  EffectPreset(
    id: EffectPresetId.slide,
    sourceType: EffectType.slide,
    type: EffectType.slide,
    options: defaultEffectOptions(EffectType.slide),
  ),
  EffectPreset(
    id: EffectPresetId.revealMask,
    sourceType: EffectType.revealMask,
    type: EffectType.revealMask,
    options: defaultEffectOptions(EffectType.revealMask),
  ),
  EffectPreset(
    id: EffectPresetId.fadeThroughColor,
    sourceType: EffectType.fadeThroughColor,
    type: EffectType.fade,
    options: const FadeEffectOptions(style: FadeStyle.throughColor),
  ),
  EffectPreset(
    id: EffectPresetId.flip,
    sourceType: EffectType.flip,
    type: EffectType.flip,
    options: defaultEffectOptions(EffectType.flip),
  ),
  EffectPreset(
    id: EffectPresetId.rotate,
    sourceType: EffectType.rotate,
    type: EffectType.rotate,
    options: defaultEffectOptions(EffectType.rotate),
  ),
  EffectPreset(
    id: EffectPresetId.softWipeLightSweep,
    sourceType: EffectType.softWipe,
    type: EffectType.revealMask,
    options: const RevealMaskEffectOptions(
      direction: EffectDirection.right,
      edgeStyle: WipeEdgeStyle.lightSweep,
    ),
  ),
  EffectPreset(
    id: EffectPresetId.softWipeNeon,
    sourceType: EffectType.softWipe,
    type: EffectType.revealMask,
    options: const RevealMaskEffectOptions(
      direction: EffectDirection.right,
      edgeStyle: WipeEdgeStyle.neon,
    ),
  ),
  EffectPreset(
    id: EffectPresetId.fadeThroughWhite,
    sourceType: EffectType.fadeThroughColor,
    type: EffectType.fade,
    options: const FadeEffectOptions(
      style: FadeStyle.throughColor,
      color: 0xFFFFFFFF,
    ),
  ),
  EffectPreset(
    id: EffectPresetId.flipVertical,
    sourceType: EffectType.flip,
    type: EffectType.flip,
    options: const FlipEffectOptions(axis: EffectAxis.vertical),
  ),
  EffectPreset(
    id: EffectPresetId.rotateBottom,
    sourceType: EffectType.rotate,
    type: EffectType.rotate,
    options: const RotateEffectOptions(edge: RotationEdge.bottom),
  ),
  EffectPreset(
    id: EffectPresetId.mosaicBinary,
    sourceType: EffectType.mosaic,
    type: EffectType.mosaic,
    options: const MosaicEffectOptions(fadeFraction: 0),
  ),
  EffectPreset(
    id: EffectPresetId.mosaicTopLeft,
    sourceType: EffectType.mosaic,
    type: EffectType.mosaic,
    options: const MosaicEffectOptions(direction: MosaicDirection.topLeft),
  ),
  EffectPreset(
    id: EffectPresetId.mosaicTopRight,
    sourceType: EffectType.mosaic,
    type: EffectType.mosaic,
    options: const MosaicEffectOptions(direction: MosaicDirection.topRight),
  ),
  EffectPreset(
    id: EffectPresetId.mosaicBottomLeft,
    sourceType: EffectType.mosaic,
    type: EffectType.mosaic,
    options: const MosaicEffectOptions(direction: MosaicDirection.bottomLeft),
  ),
  EffectPreset(
    id: EffectPresetId.mosaicBottomRight,
    sourceType: EffectType.mosaic,
    type: EffectType.mosaic,
    options: const MosaicEffectOptions(direction: MosaicDirection.bottomRight),
  ),
  EffectPreset(
    id: EffectPresetId.slidePushRight,
    sourceType: EffectType.slide,
    type: EffectType.slide,
    options: const SlideEffectOptions(
      mode: SlideMode.push,
      direction: EffectDirection.right,
    ),
  ),
  EffectPreset(
    id: EffectPresetId.slidePushUp,
    sourceType: EffectType.slide,
    type: EffectType.slide,
    options: const SlideEffectOptions(
      mode: SlideMode.push,
      direction: EffectDirection.up,
    ),
  ),
  EffectPreset(
    id: EffectPresetId.slidePushDown,
    sourceType: EffectType.slide,
    type: EffectType.slide,
    options: const SlideEffectOptions(
      mode: SlideMode.push,
      direction: EffectDirection.down,
    ),
  ),
  EffectPreset(
    id: EffectPresetId.slideCoverLeft,
    sourceType: EffectType.slide,
    type: EffectType.slide,
    options: const SlideEffectOptions(
      mode: SlideMode.cover,
      direction: EffectDirection.left,
    ),
  ),
  EffectPreset(
    id: EffectPresetId.slideCoverRight,
    sourceType: EffectType.slide,
    type: EffectType.slide,
    options: const SlideEffectOptions(
      mode: SlideMode.cover,
      direction: EffectDirection.right,
    ),
  ),
  EffectPreset(
    id: EffectPresetId.slideCoverUp,
    sourceType: EffectType.slide,
    type: EffectType.slide,
    options: const SlideEffectOptions(
      mode: SlideMode.cover,
      direction: EffectDirection.up,
    ),
  ),
  EffectPreset(
    id: EffectPresetId.slideCoverDown,
    sourceType: EffectType.slide,
    type: EffectType.slide,
    options: const SlideEffectOptions(
      mode: SlideMode.cover,
      direction: EffectDirection.down,
    ),
  ),
  EffectPreset(
    id: EffectPresetId.slideRevealLeft,
    sourceType: EffectType.slide,
    type: EffectType.slide,
    options: const SlideEffectOptions(
      mode: SlideMode.reveal,
      direction: EffectDirection.left,
    ),
  ),
  EffectPreset(
    id: EffectPresetId.slideRevealRight,
    sourceType: EffectType.slide,
    type: EffectType.slide,
    options: const SlideEffectOptions(
      mode: SlideMode.reveal,
      direction: EffectDirection.right,
    ),
  ),
  EffectPreset(
    id: EffectPresetId.slideRevealUp,
    sourceType: EffectType.slide,
    type: EffectType.slide,
    options: const SlideEffectOptions(
      mode: SlideMode.reveal,
      direction: EffectDirection.up,
    ),
  ),
  EffectPreset(
    id: EffectPresetId.slideRevealDown,
    sourceType: EffectType.slide,
    type: EffectType.slide,
    options: const SlideEffectOptions(
      mode: SlideMode.reveal,
      direction: EffectDirection.down,
    ),
  ),
  EffectPreset(
    id: EffectPresetId.wipeRight,
    sourceType: EffectType.revealMask,
    type: EffectType.revealMask,
    options: const RevealMaskEffectOptions(direction: EffectDirection.right),
  ),
  EffectPreset(
    id: EffectPresetId.wipeUp,
    sourceType: EffectType.revealMask,
    type: EffectType.revealMask,
    options: const RevealMaskEffectOptions(direction: EffectDirection.up),
  ),
  EffectPreset(
    id: EffectPresetId.wipeDown,
    sourceType: EffectType.revealMask,
    type: EffectType.revealMask,
    options: const RevealMaskEffectOptions(direction: EffectDirection.down),
  ),
  EffectPreset(
    id: EffectPresetId.curtainHorizontal,
    sourceType: EffectType.revealMask,
    type: EffectType.revealMask,
    options: const RevealMaskEffectOptions(
      shape: RevealShape.curtain,
      axis: EffectAxis.horizontal,
    ),
  ),
  EffectPreset(
    id: EffectPresetId.curtainVertical,
    sourceType: EffectType.revealMask,
    type: EffectType.revealMask,
    options: const RevealMaskEffectOptions(
      shape: RevealShape.curtain,
      axis: EffectAxis.vertical,
    ),
  ),
  EffectPreset(
    id: EffectPresetId.diagonalTopRight,
    sourceType: EffectType.revealMask,
    type: EffectType.revealMask,
    options: const RevealMaskEffectOptions(
      shape: RevealShape.diagonal,
      origin: EffectOrigin.topRight,
    ),
  ),
  EffectPreset(
    id: EffectPresetId.diagonalBottomLeft,
    sourceType: EffectType.revealMask,
    type: EffectType.revealMask,
    options: const RevealMaskEffectOptions(
      shape: RevealShape.diagonal,
      origin: EffectOrigin.bottomLeft,
    ),
  ),
  EffectPreset(
    id: EffectPresetId.diagonalBottomRight,
    sourceType: EffectType.revealMask,
    type: EffectType.revealMask,
    options: const RevealMaskEffectOptions(
      shape: RevealShape.diagonal,
      origin: EffectOrigin.bottomRight,
    ),
  ),
  EffectPreset(
    id: EffectPresetId.diagonalTopLeft,
    sourceType: EffectType.revealMask,
    type: EffectType.revealMask,
    options: const RevealMaskEffectOptions(shape: RevealShape.diagonal),
  ),
  EffectPreset(
    id: EffectPresetId.irisCenter,
    sourceType: EffectType.revealMask,
    type: EffectType.revealMask,
    options: const RevealMaskEffectOptions(
      shape: RevealShape.iris,
      origin: EffectOrigin.center,
    ),
  ),
]);

Iterable<EffectPreset> effectPresetsFor(EffectType type) =>
    effectPresets.where((preset) => preset.type == canonicalEffectType(type));

/// Converts an obsolete catalog entry without changing its duration or enabled state.
EffectConfig canonicalEffectConfig(EffectType type, EffectConfig config) {
  if (canonicalEffectType(type) == type) return config;
  final base = effectPresets
      .firstWhere((preset) => preset.sourceType == type)
      .options;
  if (config.invalid case final invalid?) {
    final raw = Map<String, dynamic>.of(invalid.raw);
    if (raw['options'] case final Map oldOptions) {
      final data = Map<String, dynamic>.from(oldOptions);
      if (type == EffectType.softWipe && data.containsKey('style'))
        data['edgeStyle'] = data.remove('style');
      if (type == EffectType.panelWipe && data.containsKey('panelCount'))
        data['stripCount'] = data.remove('panelCount');
      raw['options'] = {...base.toJson(), ...data};
    }
    return EffectConfig.fromJson(canonicalEffectType(type), raw);
  }
  final old = config.options;
  final EffectOptions options = switch (old) {
    FadeThroughColorEffectOptions(:final color) =>
      (base as FadeEffectOptions).copyWith(color: color),
    SoftWipeEffectOptions(:final style) =>
      (base as RevealMaskEffectOptions).copyWith(
        edgeStyle: switch (style) {
          SoftWipeStyle.soft => WipeEdgeStyle.soft,
          SoftWipeStyle.lightSweep => WipeEdgeStyle.lightSweep,
          SoftWipeStyle.neon => WipeEdgeStyle.neon,
        },
      ),
    PanelWipeEffectOptions(:final panelCount) =>
      (base as SliceEffectOptions).copyWith(stripCount: panelCount),
    _ => base,
  };
  return config.copyWith(options: options.withDuration(old.durationMs));
}
