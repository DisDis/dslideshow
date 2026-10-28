import 'package:dslideshow_common/effects.dart';

extension EffectOptionsValidation on EffectOptions {
  List<String> validate() => [
    if (durationMs < 0 || durationMs > 3600000) 'durationMs',
    ...switch (this) {
      MosaicEffectOptions(
        :final gridSize,
        :final fadeFraction,
        :final randomness,
      ) =>
        [
          if (gridSize < 100 || gridSize > 200) 'gridSize',
          if (!fadeFraction.isFinite || fadeFraction < 0 || fadeFraction > 1)
            'fadeFraction',
          if (!randomness.isFinite || randomness < 0 || randomness > 1)
            'randomness',
        ],
      SlideEffectOptions(
        :final blurFraction,
        :final edgeWidth,
        :final tiltDegrees,
        :final shadowStrength,
      ) =>
        [
          if (!blurFraction.isFinite || blurFraction < 0 || blurFraction > 0.08)
            'blurFraction',
          if (!edgeWidth.isFinite || edgeWidth < 0.02 || edgeWidth > 0.1)
            'edgeWidth',
          if (!tiltDegrees.isFinite || tiltDegrees < -12 || tiltDegrees > 12)
            'tiltDegrees',
          if (!shadowStrength.isFinite ||
              shadowStrength < 0 ||
              shadowStrength > 0.6)
            'shadowStrength',
        ],
      RevealMaskEffectOptions(
        :final featherFraction,
        :final lightStrength,
        :final borderWidth,
        :final borderColor,
        :final shadowStrength,
        :final pointCount,
        :final innerRadiusRatio,
        :final rotationDegrees,
        :final startAngleDegrees,
        :final shape,
        :final origin,
      ) =>
        [
          if (featherFraction != null &&
              (!featherFraction.isFinite ||
                  featherFraction < 0.005 ||
                  featherFraction > 0.3))
            'featherFraction',
          if (!lightStrength.isFinite ||
              lightStrength < 0 ||
              lightStrength > 1.5)
            'lightStrength',
          if (!borderWidth.isFinite || borderWidth < 0 || borderWidth > 0.02)
            'borderWidth',
          if (borderColor < 0 || borderColor > 4294967295) 'borderColor',
          if (!shadowStrength.isFinite ||
              shadowStrength < 0 ||
              shadowStrength > 1)
            'shadowStrength',
          if (pointCount < 3 || pointCount > 12) 'pointCount',
          if (!innerRadiusRatio.isFinite ||
              innerRadiusRatio < 0.2 ||
              innerRadiusRatio > 0.8)
            'innerRadiusRatio',
          if (!rotationDegrees.isFinite ||
              rotationDegrees < 0 ||
              rotationDegrees > 359.999)
            'rotationDegrees',
          if (!startAngleDegrees.isFinite ||
              startAngleDegrees < 0 ||
              startAngleDegrees > 359.999)
            'startAngleDegrees',
          if (shape == RevealShape.diagonal && origin == EffectOrigin.center)
            'origin',
        ],
      FadeThroughColorEffectOptions(:final color) => [
        if (color < 0 || color > 4294967295) 'color',
      ],
      FlipEffectOptions(:final perspectiveStrength) => [
        if (!perspectiveStrength.isFinite ||
            perspectiveStrength < 0 ||
            perspectiveStrength > 1.25)
          'perspectiveStrength',
      ],
      RotateEffectOptions(:final angleDegrees) => [
        if (!angleDegrees.isFinite || angleDegrees < 0 || angleDegrees > 90)
          'angleDegrees',
      ],
      BlindsEffectOptions(:final stripCount, :final staggerFraction) => [
        if (stripCount < 1 || stripCount > 32) 'stripCount',
        if (!staggerFraction.isFinite ||
            staggerFraction < 0 ||
            staggerFraction > 0.8)
          'staggerFraction',
      ],
      SliceEffectOptions(:final stripCount, :final staggerFraction) => [
        if (stripCount < 1 || stripCount > 32) 'stripCount',
        if (!staggerFraction.isFinite ||
            staggerFraction < 0 ||
            staggerFraction > 0.8)
          'staggerFraction',
      ],
      GlassEffectOptions(
        :final paneCount,
        :final refractionStrength,
        :final glintStrength,
      ) =>
        [
          if (paneCount < 1 || paneCount > 32) 'paneCount',
          if (!refractionStrength.isFinite ||
              refractionStrength < 0 ||
              refractionStrength > 2)
            'refractionStrength',
          if (!glintStrength.isFinite || glintStrength < 0 || glintStrength > 2)
            'glintStrength',
        ],
      PanelWipeEffectOptions(:final panelCount) => [
        if (panelCount < 1 || panelCount > 32) 'panelCount',
      ],
      LouverEffectOptions(
        :final slatCount,
        :final staggerFraction,
        :final shadowIntensity,
      ) =>
        [
          if (slatCount < 1 || slatCount > 32) 'slatCount',
          if (!staggerFraction.isFinite ||
              staggerFraction < 0 ||
              staggerFraction > 0.8)
            'staggerFraction',
          if (!shadowIntensity.isFinite ||
              shadowIntensity < 0 ||
              shadowIntensity > 1)
            'shadowIntensity',
        ],
      FadeEffectOptions(
        :final maxSigma,
        :final color,
        :final holdFraction,
        :final fadeOutShare,
      ) =>
        [
          if (!maxSigma.isFinite || maxSigma < 0 || maxSigma > 30) 'maxSigma',
          if (color < 0 || color > 4294967295) 'color',
          if (!holdFraction.isFinite || holdFraction < 0 || holdFraction > 0.4)
            'holdFraction',
          if (!fadeOutShare.isFinite ||
              fadeOutShare < 0.2 ||
              fadeOutShare > 0.8)
            'fadeOutShare',
        ],
      LumaFadeEffectOptions(:final softness) => [
        if (!softness.isFinite || softness < 0.02 || softness > 0.5) 'softness',
      ],
      NoiseDissolveEffectOptions(:final noiseScale, :final softness) => [
        if (!noiseScale.isFinite || noiseScale < 8 || noiseScale > 80)
          'noiseScale',
        if (!softness.isFinite || softness < 0.01 || softness > 0.2) 'softness',
      ],
      RippleRevealEffectOptions(
        :final waveAmplitude,
        :final waveFrequency,
        :final softness,
      ) =>
        [
          if (!waveAmplitude.isFinite ||
              waveAmplitude < 0 ||
              waveAmplitude > 0.08)
            'waveAmplitude',
          if (!waveFrequency.isFinite ||
              waveFrequency < 20 ||
              waveFrequency > 140)
            'waveFrequency',
          if (!softness.isFinite || softness < 0.005 || softness > 0.08)
            'softness',
        ],
      WaterRefractionEffectOptions(
        :final refractionStrength,
        :final waveFrequency,
        :final bandWidth,
      ) =>
        [
          if (!refractionStrength.isFinite ||
              refractionStrength < 0 ||
              refractionStrength > 0.025)
            'refractionStrength',
          if (!waveFrequency.isFinite ||
              waveFrequency < 40 ||
              waveFrequency > 140)
            'waveFrequency',
          if (!bandWidth.isFinite || bandWidth < 0.5 || bandWidth > 1.5)
            'bandWidth',
        ],
      LiquidMorphEffectOptions(
        :final waveCount,
        :final waveIntensity,
        :final outgoingScale,
      ) =>
        [
          if (waveCount < 3 || waveCount > 32) 'waveCount',
          if (!waveIntensity.isFinite ||
              waveIntensity < 0 ||
              waveIntensity > 60)
            'waveIntensity',
          if (!outgoingScale.isFinite ||
              outgoingScale < 1 ||
              outgoingScale > 1.3)
            'outgoingScale',
        ],
      CubeEffectOptions(:final shadowIntensity, :final perspectiveStrength) => [
        if (!shadowIntensity.isFinite ||
            shadowIntensity < 0 ||
            shadowIntensity > 1)
          'shadowIntensity',
        if (!perspectiveStrength.isFinite ||
            perspectiveStrength < 0 ||
            perspectiveStrength > 1.25)
          'perspectiveStrength',
      ],
      AccordionEffectOptions(:final shadowIntensity) => [
        if (!shadowIntensity.isFinite ||
            shadowIntensity < 0 ||
            shadowIntensity > 1)
          'shadowIntensity',
      ],
      DepthEffectOptions(:final scale, :final shadowIntensity) => [
        if (!scale.isFinite || scale < 0.2 || scale > 1) 'scale',
        if (!shadowIntensity.isFinite ||
            shadowIntensity < 0 ||
            shadowIntensity > 1)
          'shadowIntensity',
      ],
      ParallaxEffectOptions(:final clipAmount) => [
        if (!clipAmount.isFinite || clipAmount < 0 || clipAmount > 400)
          'clipAmount',
      ],
      TabletEffectOptions(:final tiltDegrees, :final perspectiveStrength) => [
        if (!tiltDegrees.isFinite || tiltDegrees < 0 || tiltDegrees > 70)
          'tiltDegrees',
        if (!perspectiveStrength.isFinite ||
            perspectiveStrength < 0 ||
            perspectiveStrength > 1.25)
          'perspectiveStrength',
      ],
      ZoomOutEffectOptions(:final zoomOutScale) => [
        if (!zoomOutScale.isFinite || zoomOutScale < 0.5 || zoomOutScale > 1)
          'zoomOutScale',
      ],
      ZoomOverEffectOptions(
        :final startScale,
        :final outgoingScale,
        :final blurFraction,
      ) =>
        [
          if (!startScale.isFinite || startScale < 1 || startScale > 2)
            'startScale',
          if (!outgoingScale.isFinite ||
              outgoingScale < 0.7 ||
              outgoingScale > 2)
            'outgoingScale',
          if (!blurFraction.isFinite || blurFraction < 0 || blurFraction > 0.03)
            'blurFraction',
        ],
      PagePeelEffectOptions(
        :final foldWidth,
        :final paperColor,
        :final shadowStrength,
        :final corner,
      ) =>
        [
          if (!foldWidth.isFinite || foldWidth < 0.04 || foldWidth > 0.25)
            'foldWidth',
          if (paperColor < 0 || paperColor > 4294967295) 'paperColor',
          if (!shadowStrength.isFinite ||
              shadowStrength < 0 ||
              shadowStrength > 1)
            'shadowStrength',
          if (corner == EffectOrigin.center) 'corner',
        ],
      SplitEffectOptions(:final splitPosition) => [
        if (!splitPosition.isFinite ||
            splitPosition < 0.2 ||
            splitPosition > 0.8)
          'splitPosition',
      ],
      StretchEffectOptions(:final maxScale) => [
        if (!maxScale.isFinite || maxScale < 1 || maxScale > 4) 'maxScale',
      ],
      MirrorEffectOptions(:final strength) => [
        if (!strength.isFinite || strength < 0 || strength > 1) 'strength',
      ],
      LightLeakEffectOptions(
        :final strength,
        :final radius,
        :final warmColor,
      ) =>
        [
          if (!strength.isFinite || strength < 0 || strength > 1.5) 'strength',
          if (!radius.isFinite || radius < 0.3 || radius > 1.2) 'radius',
          if (warmColor < 0 || warmColor > 4294967295) 'warmColor',
        ],
      BurnAlphaEffectOptions(
        :final roughness,
        :final edgeWidth,
        :final emberColor,
      ) =>
        [
          if (!roughness.isFinite || roughness < 0 || roughness > 0.12)
            'roughness',
          if (!edgeWidth.isFinite || edgeWidth < 0.01 || edgeWidth > 0.12)
            'edgeWidth',
          if (emberColor < 0 || emberColor > 4294967295) 'emberColor',
        ],
      FoldMotionEffectOptions(
        :final shadowIntensity,
        :final perspectiveStrength,
      ) =>
        [
          if (!shadowIntensity.isFinite ||
              shadowIntensity < 0 ||
              shadowIntensity > 1)
            'shadowIntensity',
          if (!perspectiveStrength.isFinite ||
              perspectiveStrength < 0 ||
              perspectiveStrength > 1.25)
            'perspectiveStrength',
        ],
      GlowEffectOptions(:final strength, :final radius, :final gain) => [
        if (!strength.isFinite || strength < 0 || strength > 1) 'strength',
        if (!radius.isFinite || radius < 0 || radius > 0.08) 'radius',
        if (!gain.isFinite || gain < 1 || gain > 3) 'gain',
      ],
      KaleidoscopeEffectOptions(:final sectorCount, :final rotationDegrees) => [
        if (sectorCount < 2 || sectorCount > 12 || sectorCount.isOdd)
          'sectorCount',
        if (!rotationDegrees.isFinite ||
            rotationDegrees < 0 ||
            rotationDegrees > 180)
          'rotationDegrees',
      ],
      TvPowerEffectOptions(:final glowStrength, :final glowColor) => [
        if (!glowStrength.isFinite || glowStrength < 0 || glowStrength > 1.5)
          'glowStrength',
        if (glowColor < 0 || glowColor > 4294967295) 'glowColor',
      ],
      SpringMotionEffectOptions(:final springStrength, :final startScale) => [
        if (!springStrength.isFinite ||
            springStrength < 0 ||
            springStrength > 1.5)
          'springStrength',
        if (!startScale.isFinite || startScale < 0.6 || startScale > 1)
          'startScale',
      ],
      ShapeDissolveEffectOptions(:final cellsAcross, :final staggerFraction) =>
        [
          if (cellsAcross < 6 || cellsAcross > 32) 'cellsAcross',
          if (!staggerFraction.isFinite ||
              staggerFraction < 0 ||
              staggerFraction > 0.6)
            'staggerFraction',
        ],
      VhsDamageEffectOptions(
        :final colorShiftFraction,
        :final trackingStrength,
        :final noiseStrength,
      ) =>
        [
          if (!colorShiftFraction.isFinite ||
              colorShiftFraction < 0 ||
              colorShiftFraction > 0.06)
            'colorShiftFraction',
          if (!trackingStrength.isFinite ||
              trackingStrength < 0 ||
              trackingStrength > 2)
            'trackingStrength',
          if (!noiseStrength.isFinite || noiseStrength < 0 || noiseStrength > 2)
            'noiseStrength',
        ],
      RadialBlurEffectOptions(:final angleDegrees) => [
        if (!angleDegrees.isFinite || angleDegrees < 0 || angleDegrees > 20)
          'angleDegrees',
      ],
      PhosphorEffectOptions(
        :final trailCount,
        :final driftFraction,
        :final trailStrength,
        :final trailColor,
      ) =>
        [
          if (trailCount < 1 || trailCount > 6) 'trailCount',
          if (!driftFraction.isFinite ||
              driftFraction < 0 ||
              driftFraction > 0.5)
            'driftFraction',
          if (!trailStrength.isFinite ||
              trailStrength < 0 ||
              trailStrength > 1.5)
            'trailStrength',
          if (trailColor < 0 || trailColor > 4294967295) 'trailColor',
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
