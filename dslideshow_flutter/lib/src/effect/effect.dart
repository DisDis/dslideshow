import 'package:flutter/material.dart';

import 'directional_slide_effect.dart';
import 'fade_through_color_effect.dart';
import 'reveal_effect.dart';
import 'procedural_reveal_effect.dart';
import 'water_refraction_effect.dart';
import 'transition_media.dart';
import 'soft_wipe_effect.dart';
import 'slice_effect.dart';
import 'luma_fade_effect.dart';
import 'page_peel_effect.dart';
import 'cinematic_transition_effect.dart';
import 'glass_effect.dart';
import 'geometric_transition_effect.dart';
import 'optical_transition_effect.dart';
import 'creative_transition_effect.dart';
export 'transition_media.dart';

import 'package:dslideshow_flutter/src/effect/accordion_effect.dart';
import 'package:dslideshow_flutter/src/effect/background_to_foreground_effect.dart';
import 'package:dslideshow_flutter/src/effect/blinds_effect.dart';
import 'package:dslideshow_flutter/src/effect/blure_fade_effect.dart';
import 'package:dslideshow_flutter/src/effect/cube_effect.dart';
import 'package:dslideshow_flutter/src/effect/depth_effect.dart';
import 'package:dslideshow_flutter/src/effect/fade_effect.dart';
import 'package:dslideshow_flutter/src/effect/flip_horizontal_effect.dart';
import 'package:dslideshow_flutter/src/effect/flip_vertical_effect.dart';
import 'package:dslideshow_flutter/src/effect/foreground_to_background_effect.dart';
import 'package:dslideshow_flutter/src/effect/liquid_morph_effect.dart';
import 'package:dslideshow_flutter/src/effect/mosaic_fade_effect.dart';
import 'package:dslideshow_flutter/src/effect/parallax_effect.dart';
import 'package:dslideshow_flutter/src/effect/rotate_down_effect.dart';
import 'package:dslideshow_flutter/src/effect/rotate_up_effect.dart';
import 'package:dslideshow_flutter/src/effect/stack_effect.dart';
import 'package:dslideshow_flutter/src/effect/tablet_effect.dart';
import 'package:dslideshow_flutter/src/effect/zoom_out_effect.dart';
import 'package:dslideshow_flutter/src/effect/zoom_over_effect.dart';

import 'media_slider_item_effect.dart';

import 'package:dslideshow_common/effects.dart';
export 'package:dslideshow_common/effects.dart';

