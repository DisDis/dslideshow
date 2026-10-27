import 'dart:convert';
import 'dart:io';

import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_backend/src/web_server/saved_config_repository.dart';
import 'package:test/test.dart';

void main() {
  test(
    'empty and default effect settings are removed by normal default stripping',
    () {
      final config = AppConfig.fromJson({});
      expect(config.slideshow.effects.items, isEmpty);
      expect(config.toStorageJson(), isEmpty);
      expect(config.slideshow.effects.toJson(), isEmpty);
      config.slideshow.effects = EffectsConfig(
        items: {
          EffectType.mosaic: EffectConfig.defaults(EffectType.mosaic),
          EffectType.fade: const EffectConfig(),
        },
      );
      expect(config.toStorageJson(), isEmpty);
      expect(
        AppConfig.fromJson(config.toStorageJson()).slideshow.effects.playable,
        isEmpty,
      );
    },
  );

  test(
    'enabled effects and disabled custom options survive compact storage',
    () {
      final config = AppConfig.fromJson({});
      config.slideshow.effects = EffectsConfig(
        defaultDurationMs: 1500,
        items: {
          EffectType.mosaic: const EffectConfig(
            options: MosaicEffectOptions(gridSize: 200),
          ),
          EffectType.slide: EffectConfig.defaults(EffectType.slide)
              .copyWith(enabled: true),
          EffectType.fade: const EffectConfig(
            enabled: true,
            options: BasicEffectOptions(durationMs: 2100),
          ),
        },
      );
      final stored = config.toStorageJson();
      expect(stored, {
        'slideshow': {
          'effects': {
            'defaultDurationMs': 1500,
            'items': {
              'mosaic': {
                'options': {'gridSize': 200},
              },
              'slide': {'enabled': true},
              'fade': {
                'enabled': true,
                'options': {'durationMs': 2100},
              },
            },
          },
        },
      });
      final reloaded = AppConfig.fromJson(stored).slideshow.effects;
      expect(reloaded, config.slideshow.effects);
      expect(reloaded.get(EffectType.mosaic).enabled, isFalse);
      expect(reloaded.get(EffectType.mosaic).options.durationMs, 0);
      expect(
        reloaded.get(EffectType.slide).options,
        const SlideEffectOptions(),
      );
      config.slideshow.effects = config.slideshow.effects.put(
        EffectType.fade,
        const EffectConfig(enabled: true),
      );
      final inherited =
          (config.toStorageJson()['slideshow']
              as Map)['effects']['items']['fade'];
      expect(inherited, {'enabled': true});
      expect(
        AppConfig.fromJson(config.toStorageJson()).slideshow.effects
            .get(EffectType.fade)
            .options
            .durationMs,
        0,
      );
      config.slideshow.effects = EffectsConfig();
      expect(config.toStorageJson(), isEmpty);
    },
  );

  test(
    'slideshow storage keeps compact screen options and custom settings',
    () {
      final config = AppConfig.fromJson({
        'slideshow': {
          'displayTimeMs': 12345,
          'specialScreens': [
            {'id': 'clock', 'type': 'clock', 'options': {}},
          ],
        },
      });
      final stored = config.toStorageJson();
      final slideshow = stored['slideshow'] as Map;
      expect(slideshow['displayTimeMs'], 12345);
      expect(slideshow, isNot(contains('fadeTimeMs')));
      expect((slideshow['specialScreens'] as List).single['options'], isNull);
      expect(
        AppConfig.fromJson(stored).slideshow.toJson(),
        config.slideshow.toJson(),
      );
    },
  );

  test(
    'legacy fields are ignored and absent effects leaves fallback selection',
    () {
      final config = SlideShowConfig.fromJson({
        'allowedEffects': ['Fade'],
        'transitionTimeMs': 9000,
      });
      expect(config.effects.defaultDurationMs, 1000);
      expect(config.effects.playable, isEmpty);
      expect(config.toJson(), isNot(contains('allowedEffects')));
      expect(config.toJson(), isNot(contains('transitionTimeMs')));
    },
  );

  test('backend saves numeric effect settings without editor validation', () {
    final directory = Directory.systemTemp.createTempSync('effects-save-');
    addTearDown(() => directory.deleteSync(recursive: true));
    final file = File('${directory.path}/config.json');
    final active = AppConfig.fromJson({})..fullConfigFilename = file.path;
    final repository = SavedConfigRepository(active);
    final next = AppConfig.fromJson({
      'slideshow': {
        'effects': {
          'schemaVersion': 2,
          'defaultDurationMs': 0,
          'items': {
            'mosaic': {
              'enabled': true,
              'options': {'gridSize': 50, 'fadeFraction': 1.1},
            },
            'fade': {
              'enabled': false,
              'options': {'durationMs': -1},
            },
          },
        },
      },
    });
    repository.save(jsonEncode(next.toJson()));
    expect(repository.load().slideshow.effects, next.slideshow.effects);
    expect(
      jsonDecode(file.readAsStringSync())['slideshow']['effects'],
      next.slideshow.effects.toJson(),
    );
    expect(active.slideshow.effects.items, isEmpty);
  });

  test(
    'malformed known options can be loaded and saved without range validation',
    () {
      final directory = Directory.systemTemp.createTempSync(
        'effects-overflow-',
      );
      addTearDown(() => directory.deleteSync(recursive: true));
      final file = File('${directory.path}/config.json');
      file.writeAsStringSync(
        '{"slideshow":{"effects":{"items":{"mosaic":'
        '{"enabled":true,"options":{"fadeFraction":1e999}}}}}}',
      );
      final active = AppConfig.fromJson({})..fullConfigFilename = file.path;
      final repository = SavedConfigRepository(active);
      final loaded = repository.load();
      expect(loaded.slideshow.effects.playable, isEmpty);
      expect(
        loaded.slideshow.effects.get(EffectType.mosaic).invalid,
        isNotNull,
      );
      repository.save(jsonEncode(loaded.toJson()));
      expect(file.readAsStringSync(), contains('Infinity'));
      expect(
        repository.load().slideshow.effects.get(EffectType.mosaic).invalid,
        isNotNull,
      );
    },
  );
}
