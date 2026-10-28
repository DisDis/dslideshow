import 'package:dslideshow_flutter/effect.dart';
import 'package:flutter/material.dart';

/// Quality-changing matrix-filter experiment, pending hardware and visual review.
/// The original effect still owns its formulas, curves, clips and blur. Only its
/// scaling transforms use a retained ImageFilter matrix at high sampling quality.
class OptimizedStretchEffect extends _RetainedScalingEffect {
  OptimizedStretchEffect({
    StretchEffectOptions options = const StretchEffectOptions(),
  }) : super(Effect(EffectType.stretch, options: options).createEffect());
}

/// Experimental ZoomOver/CrossZoom sampling; not a production replacement.
class OptimizedZoomOverEffect extends _RetainedScalingEffect {
  OptimizedZoomOverEffect({
    ZoomOverEffectOptions options = const ZoomOverEffectOptions(),
  }) : super(Effect(EffectType.zoomOver, options: options).createEffect());
}

/// Null leaves every other effect on its ordinary production implementation.
MediaSliderItemEffect? createRetainedTransformExperiment(Effect configuration) {
  final effect = configuration.canonical;
  return switch (effect.type) {
    EffectType.stretch => OptimizedStretchEffect(
      options: effect.options as StretchEffectOptions,
    ),
    EffectType.zoomOver => OptimizedZoomOverEffect(
      options: effect.options as ZoomOverEffectOptions,
    ),
    _ => null,
  };
}

abstract class _RetainedScalingEffect extends MediaSliderItemEffect {
  _RetainedScalingEffect(this.original);

  final MediaSliderItemEffect original;

  @override
  Future<void> prepare() => original.prepare();

  @override
  Widget transform(
    BuildContext context,
    Widget page,
    bool isCurrentPage,
    double pageDelta,
    double screenW,
    double screenH,
  ) => page;

  @override
  Widget createTransformWidget(
    BuildContext context,
    Widget currentWidget,
    Widget nextWidget,
    Animation<double> controller,
    double screenW,
    double screenH,
  ) => _filteredScaling(
    original.createTransformWidget(
      context,
      currentWidget,
      nextWidget,
      controller,
      screenW,
      screenH,
    ),
  );
}

// Stop at the effect's Transform: its child is a borrowed live-media subtree,
// including any caller-owned transforms, repaint boundaries and image handles.
// Never snapshot, clone, dispose or rewrite that subtree.
Widget _filteredScaling(Widget widget) => switch (widget) {
  Transform() => Transform(
    key: widget.key,
    transform: widget.transform,
    origin: widget.origin,
    alignment: widget.alignment,
    transformHitTests: widget.transformHitTests,
    filterQuality: FilterQuality.high,
    child: widget.child,
  ),
  Stack() => Stack(
    key: widget.key,
    alignment: widget.alignment,
    textDirection: widget.textDirection,
    fit: widget.fit,
    clipBehavior: widget.clipBehavior,
    children: widget.children.map(_filteredScaling).toList(),
  ),
  ClipRect() => ClipRect(
    key: widget.key,
    clipper: widget.clipper,
    clipBehavior: widget.clipBehavior,
    child: _filteredScaling(widget.child!),
  ),
  Opacity() => Opacity(
    key: widget.key,
    opacity: widget.opacity,
    alwaysIncludeSemantics: widget.alwaysIncludeSemantics,
    child: _filteredScaling(widget.child!),
  ),
  ImageFiltered() => ImageFiltered(
    key: widget.key,
    imageFilter: widget.imageFilter,
    enabled: widget.enabled,
    child: _filteredScaling(widget.child!),
  ),
  CustomPaint() => CustomPaint(
    key: widget.key,
    painter: widget.painter,
    foregroundPainter: widget.foregroundPainter,
    size: widget.size,
    isComplex: widget.isComplex,
    willChange: widget.willChange,
    child: _filteredScaling(widget.child!),
  ),
  RotatedBox() => RotatedBox(
    key: widget.key,
    quarterTurns: widget.quarterTurns,
    child: _filteredScaling(widget.child!),
  ),
  _ => widget,
};
