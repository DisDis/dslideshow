import 'package:config_app/features/config/domain/effect_settings_validation.dart';
import 'package:dslideshow_common/effects.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('all default families and boundary values can be saved', () {
    expect(EffectsConfig().validate(), isEmpty);
    for (final type in catalogEffectTypes) {
      expect(
        EffectConfig.defaults(type).validate(type),
        isEmpty,
        reason: type.name,
      );
    }
    for (final preset in effectPresets) {
      expect(
        EffectConfig(options: preset.options).validate(preset.type),
        isEmpty,
        reason: preset.id.name,
      );
    }
    for (final grid in [100, 150, 200]) {
      for (final fade in [0.0, .3, 1.0]) {
        expect(
          MosaicEffectOptions(gridSize: grid, fadeFraction: fade).validate(),
          isEmpty,
        );
      }
    }
    for (final duration in [0, 1, 3600000]) {
      expect(BasicEffectOptions(durationMs: duration).validate(), isEmpty);
    }
    for (final color in [0, 0xFFFFFFFF]) {
      expect(FadeThroughColorEffectOptions(color: color).validate(), isEmpty);
    }
    for (final angle in [0.0, 90.0]) {
      expect(RotateEffectOptions(angleDegrees: angle).validate(), isEmpty);
    }
    for (final count in [1, 32]) {
      expect(BlindsEffectOptions(stripCount: count).validate(), isEmpty);
      expect(SliceEffectOptions(stripCount: count).validate(), isEmpty);
      expect(GlassEffectOptions(paneCount: count).validate(), isEmpty);
      expect(PanelWipeEffectOptions(panelCount: count).validate(), isEmpty);
      expect(LouverEffectOptions(slatCount: count).validate(), isEmpty);
    }
  });

  test(
    'config_app rejects invalid ranges and combinations with enum-keyed paths',
    () {
      for (final (type, options, field)
          in <(EffectType, EffectOptions, String)>[
            (
              EffectType.fade,
              const FadeEffectOptions(durationMs: -1),
              'durationMs',
            ),
            (
              EffectType.fade,
              const FadeEffectOptions(durationMs: 3600001),
              'durationMs',
            ),
            (
              EffectType.mosaic,
              const MosaicEffectOptions(gridSize: 99),
              'gridSize',
            ),
            (
              EffectType.mosaic,
              const MosaicEffectOptions(gridSize: 201),
              'gridSize',
            ),
            (
              EffectType.mosaic,
              const MosaicEffectOptions(fadeFraction: -0.1),
              'fadeFraction',
            ),
            (
              EffectType.mosaic,
              const MosaicEffectOptions(fadeFraction: 1.1),
              'fadeFraction',
            ),
            (
              EffectType.mosaic,
              const MosaicEffectOptions(fadeFraction: double.nan),
              'fadeFraction',
            ),
            (
              EffectType.revealMask,
              const RevealMaskEffectOptions(
                shape: RevealShape.diagonal,
                origin: EffectOrigin.center,
              ),
              'origin',
            ),
            (EffectType.fade, const FadeEffectOptions(color: -1), 'color'),
            (
              EffectType.fade,
              const FadeEffectOptions(color: 0x100000000),
              'color',
            ),
            (
              EffectType.rotate,
              const RotateEffectOptions(angleDegrees: -1),
              'angleDegrees',
            ),
            (
              EffectType.rotate,
              const RotateEffectOptions(angleDegrees: 91),
              'angleDegrees',
            ),
            (
              EffectType.rotate,
              const RotateEffectOptions(angleDegrees: double.infinity),
              'angleDegrees',
            ),
            (
              EffectType.blinds,
              const BlindsEffectOptions(stripCount: 0),
              'stripCount',
            ),
            (
              EffectType.slice,
              const SliceEffectOptions(stripCount: 33),
              'stripCount',
            ),
            (
              EffectType.glass,
              const GlassEffectOptions(paneCount: 0),
              'paneCount',
            ),
            (
              EffectType.slice,
              const SliceEffectOptions(mode: SliceMode.reveal, stripCount: 33),
              'stripCount',
            ),
            (
              EffectType.louver,
              const LouverEffectOptions(slatCount: 0),
              'slatCount',
            ),
            (
              EffectType.fade,
              const FadeEffectOptions(
                style: FadeStyle.throughColor,
                fadeOutShare: 1,
              ),
              'fadeOutShare',
            ),
            (
              EffectType.fade,
              const FadeEffectOptions(style: FadeStyle.blur, maxSigma: -1),
              'maxSigma',
            ),
            (
              EffectType.waterRefraction,
              const WaterRefractionEffectOptions(bandWidth: 0),
              'bandWidth',
            ),
            (
              EffectType.rippleReveal,
              const RippleRevealEffectOptions(softness: 0),
              'softness',
            ),
            (
              EffectType.kaleidoscope,
              const KaleidoscopeEffectOptions(sectorCount: 1),
              'sectorCount',
            ),
            (
              EffectType.shapeDissolve,
              const ShapeDissolveEffectOptions(cellsAcross: 0),
              'cellsAcross',
            ),
            (
              EffectType.phosphor,
              const PhosphorEffectOptions(trailCount: 7),
              'trailCount',
            ),
          ]) {
        final config = EffectsConfig(
          items: {type: EffectConfig(options: options)},
        );
        expect(config.validate(), [
          'effects.items.${type.name}.options.$field',
        ]);
        expect(config.validateForSave, throwsFormatException);
      }
    },
  );

  test('config_app blocks malformed options, mismatched families and unsupported schemas', () {
    for (final config in [
      EffectsConfig(schemaVersion: 2),
      EffectsConfig(defaultDurationMs: 0),
      EffectsConfig(defaultDurationMs: 3600001),
      EffectsConfig(items: {EffectType.mosaic: const EffectConfig()}),
      EffectsConfig(items: {EffectType.unknown: const EffectConfig()}),
      EffectsConfig.fromJson({
        'items': {
          'mosaic': {
            'options': {'direction': 'future'},
          },
        },
      }),
    ]) {
      expect(config.validate(), isNotEmpty);
      expect(config.validateForSave, throwsFormatException);
    }
    expect(EffectsConfig(defaultDurationMs: -1).safeDefaultDurationMs, 1000);
  });
}
