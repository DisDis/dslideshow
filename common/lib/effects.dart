import 'package:freezed_annotation/freezed_annotation.dart';

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

enum RevealShape { wipe, curtain, diagonal, iris }

enum SoftWipeStyle { soft, lightSweep, neon }

enum RotationEdge { top, bottom }

enum EffectGroup { fades, movement, masks, geometric, cinematic, creative }

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

/// Common contract; data, equality and copyWith belong to Freezed models.
abstract class EffectOptions {
  const EffectOptions();
  int get durationMs;
  Map<String, dynamic> toJson();
  EffectOptions withDuration(int durationMs);
  List<String> validate() => [
    if (durationMs < 0 || durationMs > 3600000) 'durationMs',
  ];
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
  Map<String, dynamic> toJson() => _$BasicEffectOptionsToJson(this);
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
  const MosaicEffectOptions({
    this.durationMs = 0,
    this.gridSize = 100,
    this.fadeFraction = 0.3,
    this.direction = MosaicDirection.random,
  });
  factory MosaicEffectOptions.fromJson(Map<String, dynamic> json) =>
      _$MosaicEffectOptionsFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$MosaicEffectOptionsToJson(this);
  @override
  MosaicEffectOptions withDuration(int durationMs) =>
      copyWith(durationMs: durationMs);
  @override
  List<String> validate() => [
    ...super.validate(),
    if (gridSize < 100 || gridSize > 200) 'gridSize',
    if (!fadeFraction.isFinite || fadeFraction < 0 || fadeFraction > 1)
      'fadeFraction',
  ];
}

@freezed
@JsonSerializable()
class SlideEffectOptions extends EffectOptions with _$SlideEffectOptions {
  @override
  @StrictIntConverter()
  final int durationMs;
  final SlideMode mode;
  final EffectDirection direction;
  const SlideEffectOptions({
    this.durationMs = 0,
    this.mode = SlideMode.push,
    this.direction = EffectDirection.left,
  });
  factory SlideEffectOptions.fromJson(Map<String, dynamic> json) =>
      _$SlideEffectOptionsFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$SlideEffectOptionsToJson(this);
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
  const RevealMaskEffectOptions({
    this.durationMs = 0,
    this.shape = RevealShape.wipe,
    this.direction = EffectDirection.left,
    this.axis = EffectAxis.horizontal,
    this.origin = EffectOrigin.topLeft,
  });
  factory RevealMaskEffectOptions.fromJson(Map<String, dynamic> json) =>
      _$RevealMaskEffectOptionsFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$RevealMaskEffectOptionsToJson(this);
  @override
  RevealMaskEffectOptions withDuration(int durationMs) =>
      copyWith(durationMs: durationMs);
  @override
  List<String> validate() => [
    ...super.validate(),
    if (shape == RevealShape.diagonal && origin == EffectOrigin.center)
      'origin',
  ];
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
  Map<String, dynamic> toJson() => _$FadeThroughColorEffectOptionsToJson(this);
  @override
  FadeThroughColorEffectOptions withDuration(int durationMs) =>
      copyWith(durationMs: durationMs);
  @override
  List<String> validate() => [
    ...super.validate(),
    if (color < 0 || color > 0xFFFFFFFF) 'color',
  ];
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
  Map<String, dynamic> toJson() => _$SoftWipeEffectOptionsToJson(this);
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
  const FlipEffectOptions({
    this.durationMs = 0,
    this.axis = EffectAxis.horizontal,
  });
  factory FlipEffectOptions.fromJson(Map<String, dynamic> json) =>
      _$FlipEffectOptionsFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$FlipEffectOptionsToJson(this);
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
  const RotateEffectOptions({
    this.durationMs = 0,
    this.edge = RotationEdge.top,
    this.angleDegrees = 45,
  });
  factory RotateEffectOptions.fromJson(Map<String, dynamic> json) =>
      _$RotateEffectOptionsFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$RotateEffectOptionsToJson(this);
  @override
  RotateEffectOptions withDuration(int durationMs) =>
      copyWith(durationMs: durationMs);
  @override
  List<String> validate() => [
    ...super.validate(),
    if (!angleDegrees.isFinite || angleDegrees < 0 || angleDegrees > 90)
      'angleDegrees',
  ];
}

