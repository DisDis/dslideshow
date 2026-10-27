import 'dart:convert';

import 'package:config_app/features/config/domain/effect_settings_validation.dart';
import 'package:config_app/features/config/domain/config_draft.dart';
import 'package:dslideshow_backend/config.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'invalid overflowing effect settings remain editable and protected on Save',
    () {
      final config = AppConfig.fromJson(
        jsonDecode(
          '{"slideshow":{"effects":{"items":{"mosaic":{'
          '"options":{"fadeFraction":1e999}}}}}}',
        ) as Map<String, dynamic>,
      );
      final draft = ConfigDraft()..replaceSaved(config);
      expect(draft.hasChanges, isFalse);
      expect(
        draft.value!.slideshow.effects.validateForSave,
        throwsFormatException,
      );
      draft.value!.slideshow.effects = EffectsConfig();
      expect(draft.hasChanges, isTrue);
      expect(draft.value!.slideshow.effects.validate(), isEmpty);
      draft.discard();
      expect(draft.hasChanges, isFalse);
      expect(
        draft.value!.slideshow.effects.validateForSave,
        throwsFormatException,
      );
    },
  );

  test('default disabled effect entries do not create unsaved changes', () {
    final draft = ConfigDraft()..replaceSaved(AppConfig.fromJson({}));
    draft.value!.slideshow.effects = EffectsConfig(
      items: {EffectType.mosaic: EffectConfig.defaults(EffectType.mosaic)},
    );
    expect(draft.hasChanges, isFalse);
    draft.value!.slideshow.effects = draft.value!.slideshow.effects.put(
      EffectType.mosaic,
      const EffectConfig(options: MosaicEffectOptions(gridSize: 150)),
    );
    expect(draft.hasChanges, isTrue);
    draft.value!.slideshow.effects = draft.value!.slideshow.effects.put(
      EffectType.mosaic,
      EffectConfig.defaults(EffectType.mosaic),
    );
    expect(draft.hasChanges, isFalse);
  });

  test('edits and discard never mutate the saved configuration', () {
    final saved = AppConfig.fromJson({
      'welcome': {'text': 'Saved welcome'},
    });
    final draft = ConfigDraft()..replaceSaved(saved);
    expect(draft.hasChanges, isFalse);
    draft.value!.welcome.text = 'Edited welcome';
    expect(saved.welcome.text, 'Saved welcome');
    expect(draft.hasChanges, isTrue);
    draft.discard();
    expect(draft.value!.welcome.text, 'Saved welcome');
    expect(draft.hasChanges, isFalse);
  });

  test('reverting an edit returns to the saved state', () {
    final draft = ConfigDraft()..replaceSaved(AppConfig.fromJson({}));
    final previous = draft.value!.hardware.smoothingGPIOMs;
    draft.value!.hardware.smoothingGPIOMs = previous + 1;
    expect(draft.hasChanges, isTrue);
    draft.value!.hardware.smoothingGPIOMs = previous;
    expect(draft.hasChanges, isFalse);
  });

  test('creating default storage options does not mark the draft dirty', () {
    final draft = ConfigDraft()..replaceSaved(AppConfig.fromJson({}));
    for (final type in StorageType.values) {
      draft.value!.storages.getOrCreateEmpty(type);
    }
    expect(draft.hasChanges, isFalse);
  });

  test('unknown nested options are isolated and compared independent of key order', () {
    AppConfig config(Map<String, dynamic> options) => AppConfig.fromJson({
      'slideshow': {
        'specialScreens': [
          {'id': 'future', 'type': 'future-widget', 'options': options},
        ],
      },
    });
    final first = config({
      'a': {'x': 1, 'y': 2},
      'b': [1, 2],
    });
    final draft = ConfigDraft()..replaceSaved(first);
    final reordered = config({
      'b': [1, 2],
      'a': {'y': 2, 'x': 1},
    });
    // Move opaque options into the editable model without changing their values.
    draft.value!.slideshow.specialScreens[0] =
        reordered.slideshow.specialScreens[0];
    expect(draft.hasChanges, isFalse);
    final options = draft.value!.slideshow.specialScreens.single.options
        .toJson();
    (options['a'] as Map)['x'] = 3;
    // Unknown options.toJson returns a copy, so explicitly replace the screen.
    draft.value!.slideshow.specialScreens[0] = config(options)
        .slideshow
        .specialScreens[0];
    expect(draft.hasChanges, isTrue);
    expect(first.slideshow.specialScreens.single.options.toJson()['a'], {
      'x': 1,
      'y': 2,
    });
    draft.discard();
    expect(draft.hasChanges, isFalse);
  });

  test('invalid numeric input remains protected until discarded', () {
    final draft = ConfigDraft()..replaceSaved(AppConfig.fromJson({}));
    draft.value!.welcome.size = double.nan;
    expect(draft.hasChanges, isTrue);
    expect(
      () => cloneConfig(draft.value!),
      throwsA(isA<JsonUnsupportedObjectError>()),
    );
    draft.discard();
    expect(draft.hasChanges, isFalse);
    expect(draft.value!.welcome.size.isFinite, isTrue);
  });

  test(
    'replaceSaved adopts the new server value and resets discard baseline',
    () {
      final draft = ConfigDraft()..replaceSaved(AppConfig.fromJson({}));
      draft.value!.welcome.text = 'Old draft';
      draft.replaceSaved(
        AppConfig.fromJson({
          'welcome': {'text': 'New server value'},
        }),
      );
      expect(draft.hasChanges, isFalse);
      expect(draft.value!.welcome.text, 'New server value');
      draft.value!.welcome.text = 'Later draft';
      draft.discard();
      expect(draft.value!.welcome.text, 'New server value');
      expect(draft.hasChanges, isFalse);
    },
  );
}
