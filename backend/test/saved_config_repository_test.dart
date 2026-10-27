import 'dart:convert';
import 'dart:io';

import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_backend/src/web_server/saved_config_repository.dart';
import 'package:test/test.dart';

void main() {
  late Directory directory;
  late File file;
  late AppConfig activeConfig;
  late SavedConfigRepository repository;

  setUp(() {
    directory = Directory.systemTemp.createTempSync('saved-config-');
    file = File('${directory.path}/config.json');
    activeConfig = AppConfig.fromJson({
      'slideshow': {'displayTimeMs': 8000},
      'web': {'port': 8090},
    })..fullConfigFilename = file.path;
    repository = SavedConfigRepository(activeConfig);
  });

  tearDown(() {
    directory.deleteSync(recursive: true);
  });

  test(
    'save then load returns saved values without changing active services',
    () {
      final before = jsonEncode(activeConfig.toJson());
      final edited = AppConfig.fromJson(activeConfig.toJson());
      edited.slideshow.displayTimeMs = 12000;
      edited.webServer.port = 8091;

      repository.save(jsonEncode(edited.toJson()));

      expect(repository.load().toJson(), edited.toJson());
      expect(jsonEncode(activeConfig.toJson()), before);
      expect(activeConfig.fullConfigFilename, file.path);
    },
  );

  test('load reads external changes instead of retaining a saved snapshot', () {
    repository.save('{"slideshow":{"displayTimeMs":12000}}');
    expect(repository.load().slideshow.displayTimeMs, 12000);

    file.writeAsStringSync('{"slideshow":{"displayTimeMs":15000}}');

    expect(repository.load().slideshow.displayTimeMs, 15000);
    expect(activeConfig.slideshow.displayTimeMs, 8000);
  });

  test('missing file returns an independent copy of the active config', () {
    final loaded = repository.load();
    expect(loaded.toJson(), activeConfig.toJson());
    expect(identical(loaded, activeConfig), isFalse);
    loaded.webServer.port = 8092;
    loaded.slideshow.specialScreens.add(
      SpecialScreenConfig(id: 'clock', type: SpecialScreenType.clock),
    );
    expect(activeConfig.webServer.port, 8090);
    expect(activeConfig.slideshow.specialScreens, isEmpty);
    expect(file.existsSync(), isFalse);
  });

  test('missing-file fallback deep copies opaque future screen options', () {
    activeConfig.slideshow.specialScreens.add(
      SpecialScreenConfig.fromJson({
        'id': 'future',
        'type': 'future-screen',
        'options': {
          'layers': [
            {
              'nested': {'color': 'blue'},
            },
          ],
        },
      }),
    );
    final before = jsonEncode(activeConfig.toJson());
    final loaded = repository.load();
    final options =
        loaded.slideshow.specialScreens.single.options as UnknownScreenOptions;
    final layers = options.json['layers'] as List<dynamic>;
    ((layers.single as Map<String, dynamic>)['nested']
            as Map<String, dynamic>)['color'] =
        'red';
    layers.add({'nested': {}});

    expect(jsonEncode(activeConfig.toJson()), before);
    expect(repository.load().toJson(), activeConfig.toJson());
  });

  test('save uses the private server filename and compact default values', () {
    final untrustedFile = File('${directory.path}/client-chosen.json');
    repository.save(
      jsonEncode({
        'fullConfigFilename': untrustedFile.path,
        'slideshow': {
          'displayTimeMs': 5000,
          'specialScreens': [
            {'id': 'clock', 'type': 'clock', 'enabled': true},
          ],
        },
      }),
    );

    final stored = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
    expect(stored, {
      'slideshow': {
        'effects': EffectsConfig.defaults().toJson(),
        'specialScreens': [
          {'id': 'clock', 'type': 'clock', 'enabled': true},
        ],
      },
    });
    expect(untrustedFile.existsSync(), isFalse);
    final full = repository.load().toJson();
    expect(full.containsKey('fullConfigFilename'), isFalse);
    expect((full['slideshow'] as Map)['displayTimeMs'], 5000);
  });

  for (final content in [
    '{malformed',
    '[]',
    '{"slideshow":{"displayTimeMs":"invalid"}}',
  ]) {
    test(
      'invalid saved content is reported instead of using active config: $content',
      () {
        file.writeAsStringSync(content);
        expect(repository.load, throwsA(anything));
        expect(activeConfig.slideshow.displayTimeMs, 8000);
      },
    );

    test(
      'invalid upload leaves the previous saved content intact: $content',
      () {
        repository.save('{"slideshow":{"displayTimeMs":12000}}');
        final before = file.readAsStringSync();
        expect(() => repository.save(content), throwsA(anything));
        expect(file.readAsStringSync(), before);
        expect(activeConfig.slideshow.displayTimeMs, 8000);
      },
    );
  }

  test('read failures other than missing files are reported', () {
    Directory(file.path).createSync();
    expect(repository.load, throwsA(isA<FileSystemException>()));
  });

  test(
    'a non-directory parent is a read error, not a missing-file fallback',
    () {
      file.writeAsStringSync('{}');
      final invalidPath = AppConfig.fromJson(activeConfig.toJson())
        ..fullConfigFilename = '${file.path}/config.json';
      expect(
        SavedConfigRepository(invalidPath).load,
        throwsA(isA<FileSystemException>()),
      );
    },
  );

  test('write failures propagate without mutating active config', () {
    Directory(file.path).createSync();
    expect(
      () => repository.save('{"web":{"port":8091}}'),
      throwsA(isA<FileSystemException>()),
    );
    expect(activeConfig.webServer.port, 8090);
  });
}
