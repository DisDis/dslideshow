import 'dart:convert';
import 'dart:io';

import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_backend/src/web_server/saved_config_repository.dart';
import 'package:test/test.dart';

void main() {
  test('overflowing effect numbers can be read but cannot overwrite the saved file', () {
    final directory = Directory.systemTemp.createTempSync('effects-overflow-');
    addTearDown(() => directory.deleteSync(recursive: true));
    final file = File('${directory.path}/config.json');
    const raw =
        '{"slideshow":{"effects":{"items":[{"type":"mosaic",'
        '"enabled":true,"options":{"fadeFraction":1e999}}]}}}';
    file.writeAsStringSync(raw);
    final active = AppConfig.fromJson({})..fullConfigFilename = file.path;
    final repository = SavedConfigRepository(active);
    final loaded = repository.load();
    expect(loaded.slideshow.effects.playable, isEmpty);
    final payload = jsonEncode(loaded.toJson());
    expect(() => repository.save(payload), throwsFormatException);
    expect(file.readAsStringSync(), raw);
  });

  test(
    'storage retains an explicit default set, empty set and zero overrides',
    () {
      final config = AppConfig.fromJson({});
      final full = config.toStorageJson();
      expect(
        (full['slideshow'] as Map)['effects'],
        config.slideshow.effects.toJson(),
      );
      config.slideshow.effects = EffectsConfig();
      final stored = config.toStorageJson();
      final effects = (stored['slideshow'] as Map)['effects'] as Map;
      expect(effects['schemaVersion'], 1);
      expect(effects['items'], isEmpty);
      expect(AppConfig.fromJson(stored).slideshow.effects.playable, isEmpty);
      config.slideshow.effects = config.slideshow.effects.put(
        EffectConfig(type: EffectType.mosaic),
      );
      final reloaded = AppConfig.fromJson(config.toStorageJson());
      expect(reloaded.slideshow.effects.items.single.options.durationMs, 0);
      expect(reloaded.slideshow.effects.items.single.enabled, false);
    },
  );
  test(
    'legacy fields do not enable a legacy selection or affect global timing',
    () {
      final config = SlideShowConfig.fromJson({
        'allowedEffects': ['Fade'],
        'transitionTimeMs': 9000,
      });
      expect(config.effects.defaultDurationMs, 1000);
      expect(config.effects.playable.length, 51);
      expect(config.toJson().containsKey('allowedEffects'), false);
      expect(config.toJson().containsKey('transitionTimeMs'), false);
    },
  );
  test(
    'Save rejects invalid options without changing file or active services',
    () {
      final directory = Directory.systemTemp.createTempSync('effects-save-');
      addTearDown(() => directory.deleteSync(recursive: true));
      final file = File('${directory.path}/config.json');
      final active = AppConfig.fromJson({})..fullConfigFilename = file.path;
      final repository = SavedConfigRepository(active);
      repository.save(jsonEncode(active.toJson()));
      final before = file.readAsStringSync();
      for (final effects in [
        {'schemaVersion': 2},
        {'defaultDurationMs': 0},
        {
          'items': [
            {'type': 'future'},
          ],
        },
        {
          'items': [
            {
              'type': 'mosaic',
              'options': {'gridSize': 50},
            },
          ],
        },
        {
          'items': [
            {'type': 'fade'},
            {'type': 'fade'},
          ],
        },
      ]) {
        expect(
          () => repository.save(
            jsonEncode({
              'slideshow': {'effects': effects},
            }),
          ),
          throwsFormatException,
        );
        expect(file.readAsStringSync(), before);
      }
      expect(active.slideshow.effects.playable.length, 51);
      final next = AppConfig.fromJson({
        'slideshow': {
          'effects': {
            'items': [
              {
                'type': 'fade',
                'enabled': true,
                'options': {'durationMs': 1500},
              },
            ],
          },
        },
      });
      repository.save(jsonEncode(next.toJson()));
      expect(
        repository.load().slideshow.effects.items.single.options.durationMs,
        1500,
      );
      expect(active.slideshow.effects.items.length, 51);
    },
  );
}
