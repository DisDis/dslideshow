import 'package:dslideshow_common/effects.dart';

/// Form and Save validation belongs to config_app, not the storage models.
extension EffectOptionsValidation on EffectOptions {
  List<String> validate() => [
    if (durationMs < 0 || durationMs > 3600000) 'durationMs',
    ...switch (this) {
      MosaicEffectOptions(:final gridSize, :final fadeFraction) => [
        if (gridSize < 100 || gridSize > 200) 'gridSize',
        if (!fadeFraction.isFinite || fadeFraction < 0 || fadeFraction > 1)
          'fadeFraction',
      ],
      RevealMaskEffectOptions(:final shape, :final origin) => [
        if (shape == RevealShape.diagonal && origin == EffectOrigin.center)
          'origin',
      ],
      FadeThroughColorEffectOptions(:final color) => [
        if (color < 0 || color > 0xFFFFFFFF) 'color',
      ],
      RotateEffectOptions(:final angleDegrees) => [
        if (!angleDegrees.isFinite || angleDegrees < 0 || angleDegrees > 90)
          'angleDegrees',
      ],
      BlindsEffectOptions(:final stripCount) ||
      SliceEffectOptions(
        :final stripCount,
      ) => [if (stripCount < 1 || stripCount > 32) 'stripCount'],
      GlassEffectOptions(:final paneCount) => [
        if (paneCount < 1 || paneCount > 32) 'paneCount',
      ],
      PanelWipeEffectOptions(:final panelCount) => [
        if (panelCount < 1 || panelCount > 32) 'panelCount',
      ],
      LouverEffectOptions(:final slatCount) => [
        if (slatCount < 1 || slatCount > 32) 'slatCount',
      ],
      _ => <String>[],
    },
  ];
}

extension EffectConfigValidation on EffectConfig {
  List<String> validate(EffectType type) => invalid != null
      ? [invalid!.error]
      : [
          if (type == EffectType.unknown) 'type',
          if (options.runtimeType != defaultEffectOptions(type).runtimeType)
            'options',
          ...options.validate().map((field) => 'options.$field'),
        ];
}

extension EffectsConfigValidation on EffectsConfig {
  List<String> validate() => [
    if (schemaVersion != 1) 'effects.schemaVersion',
    if (defaultDurationMs < 1 || defaultDurationMs > 3600000)
      'effects.defaultDurationMs',
    for (final entry in items.entries)
      ...entry.value
          .validate(entry.key)
          .map((field) => 'effects.items.${entry.key.name}.$field'),
  ];

  void validateForSave() {
    final errors = validate();
    if (errors.isNotEmpty) throw FormatException(errors.join(', '));
  }

  // Invalid persisted global values must not break the editor's preview.
  int get safeDefaultDurationMs =>
      defaultDurationMs >= 1 && defaultDurationMs <= 3600000
      ? defaultDurationMs
      : 1000;
}
