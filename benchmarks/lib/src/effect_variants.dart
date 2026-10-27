import 'package:dslideshow_flutter/effect.dart';

// Former catalog entries expressed as settings; every former visual case stays covered.
const benchmarkEffects = <Effect>[
  Effect.noiseDissolveEffect,
  Effect.rippleRevealEffect,
  Effect.waterRefractionEffect,
  Effect.cubeEffect,
  Effect.accordionEffect,
  Effect.backgroundToForegroundEffect,
  Effect.foregroundToBackgroundEffect,
  Effect(EffectType.slide, options: SlideEffectOptions()),
  Effect.depthEffect,
  Effect(EffectType.flip, options: FlipEffectOptions()),
  Effect(
    EffectType.flip,
    options: FlipEffectOptions(axis: EffectAxis.vertical),
  ),
  Effect.parallaxEffect,
  Effect.stackEffect,
  Effect.tabletEffect,
  Effect(
    EffectType.rotate,
    options: RotateEffectOptions(edge: RotationEdge.bottom),
  ),
  Effect(EffectType.rotate, options: RotateEffectOptions()),
  Effect.zoomOutSlideEffect,
  Effect.fadeEffect,
  Effect(EffectType.mosaic, options: MosaicEffectOptions(fadeFraction: 0)),
  Effect(EffectType.mosaic, options: MosaicEffectOptions()),
  Effect(
    EffectType.mosaic,
    options: MosaicEffectOptions(direction: MosaicDirection.topLeft),
  ),
  Effect(
    EffectType.mosaic,
    options: MosaicEffectOptions(direction: MosaicDirection.bottomRight),
  ),
  Effect.liquidMorphEffect,
  Effect.blindsEffect,
  Effect.blurFadeEffect,
  Effect.zoomOverEffect,
  Effect(
    EffectType.mosaic,
    options: MosaicEffectOptions(direction: MosaicDirection.topRight),
  ),
  Effect(
    EffectType.mosaic,
    options: MosaicEffectOptions(direction: MosaicDirection.bottomLeft),
  ),
  Effect(
    EffectType.revealMask,
    options: RevealMaskEffectOptions(direction: EffectDirection.left),
  ),
  Effect(
    EffectType.revealMask,
    options: RevealMaskEffectOptions(direction: EffectDirection.right),
  ),
  Effect(
    EffectType.revealMask,
    options: RevealMaskEffectOptions(direction: EffectDirection.up),
  ),
  Effect(
    EffectType.revealMask,
    options: RevealMaskEffectOptions(direction: EffectDirection.down),
  ),
  Effect(
    EffectType.revealMask,
    options: RevealMaskEffectOptions(
      shape: RevealShape.curtain,
      axis: EffectAxis.horizontal,
    ),
  ),
  Effect(
    EffectType.revealMask,
    options: RevealMaskEffectOptions(
      shape: RevealShape.curtain,
      axis: EffectAxis.vertical,
    ),
  ),
  Effect(
    EffectType.revealMask,
    options: RevealMaskEffectOptions(
      shape: RevealShape.diagonal,
      origin: EffectOrigin.topLeft,
    ),
  ),
  Effect(
    EffectType.revealMask,
    options: RevealMaskEffectOptions(
      shape: RevealShape.diagonal,
      origin: EffectOrigin.topRight,
    ),
  ),
  Effect(
    EffectType.revealMask,
    options: RevealMaskEffectOptions(
      shape: RevealShape.diagonal,
      origin: EffectOrigin.bottomLeft,
    ),
  ),
  Effect(
    EffectType.revealMask,
    options: RevealMaskEffectOptions(
      shape: RevealShape.diagonal,
      origin: EffectOrigin.bottomRight,
    ),
  ),
  Effect(
    EffectType.revealMask,
    options: RevealMaskEffectOptions(
      shape: RevealShape.iris,
      origin: EffectOrigin.center,
    ),
  ),
  Effect(EffectType.fadeThroughColor, options: FadeThroughColorEffectOptions()),
  Effect(
    EffectType.fadeThroughColor,
    options: FadeThroughColorEffectOptions(color: 0xFFFFFFFF),
  ),
  Effect(
    EffectType.slide,
    options: SlideEffectOptions(
      mode: SlideMode.push,
      direction: EffectDirection.right,
    ),
  ),
  Effect(
    EffectType.slide,
    options: SlideEffectOptions(
      mode: SlideMode.push,
      direction: EffectDirection.up,
    ),
  ),
  Effect(
    EffectType.slide,
    options: SlideEffectOptions(
      mode: SlideMode.push,
      direction: EffectDirection.down,
    ),
  ),
  Effect(
    EffectType.slide,
    options: SlideEffectOptions(
      mode: SlideMode.cover,
      direction: EffectDirection.right,
    ),
  ),
  Effect(
    EffectType.slide,
    options: SlideEffectOptions(
      mode: SlideMode.cover,
      direction: EffectDirection.up,
    ),
  ),
  Effect(
    EffectType.slide,
    options: SlideEffectOptions(
      mode: SlideMode.cover,
      direction: EffectDirection.down,
    ),
  ),
  Effect(
    EffectType.slide,
    options: SlideEffectOptions(
      mode: SlideMode.reveal,
      direction: EffectDirection.left,
    ),
  ),
  Effect(
    EffectType.slide,
    options: SlideEffectOptions(
      mode: SlideMode.reveal,
      direction: EffectDirection.right,
    ),
  ),
  Effect(
    EffectType.slide,
    options: SlideEffectOptions(
      mode: SlideMode.reveal,
      direction: EffectDirection.up,
    ),
  ),
  Effect(
    EffectType.slide,
    options: SlideEffectOptions(
      mode: SlideMode.reveal,
      direction: EffectDirection.down,
    ),
  ),
  Effect.softWipeEffect,
  Effect(
    EffectType.softWipe,
    options: SoftWipeEffectOptions(style: SoftWipeStyle.lightSweep),
  ),
  Effect.sliceEffect,
  Effect.lumaFadeEffect,
  Effect.pagePeelEffect,
  Effect.lightLeakEffect,
  Effect.filmRollEffect,
  Effect.crossZoomEffect,
  Effect.whipEffect,
  Effect.glassEffect,
  Effect.clockWipeEffect,
  Effect.splitEffect,
  Effect.panelWipeEffect,
  Effect.stretchEffect,
  Effect.starWipeEffect,
  Effect.filmDissolveEffect,
  Effect.frameEffect,
  Effect.louverEffect,
  Effect.mirrorEffect,
  Effect(
    EffectType.softWipe,
    options: SoftWipeEffectOptions(style: SoftWipeStyle.neon),
  ),
  Effect.burnAlphaEffect,
  Effect.foldMotionEffect,
  Effect.glowEffect,
  Effect.kaleidoscopeEffect,
  Effect.tvPowerEffect,
  Effect.springMotionEffect,
  Effect.shapeDissolveEffect,
  Effect.vhsDamageEffect,
  Effect.radialBlurEffect,
  Effect.phosphorEffect,
];

String effectSettingsId(Effect effect) => effect.options
    .toJson()
    .entries
    .where((entry) => entry.key != 'durationMs' || entry.value != 0)
    .map((entry) => '${entry.key}_${entry.value}')
    .join('-');
