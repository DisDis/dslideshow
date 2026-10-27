import 'dart:convert';

import 'package:dslideshow_common/effects.dart';
import 'package:test/test.dart';

void main() {
  test('malformed known options retain their effect type and enabled flag for repair', () {
    final entry = EffectConfig.fromJson({
      'type': 'mosaic',
      'enabled': true,
      'options': {'direction': 'future'},
    });
    expect(entry.type, EffectType.mosaic);
    expect(entry.enabled, isTrue);
    expect(entry.validate(), isNotEmpty);
    final cloned = EffectConfig.fromJson(entry.toJson());
    expect(cloned.type, EffectType.mosaic);
    expect(cloned.enabled, isTrue);
    expect(cloned.validate(), isNotEmpty);
    expect(EffectsConfig(items: [cloned]).playable, isEmpty);
  });

  test('overflowing JSON numbers stay diagnosable and JSON serializable', () {
    for (final raw in [
      '{"type":"mosaic","options":{"fadeFraction":1e999}}',
      '{"type":"rotate","options":{"angleDegrees":-1e999}}',
      '{"type":"future","options":{"number":1e999}}',
    ]) {
      final entry = EffectConfig.fromJson(
        jsonDecode(raw) as Map<String, dynamic>,
      );
      final config = EffectsConfig(
        items: [
          entry,
          EffectConfig(type: EffectType.fade, enabled: true),
        ],
      );
      final encoded = jsonEncode(config.toJson());
      final cloned = EffectsConfig.fromJson(
        jsonDecode(encoded) as Map<String, dynamic>,
      );
      expect(cloned.items.first.validate(), isNotEmpty);
      expect(cloned.playable.single.type, EffectType.fade);
      expect(cloned.validateForSave, throwsFormatException);
      expect(encoded, contains('Infinity'));
    }
  });

  test('Freezed updates preserve immutable configuration snapshots', () {
    const options = MosaicEffectOptions(gridSize: 150);
    final originalItem = EffectConfig(
      type: EffectType.mosaic,
      options: options,
    );
    final source = [originalItem];
    final original = EffectsConfig(items: source);
    source.clear();
    expect(original.items, [originalItem]);
    expect(() => original.items.clear(), throwsUnsupportedError);

    final updatedOptions = options.copyWith(durationMs: 2300, gridSize: 200);
    final updatedItem = originalItem.copyWith(
      enabled: true,
      options: updatedOptions,
    );
    final updated = original.copyWith(defaultDurationMs: 1200).put(updatedItem);
    expect(original.defaultDurationMs, 1000);
    expect(original.items.single.enabled, isFalse);
    expect(
      original.items.single.options,
      const MosaicEffectOptions(gridSize: 150),
    );
    expect(updated.items.single.options, updatedOptions);
    expect(updated, EffectsConfig.fromJson(updated.toJson()));
    expect(updated.hashCode, EffectsConfig.fromJson(updated.toJson()).hashCode);

    final raw = <String, dynamic>{
      'type': 'future',
      'options': {
        'values': [1, 2],
      },
    };
    final invalid = EffectConfig.fromJson(raw);
    (raw['options']['values'] as List).clear();
    final retained = invalid.toJson()['options'] as Map;
    expect(retained['values'], [1, 2]);
    expect(() => retained.clear(), throwsUnsupportedError);
    expect(() => (retained['values'] as List).clear(), throwsUnsupportedError);
  });

  test('defaults contain one explicit record per canonical type and serialize zero', () {
    final config = EffectsConfig.defaults();
    expect(config.validate(), isEmpty);
    expect(config.items.map((e) => e.type).toSet().length, 51);
    expect(config.items.length, 51);
    final encoded =
        jsonDecode(jsonEncode(config.toJson())) as Map<String, dynamic>;
    for (final item in encoded['items'] as List) {
      expect(item['enabled'], isTrue);
      expect(item['options']['durationMs'], 0);
      expect(item.containsKey('durationMs'), isFalse);
    }
    expect(EffectsConfig.fromJson(encoded).toJson(), config.toJson());
  });
  test(
    'zero inherits the current global time while positive values stay personal',
    () {
      var config = EffectsConfig(defaultDurationMs: 1200);
      const inherited = MosaicEffectOptions();
      const personal = MosaicEffectOptions(durationMs: 2500);
      expect(config.durationFor(inherited), 1200);
      expect(config.durationFor(personal), 2500);
      config = config.copyWith(defaultDurationMs: 1700);
      expect(config.durationFor(inherited), 1700);
      expect(config.durationFor(personal), 2500);
      expect(EffectConfig.fromJson({'type': 'fade'}).options.durationMs, 0);
      expect(
        EffectConfig.fromJson({
          'type': 'fade',
          'options': {'durationMs': null},
        }).options.durationMs,
        0,
      );
    },
  );
  test(
    'disabled settings survive JSON and enabling restores their parameters',
    () {
      final entry = EffectConfig(
        type: EffectType.mosaic,
        options: const MosaicEffectOptions(
          gridSize: 200,
          direction: MosaicDirection.bottomRight,
          fadeFraction: .75,
          durationMs: 2400,
        ),
      );
      final reloaded = EffectConfig.fromJson(
        jsonDecode(jsonEncode(entry.toJson())) as Map<String, dynamic>,
      );
      expect(reloaded.enabled, false);
      expect(reloaded.options, entry.options);
      var config = EffectsConfig(items: [reloaded]);
      expect(config.playable, isEmpty);
      config = config.put(reloaded.copyWith(enabled: true));
      expect(config.playable.single.options, entry.options);
    },
  );
  test(
    'empty, absent, unsupported and duplicate sets have explicit behavior',
    () {
      expect(parseEffectsConfig(null).playable.length, 51);
      expect(parseEffectsConfig({}).playable, isEmpty);
      expect(parseEffectsConfig({'items': []}).playable, isEmpty);
      final a = EffectConfig(type: EffectType.fade, enabled: true);
      final config = EffectsConfig(items: [a, a]);
      expect(config.validate().last, contains('duplicate'));
      expect(config.playable.length, 1);
      expect(config.validateForSave, throwsFormatException);
      final unsupported = EffectsConfig(schemaVersion: 2, items: [a]);
      expect(unsupported.playable, isEmpty);
      expect(unsupported.validateForSave, throwsFormatException);
    },
  );
  test('invalid values retain diagnostics and never become other effects', () {
    for (final data in <Map<String, dynamic>>[
      {'type': 'future'},
      {
        'type': 'mosaic',
        'options': {'direction': 'future'},
      },
      {
        'type': 'mosaic',
        'options': {'gridSize': 99},
      },
      {
        'type': 'mosaic',
        'options': {'gridSize': 100.5},
      },
      {
        'type': 'mosaic',
        'options': {'fadeFraction': 1.1},
      },
      {
        'type': 'fade',
        'options': {'durationMs': -1},
      },
      {
        'type': 'fade',
        'options': {'durationMs': 1.5},
      },
      {
        'type': 'fade',
        'options': {'durationMs': 3600001},
      },
      {'type': 'slide', 'options': 'invalid'},
      {
        'type': 'glass',
        'options': {'paneCount': 33},
      },
    ]) {
      final item = EffectConfig.fromJson(data);
      expect(item.validate(), isNotEmpty, reason: '$data');
      final config = EffectsConfig(items: [item]);
      expect(config.playable, isEmpty);
      expect(config.validateForSave, throwsFormatException);
      expect(EffectConfig.fromJson(item.toJson()).validate(), isNotEmpty);
    }
    final future = EffectConfig.fromJson({
      'type': 'future',
      'options': {'setting': 42},
    });
    expect(future.toJson()['type'], 'future');
    expect((future.toJson()['options'] as Map)['setting'], 42);
  });
  test('all supported option families retain their types and boundaries', () {
    for (final type in EffectType.values.where(
      (e) => e != EffectType.unknown,
    )) {
      final entry = EffectConfig(
        type: type,
        enabled: true,
        options: defaultEffectOptions(type).withDuration(2000),
      );
      final restored = EffectConfig.fromJson(entry.toJson());
      expect(restored.validate(), isEmpty, reason: '$type');
      expect(restored.options, entry.options);
      expect(restored.options.durationMs, 2000);
    }
    for (final size in [100, 150, 200]) {
      for (final fade in [0.0, .3, 1.0]) {
        expect(
          MosaicEffectOptions(gridSize: size, fadeFraction: fade).validate(),
          isEmpty,
        );
      }
    }
    expect(EffectsConfig(defaultDurationMs: -1).safeDefaultDurationMs, 1000);
    expect(parseEffectsConfig({'schemaVersion': 1.5}).playable, isEmpty);
  });
}
