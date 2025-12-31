import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_backend/src/service/hardware/hardware.dart';
import 'package:dslideshow_backend/src/service/storage/disk/disk_storage_config.dart';
import 'package:dslideshow_backend/src/service/storage/googlephoto/gphoto_storage_config.dart';
import 'package:dslideshow_backend/src/service/storage/storages_config.dart';
import 'package:logging/logging.dart';
import 'package:test/test.dart';

void main() {
  group('AppConfig', () {
    test('parse test config', () {
      final testData = {
        "slideshow": {
          "displayTimeMs": 5000,
          "fadeTimeMs": 2000,
          "transitionTimeMs": 1000,
          "allowedEffects": ["Fade"],
          "isBlurredBackground": false,
        },
      };

      final _config = new AppConfig.fromJson(testData);
      expect(_config.slideshow.allowedEffects, equals(['Fade']));
    });

    test('parse button', () {
      final testData = {
        "action": "SlideshowAction.toggleScreen",
        "minPressingMs": 3000,
      };

      final _config = SlideShowButtonConfig.fromJson(testData);
      expect(_config.action, SlideshowAction.toggleScreen);
      expect(_config.minPressingMs, 3000);
    });

    test('parse default buttons', () {
      final testData = <String, Map>{};

      final _config = SlideShowConfig.fromJson(testData);
      expect(_config.buttons.button0.action, SlideshowAction.showInfo);
      expect(_config.buttons.button0.minPressingMs, 500);
    });

    group('SlideShowConfig', () {
      test('parse allowedEffects', () {
        final _slideShowConfig = new SlideShowConfig.fromJson(<String, dynamic>{
          'allowedEffects': ['Fade'],
        });
        expect(_slideShowConfig.allowedEffects, equals(['Fade']));
      });
    });

    group('HardwareConfig', () {
      test('pinPeopleSensor', () {
        final _config = new HardwareConfig.fromJson(<String, dynamic>{});
        expect(_config.pinPeopleSensor, equals(12));
      });
    });
    group('AppConfig', () {
      test('log', () {
        final _config = new AppConfig.fromJson(<String, dynamic>{});
        expect(_config.log.levelMain, equals(Level.INFO));
      });
    });
    group('Storages', () {
      test('GPhotoStorageConfig', () {
        final _config = new GPhotoStorageConfig.fromJson(<String, dynamic>{
          "syncPeriod": 60,
          "albumNames": ["TEST_slide1", "TEST_slide2"],
          "refreshToken": "123456",
          "clientId": {"identifier": "id", "secret": "secret123"},
        });
        expect(_config.albumNames, equals(["TEST_slide1", "TEST_slide2"]));
        expect(_config.syncPeriod, equals(Duration(seconds: 60)));
        expect(_config.refreshToken, equals('123456'));
        expect(_config.clientId.identifier, equals('id'));
        expect(_config.clientId.secret, equals('secret123'));
        expect(_config.name, equals(StorageType.GPhotoStorage));
      });

      test('DiskStorageConfig', () {
        final _config = new DiskStorageConfig.fromJson(<String, dynamic>{});
        expect(_config.name, equals(StorageType.DiskStorage));
      });

      test('StoragesConfig', () {
        final _config = new StoragesConfig.fromJson(<String, dynamic>{
          "selected": "GPhotoStorage",
          "storages": {
            "GPhotoStorage": {
              "syncPeriod": 60,
              "albumNames": ["TEST_slide"],
              "refreshToken": "123456",
              "clientId": {"identifier": "id", "secret": "secret123"},
            },
          },
        });
        expect(_config.selected, equals(StorageType.GPhotoStorage));
        final storage = _config.getOrCreateEmpty(_config.selected);
        expect(storage.runtimeType, equals(GPhotoStorageConfig));
        final gstorage = storage as GPhotoStorageConfig;
        expect(gstorage.refreshToken, equals("123456"));
      });
    });
  });
}