/// A configured, immutable effect. One catalog entry per algorithm.
class Effect {
  static const Effect burnAlphaEffect = Effect(EffectType.burnAlpha);
  static const Effect foldMotionEffect = Effect(EffectType.foldMotion);
  static const Effect glowEffect = Effect(EffectType.glow);
  static const Effect kaleidoscopeEffect = Effect(EffectType.kaleidoscope);
  static const Effect tvPowerEffect = Effect(EffectType.tvPower);
  static const Effect springMotionEffect = Effect(EffectType.springMotion);
  static const Effect shapeDissolveEffect = Effect(EffectType.shapeDissolve);
  static const Effect vhsDamageEffect = Effect(EffectType.vhsDamage);
  static const Effect radialBlurEffect = Effect(EffectType.radialBlur);
  static const Effect phosphorEffect = Effect(EffectType.phosphor);
  static const Effect filmDissolveEffect = Effect(EffectType.filmDissolve);
  static const Effect frameEffect = Effect(EffectType.frame);
  static const Effect louverEffect = Effect(EffectType.louver);
  static const Effect mirrorEffect = Effect(EffectType.mirror);
  static const Effect clockWipeEffect = Effect(EffectType.clockWipe);
  static const Effect splitEffect = Effect(EffectType.split);
  static const Effect panelWipeEffect = Effect(EffectType.panelWipe);
  static const Effect stretchEffect = Effect(EffectType.stretch);
  static const Effect starWipeEffect = Effect(EffectType.starWipe);
  static const Effect lightLeakEffect = Effect(EffectType.lightLeak);
  static const Effect filmRollEffect = Effect(EffectType.filmRoll);
  static const Effect crossZoomEffect = Effect(EffectType.crossZoom);
  static const Effect whipEffect = Effect(EffectType.whip);
  static const Effect glassEffect = Effect(EffectType.glass);
  static const Effect softWipeEffect = Effect(EffectType.softWipe);
  static const Effect sliceEffect = Effect(EffectType.slice);
  static const Effect lumaFadeEffect = Effect(EffectType.lumaFade);
  static const Effect pagePeelEffect = Effect(EffectType.pagePeel);
  static const Effect noiseDissolveEffect = Effect(EffectType.noiseDissolve);
  static const Effect rippleRevealEffect = Effect(EffectType.rippleReveal);
  static const Effect waterRefractionEffect = Effect(
    EffectType.waterRefraction,
  );
  static const Effect cubeEffect = Effect(EffectType.cube);
  static const Effect accordionEffect = Effect(EffectType.accordion);
  static const Effect backgroundToForegroundEffect = Effect(
    EffectType.backgroundToForeground,
  );
  static const Effect foregroundToBackgroundEffect = Effect(
    EffectType.foregroundToBackground,
  );
  static const Effect depthEffect = Effect(EffectType.depth);
  static const Effect parallaxEffect = Effect(EffectType.parallax);
  static const Effect stackEffect = Effect(EffectType.stack);
  static const Effect tabletEffect = Effect(EffectType.tablet);
  static const Effect zoomOutSlideEffect = Effect(EffectType.zoomOut);
  static const Effect fadeEffect = Effect(EffectType.fade);
  static const Effect mosaicEffect = Effect(EffectType.mosaic);
  static const Effect liquidMorphEffect = Effect(EffectType.liquidMorph);
  static const Effect blindsEffect = Effect(EffectType.blinds);
  static const Effect blurFadeEffect = Effect(EffectType.blurFade);
  static const Effect zoomOverEffect = Effect(EffectType.zoomOver);
  static const Effect slideEffect = Effect(EffectType.slide);
  static const Effect revealMaskEffect = Effect(EffectType.revealMask);
  static const Effect fadeThroughColorEffect = Effect(
    EffectType.fadeThroughColor,
  );
  static const Effect flipEffect = Effect(EffectType.flip);
  static const Effect rotateEffect = Effect(EffectType.rotate);
  static const Iterable<Effect> values = [
    burnAlphaEffect,
    foldMotionEffect,
    glowEffect,
    kaleidoscopeEffect,
    tvPowerEffect,
    springMotionEffect,
    shapeDissolveEffect,
    vhsDamageEffect,
    radialBlurEffect,
    phosphorEffect,
    filmDissolveEffect,
    frameEffect,
    louverEffect,
    mirrorEffect,
    clockWipeEffect,
    splitEffect,
    panelWipeEffect,
    stretchEffect,
    starWipeEffect,
    lightLeakEffect,
    filmRollEffect,
    crossZoomEffect,
    whipEffect,
    glassEffect,
    softWipeEffect,
    sliceEffect,
    lumaFadeEffect,
    pagePeelEffect,
    noiseDissolveEffect,
    rippleRevealEffect,
    waterRefractionEffect,
    cubeEffect,
    accordionEffect,
    backgroundToForegroundEffect,
    foregroundToBackgroundEffect,
    depthEffect,
    parallaxEffect,
    stackEffect,
    tabletEffect,
    zoomOutSlideEffect,
    fadeEffect,
    mosaicEffect,
    liquidMorphEffect,
    blindsEffect,
    blurFadeEffect,
    zoomOverEffect,
    slideEffect,
    revealMaskEffect,
    fadeThroughColorEffect,
    flipEffect,
    rotateEffect,
  ];
  final EffectType type;
  final EffectOptions? _options;
  const Effect(this.type, {this._options});
  EffectOptions get options => _options ?? defaultEffectOptions(type);
  Effect configured(EffectOptions options) => Effect(type, options: options);
  static Effect fromConfig(EffectType type, EffectConfig config) =>
      Effect(type, options: config.options);
  EffectConfig toConfig({bool enabled = true}) =>
      EffectConfig(enabled: enabled, options: options);
  bool get isMosaic => type == EffectType.mosaic;
  String get name => switch (type) {
    EffectType.burnAlpha => 'Burn Alpha',
    EffectType.foldMotion => 'Fold Motion',
    EffectType.glow => 'Glow',
    EffectType.kaleidoscope => 'Kaleidoscope',
    EffectType.tvPower => 'TV Power',
    EffectType.springMotion => 'Spring Motion',
    EffectType.shapeDissolve => 'Shape Dissolve',
    EffectType.vhsDamage => 'VHS Damage',
    EffectType.radialBlur => 'Radial Blur',
    EffectType.phosphor => 'Phosphor',
    EffectType.filmDissolve => 'Film Dissolve',
    EffectType.frame => 'Frame',
    EffectType.louver => 'Louver',
    EffectType.mirror => 'Mirror',
    EffectType.clockWipe => 'Clock Wipe',
    EffectType.split => 'Split',
    EffectType.panelWipe => 'Panel Wipe',
    EffectType.stretch => 'Stretch',
    EffectType.starWipe => 'Star Wipe',
    EffectType.lightLeak => 'Light Leak',
    EffectType.filmRoll => 'Film Roll',
    EffectType.crossZoom => 'Cross Zoom',
    EffectType.whip => 'Whip',
    EffectType.glass => 'Glass',
    EffectType.softWipe => 'Soft Wipe',
    EffectType.slice => 'Slice',
    EffectType.lumaFade => 'Luma Fade',
    EffectType.pagePeel => 'Page Peel',
    EffectType.noiseDissolve => 'Noise Dissolve',
    EffectType.rippleReveal => 'Ripple Reveal',
    EffectType.waterRefraction => 'Water Refraction',
    EffectType.cube => 'Cube',
    EffectType.accordion => 'Accordion',
    EffectType.backgroundToForeground => 'Background To Foreground',
    EffectType.foregroundToBackground => 'Foreground To Background',
    EffectType.depth => 'Depth',
    EffectType.parallax => 'Parallax',
    EffectType.stack => 'Stack',
    EffectType.tablet => 'Tablet',
    EffectType.zoomOut => 'Zoom Out',
    EffectType.fade => 'Fade',
    EffectType.mosaic => 'Mosaic',
    EffectType.liquidMorph => 'LiquidMorph',
    EffectType.blinds => 'Blinds',
    EffectType.blurFade => 'BlurFade',
    EffectType.zoomOver => 'ZoomOver',
    EffectType.slide => 'Slide',
    EffectType.revealMask => 'Reveal Mask',
    EffectType.fadeThroughColor => 'Fade Through Color',
    EffectType.flip => 'Flip',
    EffectType.rotate => 'Rotate',
    EffectType.unknown => 'Unknown',
  };
  EffectGroup get group => switch (type) {
    EffectType.fade ||
    EffectType.fadeThroughColor ||
    EffectType.filmDissolve ||
    EffectType.lumaFade ||
    EffectType.blurFade => EffectGroup.fades,
    EffectType.mosaic ||
    EffectType.revealMask ||
    EffectType.softWipe ||
    EffectType.noiseDissolve ||
    EffectType.rippleReveal => EffectGroup.masks,
    EffectType.burnAlpha ||
    EffectType.foldMotion ||
    EffectType.glow ||
    EffectType.kaleidoscope ||
    EffectType.tvPower ||
    EffectType.springMotion ||
    EffectType.shapeDissolve ||
    EffectType.vhsDamage ||
    EffectType.radialBlur ||
    EffectType.phosphor => EffectGroup.creative,
    EffectType.lightLeak ||
    EffectType.filmRoll ||
    EffectType.crossZoom ||
    EffectType.whip => EffectGroup.cinematic,
    EffectType.clockWipe ||
    EffectType.split ||
    EffectType.panelWipe ||
    EffectType.stretch ||
    EffectType.starWipe ||
    EffectType.glass ||
    EffectType.frame ||
    EffectType.louver ||
    EffectType.mirror => EffectGroup.geometric,
    _ => EffectGroup.movement,
  };
  bool supportsMedia(TransitionMedia from, TransitionMedia to) =>
      type != EffectType.waterRefraction ||
      (from == TransitionMedia.photo && to == TransitionMedia.photo);
  MediaSliderItemEffect createEffect({
    int? seed,
    int? mosaicGridSize,
    MosaicBackend mosaicBackend = MosaicBackend.canvas,
  }) {
    final settings = options;
    return switch (type) {
      EffectType.burnAlpha => CreativeTransitionEffect(
        CreativeTransitionKind.burnAlpha,
      ),
      EffectType.foldMotion => CreativeTransitionEffect(
        CreativeTransitionKind.foldMotion,
      ),
      EffectType.glow => CreativeTransitionEffect(CreativeTransitionKind.glow),
      EffectType.kaleidoscope => CreativeTransitionEffect(
        CreativeTransitionKind.kaleidoscope,
      ),
      EffectType.tvPower => CreativeTransitionEffect(
        CreativeTransitionKind.tvPower,
      ),
      EffectType.springMotion => CreativeTransitionEffect(
        CreativeTransitionKind.springMotion,
      ),
      EffectType.shapeDissolve => CreativeTransitionEffect(
        CreativeTransitionKind.shapeDissolve,
      ),
      EffectType.vhsDamage => CreativeTransitionEffect(
        CreativeTransitionKind.vhsDamage,
      ),
      EffectType.radialBlur => CreativeTransitionEffect(
        CreativeTransitionKind.radialBlur,
      ),
      EffectType.phosphor => CreativeTransitionEffect(
        CreativeTransitionKind.phosphor,
      ),
      EffectType.filmDissolve => OpticalTransitionEffect(
        OpticalTransitionKind.filmDissolve,
      ),
      EffectType.frame => OpticalTransitionEffect(OpticalTransitionKind.frame),
      EffectType.louver => OpticalTransitionEffect(
        OpticalTransitionKind.louver,
        slatCount: (settings as LouverEffectOptions).slatCount,
      ),
      EffectType.mirror => OpticalTransitionEffect(
        OpticalTransitionKind.mirror,
      ),
      EffectType.clockWipe => GeometricTransitionEffect(
        GeometricTransitionKind.clockWipe,
      ),
      EffectType.split => GeometricTransitionEffect(
        GeometricTransitionKind.split,
      ),
      EffectType.panelWipe => GeometricTransitionEffect(
        GeometricTransitionKind.panelWipe,
        panelCount: (settings as PanelWipeEffectOptions).panelCount,
      ),
      EffectType.stretch => GeometricTransitionEffect(
        GeometricTransitionKind.stretch,
      ),
      EffectType.starWipe => GeometricTransitionEffect(
        GeometricTransitionKind.starWipe,
      ),
      EffectType.lightLeak => CinematicTransitionEffect(
        CinematicTransitionKind.lightLeak,
      ),
      EffectType.filmRoll => CinematicTransitionEffect(
        CinematicTransitionKind.filmRoll,
      ),
      EffectType.crossZoom => CinematicTransitionEffect(
        CinematicTransitionKind.crossZoom,
      ),
      EffectType.whip => CinematicTransitionEffect(
        CinematicTransitionKind.whip,
      ),
      EffectType.glass => GlassEffect(
        paneCount: (settings as GlassEffectOptions).paneCount,
      ),
      EffectType.softWipe => SoftWipeEffect(
        style: (settings as SoftWipeEffectOptions).style,
      ),
      EffectType.slice => SliceEffect(
        stripCount: (settings as SliceEffectOptions).stripCount,
      ),
      EffectType.lumaFade => LumaFadeEffect(),
      EffectType.pagePeel => PagePeelEffect(),
      EffectType.noiseDissolve => ProceduralRevealEffect(
        ProceduralRevealKind.noiseDissolve,
        seed: seed,
      ),
      EffectType.rippleReveal => ProceduralRevealEffect(
        ProceduralRevealKind.rippleReveal,
      ),
      EffectType.waterRefraction => WaterRefractionEffect(),
      EffectType.cube => CubeEffect(),
      EffectType.accordion => AccordionEffect(),
      EffectType.backgroundToForeground => BackgroundToForegroundEffect(),
      EffectType.foregroundToBackground => ForegroundToBackgroundEffect(),
      EffectType.depth => DepthEffect(),
      EffectType.parallax => ParallaxEffect(),
      EffectType.stack => StackEffect(),
      EffectType.tablet => TabletEffect(),
      EffectType.zoomOut => ZoomOutEffect(),
      EffectType.fade => FadeEffect(),
      EffectType.mosaic => _mosaic(
        settings as MosaicEffectOptions,
        seed,
        mosaicGridSize,
        mosaicBackend,
      ),
      EffectType.liquidMorph => LiquidMorphEffect(),
      EffectType.blinds => BlindsEffect(
        stripCount: (settings as BlindsEffectOptions).stripCount,
      ),
      EffectType.blurFade => BlurFadeEffect(),
      EffectType.zoomOver => ZoomOverEffect(),
      EffectType.slide => DirectionalSlideEffect(
        mode: (settings as SlideEffectOptions).mode,
        direction: _direction(settings.direction),
      ),
      EffectType.revealMask => _reveal(settings as RevealMaskEffectOptions),
      EffectType.fadeThroughColor => FadeThroughColorEffect(
        color: Color((settings as FadeThroughColorEffectOptions).color),
      ),
      EffectType.flip =>
        (settings as FlipEffectOptions).axis == EffectAxis.horizontal
            ? FlipHorizontalEffect()
            : FlipVerticalEffect(),
      EffectType.rotate =>
        (settings as RotateEffectOptions).edge == RotationEdge.top
            ? RotateUpEffect(rotationAngle: settings.angleDegrees)
            : RotateDownEffect(rotationAngle: settings.angleDegrees),
      EffectType.unknown => throw ArgumentError('Unknown effect type'),
    };
  }

