import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_backend/src/service/hardware/hardware.dart';
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
          "isBlurredBackground": false
        }
      };

      final _config = new AppConfig.fromJson(testData);
      expect(_config.slideshow.allowedEffects, equals(['Fade']));
    });

    group('SlideShowConfig', () {
      test('parse allowedEffects', () {
        final _slideShowConfig = new SlideShowConfig.fromJson(<String, dynamic>{
          'allowedEffects': ['Fade']
        });
        expect(_slideShowConfig.allowedEffects, equals(['Fade']));
      });
    });

    group('HardwareConfigJ', () {
      test('pinPIRSensor', () {
        final _config = new HardwareConfig.fromJson(<String, dynamic>{});
        expect(_config.pinPIRSensor, equals(15));
      });
    });
    group('AppConfig', () {
      test('log', () {
        final _config = new AppConfig.fromJson(<String, dynamic>{});
        expect(_config.log.levelMain, equals(Level.ALL));
      });
    });
  });
}
