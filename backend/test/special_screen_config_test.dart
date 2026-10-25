import 'dart:convert';
import 'dart:io';

import 'package:dslideshow_backend/config.dart';
import 'package:test/test.dart';

void main() {
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
      expect(clock.toStorageJson(stripDefaults), {
        'id': 'clock',
        'type': 'clock',
        'enabled': true,
        'options': {'showDate': false},
      });
      expect(
        SpecialScreenConfig.fromJson(clock.toStorageJson(stripDefaults))
            .toJson(),
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
    final compact = clock.toStorageJson(stripDefaults);
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
      final compact = screen.toStorageJson(stripDefaults);
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
      expect((screen.toJson()['options'] as Map)['columns'], 0);
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
  test('unknown screen options survive a round trip and stay unsupported', () {
    final screen = SpecialScreenConfig.fromJson({
      'id': 'future',
      'type': 'weather',
      'options': {'provider': 'later'},
    });
    expect(screen.isSupported, false);
    expect(screen.toStorageJson(stripDefaults)['options'], {
      'provider': 'later',
    });
    expect(screen.toStorageJson(stripDefaults), {
      'id': 'future',
      'type': 'weather',
      'options': {'provider': 'later'},
    });
    expect(
      SpecialScreenConfig.fromJson(screen.toStorageJson(stripDefaults))
          .toJson(),
      screen.toJson(),
    );
    final empty = SpecialScreenConfig.fromJson({
      'id': 'empty',
      'type': 'weather',
      'options': <String, dynamic>{},
    });
    expect(empty.toStorageJson(stripDefaults), {
      'id': 'empty',
      'type': 'weather',
      'options': <String, dynamic>{},
    });
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
      expect((screen.options as ClockScreenOptions).timeFontSizePercent, 20);
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