@freezed
@JsonSerializable()
class BlindsEffectOptions extends EffectOptions with _$BlindsEffectOptions {
  @override
  @StrictIntConverter()
  final int durationMs;
  @StrictIntConverter()
  final int stripCount;
  const BlindsEffectOptions({this.durationMs = 0, this.stripCount = 10});
  factory BlindsEffectOptions.fromJson(Map<String, dynamic> json) =>
      _$BlindsEffectOptionsFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$BlindsEffectOptionsToJson(this);
  @override
  BlindsEffectOptions withDuration(int durationMs) =>
      copyWith(durationMs: durationMs);
  @override
  List<String> validate() => [
    ...super.validate(),
    if (stripCount < 1 || stripCount > 32) 'stripCount',
  ];
}

@freezed
@JsonSerializable()
class SliceEffectOptions extends EffectOptions with _$SliceEffectOptions {
  @override
  @StrictIntConverter()
  final int durationMs;
  @StrictIntConverter()
  final int stripCount;
  const SliceEffectOptions({this.durationMs = 0, this.stripCount = 8});
  factory SliceEffectOptions.fromJson(Map<String, dynamic> json) =>
      _$SliceEffectOptionsFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$SliceEffectOptionsToJson(this);
  @override
  SliceEffectOptions withDuration(int durationMs) =>
      copyWith(durationMs: durationMs);
  @override
  List<String> validate() => [
    ...super.validate(),
    if (stripCount < 1 || stripCount > 32) 'stripCount',
  ];
}

@freezed
@JsonSerializable()
class GlassEffectOptions extends EffectOptions with _$GlassEffectOptions {
  @override
  @StrictIntConverter()
  final int durationMs;
  @StrictIntConverter()
  final int paneCount;
  const GlassEffectOptions({this.durationMs = 0, this.paneCount = 8});
  factory GlassEffectOptions.fromJson(Map<String, dynamic> json) =>
      _$GlassEffectOptionsFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$GlassEffectOptionsToJson(this);
  @override
  GlassEffectOptions withDuration(int durationMs) =>
      copyWith(durationMs: durationMs);
  @override
  List<String> validate() => [
    ...super.validate(),
    if (paneCount < 1 || paneCount > 32) 'paneCount',
  ];
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
  Map<String, dynamic> toJson() => _$PanelWipeEffectOptionsToJson(this);
  @override
  PanelWipeEffectOptions withDuration(int durationMs) =>
      copyWith(durationMs: durationMs);
  @override
  List<String> validate() => [
    ...super.validate(),
    if (panelCount < 1 || panelCount > 32) 'panelCount',
  ];
}

@freezed
@JsonSerializable()
class LouverEffectOptions extends EffectOptions with _$LouverEffectOptions {
  @override
  @StrictIntConverter()
  final int durationMs;
  @StrictIntConverter()
  final int slatCount;
  const LouverEffectOptions({this.durationMs = 0, this.slatCount = 8});
  factory LouverEffectOptions.fromJson(Map<String, dynamic> json) =>
      _$LouverEffectOptionsFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$LouverEffectOptionsToJson(this);
  @override
  LouverEffectOptions withDuration(int durationMs) =>
      copyWith(durationMs: durationMs);
  @override
  List<String> validate() => [
    ...super.validate(),
    if (slatCount < 1 || slatCount > 32) 'slatCount',
  ];
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
  _ => const BasicEffectOptions(),
};

/// Boundary-only dispatch; ordinary models use json_serializable.
EffectType _readEffectType(Object? value) =>
    $enumDecodeNullable(
      _$EffectTypeEnumMap,
      value,
      unknownValue: EffectType.unknown,
    ) ??
    EffectType.unknown;

EffectOptions _readOptions(Object? value) {
  final json = Map<String, dynamic>.from(value as Map);
  final type = _readEffectType(json['type']);
  final options = json['options'];
  final data = options == null
      ? <String, dynamic>{}
      : Map<String, dynamic>.from(options as Map);
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
    _ => BasicEffectOptions.fromJson(data),
  };
}

Object? _optionsSource(Map json, String key) => json;

