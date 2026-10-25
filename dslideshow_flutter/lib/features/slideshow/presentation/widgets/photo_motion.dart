import 'package:dslideshow_backend/config.dart';
import 'package:flutter/material.dart';

import 'fixed_animation_controller.dart';

/// A stable camera trajectory. Motion crops only the already-prepared viewport;
/// it never changes decoding resolution, sampling quality or the media clock.
class PhotoMotionPath {
  // Up to 15% zoom: retain spare prepared pixels instead of magnifying a
  // display-sized intermediate and losing original detail.
  static const preparationScale = 1.25;

  static int seedFor(String identity) => identity.runes.fold(
    0x811c9dc5,
    (value, rune) => ((value ^ rune) * 0x01000193) & 0x7fffffff,
  );
  final double maxZoom;
  final Offset direction;

  PhotoMotionPath({double maxZoom = 1.06, int seed = 0})
    : maxZoom = maxZoom.isFinite ? maxZoom.clamp(1.0, 1.15) : 1.06,
      direction = Offset(seed.isEven ? .7 : -.7, seed % 3 == 0 ? .45 : -.45);

  Matrix4 transform(Size size, double progress) {
    final t = Curves.easeInOut.transform(progress.clamp(0.0, 1.0));
    final scale = 1 + (maxZoom - 1) * t;
    return Matrix4.identity()
      ..translateByDouble(
        direction.dx * (scale - 1) * size.width / 2,
        direction.dy * (scale - 1) * size.height / 2,
        0,
        1,
      )
      ..scaleByDouble(scale, scale, 1, 1);
  }
}

class PhotoMotionFrame extends StatelessWidget {
  final PhotoMotionPath path;
  final double progress;
  final Widget child;
  const PhotoMotionFrame({
    super.key,
    required this.path,
    required this.progress,
    required this.child,
  });

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) => ClipRect(
      child: Transform(
        alignment: Alignment.center,
        transform: path.transform(constraints.biggest, progress),
        child: child,
      ),
    ),
  );
}

/// Owned alongside a prepared image, not by its position in the widget tree.
/// Reparenting into a transition therefore cannot reset the camera or ticker.
class PhotoMotionSession {
  final FixedAnimationController _controller;
  final PhotoMotionPath path;
  bool _disposed = false;

  PhotoMotionSession({
    required TickerProvider vsync,
    required Duration duration,
    required PhotoMotionConfig config,
    required int seed,
  }) : path = PhotoMotionPath(maxZoom: config.maxZoom, seed: seed),
       _controller = FixedAnimationController(
         vsync: vsync,
         duration: duration > Duration.zero
             ? duration
             : const Duration(milliseconds: 1),
         animationBehavior: AnimationBehavior.preserve,
       );

  double get progress => _controller.value;

  void setPlaying(bool playing) {
    if (_disposed) return;
    if (playing && !_controller.isAnimating && _controller.value < 1) {
      _controller.forward();
    } else if (!playing && _controller.isAnimating) {
      _controller.stop(canceled: false);
    }
  }

  Widget view(Widget child) => AnimatedBuilder(
    animation: _controller,
    child: child,
    builder: (context, child) => PhotoMotionFrame(
      path: path,
      progress: _controller.value,
      child: child!,
    ),
  );

  void dispose() {
    if (_disposed) return;
    _disposed = true;
    _controller.dispose();
  }
}
