import 'support/storage_sections.dart';

import 'package:dslideshow_backend/config.dart';
import 'package:test/test.dart';

void main() {
  test('photo motion defaults safely and round trips typed configuration', () {
    for (final value in [
      null,
      'invalid',
      [],
      {'mode': 'future', 'maxZoom': 'bad'},
    ]) {
      final config = SlideShowConfig.fromJson({'photoMotion': value});
      expect(config.photoMotion.mode, PhotoMotionMode.off);
      expect(config.photoMotion.maxZoom, 1.06);
    }
    final config = AppConfig.fromJson({
      'slideshow': {
        'photoMotion': {'mode': 'kenBurns', 'maxZoom': 1.12},
      },
    });
    expect(config.slideshow.photoMotion.mode, PhotoMotionMode.kenBurns);
    expect(otherStorageSections(config), {
      'slideshow': {
        'photoMotion': {'mode': 'kenBurns', 'maxZoom': 1.12},
      },
    });
    expect(
      AppConfig.fromJson(otherStorageSections(config))
          .slideshow
          .photoMotion
          .maxZoom,
      1.12,
    );
    config.slideshow.photoMotion = PhotoMotionConfig();
    expect(otherStorageSections(config), isEmpty);
  });
  test('zoom is bounded without accepting non-finite numbers', () {
    for (final (input, expected) in [
      (2.0, 1.15),
      (0.0, 1.0),
      (double.nan, 1.06),
      (double.infinity, 1.06),
    ]) {
      expect(PhotoMotionConfig.fromJson({'maxZoom': input}).maxZoom, expected);
      expect(PhotoMotionConfig(maxZoom: input).maxZoom, expected);
    }
  });
}
