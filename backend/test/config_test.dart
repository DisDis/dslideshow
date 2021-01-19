import 'dart:convert';

import 'package:dslideshow_backend/config.dart';
import 'package:test/test.dart';

void main() {
  group('AppConfig', () {
    test('parse test config', () {
      final testData = {"slideshow": {
      "displayTimeMs": 5000,
      "fadeTimeMs": 2000,
      "transitionTimeMs": 1000,
      "allowedEffects": ["Fade"],
      "isBlurredBackground": false
      }};

      final _config = new AppConfig.json(json.encode(testData));
      expect(_config.slideshow.allowedEffects, equals(['Fade']));
    });

  group('SlideShowConfig', () {
    test('parse allowedEffects', () {
      final _slideShowConfig = new SlideShowConfig(<String,dynamic>{'allowedEffects': ['Fade']});
      expect(_slideShowConfig.allowedEffects, equals(['Fade']));
    });
  });
  });
}