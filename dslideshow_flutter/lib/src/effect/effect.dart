import 'effect_geometry.dart';
import 'configured_fade_effect.dart';

import 'package:flutter/material.dart';

import 'directional_slide_effect.dart';
import 'reveal_effect.dart';
import 'procedural_reveal_effect.dart';
import 'water_refraction_effect.dart';
import 'radial_blur_effect.dart';
import 'transition_media.dart';
import 'soft_wipe_effect.dart';
import 'slice_effect.dart';
import 'luma_fade_effect.dart';
import 'page_peel_effect.dart';
import 'cinematic_transition_effect.dart';
import 'photo_shader_effects.dart';
import 'geometric_transition_effect.dart';
import 'optical_transition_effect.dart';
import 'creative_transition_effect.dart';
export 'transition_media.dart';

import 'package:dslideshow_flutter/src/effect/accordion_effect.dart';
import 'package:dslideshow_flutter/src/effect/background_to_foreground_effect.dart';
import 'package:dslideshow_flutter/src/effect/blinds_effect.dart';
import 'package:dslideshow_flutter/src/effect/cube_effect.dart';
import 'package:dslideshow_flutter/src/effect/depth_effect.dart';
import 'package:dslideshow_flutter/src/effect/flip_horizontal_effect.dart';
import 'package:dslideshow_flutter/src/effect/flip_vertical_effect.dart';
import 'package:dslideshow_flutter/src/effect/foreground_to_background_effect.dart';
import 'package:dslideshow_flutter/src/effect/liquid_morph_effect.dart';
import 'package:dslideshow_flutter/src/effect/mosaic_fade_effect.dart';
import 'package:dslideshow_flutter/src/effect/parallax_effect.dart';
import 'package:dslideshow_flutter/src/effect/rotate_down_effect.dart';
import 'package:dslideshow_flutter/src/effect/rotate_up_effect.dart';
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
    Effect(EffectType.burnAlpha),
    Effect(EffectType.foldMotion),
    Effect(EffectType.glow),
    Effect(EffectType.kaleidoscope),
    Effect(EffectType.tvPower),
    Effect(EffectType.springMotion),
    Effect(EffectType.shapeDissolve),
    Effect(EffectType.vhsDamage),
    Effect(EffectType.radialBlur),
    Effect(EffectType.phosphor),
    Effect(EffectType.louver),
    Effect(EffectType.mirror),
    Effect(EffectType.split),
    Effect(EffectType.stretch),
    Effect(EffectType.lightLeak),
    Effect(EffectType.glass),
    Effect(EffectType.slice),
    Effect(EffectType.lumaFade),
    Effect(EffectType.pagePeel),
    Effect(EffectType.noiseDissolve),
    Effect(EffectType.rippleReveal),
    Effect(EffectType.waterRefraction),
    Effect(EffectType.cube),
    Effect(EffectType.accordion),
    Effect(EffectType.depth),
    Effect(EffectType.parallax),
    Effect(EffectType.tablet),
    Effect(EffectType.zoomOut),
    Effect(EffectType.fade),
    Effect(EffectType.mosaic),
    Effect(EffectType.liquidMorph),
    Effect(EffectType.blinds),
    Effect(EffectType.zoomOver),
    Effect(EffectType.slide),
    Effect(EffectType.revealMask),
    Effect(EffectType.flip),
    Effect(EffectType.rotate),
  ];
  final EffectType type;
  final EffectOptions? _options;
  const Effect(this.type, {this._options});
  EffectOptions get options {
    final value = _options;
    final defaults = defaultEffectOptions(type);
    return value is BasicEffectOptions && defaults is! BasicEffectOptions
        ? defaults.withDuration(value.durationMs)
        : value ?? defaults;
  }

  Effect configured(EffectOptions options) => Effect(type, options: options);
  static Effect fromConfig(EffectType type, EffectConfig config) =>
      Effect(type, options: config.options).canonical;
  Effect get canonical => canonicalEffectType(type) == type
      ? this
      : Effect(
          canonicalEffectType(type),
          options: canonicalEffectConfig(type, toConfig()).options,
        );
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
    if (canonicalEffectType(type) != type) {
      final canonical = canonicalEffectConfig(type, toConfig());
      return Effect(
        canonicalEffectType(type),
        options: canonical.options,
      ).createEffect(
        seed: seed,
        mosaicGridSize: mosaicGridSize,
        mosaicBackend: mosaicBackend,
      );
    }
    final settings = options;
    return switch (type) {
      EffectType.burnAlpha => _rightDirected(
        CreativeTransitionEffect(
          CreativeTransitionKind.burnAlpha,
          options: settings,
        ),
        (settings as BurnAlphaEffectOptions).direction,
      ),
      EffectType.foldMotion => _axis(
        CreativeTransitionEffect(
          CreativeTransitionKind.foldMotion,
          options: settings,
        ),
        (settings as FoldMotionEffectOptions).axis,
        EffectAxis.vertical,
      ),
      EffectType.glow => CreativeTransitionEffect(
        CreativeTransitionKind.glow,
        options: settings,
      ),
      EffectType.kaleidoscope => CreativeTransitionEffect(
        CreativeTransitionKind.kaleidoscope,
        options: settings,
      ),
      EffectType.tvPower => _axis(
        CreativeTransitionEffect(
          CreativeTransitionKind.tvPower,
          options: settings,
        ),
        (settings as TvPowerEffectOptions).lineAxis,
        EffectAxis.horizontal,
      ),
      EffectType.springMotion => _direct(
        CreativeTransitionEffect(
          CreativeTransitionKind.springMotion,
          options: settings,
        ),
        (settings as SpringMotionEffectOptions).direction,
      ),
      EffectType.shapeDissolve => CreativeTransitionEffect(
        CreativeTransitionKind.shapeDissolve,
        options: settings,
      ),
      EffectType.vhsDamage => PhotoVhsDamageEffect(
        options: settings as VhsDamageEffectOptions,
      ),
      EffectType.radialBlur => RadialBlurEffect(
        options: settings as RadialBlurEffectOptions,
      ),
      EffectType.phosphor => CreativeTransitionEffect(
        CreativeTransitionKind.phosphor,
        options: settings,
      ),
      EffectType.fade =>
        (settings as FadeEffectOptions).style == FadeStyle.linearLight
            ? PhotoFilmDissolveEffect(options: settings)
            : ConfiguredFadeEffect(settings),
      EffectType.slide => DirectionalSlideEffect(
        mode: (settings as SlideEffectOptions).mode,
        direction: _direction(settings.direction),
        motionCurve: settings.motionCurve,
        blurFraction: settings.blurFraction,
        decoration: settings.decoration,
        edgeWidth: settings.edgeWidth,
        tiltDegrees: settings.tiltDegrees,
        shadowStrength: settings.shadowStrength,
      ),
      EffectType.depth => _depth(settings as DepthEffectOptions),
      EffectType.zoomOver =>
        (settings as ZoomOverEffectOptions).mode == ZoomMode.cross
            ? CinematicTransitionEffect(
                CinematicTransitionKind.crossZoom,
                zoom: settings,
              )
            : ZoomOverEffect(
                startScale: settings.startScale,
                outgoingScale: settings.outgoingScale,
                blurFraction: settings.blurFraction,
                origin: settings.origin,
              ),
      EffectType.revealMask => _reveal(settings as RevealMaskEffectOptions),
      EffectType.slice => _slice(settings as SliceEffectOptions),
      EffectType.lumaFade => LumaFadeEffect(
        softness: (settings as LumaFadeEffectOptions).softness,
        order: settings.order,
      ),
      EffectType.pagePeel => _peel(settings as PagePeelEffectOptions),
      EffectType.noiseDissolve => ProceduralRevealEffect(
        ProceduralRevealKind.noiseDissolve,
        seed: seed,
        noiseScale: (settings as NoiseDissolveEffectOptions).noiseScale,
        softness: settings.softness,
      ),
      EffectType.rippleReveal => ProceduralRevealEffect(
        ProceduralRevealKind.rippleReveal,
        origin: (settings as RippleRevealEffectOptions).origin,
        waveAmplitude: settings.waveAmplitude,
        waveFrequency: settings.waveFrequency,
        softness: settings.softness,
      ),
      EffectType.waterRefraction => WaterRefractionEffect(
        options: settings as WaterRefractionEffectOptions,
      ),
      EffectType.cube => _direct(
        CubeEffect(
          shadowIntensity: (settings as CubeEffectOptions).shadowIntensity,
          perspectiveStrength: settings.perspectiveStrength,
        ),
        settings.direction,
      ),
      EffectType.accordion => _direct(
        AccordionEffect(
          shadowIntensity: (settings as AccordionEffectOptions).shadowIntensity,
        ),
        settings.direction,
      ),
      EffectType.parallax => _direct(
        ParallaxEffect(
          clipAmount: (settings as ParallaxEffectOptions).clipAmount,
        ),
        settings.direction,
      ),
      EffectType.tablet => _direct(
        TabletEffect(
          tiltDegrees: (settings as TabletEffectOptions).tiltDegrees,
          perspectiveStrength: settings.perspectiveStrength,
        ),
        settings.direction,
      ),
      EffectType.zoomOut => _direct(
        ZoomOutEffect(
          zoomOutScale: (settings as ZoomOutEffectOptions).zoomOutScale,
          enableOpacity: settings.enableOpacity,
        ),
        settings.direction,
      ),
      EffectType.liquidMorph => LiquidMorphEffect(
        waveCount: (settings as LiquidMorphEffectOptions).waveCount,
        waveIntensity: settings.waveIntensity,
        outgoingScale: settings.outgoingScale,
        origin: settings.origin,
      ),
      EffectType.blinds => _axis(
        BlindsEffect(
          stripCount: (settings as BlindsEffectOptions).stripCount,
          staggerFraction: settings.staggerFraction,
          order: settings.order,
        ),
        settings.axis,
        EffectAxis.horizontal,
      ),
      EffectType.glass => PhotoGlassEffect(
        options: settings as GlassEffectOptions,
      ),
      EffectType.louver => _axis(
        OpticalTransitionEffect(
          OpticalTransitionKind.louver,
          slatCount: (settings as LouverEffectOptions).slatCount,
          louver: settings,
        ),
        settings.axis,
        EffectAxis.vertical,
      ),
      EffectType.mirror => _axis(
        OpticalTransitionEffect(
          OpticalTransitionKind.mirror,
          mirror: settings as MirrorEffectOptions,
        ),
        settings.axis,
        EffectAxis.vertical,
      ),
      EffectType.split => _axis(
        GeometricTransitionEffect(
          GeometricTransitionKind.split,
          splitOptions: settings as SplitEffectOptions,
        ),
        settings.axis,
        EffectAxis.horizontal,
      ),
      EffectType.stretch => _axis(
        GeometricTransitionEffect(
          GeometricTransitionKind.stretch,
          stretchOptions: settings as StretchEffectOptions,
        ),
        settings.axis,
        EffectAxis.horizontal,
      ),
      EffectType.lightLeak => _rightDirected(
        CinematicTransitionEffect(
          CinematicTransitionKind.lightLeak,
          light: settings as LightLeakEffectOptions,
        ),
        settings.direction,
      ),
      EffectType.mosaic => MosaicFadeEffect(
        gridSize: mosaicGridSize ?? (settings as MosaicEffectOptions).gridSize,
        fadeFraction: (settings as MosaicEffectOptions).fadeFraction,
        direction: settings.direction,
        randomness: settings.randomness,
        seed: seed,
        backend: mosaicBackend,
      ),
      EffectType.flip =>
        (settings as FlipEffectOptions).axis == EffectAxis.horizontal
            ? FlipHorizontalEffect(
                perspectiveScale: .002 * settings.perspectiveStrength,
                reverse: settings.rotationSense == RotationSense.backward,
              )
            : FlipVerticalEffect(
                perspectiveScale: .002 * settings.perspectiveStrength,
                reverse: settings.rotationSense == RotationSense.backward,
              ),
      EffectType.rotate => _direct(
        (settings as RotateEffectOptions).edge == RotationEdge.top
            ? RotateUpEffect(rotationAngle: settings.angleDegrees)
            : RotateDownEffect(rotationAngle: settings.angleDegrees),
        settings.direction,
      ),
      _ => throw ArgumentError(
        'Unknown or unresolved legacy effect type: $type',
      ),
    };
  }

  static MediaSliderItemEffect _direct(
    MediaSliderItemEffect inner,
    EffectDirection direction,
  ) => direction == EffectDirection.left
      ? inner
      : DirectedEffect(inner, direction);
  static MediaSliderItemEffect _rightDirected(
    MediaSliderItemEffect inner,
    EffectDirection direction,
  ) => _direct(inner, switch (direction) {
    EffectDirection.right => EffectDirection.left,
    EffectDirection.left => EffectDirection.right,
    EffectDirection.up => EffectDirection.down,
    EffectDirection.down => EffectDirection.up,
  });
  static MediaSliderItemEffect _axis(
    MediaSliderItemEffect inner,
    EffectAxis axis,
    EffectAxis original,
  ) => axis == original ? inner : DirectedEffect(inner, EffectDirection.up);
  static AxisDirection _direction(EffectDirection direction) =>
      switch (direction) {
        EffectDirection.left => AxisDirection.left,
        EffectDirection.right => AxisDirection.right,
        EffectDirection.up => AxisDirection.up,
        EffectDirection.down => AxisDirection.down,
      };
  static MediaSliderItemEffect _depth(DepthEffectOptions o) =>
      _direct(switch (o.mode) {
        DepthMode.recedeStill => DepthEffect(
          startScale: o.scale,
          shadowIntensity: o.shadowIntensity,
        ),
        DepthMode.recedeSlide => ForegroundToBackgroundEffect(
          endScale: o.scale,
          shadowIntensity: o.shadowIntensity,
        ),
        DepthMode.approach => BackgroundToForegroundEffect(
          startScale: o.scale,
          shadowIntensity: o.shadowIntensity,
        ),
      }, o.direction);
  static MediaSliderItemEffect _slice(SliceEffectOptions o) => _axis(
    o.mode == SliceMode.slide
        ? SliceEffect(
            stripCount: o.stripCount,
            staggerFraction: o.staggerFraction,
            pattern: o.pattern,
          )
        : GeometricTransitionEffect(
            GeometricTransitionKind.panelWipe,
            panelCount: o.stripCount,
            staggerFraction: o.staggerFraction,
            pattern: o.pattern,
          ),
    o.axis,
    EffectAxis.horizontal,
  );
  static MediaSliderItemEffect _peel(PagePeelEffectOptions o) {
    final inner = PagePeelEffect(options: o);
    if (o.corner == EffectOrigin.topRight) return inner;
    return ReflectedEffect(
      inner,
      flipX:
          o.corner == EffectOrigin.topLeft ||
          o.corner == EffectOrigin.bottomLeft,
      flipY:
          o.corner == EffectOrigin.bottomLeft ||
          o.corner == EffectOrigin.bottomRight,
    );
  }

  static MediaSliderItemEffect _reveal(RevealMaskEffectOptions o) {
    final MediaSliderItemEffect inner;
    if (o.shape == RevealShape.wipe && o.edgeStyle != WipeEdgeStyle.hard) {
      inner = _rightDirected(
        SoftWipeEffect(
          style: switch (o.edgeStyle) {
            WipeEdgeStyle.lightSweep => SoftWipeStyle.lightSweep,
            WipeEdgeStyle.neon => SoftWipeStyle.neon,
            _ => SoftWipeStyle.soft,
          },
          featherFraction: o.featherFraction,
          lightStrength: o.lightStrength,
        ),
        o.direction,
      );
    } else if (o.shape == RevealShape.rectangle && o.frameEnabled) {
      inner = OpticalTransitionEffect(OpticalTransitionKind.frame, frame: o);
    } else if (o.shape == RevealShape.star || o.shape == RevealShape.clock) {
      inner = GeometricTransitionEffect(
        o.shape == RevealShape.star
            ? GeometricTransitionKind.starWipe
            : GeometricTransitionKind.clockWipe,
        revealOptions: o,
      );
    } else {
      inner = RevealEffect(
        shape: o.shape,
        direction: o.shape == RevealShape.curtain
            ? (o.axis == EffectAxis.horizontal
                  ? AxisDirection.left
                  : AxisDirection.up)
            : _direction(o.direction),
        origin: effectOrigin(o.origin),
      );
    }
    return o.operation == RevealOperation.hideOutgoing
        ? ReversedMaskEffect(inner)
        : inner;
  }

  /// Parsing is confined to external tools; unknown IDs are an explicit error.
  static Effect parse(String name) => EffectType.values
      .where((type) => type != EffectType.unknown)
      .map((type) => Effect(type))
      .firstWhere(
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