  static AxisDirection _direction(EffectDirection direction) =>
      switch (direction) {
        EffectDirection.left => AxisDirection.left,
        EffectDirection.right => AxisDirection.right,
        EffectDirection.up => AxisDirection.up,
        EffectDirection.down => AxisDirection.down,
      };
  static MediaSliderItemEffect _mosaic(
    MosaicEffectOptions options,
    int? seed,
    int? grid,
    MosaicBackend backend,
  ) => MosaicFadeEffect(
    gridSize: grid ?? options.gridSize,
    fadeFraction: options.fadeFraction,
    direction: options.direction,
    seed: seed,
    backend: backend,
  );
  static MediaSliderItemEffect _reveal(RevealMaskEffectOptions options) =>
      RevealEffect(
        shape: options.shape,
        direction: options.shape == RevealShape.curtain
            ? (options.axis == EffectAxis.horizontal
                  ? AxisDirection.left
                  : AxisDirection.up)
            : _direction(options.direction),
        origin: switch (options.origin) {
          EffectOrigin.center => Alignment.center,
          EffectOrigin.topLeft => Alignment.topLeft,
          EffectOrigin.topRight => Alignment.topRight,
          EffectOrigin.bottomLeft => Alignment.bottomLeft,
          EffectOrigin.bottomRight => Alignment.bottomRight,
        },
      );

  /// Parsing is confined to external tools; unknown IDs are an explicit error.
  static Effect parse(String name) => values.firstWhere(
    (e) => e.name == name,
    orElse: () => throw FormatException('Unknown effect: $name'),
  );
  @override
  bool operator ==(Object other) =>
      other is Effect && type == other.type && options == other.options;
  @override
  int get hashCode => Object.hash(type, options);
  @override
  String toString() => name;
}
