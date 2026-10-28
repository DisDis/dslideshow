import 'dart:convert';

import 'package:dslideshow_common/effects.dart';
import 'package:test/test.dart';

void main() {
  test(
    '37 canonical families cover every old type through immutable presets',
    () {
      expect(catalogEffectTypes.length, 37);
      expect(catalogEffectTypes.toSet().length, 37);
      expect(
        catalogEffectTypes.every((type) => canonicalEffectType(type) == type),
        isTrue,
      );
      expect(
        effectPresets.map((p) => p.sourceType).toSet(),
        EffectType.values.where((type) => type != EffectType.unknown).toSet(),
      );
      expect(
        effectPresets.map((p) => p.id).toSet().length,
        effectPresets.length,
      );
      for (final preset in effectPresets) {
        expect(preset.options.durationMs, 0);
        expect(preset.type, canonicalEffectType(preset.sourceType));
        final config = EffectConfig(
          enabled: true,
          options: preset.options.withDuration(1700),
        );
        final restored = EffectConfig.fromJson(
          preset.type,
          jsonDecode(jsonEncode(config.toJson())) as Map<String, dynamic>,
        );
        expect(restored, config, reason: preset.id.name);
        expect(preset.options.durationMs, 0);
      }
      expect(() => effectPresets.clear(), throwsUnsupportedError);
    },
  );

  test('legacy enabled and disabled custom settings move to one family', () {
    final config = EffectsConfig.fromJson({
      'items': {
        'fadeThroughColor': {
          'options': {'color': 0x40112233, 'durationMs': 1700},
        },
        'panelWipe': {
          'enabled': true,
          'options': {'panelCount': 13, 'durationMs': 2200},
        },
        'softWipe': {
          'options': {'style': 'neon'},
        },
      },
    });
    expect(config.items.keys.toSet(), {
      EffectType.fade,
      EffectType.slice,
      EffectType.revealMask,
    });
    expect(
      config.get(EffectType.fade),
      const EffectConfig(
        options: FadeEffectOptions(
          style: FadeStyle.throughColor,
          color: 0x40112233,
          durationMs: 1700,
        ),
      ),
    );
    expect(
      config.get(EffectType.slice),
      const EffectConfig(
        enabled: true,
        options: SliceEffectOptions(
          mode: SliceMode.reveal,
          stripCount: 13,
          staggerFraction: .28,
          durationMs: 2200,
        ),
      ),
    );
    expect(
      (config.get(EffectType.revealMask).options as RevealMaskEffectOptions)
          .edgeStyle,
      WipeEdgeStyle.neon,
    );
    expect(EffectsConfig.fromJson(config.toJson()), config);
  });

  test(
    'collision selection is independent of JSON order and canonical wins',
    () {
      final entries = {
        'blurFade': {'enabled': true},
        'filmDissolve': {'enabled': true},
      };
      final a = EffectsConfig.fromJson({'items': entries});
      final b = EffectsConfig.fromJson({
        'items': Map.fromEntries(entries.entries.toList().reversed),
      });
      expect(a, b);
      expect(a.items.length, 1);
      expect(
        (a.get(EffectType.fade).options as FadeEffectOptions).style,
        FadeStyle.linearLight,
      );
      final explicit = EffectsConfig.fromJson({
        'items': {
          ...entries,
          'fade': {
            'options': {'style': 'throughColor'},
          },
        },
      });
      expect(explicit.get(EffectType.fade).enabled, isFalse);
      expect(
        (explicit.get(EffectType.fade).options as FadeEffectOptions).style,
        FadeStyle.throughColor,
      );
    },
  );

  test('malformed former enum survives canonical storage for repair', () {
    final a = EffectsConfig.fromJson({
      'items': {
        'softWipe': {
          'enabled': true,
          'options': {'style': 'future'},
        },
      },
    });
    expect(a.get(EffectType.revealMask).invalid, isNotNull);
    expect(a.playable, isEmpty);
    final b = EffectsConfig.fromJson(a.toJson());
    expect(b.get(EffectType.revealMask).invalid, isNotNull);
    expect(
      b.get(EffectType.revealMask).invalid!.raw['options'],
      containsPair('edgeStyle', 'future'),
    );
  });

  test(
    'wave origin defaults and every corner round-trip with unknown rejection',
    () {
      for (final origin in EffectOrigin.values) {
        final options = WaterRefractionEffectOptions(origin: origin);
        expect(
          WaterRefractionEffectOptions.fromJson(options.toJson()),
          options,
        );
      }
      expect(
        WaterRefractionEffectOptions.fromJson({'origin': null}).origin,
        EffectOrigin.center,
      );
      expect(
        EffectConfig.fromJson(EffectType.waterRefraction, {
          'options': {'origin': 'future'},
        }).invalid,
        isNotNull,
      );
    },
  );
}
