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
  const MosaicEffectOptions({
    this.durationMs = 0,
    this.gridSize = 100,
    this.fadeFraction = 0.3,
    this.direction = MosaicDirection.random,
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
  const SlideEffectOptions({
    this.durationMs = 0,
    this.mode = SlideMode.push,
    this.direction = EffectDirection.left,
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
  const FlipEffectOptions({
    this.durationMs = 0,
    this.axis = EffectAxis.horizontal,
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
  const RotateEffectOptions({
    this.durationMs = 0,
    this.edge = RotationEdge.top,
    this.angleDegrees = 45,
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
  const BlindsEffectOptions({this.durationMs = 0, this.stripCount = 10});
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
  const SliceEffectOptions({this.durationMs = 0, this.stripCount = 8});
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
  const GlassEffectOptions({this.durationMs = 0, this.paneCount = 8});
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
  const LouverEffectOptions({this.durationMs = 0, this.slatCount = 8});
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

/// Polymorphic JSON dispatch uses the enclosing map key as the only type tag.
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
  }) : items = Map.unmodifiable(items ?? {});
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
