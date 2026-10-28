import 'dart:async';

import 'package:dslideshow_flutter/src/effect/effect_slide_input.dart';
import 'package:flutter/widgets.dart';
import 'package:logging/logging.dart';

import '../bloc/slideshow_slide.dart';
import '../widgets/image_widget.dart';
import '../widgets/photo_motion.dart';
import '../widgets/slideshow_loader_widget.dart';
import '../widgets/special_screen_renderers.dart';
import '../widgets/video_widget.dart';
import 'cameras_screen_session.dart';
import 'special_screen_session.dart';

enum SlideSessionRole { pending, current, outgoing, incoming }

/// Owns one slide's resources independently of its views in a transition.
/// The renderer owns this session from creation, including during preparation.
abstract class SlideSession {
  Future<bool>? _preparation;
  Future<void>? _disposal;
  bool _disposed = false;

  bool get disposed => _disposed;
  Widget get view;

  /// Capture once before a transition; this session retains resource ownership.
  EffectSlideInput createEffectInput(Size size) => EffectSlideInput(view: view);
  bool get cancelPreparationOnSleep => false;

  Future<bool> prepare(BuildContext context) {
    if (_disposed) return Future.value(false);
    return _preparation ??= _prepare(context);
  }

  Future<bool> _prepare(BuildContext context) async {
    final ready = await prepareContents(context);
    return ready && !_disposed;
  }

  @protected
  Future<bool> prepareContents(BuildContext context);

  /// Called only after the renderer accepts this preparation's generation.
  void commitPreparation() {}

  void setActivity({
    required SlideSessionRole role,
    required bool playing,
    required bool screenOn,
  });

  /// Releases tickers, timers and images synchronously, then awaits native I/O.
  Future<void> dispose() {
    if (_disposal case final disposal?) return disposal;
    _disposed = true;
    return _disposal = Future<void>.sync(disposeResources);
  }

  @protected
  FutureOr<void> disposeResources();
}

class ImageSlideSession extends SlideSession {
  final ImageWidget image;
  final Size size;
  final PhotoMotionSession Function()? createMotion;
  PhotoMotionSession? _motion;
  Widget _view = slideShowLoaderWidget;

  ImageSlideSession({
    required this.image,
    required this.size,
    this.createMotion,
  });

  @override
  Widget get view => _view;

  @override
  EffectSlideInput createEffectInput(Size size) {
    final bitmap = image.preparedBitmap;
    return EffectSlideInput(
      view: view,
      photo: bitmap == null
          ? null
          : PreparedPhoto(
              bitmap: bitmap,
              camera: PhotoCamera.fromMatrix(
                _motion?.path.transform(size, _motion!.progress),
              ),
            ),
    );
  }

  @override
  Future<bool> prepareContents(BuildContext context) async {
    await image.precache(context);
    if (disposed) return false;
    _motion = createMotion?.call();
    _view = SizedBox(
      width: size.width,
      height: size.height,
      child: _motion?.view(image) ?? image,
    );
    return true;
  }

  @override
  void setActivity({
    required SlideSessionRole role,
    required bool playing,
    required bool screenOn,
  }) {
    if (disposed) return;
    _motion?.setPlaying(
      playing && screenOn && role == SlideSessionRole.current,
    );
  }

  @override
  void disposeResources() {
    _motion?.dispose();
    image.dispose();
    _view = slideShowLoaderWidget;
  }
}

class VideoSlideSession extends SlideSession {
  static final _log = Logger('VideoSlideSession');
  final VideoSession video;
  @override
  final Widget view;

  VideoSlideSession({required this.video, required this.view});

  @override
  Future<bool> prepareContents(BuildContext context) async {
    await video.prepare();
    return !disposed;
  }

  @override
  void setActivity({
    required SlideSessionRole role,
    required bool playing,
    required bool screenOn,
  }) {
    if (disposed || role == SlideSessionRole.pending) return;
    unawaited(
      video.setPlaying(playing && screenOn).catchError((
        Object e,
        StackTrace st,
      ) {
        _log.warning('Video playback failed', e, st);
      }),
    );
  }

  @override
  Future<void> disposeResources() => video.dispose();
}

class SpecialSlideSession extends SlideSession {
  final SpecialSlide _slide;
  final SpecialScreenSession? _screen;
  final SpecialScreenRenderer? _renderer;
  final Size size;
  Widget _view = slideShowLoaderWidget;

  SpecialSlideSession({
    required SpecialSlide slide,
    required SpecialScreenRenderer? renderer,
    required this.size,
  }) : _slide = slide,
       _renderer = renderer,
       _screen = renderer?.createSession(slide.config, slide.cameraIndex);

  @override
  Widget get view => _view;

  @override
  bool get cancelPreparationOnSleep => true;

  @override
  Future<bool> prepareContents(BuildContext context) async {
    final screen = _screen;
    if (screen == null || !await screen.prepare() || disposed) return false;
    _view = SizedBox(
      width: size.width,
      height: size.height,
      child: _renderer!.build(screen),
    );
    return true;
  }

  @override
  void commitPreparation() {
    if (disposed) return;
    if (_screen case CamerasScreenSession screen) {
      _slide.cameraIndex = screen.cameraIndex;
    }
  }

  @override
  void setActivity({
    required SlideSessionRole role,
    required bool playing,
    required bool screenOn,
  }) {
    // Deactivating a preparing camera cancels its requests, even if it was
    // already inactive. Pending preparation is cancelled by its owner on sleep.
    if (disposed || role == SlideSessionRole.pending) return;
    _screen?.setActive(screenOn);
  }

  @override
  void disposeResources() {
    _screen?.dispose();
    _view = slideShowLoaderWidget;
  }
}

class PlaceholderSlideSession extends SlideSession {
  @override
  Widget get view => slideShowLoaderWidget;

  @override
  Future<bool> prepareContents(BuildContext context) async => true;

  @override
  void setActivity({
    required SlideSessionRole role,
    required bool playing,
    required bool screenOn,
  }) {}

  @override
  void disposeResources() {}
}