@freezed
@JsonSerializable(explicitToJson: true)
class EffectConfig with _$EffectConfig {
  @JsonKey(unknownEnumValue: EffectType.unknown)
  final EffectType type;
  final bool enabled;
  @JsonKey(readValue: _optionsSource, fromJson: _readOptions)
  final EffectOptions options;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final InvalidEffectData? invalid;

  EffectConfig({
    required this.type,
    this.enabled = false,
    EffectOptions? options,
    this.invalid,
  }) : options = options ?? defaultEffectOptions(type);

  factory EffectConfig.invalid(Map<String, dynamic> raw, String error) =>
      EffectConfig(
        type: _readEffectType(raw['type']),
        enabled: raw['enabled'] is bool ? raw['enabled'] as bool : false,
        invalid: InvalidEffectData(raw, error),
      );

  factory EffectConfig.fromJson(Map<String, dynamic> json) {
    try {
      final result = _$EffectConfigFromJson(json);
      return result.type == EffectType.unknown
          ? EffectConfig.invalid(json, 'type: unknown')
          : result;
    } catch (error) {
      return EffectConfig.invalid(json, error.toString());
    }
  }
  // Opaque malformed variants are retained at the polymorphic JSON boundary.
  Map<String, dynamic> toJson() => invalid?.raw ?? _$EffectConfigToJson(this);

  List<String> validate() => invalid != null
      ? [invalid!.error]
      : [
          if (type == EffectType.unknown) 'type',
          if (options.runtimeType != defaultEffectOptions(type).runtimeType)
            'options',
          ...options.validate().map((key) => 'options.$key'),
        ];
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

List<EffectConfig> _readItems(Object? value) {
  if (value == null) return [];
  if (value is! List)
    return [
      EffectConfig.invalid({'items': value}, 'items must be a list'),
    ];
  return value
      .map(
        (item) => item is Map
            ? EffectConfig.fromJson(Map<String, dynamic>.from(item))
            : EffectConfig.invalid({'item': item}, 'item must be an object'),
      )
      .toList();
}

int _readInteger(Object? value) => value == null
    ? 1000
    : value is int
    ? value
    : -1;

@freezed
@JsonSerializable(explicitToJson: true)
class EffectsConfig with _$EffectsConfig {
  @StrictIntConverter()
  final int schemaVersion;
  @JsonKey(fromJson: _readInteger)
  final int defaultDurationMs;
  @JsonKey(fromJson: _readItems)
  final List<EffectConfig> items;
  EffectsConfig({
    this.schemaVersion = 1,
    this.defaultDurationMs = 1000,
    List<EffectConfig>? items,
  }) : items = List.unmodifiable(items ?? []);
  factory EffectsConfig.fromJson(Map<String, dynamic> json) =>
      _$EffectsConfigFromJson(json);
  Map<String, dynamic> toJson() => _$EffectsConfigToJson(this);
  // Explicit template: adding an enum value does not enable it automatically.
  factory EffectsConfig.defaults() => EffectsConfig(
    items: [
      EffectConfig(type: EffectType.burnAlpha, enabled: true),
      EffectConfig(type: EffectType.foldMotion, enabled: true),
      EffectConfig(type: EffectType.glow, enabled: true),
      EffectConfig(type: EffectType.kaleidoscope, enabled: true),
      EffectConfig(type: EffectType.tvPower, enabled: true),
      EffectConfig(type: EffectType.springMotion, enabled: true),
      EffectConfig(type: EffectType.shapeDissolve, enabled: true),
      EffectConfig(type: EffectType.vhsDamage, enabled: true),
      EffectConfig(type: EffectType.radialBlur, enabled: true),
      EffectConfig(type: EffectType.phosphor, enabled: true),
      EffectConfig(type: EffectType.filmDissolve, enabled: true),
      EffectConfig(type: EffectType.frame, enabled: true),
      EffectConfig(type: EffectType.louver, enabled: true),
      EffectConfig(type: EffectType.mirror, enabled: true),
      EffectConfig(type: EffectType.clockWipe, enabled: true),
      EffectConfig(type: EffectType.split, enabled: true),
      EffectConfig(type: EffectType.panelWipe, enabled: true),
      EffectConfig(type: EffectType.stretch, enabled: true),
      EffectConfig(type: EffectType.starWipe, enabled: true),
      EffectConfig(type: EffectType.lightLeak, enabled: true),
      EffectConfig(type: EffectType.filmRoll, enabled: true),
      EffectConfig(type: EffectType.crossZoom, enabled: true),
      EffectConfig(type: EffectType.whip, enabled: true),
      EffectConfig(type: EffectType.glass, enabled: true),
      EffectConfig(type: EffectType.softWipe, enabled: true),
      EffectConfig(type: EffectType.slice, enabled: true),
      EffectConfig(type: EffectType.lumaFade, enabled: true),
      EffectConfig(type: EffectType.pagePeel, enabled: true),
      EffectConfig(type: EffectType.noiseDissolve, enabled: true),
      EffectConfig(type: EffectType.rippleReveal, enabled: true),
      EffectConfig(type: EffectType.waterRefraction, enabled: true),
      EffectConfig(type: EffectType.cube, enabled: true),
      EffectConfig(type: EffectType.accordion, enabled: true),
      EffectConfig(type: EffectType.backgroundToForeground, enabled: true),
      EffectConfig(type: EffectType.foregroundToBackground, enabled: true),
      EffectConfig(type: EffectType.depth, enabled: true),
      EffectConfig(type: EffectType.parallax, enabled: true),
      EffectConfig(type: EffectType.stack, enabled: true),
      EffectConfig(type: EffectType.tablet, enabled: true),
      EffectConfig(type: EffectType.zoomOut, enabled: true),
      EffectConfig(type: EffectType.fade, enabled: true),
      EffectConfig(type: EffectType.mosaic, enabled: true),
      EffectConfig(type: EffectType.liquidMorph, enabled: true),
      EffectConfig(type: EffectType.blinds, enabled: true),
      EffectConfig(type: EffectType.blurFade, enabled: true),
      EffectConfig(type: EffectType.zoomOver, enabled: true),
      EffectConfig(type: EffectType.slide, enabled: true),
      EffectConfig(type: EffectType.revealMask, enabled: true),
      EffectConfig(type: EffectType.fadeThroughColor, enabled: true),
      EffectConfig(type: EffectType.flip, enabled: true),
      EffectConfig(type: EffectType.rotate, enabled: true),
    ],
  );
  int durationFor(EffectOptions options) =>
      options.durationMs == 0 ? safeDefaultDurationMs : options.durationMs;
  int get safeDefaultDurationMs =>
      defaultDurationMs >= 1 && defaultDurationMs <= 3600000
      ? defaultDurationMs
      : 1000;
  EffectConfig get(EffectType type) =>
      items.where((e) => e.type == type).firstOrNull ??
      EffectConfig(type: type);
  EffectsConfig put(EffectConfig value) {
    final next = [...items];
    final index = next.indexWhere((e) => e.type == value.type);
    if (index < 0) {
      next.add(value);
    } else {
      next[index] = value;
    }
    return copyWith(items: next);
  }

