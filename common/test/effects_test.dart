import 'dart:convert';

import 'package:dslideshow_common/effects.dart';
import 'package:test/test.dart';

void main() {
  test(
    'map key selects concrete options without a type field in the value',
    () {
      final config = EffectsConfig.fromJson({
        'items': {
          'mosaic': {
            'enabled': true,
            'options': {'gridSize': 150, 'direction': 'bottomRight'},
          },
          'slide': {
            'options': {'mode': 'cover', 'direction': 'up'},
          },
        },
      });
      expect(config.items.keys, [EffectType.mosaic, EffectType.slide]);
      expect(
        config.items[EffectType.mosaic]!.options,
        const MosaicEffectOptions(
          gridSize: 150,
          direction: MosaicDirection.bottomRight,
        ),
      );
      expect(
        config.items[EffectType.slide]!.options,
        const SlideEffectOptions(
          mode: SlideMode.cover,
          direction: EffectDirection.up,
        ),
      );
      expect(config.playable.single.key, EffectType.mosaic);
      final encoded =
          jsonDecode(jsonEncode(config.toJson())) as Map<String, dynamic>;
      for (final value in (encoded['items'] as Map).values) {
        expect(value, isNot(contains('type')));
      }
      expect(EffectsConfig.fromJson(encoded), config);
    },
  );

  test(
    'malformed known options keep their map key and enabled flag for repair',
    () {
      final config = EffectsConfig.fromJson({
        'items': {
          'mosaic': {
            'enabled': true,
            'options': {'direction': 'future'},
          },
          'fade': {'enabled': true},
        },
      });
      final cloned = EffectsConfig.fromJson(config.toJson());
      final entry = cloned.items[EffectType.mosaic]!;
      expect(entry.enabled, isTrue);
      expect(entry.invalid!.error, isNotEmpty);
      expect(cloned.playable.single.key, EffectType.fade);
      expect(entry.toJson()['options'], {'direction': 'future'});
    },
  );

  test('overflowing JSON numbers remain diagnosable and serializable', () {
    for (final (type, field, number) in [
      ('mosaic', 'fadeFraction', '1e999'),
      ('rotate', 'angleDegrees', '-1e999'),
    ]) {
      final config = EffectsConfig.fromJson(
        jsonDecode(
          '{"items":{"$type":{"options":{"$field":$number}},"fade":{"enabled":true}}}',
        ) as Map<String, dynamic>,
      );
      final encoded = jsonEncode(config.toJson());
      final cloned = EffectsConfig.fromJson(
        jsonDecode(encoded) as Map<String, dynamic>,
      );
      expect(cloned.items.values.first.invalid, isNotNull);
      expect(cloned.playable.single.key, EffectType.fade);
      expect(encoded, contains('Infinity'));
    }
  });

  test(
    'Freezed updates preserve immutable map snapshots and replace by key',
    () {
      const options = MosaicEffectOptions(gridSize: 150);
      const originalItem = EffectConfig(options: options);
      final source = {EffectType.mosaic: originalItem};
      final original = EffectsConfig(items: source);
      source.clear();
      expect(original.items, {EffectType.mosaic: originalItem});
      expect(() => original.items.clear(), throwsUnsupportedError);
      final updatedOptions = options.copyWith(durationMs: 2300, gridSize: 200);
      final updated = original
          .copyWith(defaultDurationMs: 1200)
          .put(
            EffectType.mosaic,
            originalItem.copyWith(enabled: true, options: updatedOptions),
          );
      expect(original.defaultDurationMs, 1000);
      expect(original.items.values.single.enabled, isFalse);
      expect(original.items.values.single.options, options);
      expect(updated.items.length, 1);
      expect(updated.items.values.single.options, updatedOptions);
      expect(updated, EffectsConfig.fromJson(updated.toJson()));
      expect(
        updated.hashCode,
        EffectsConfig.fromJson(updated.toJson()).hashCode,
      );
    },
  );

  test('malformed payloads remain deeply isolated from input mutations', () {
    final raw = <String, dynamic>{
      'options': {
        'values': [1, 2],
        'direction': 'future',
      },
    };
    final invalid = EffectConfig.fromJson(EffectType.mosaic, raw);
    (raw['options']['values'] as List).clear();
    final retained = invalid.toJson()['options'] as Map;
    expect(retained['values'], [1, 2]);
    expect(() => retained.clear(), throwsUnsupportedError);
    expect(() => (retained['values'] as List).clear(), throwsUnsupportedError);
  });

  test('absent settings have an empty selection and catalog defaults use zero duration', () {
    final config = EffectsConfig();
    expect(config.items, isEmpty);
    expect(parseEffectsConfig(null), config);
    for (final type in EffectType.values.where(
      (type) => type != EffectType.unknown,
    )) {
      final entry = config.get(type);
      expect(entry.enabled, isFalse);
      expect(entry.options, defaultEffectOptions(type));
      expect(entry.toJson(), isEmpty);
      expect(entry.toJson(), isNot(contains('type')));
    }
    expect(EffectsConfig.fromJson(config.toJson()), config);
  });

  test(
    'zero inherits current global time while positive duration stays personal',
    () {
      var config = EffectsConfig(defaultDurationMs: 1200);
      const inherited = MosaicEffectOptions();
      const personal = MosaicEffectOptions(durationMs: 2500);
      expect(config.durationFor(inherited), 1200);
      expect(config.durationFor(personal), 2500);
      config = config.copyWith(defaultDurationMs: 1700);
      expect(config.durationFor(inherited), 1700);
      expect(config.durationFor(personal), 2500);
      expect(EffectConfig.fromJson(EffectType.fade, {}).options.durationMs, 0);
      expect(
        EffectConfig.fromJson(EffectType.fade, {
          'options': {'durationMs': null},
        }).options.durationMs,
        0,
      );
    },
  );

  test('disabled options survive JSON and are restored when enabled', () {
    const entry = EffectConfig(
      options: MosaicEffectOptions(
        gridSize: 200,
        direction: MosaicDirection.bottomRight,
        fadeFraction: .75,
        durationMs: 2400,
      ),
    );
    final restored = EffectConfig.fromJson(
      EffectType.mosaic,
      jsonDecode(jsonEncode(entry.toJson())) as Map<String, dynamic>,
    );
    var config = EffectsConfig(items: {EffectType.mosaic: restored});
    expect(restored, entry);
    expect(config.playable, isEmpty);
    config = config.put(EffectType.mosaic, restored.copyWith(enabled: true));
    expect(config.playable.single.value.options, entry.options);
  });

  test(
    'absent, empty, unsupported and malformed sets have explicit behavior',
    () {
      expect(parseEffectsConfig(null).playable, isEmpty);
      expect(parseEffectsConfig({}).playable, isEmpty);
      expect(parseEffectsConfig({'items': {}}).playable, isEmpty);
      expect(parseEffectsConfig({'items': []}).playable, isEmpty);
      expect(parseEffectsConfig({'schemaVersion': 1.5}).playable, isEmpty);
      expect(
        EffectsConfig(
          schemaVersion: 2,
          items: {EffectType.fade: const EffectConfig(enabled: true)},
        ).playable,
        isEmpty,
      );
    },
  );

  test('unknown keys and malformed map values do not hide valid effects', () {
    final config = EffectsConfig.fromJson({
      'items': {
        'future': {'enabled': true},
        'unknown': {'enabled': true},
        'slide': 'invalid',
        'fade': {'enabled': true},
      },
    });
    expect(config.items.keys, [EffectType.fade]);
    expect(config.playable.single.key, EffectType.fade);
    expect(config.toJson()['items'], {
      'fade': {'enabled': true},
    });
  });

  test(
    'models parse numeric values without applying editor range validation',
    () {
      final config = EffectsConfig.fromJson({
        'defaultDurationMs': -100,
        'items': {
          'mosaic': {
            'enabled': true,
            'options': {'gridSize': 99, 'fadeFraction': 1.1},
          },
          'fade': {
            'enabled': true,
            'options': {'durationMs': -1},
          },
        },
      });
      expect(config.defaultDurationMs, -100);
      expect(
        config.items[EffectType.mosaic]!.options,
        const MosaicEffectOptions(gridSize: 99, fadeFraction: 1.1),
      );
      expect(config.items[EffectType.fade]!.options.durationMs, -1);
      expect(config.playable.length, 2);
      expect(EffectsConfig.fromJson(config.toJson()), config);
    },
  );

  test(
    'all option families use defaults and retain concrete type on round trip',
    () {
      for (final type in EffectType.values.where(
        (e) => e != EffectType.unknown,
      )) {
        final entry = EffectConfig(
          enabled: true,
          options: defaultEffectOptions(type).withDuration(2000),
        );
        final restored = EffectConfig.fromJson(type, entry.toJson());
        expect(restored, entry, reason: '$type');
        expect(
          EffectConfig.fromJson(type, {}).options,
          defaultEffectOptions(type),
        );
        expect(EffectsConfig().get(type).options, defaultEffectOptions(type));
      }
    },
  );
}
