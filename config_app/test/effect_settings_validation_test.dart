import 'package:config_app/features/config/domain/effect_settings_validation.dart';
import 'package:dslideshow_common/effects.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('all default families and boundary values can be saved', () {
    expect(EffectsConfig().validate(), isEmpty);
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
              const BasicEffectOptions(durationMs: -1),
              'durationMs',
            ),
            (
              EffectType.fade,
              const BasicEffectOptions(durationMs: 3600001),
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
            (
              EffectType.fadeThroughColor,
              const FadeThroughColorEffectOptions(color: -1),
              'color',
            ),
            (
              EffectType.fadeThroughColor,
              const FadeThroughColorEffectOptions(color: 0x100000000),
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
              EffectType.panelWipe,
              const PanelWipeEffectOptions(panelCount: 33),
              'panelCount',
            ),
            (
              EffectType.louver,
              const LouverEffectOptions(slatCount: 0),
              'slatCount',
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
