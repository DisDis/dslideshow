import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_backend/storage.dart';
import 'package:path/path.dart' as path;
import 'package:dslideshow_flutter/src/effect/transition_media.dart';

sealed class SlideshowSlide {
  const SlideshowSlide();
  TransitionMedia get transitionMedia;
}

class MediaSlide extends SlideshowSlide {
  final MediaItem item;
  const MediaSlide(this.item);
  @override
  TransitionMedia get transitionMedia => item.isVideo
      ? TransitionMedia.video
      : path.extension(item.uri?.path ?? item.id ?? '').toLowerCase() == '.gif'
      ? TransitionMedia.animatedImage
      : TransitionMedia.photo;
}

class SpecialSlide extends SlideshowSlide {
  final SpecialScreenConfig config;
  int cameraIndex;
  SpecialSlide(this.config, {this.cameraIndex = 0});
  @override
  TransitionMedia get transitionMedia => TransitionMedia.special;
}
