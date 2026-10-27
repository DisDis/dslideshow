import 'dart:convert';
import 'dart:io';

import 'package:dslideshow_backend/config.dart';
import 'package:test/test.dart';

void main() {
  test('clone isolates nested camera drafts', () {
    final original = SpecialScreenConfig(
      id: 'cameras',
      type: SpecialScreenType.cameras,
      options: CamerasScreenOptions(
        cameras: [CameraConfig(id: 'front', url: 'https://cam/front')],
      ),
    );
    final draft = original.clone();
    final cameras = (draft.options as CamerasScreenOptions).cameras;
    cameras.single.url = 'https://cam/edited';
    cameras.add(CameraConfig(id: 'back', url: 'https://cam/back'));
    expect(
      (original.options as CamerasScreenOptions).cameras.single.url,
      'https://cam/front',
    );
  });

  test('generated copyWith updates typed drafts without changing original values', () {
    final schedule = SpecialScreenSchedule();
    final clockOptions = ClockScreenOptions();
    final clock = SpecialScreenConfig(
      id: 'clock',
      type: SpecialScreenType.clock,
      schedule: schedule,
      options: clockOptions,
    );
    final editedClock = clock.copyWith(
      enabled: true,
      schedule: schedule.copyWith(count: 3),
      options: clockOptions.copyWith(showDate: false),
    );
    expect(editedClock.toJson(), {
      'id': 'clock',
      'type': 'clock',
      'enabled': true,
      'schedule': {'count': 3},
      'options': {'showDate': false},
    });
    expect(clock.toJson(), {'id': 'clock', 'type': 'clock'});
    // The existing editor still writes directly to its isolated mutable draft.
    editedClock.name = 'Kitchen';
    (editedClock.options as ClockScreenOptions).showSeconds = true;
    expect(clock.name, isEmpty);
    expect(clockOptions.showSeconds, isFalse);

    final camera = CameraConfig(id: 'front', url: 'https://cam/front');
    final cameras = CamerasScreenOptions(cameras: [camera]);
    final editedCameras = cameras.copyWith(
      mode: CameraDisplayMode.sequence,
      cameras: [camera.copyWith(url: 'https://cam/back', name: 'Back')],
    );
    expect(editedCameras.toJson(), {
      'mode': 'sequence',
      'cameras': [
        {'id': 'front', 'url': 'https://cam/back', 'name': 'Back'},
      ],
    });
    expect(cameras.mode, CameraDisplayMode.grid);
    expect(camera.url, 'https://cam/front');
    expect(
      CamerasScreenOptions.fromJson(editedCameras.toJson()).toJson(),
      editedCameras.toJson(),
    );

    final clockDefinition =
        SpecialScreenRegistry.definitions[SpecialScreenType.clock]!;
    final cameraDefinition = clockDefinition.copyWith(
      parseOptions: CamerasScreenOptions.fromJson,
    );
    expect(clockDefinition.defaults(), isA<ClockScreenOptions>());
    expect(cameraDefinition.defaults(), isA<CamerasScreenOptions>());
  });

  test(
    'generated slideshow JSON delegates compact serialization to nested models',
    () {
      final config = SlideShowConfig.fromJson({});
      config.specialScreens.addAll([
        SpecialScreenConfig(id: 'clock', type: SpecialScreenType.clock),
        SpecialScreenConfig(
          id: 'cameras',
          type: SpecialScreenType.cameras,
          options: CamerasScreenOptions(
            cameras: [
              CameraConfig(
                id: 'door',
                url: 'https://cam/snapshot',
                password: 'secret',
              ),
            ],
          ),
        ),
      ]);
      final json = config.toJson();
      expect(json['specialScreens'], [
        {'id': 'clock', 'type': 'clock'},
        {
          'id': 'cameras',
          'type': 'cameras',
          'options': {
            'cameras': [
              {
                'id': 'door',
                'url': 'https://cam/snapshot',
                'password': 'secret',
              },
            ],
          },
        },
      ]);
      final restored = SlideShowConfig.fromJson(
        jsonDecode(jsonEncode(json)) as Map<String, dynamic>,
      );
      expect(restored.toJson(), json);
      expect(
        (restored.specialScreens.first.options as ClockScreenOptions).showDate,
        isTrue,
      );
      expect(restored.specialScreens.first.schedule.count, 10);
    },
  );

  test(
    'clock defaults survive JSON and compact storage without size drift',
    () {
      final defaults = ClockScreenOptions();
      expect(defaults.timeFontSizePercent, 50);
      for (final json in <Map<String, dynamic>>[
        {},
        {'timeFontSizePercent': null},
        {'timeFontSizePercent': -1},
      ]) {
        expect(ClockScreenOptions.fromJson(json).toJson(), defaults.toJson());
      }
      final screen = SpecialScreenConfig(
        id: 'clock',
        type: SpecialScreenType.clock,
        options: defaults,
      );
      final compact = screen.toJson();
      expect(compact, {'id': 'clock', 'type': 'clock'});
      expect(SpecialScreenConfig.fromJson(compact).toJson(), screen.toJson());

      final explicit = SpecialScreenConfig.fromJson({
        'id': 'small-clock',
        'type': 'clock',
        'options': {'timeFontSizePercent': 20},
      });
      final explicitCompact = explicit.toJson();
      expect(explicitCompact['options'], {'timeFontSizePercent': 20.0});
      expect(
        SpecialScreenConfig.fromJson(explicitCompact).toJson(),
        explicit.toJson(),
      );
    },
  );
  test(
    'storage serialization is pure and removes values reset to defaults',
    () {
      final config = AppConfig.fromJson({});
      final clock = SpecialScreenConfig(
        id: 'clock',
        type: SpecialScreenType.clock,
        enabled: true,
        options: ClockScreenOptions(showDate: false),
      );
      config.slideshow.specialScreens.add(clock);
      final full = jsonEncode(config.toJson());
      expect(config.toStorageJson(), {
        'slideshow': {
          'specialScreens': [
            {
              'id': 'clock',
              'type': 'clock',
              'enabled': true,
              'options': {'showDate': false},
            },
          ],
        },
      });
      expect(jsonEncode(config.toJson()), full);
      (clock.options as ClockScreenOptions).showDate = true;
      clock.enabled = false;
      expect(config.toStorageJson(), {
        'slideshow': {
          'specialScreens': [
            {'id': 'clock', 'type': 'clock'},
          ],
        },
      });
      config.slideshow.specialScreens.clear();
      expect(config.toStorageJson(), isEmpty);
    },
  );
  test('enum JSON names and annotated date formats round trip', () {
    final screen = SpecialScreenConfig.fromJson({
      'id': 'clock',
      'type': 'clock',
      'schedule': {'type': 'interval'},
      'options': {'timeFormat': 'h12', 'dateFormat': 'yyyy-MM-dd'},
    });
    expect(screen.type, SpecialScreenType.clock);
    expect(screen.schedule.type, SpecialScreenScheduleType.interval);
    final options = screen.options as ClockScreenOptions;
    expect(options.timeFormat, ClockTimeFormat.h12);
    expect(options.dateFormat, ClockDateFormat.yearMonthDay);
    expect((screen.toJson()['options'] as Map)['dateFormat'], 'yyyy-MM-dd');
    final cameraOptions = CamerasScreenOptions.fromJson({
      'mode': 'other',
      'fit': 'other',
    });
    expect(cameraOptions.mode, CameraDisplayMode.grid);
    expect(cameraOptions.fit, CameraImageFit.contain);
    expect(
      SpecialScreenSchedule.fromJson({'type': 'other'}).type,
      SpecialScreenScheduleType.everyMediaSlides,
    );
  });
  test(
    'clock fonts and weekday have compatible defaults and enum fallbacks',
    () {
      for (final json in <Map<String, dynamic>>[
        {},
        {'timeFont': null, 'dateFont': null},
        {'timeFont': 'future-font', 'dateFont': 'future-font'},
        {'timeFont': 1, 'dateFont': true},
      ]) {
        final options = ClockScreenOptions.fromJson(json);
        expect(options.timeFont, ClockFont.system);
        expect(options.dateFont, ClockFont.system);
        expect(options.showWeekday, isFalse);
      }
      for (final font in ClockFont.values) {
        final screen = SpecialScreenConfig(
          id: 'clock',
          type: SpecialScreenType.clock,
          options: ClockScreenOptions(
            timeFont: font,
            dateFont: ClockFont.fredoka,
            showDate: false,
            showWeekday: true,
          ),
        );
        final cloned = screen.clone();
        final options = cloned.options as ClockScreenOptions;
        expect(options.timeFont, font);
        expect(options.dateFont, ClockFont.fredoka);
        expect(options.showWeekday, isTrue);
        expect(options.showDate, isFalse);
        expect(cloned.toJson(), screen.toJson());
        expect(
          SpecialScreenConfig.fromJson(screen.toJson()).toJson(),
          screen.toJson(),
        );
      }
    },
  );
  test(
    'camera timeout accepts finite milliseconds within the configured bounds',
    () {
      expect(CamerasScreenOptions().requestTimeoutMs, 10000);
      expect(CamerasScreenOptions.fromJson({}).requestTimeoutMs, 10000);
      for (final value in <dynamic>[
        null,
        -1,
        0,
        99,
        99.99,
        120001,
        double.nan,
        double.infinity,
        double.negativeInfinity,
        '1000',
        true,
        [],
        {},
      ]) {
        expect(
          CamerasScreenOptions.fromJson({'requestTimeoutMs': value})
              .requestTimeoutMs,
          10000,
          reason: 'Invalid timeout $value must use the default',
        );
      }
      for (final value in <num>[100, 250, 1000.9, 10000, 120000]) {
        final options = CamerasScreenOptions.fromJson({
          'requestTimeoutMs': value,
        });
        expect(options.requestTimeoutMs, value.toInt());
        expect(
          CamerasScreenOptions.fromJson(options.toJson()).requestTimeoutMs,
          value.toInt(),
        );
      }
    },
  );
  test(
    'AppConfig stores new options and strips them when reset to defaults',
    () {
      final config = AppConfig.fromJson({});
      final clockOptions = ClockScreenOptions(
        timeFont: ClockFont.orbitron,
        dateFont: ClockFont.roboto,
        showWeekday: true,
      );
      final cameraOptions = CamerasScreenOptions(requestTimeoutMs: 1500);
      config.slideshow.specialScreens.addAll([
        SpecialScreenConfig(
          id: 'clock',
          type: SpecialScreenType.clock,
          options: clockOptions,
        ),
        SpecialScreenConfig(
          id: 'cameras',
          type: SpecialScreenType.cameras,
          options: cameraOptions,
        ),
      ]);
      final compact = config.toStorageJson();
      expect(compact, {
        'slideshow': {
          'specialScreens': [
            {
              'id': 'clock',
              'type': 'clock',
              'options': {
                'timeFont': 'orbitron',
                'dateFont': 'roboto',
                'showWeekday': true,
              },
            },
            {
              'id': 'cameras',
              'type': 'cameras',
              'options': {'requestTimeoutMs': 1500},
            },
          ],
        },
      });
      expect(AppConfig.fromJson(compact).toJson(), config.toJson());
      clockOptions
        ..timeFont = ClockFont.system
        ..dateFont = ClockFont.system
        ..showWeekday = false;
      cameraOptions.requestTimeoutMs = 10000;
      expect(config.toStorageJson(), {
        'slideshow': {
          'specialScreens': [
            {'id': 'clock', 'type': 'clock'},
            {'id': 'cameras', 'type': 'cameras'},
          ],
        },
      });
    },
  );
  test(
    'old configuration has no special screens and saves without the section',
    () {
      final config = AppConfig.fromJson({});
      expect(config.slideshow.specialScreens, isEmpty);
      expect(
        stripDefaults(config.toJson(), AppConfig.fromJson({}).toJson()),
        isEmpty,
      );
    },
  );
  test(
    'clock storage retains identity and differences, including explicit false',
    () {
      final clock = SpecialScreenConfig.fromJson({
        'id': 'clock',
        'type': 'clock',
        'enabled': true,
        'options': {'showDate': false},
      });
      expect(clock.toJson(), {
        'id': 'clock',
        'type': 'clock',
        'enabled': true,
        'options': {'showDate': false},
      });
      expect(
        SpecialScreenConfig.fromJson(clock.toJson()).toJson(),
        clock.toJson(),
      );
    },
  );
  test('typed interval defaults are omitted and correctly restored', () {
    final clock = SpecialScreenConfig(
      id: 'clock',
      type: SpecialScreenType.clock,
      schedule: SpecialScreenSchedule(type: SpecialScreenScheduleType.interval),
    );
    final compact = clock.toJson();
    expect(compact['schedule'], {'type': 'interval'});
    expect(SpecialScreenConfig.fromJson(compact).schedule.intervalMs, 300000);
    expect(SpecialScreenConfig.fromJson(compact).toJson(), clock.toJson());
  });
  test(
    'camera defaults are stripped per item, while order and sources survive',
    () {
      final screen = SpecialScreenConfig(
        id: 'cameras',
        type: SpecialScreenType.cameras,
        options: CamerasScreenOptions(
          mode: CameraDisplayMode.sequence,
          showNames: false,
          refreshIntervalMs: 0,
          cameras: [
            CameraConfig(id: 'a', url: 'http://cam/a.jpg'),
            CameraConfig(id: 'b', name: 'Back', url: 'https://cam/b.png'),
          ],
        ),
      );
      final compact = screen.toJson();
      expect(compact['options'], {
        'mode': 'sequence',
        'showNames': false,
        'refreshIntervalMs': 0,
        'cameras': [
          {'id': 'a', 'url': 'http://cam/a.jpg'},
          {'id': 'b', 'name': 'Back', 'url': 'https://cam/b.png'},
        ],
      });
      expect(SpecialScreenConfig.fromJson(compact).toJson(), screen.toJson());
      expect((screen.options as CamerasScreenOptions).columns, 0);
      expect(screen.toJson()['options'], isNot(contains('columns')));
    },
  );
  test('file save and reload preserves multiple typed screens', () {
    final directory = Directory.systemTemp.createTempSync(
      'special-screen-config-',
    );
    addTearDown(() => directory.deleteSync(recursive: true));
    final config = AppConfig.fromJson({});
    config.slideshow.specialScreens.addAll([
      SpecialScreenConfig(
        id: 'clock',
        type: SpecialScreenType.clock,
        enabled: true,
      ),
      SpecialScreenConfig(
        id: 'cam',
        type: SpecialScreenType.cameras,
        options: CamerasScreenOptions(
          cameras: [
            CameraConfig(id: 'door', url: 'https://cam/snapshot?token=abc'),
          ],
        ),
      ),
    ]);
    final filename = '${directory.path}/config.json';
    config.toFile(filename);
    final saved = jsonDecode(File(filename).readAsStringSync()) as Map;
    final screens = (saved['slideshow'] as Map)['specialScreens'] as List;
    expect(screens[0], {'id': 'clock', 'type': 'clock', 'enabled': true});
    final restored = AppConfig.fromFile(directory.path);
    expect(restored.slideshow.toJson(), config.slideshow.toJson());
  });
  test('unknown and missing screen types are excluded while supported entries retain order and IDs', () {
    final config = SlideShowConfig.fromJson({
      'specialScreens': [
        {
          'id': 'same',
          'type': 'weather',
          'options': {'provider': 'later'},
        },
        {'id': 'same', 'type': 'clock', 'enabled': true},
        {'id': 'missing'},
        {'id': 'explicit', 'type': 'unknown'},
        {'id': 'bad', 'type': 42},
        {'id': 'cameras', 'type': 'cameras'},
        {'id': 'same', 'type': 'clock'},
      ],
    });
    expect(config.specialScreens.map((s) => s.type), [
      SpecialScreenType.clock,
      SpecialScreenType.cameras,
      SpecialScreenType.clock,
    ]);
    expect(config.specialScreens.first.id, 'same');
    expect(config.specialScreens.map((s) => s.id).toSet(), hasLength(3));
    expect(SlideShowConfig.fromJson(config.toJson()).toJson(), config.toJson());
    final empty = AppConfig.fromJson({
      'slideshow': {
        'specialScreens': [
          {'id': 'future', 'type': 'weather'},
        ],
      },
    });
    expect(empty.slideshow.specialScreens, isEmpty);
    expect(empty.toStorageJson(), isEmpty);
    expect(
      () => SpecialScreenConfig.fromJson({'id': 'future', 'type': 'weather'}),
      throwsFormatException,
    );
  });

  test(
    'invalid timing and sizes fall back; camera URL schemes are constrained',
    () {
      final screen = SpecialScreenConfig.fromJson({
        'id': 'clock',
        'type': 'clock',
        'displayTimeMs': -1,
        'schedule': {'count': 0},
        'options': {'timeFontSizePercent': -20},
      });
      expect(screen.displayTimeMs, 10000);
      expect(screen.schedule.count, 10);
      expect((screen.options as ClockScreenOptions).timeFontSizePercent, 50);
      expect(
        CameraConfig(id: 'x', url: 'rtsp://camera/live').hasValidUrl,
        false,
      );
      expect(
        CameraConfig(id: 'x', url: 'http://camera/snapshot?x=1').hasValidUrl,
        true,
      );
    },
  );
}
