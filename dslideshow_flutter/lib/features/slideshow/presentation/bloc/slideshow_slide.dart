import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_backend/storage.dart';

sealed class SlideshowSlide {
  const SlideshowSlide();
}

class MediaSlide extends SlideshowSlide {
  final MediaItem item;
  const MediaSlide(this.item);
}

class SpecialSlide extends SlideshowSlide {
  final SpecialScreenConfig config;
  int cameraIndex;
  SpecialSlide(this.config, {this.cameraIndex = 0});
}
