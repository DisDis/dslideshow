import 'dart:math' as math;

import 'package:dslideshow_flutter/effect.dart';
import 'package:flutter/material.dart';

import 'composition_reference.dart';

/// Frozen controls are opt-in and never expand the normal effect matrix.
enum CompositionProbe {
  accordionReference,
  accordionGrouped,
  liquidReference,
  accordionNoShadow,
  liquidNoScale,
  liquidNoClip,
  liquidBounded,
  liquidRectTail;

  String get effectName => 'CompositionProbe-$name';

  Effect get effect => switch (this) {
    accordionReference ||
    accordionGrouped ||
    accordionNoShadow => Effect.accordionEffect,
    _ => Effect.liquidMorphEffect,
  };

  MediaSliderItemEffect createEffect() => switch (this) {
    accordionReference => ReferenceAccordionEffect(),
    accordionGrouped => _GroupedAccordionProbe(),
    liquidReference => ReferenceLiquidMorphEffect(),
    _ => _CompositionDiagnostic(this),
  };
}

/// Component removals deliberately change the picture and are diagnostics only.
/// liquidBounded is a candidate: only content outside the viewport is clipped.
class _CompositionDiagnostic extends MediaSliderItemEffect {
  final CompositionProbe probe;
  final _accordion = ReferenceAccordionEffect();
  final _liquid = Effect.liquidMorphEffect.createEffect();
  _CompositionDiagnostic(this.probe);

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
  ) {
    final source =
        (probe == CompositionProbe.accordionNoShadow ? _accordion : _liquid)
                .createTransformWidget(
                  context,
                  currentWidget,
                  nextWidget,
                  controller,
                  screenW,
                  screenH,
                )
            as Stack;
    final children = switch (probe) {
      CompositionProbe.accordionNoShadow => [
        source.children[0],
        source.children[2],
      ],
      CompositionProbe.liquidNoScale => [currentWidget, source.children[1]],
      CompositionProbe.liquidNoClip => [source.children[0], nextWidget],
      CompositionProbe.liquidBounded => [
        ClipRect(child: source.children[0]),
        source.children[1],
      ],
      CompositionProbe.liquidRectTail => [
        source.children[0],
        ClipPath(
          clipper: _RectTailClipper(
            controller.value,
            (source.children[1] as ClipPath).clipper!,
          ),
          child: nextWidget,
        ),
      ],
      _ => throw StateError('Not a component probe'),
    };
    return Stack(fit: StackFit.expand, children: children);
  }
}

class _RectTailClipper extends CustomClipper<Path> {
  final double t;
  final CustomClipper<Path> original;
  _RectTailClipper(this.t, this.original);

  @override
  Path getClip(Size size) {
    final diagonal = math.sqrt(
      size.width * size.width + size.height * size.height,
    );
    // Default effect intensity is 15. Every original vertex lies outside this
    // circle, and each edge spans <= .05 radians. Leave a full logical pixel
    // outside the viewport for AA before replacing the already-covered region.
    final innerRadius = (diagonal / 1.8 * t - 15 * (1 - t)) * math.cos(.025);
    if (t > 0 && innerRadius > diagonal / 2 + 1) {
      return Path()..addRect(Offset.zero & size);
    }
    return original.getClip(size);
  }

  @override
  bool shouldReclip(_RectTailClipper old) =>
      t != old.t || original.shouldReclip(old.original);
}

// Rejected for production: UI improvement did not repeat in the reverse A/B.

class _GroupedAccordionProbe extends MediaSliderItemEffect {
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
  ) {
    final progress = controller.value;
    Widget panel(
      Widget media,
      Alignment alignment,
      double scale,
      double shadow,
    ) {
      return Align(
        alignment: alignment,
        child: Transform(
          alignment: alignment,
          transform: Matrix4.identity()..scaleByDouble(scale, 1.0, scale, 1.0),
          child: SizedBox(
            width: screenW,
            height: screenH,
            child: Stack(
              fit: StackFit.expand,
              children: [
                media,
                ColoredBox(
                  color: Colors.black.withAlpha((255 * shadow).round()),
                ),
              ],
            ),
          ),
        ),
      );
    }

    // Media and its shadow share exactly the same transform. Keep the full
    // layout size, sampling, 8-bit shadow rounding and both source states.
    return Stack(
      fit: StackFit.expand,
      children: [
        panel(currentWidget, Alignment.centerLeft, 1 - progress, progress * .5),
        panel(nextWidget, Alignment.centerRight, progress, (1 - progress) * .5),
      ],
    );
  }
}