  List<String> validate() {
    final errors = <String>[
      if (schemaVersion != 1) 'effects.schemaVersion',
      if (defaultDurationMs < 1 || defaultDurationMs > 3600000)
        'effects.defaultDurationMs',
    ];
    final seen = <EffectType>{};
    for (var i = 0; i < items.length; i++) {
      final item = items[i];
      errors.addAll(item.validate().map((field) => 'effects.items[$i].$field'));
      if (!seen.add(item.type)) errors.add('effects.items[$i].type: duplicate');
    }
    return errors;
  }

  Iterable<EffectConfig> get playable sync* {
    if (schemaVersion != 1) return;
    final seen = <EffectType>{};
    for (final item in items) {
      if (item.validate().isEmpty && seen.add(item.type) && item.enabled) {
        yield item;
      }
    }
  }

  void validateForSave() {
    final errors = validate();
    if (errors.isNotEmpty) throw FormatException(errors.join(', '));
  }
}

EffectsConfig parseEffectsConfig(Object? value) {
  if (value == null) return EffectsConfig.defaults();
  try {
    return EffectsConfig.fromJson(Map<String, dynamic>.from(value as Map));
  } catch (error) {
    return EffectsConfig(
      schemaVersion: -1,
      items: [
        EffectConfig.invalid({'effects': value}, error.toString()),
      ],
    );
  }
}
