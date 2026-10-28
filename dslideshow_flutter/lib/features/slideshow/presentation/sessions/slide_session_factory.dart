import 'dart:io';

import 'package:dslideshow_backend/config.dart';
import 'package:flutter/widgets.dart';

import '../bloc/slideshow_slide.dart';
import '../widgets/image_widget.dart';
import '../widgets/photo_motion.dart';
import '../widgets/special_screen_renderers.dart';
import '../widgets/video_widget.dart';
import 'slide_session.dart';

/// Creates slide owners; platform video allocation can be supplied separately.
class SlideSessionFactory {
  final VideoSession Function(File) createVideo;

  const SlideSessionFactory({this.createVideo = VideoSession.new});

  SlideSession create(
    SlideshowSlide slide, {
    required SlideShowConfig config,
    required Size size,
    required double pixelRatio,
    required TickerProvider vsync,
  }) {
    if (slide is SpecialSlide) {
      return SpecialSlideSession(
        slide: slide,
        renderer: SpecialScreenRenderers.definitions[slide.config.type],
        size: size,
      );
    }
    final item = (slide as MediaSlide).item;
    if (item.uri == null) return PlaceholderSlideSession();
    if (item.isVideo) {
      final video = createVideo(File(item.uri!.toFilePath()));
      return VideoSlideSession(
        video: video,
        view: SizedBox(
          width: size.width,
          height: size.height,
          child: VideoWidget(item, session: video),
        ),
      );
    }
    final moving = config.photoMotion.mode == PhotoMotionMode.kenBurns;
    final image = ImageWidget(
      item,
      config,
      size,
      pixelRatio: pixelRatio * (moving ? PhotoMotionPath.preparationScale : 1),
    );
    return ImageSlideSession(
      image: image,
      size: size,
      createMotion: moving && !image.isGif
          ? () => PhotoMotionSession(
              vsync: vsync,
              duration: Duration(milliseconds: config.displayTimeMs),
              config: config.photoMotion,
              seed: PhotoMotionPath.seedFor(item.id ?? item.uri.toString()),
            )
          : null,
    );
  }
}
