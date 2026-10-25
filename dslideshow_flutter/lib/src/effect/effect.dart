import 'package:flutter/material.dart';

import 'directional_slide_effect.dart';
import 'fade_through_color_effect.dart';
import 'reveal_effect.dart';
import 'procedural_reveal_effect.dart';
import 'water_refraction_effect.dart';
import 'transition_media.dart';
export 'transition_media.dart';

import 'package:dslideshow_flutter/src/effect/accordion_effect.dart';
import 'package:dslideshow_flutter/src/effect/background_to_foreground_effect.dart';
import 'package:dslideshow_flutter/src/effect/blinds_effect.dart';
import 'package:dslideshow_flutter/src/effect/blure_fade_effect.dart';
import 'package:dslideshow_flutter/src/effect/cube_effect.dart';
import 'package:dslideshow_flutter/src/effect/default_effect.dart';
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
import 'mosaic_transition_effect.dart';

typedef EffectImplementor = MediaSliderItemEffect Function();

class Effect {
  static const Effect noiseDissolveEffect = Effect._(
    'Noise Dissolve',
    _createNoiseDissolve,
  );
  static const Effect rippleRevealEffect = Effect._(
    'Ripple Reveal',
    _createRippleReveal,
  );
  static const Effect waterRefractionEffect = Effect._(
    'Water Refraction',
    _createWaterRefraction,
  );
  static const Effect cubeEffect = Effect._('Cube', _createCubeEffect);
  static const Effect accordionEffect = Effect._(
    'Accordion',
    _createAccordionEffect,
  );
  static const Effect backgroundToForegroundEffect = Effect._(
    'Background To Foreground',
    _createBackgroundToForegroundEffect,
  );
  static const Effect foregroundToBackgroundEffect = Effect._(
    'Foreground To Background',
    _createForegroundToBackgroundEffect,
  );
  static const Effect defaultEffect = Effect._('Default', _createDefaultEffect);
  static const Effect depthEffect = Effect._('Depth', _createDepthEffect);
  static const Effect flipHorizontalEffect = Effect._(
    'Flip Horizontal',
    _createFlipHorizontalEffect,
  );
  static const Effect flipVerticalEffect = Effect._(
    'Flip Vertical',
    _createFlipVerticalEffect,
  );
  static const Effect parallaxEffect = Effect._(
    'Parallax',
    _createParallaxEffect,
  );
  static const Effect stackEffect = Effect._('Stack', _createStackEffect);
  static const Effect tabletEffect = Effect._('Tablet', _createTabletEffect);
  static const Effect rotateDownEffect = Effect._(
    'Rotate Down',
    _createRotateDownEffect,
  );
  static const Effect rotateUpEffect = Effect._(
    'Rotate Up',
    _createRotateUpEffect,
  );
  static const Effect zoomOutSlideEffect = Effect._(
    'Zoom Out',
    _createZoomOutSlideEffect,
  );
  static const Effect fadeEffect = Effect._('Fade', _createFadeEffect);
  static const Effect mosaicEffect = Effect._('Mosaic', _createMosaicEffect);
  static const Effect mosaicFadeEffect = Effect._(
    'MosaicFade',
    _createMosaicFadeEffect,
  );
  static const Effect mosaicTLFadeEffect = Effect._(
    'MosaicTLFade',
    _createMosaicTLFadeEffect,
  );
  static const Effect mosaicBRFadeEffect = Effect._(
    'MosaicBRFade',
    _createMosaicBRFadeEffect,
  );
  static const Effect liquidMorphEffect = Effect._(
    'LiquidMorph',
    _createLiquidMorphEffect,
  );
  static const Effect blindsEffect = Effect._('Blinds', _createBlindsEffect);
  static const Effect blurFadeEffect = Effect._(
    'BlurFade',
    _createBlurFadeEffect,
  );
  static const Effect zoomOverEffect = Effect._(
    'ZoomOver',
    _createZoomOverEffect,
  );

  static const Effect mosaicTRFadeEffect = Effect._(
    'MosaicTRFade',
    _createMosaicTRFade,
  );
  static const Effect mosaicBLFadeEffect = Effect._(
    'MosaicBLFade',
    _createMosaicBLFade,
  );
  static const Effect wipeLeftEffect = Effect._('Wipe Left', _createWipeLeft);
  static const Effect wipeRightEffect = Effect._(
    'Wipe Right',
    _createWipeRight,
  );
  static const Effect wipeUpEffect = Effect._('Wipe Up', _createWipeUp);
  static const Effect wipeDownEffect = Effect._('Wipe Down', _createWipeDown);
  static const Effect curtainHorizontalEffect = Effect._(
    'Curtain Horizontal',
    _createCurtainHorizontal,
  );
  static const Effect curtainVerticalEffect = Effect._(
    'Curtain Vertical',
    _createCurtainVertical,
  );
  static const Effect diagonalTopLeftEffect = Effect._(
    'Diagonal topLeft',
    _createDiagonalTopLeft,
  );
  static const Effect diagonalTopRightEffect = Effect._(
    'Diagonal topRight',
    _createDiagonalTopRight,
  );
  static const Effect diagonalBottomLeftEffect = Effect._(
    'Diagonal bottomLeft',
    _createDiagonalBottomLeft,
  );
  static const Effect diagonalBottomRightEffect = Effect._(
    'Diagonal bottomRight',
    _createDiagonalBottomRight,
  );
  static const Effect irisEffect = Effect._('Iris', _createIris);
  static const Effect fadeThroughBlackEffect = Effect._(
    'Fade Through Black',
    _createFadeThroughBlack,
  );
  static const Effect fadeThroughWhiteEffect = Effect._(
    'Fade Through White',
    _createFadeThroughWhite,
  );
  static const Effect pushRightEffect = Effect._(
    'Push Right',
    _createPushRight,
  );
  static const Effect pushUpEffect = Effect._('Push Up', _createPushUp);
  static const Effect pushDownEffect = Effect._('Push Down', _createPushDown);
  static const Effect coverRightEffect = Effect._(
    'Cover Right',
    _createCoverRight,
  );
  static const Effect coverUpEffect = Effect._('Cover Up', _createCoverUp);
  static const Effect coverDownEffect = Effect._(
    'Cover Down',
    _createCoverDown,
  );
  static const Effect revealLeftEffect = Effect._(
    'Reveal Left',
    _createRevealLeft,
  );
  static const Effect revealRightEffect = Effect._(
    'Reveal Right',
    _createRevealRight,
  );
  static const Effect revealUpEffect = Effect._('Reveal Up', _createRevealUp);
  static const Effect revealDownEffect = Effect._(
    'Reveal Down',
    _createRevealDown,
  );

  static const Iterable<Effect> values = [
    noiseDissolveEffect,
    rippleRevealEffect,
    waterRefractionEffect,
    cubeEffect,
    accordionEffect,
    backgroundToForegroundEffect,
    foregroundToBackgroundEffect,
    defaultEffect,
    depthEffect,
    flipHorizontalEffect,
    flipVerticalEffect,
    parallaxEffect,
    stackEffect,
    tabletEffect,
    rotateDownEffect,
    rotateUpEffect,
    zoomOutSlideEffect,
    fadeEffect,
    mosaicEffect,
    mosaicFadeEffect,
    mosaicTLFadeEffect,
    mosaicBRFadeEffect,
    liquidMorphEffect,
    blindsEffect,
    blurFadeEffect,
    zoomOverEffect,
    mosaicTRFadeEffect,
    mosaicBLFadeEffect,
    wipeLeftEffect,
    wipeRightEffect,
    wipeUpEffect,
    wipeDownEffect,
    curtainHorizontalEffect,
    curtainVerticalEffect,
    diagonalTopLeftEffect,
    diagonalTopRightEffect,
    diagonalBottomLeftEffect,
    diagonalBottomRightEffect,
    irisEffect,
    fadeThroughBlackEffect,
    fadeThroughWhiteEffect,
    pushRightEffect,
    pushUpEffect,
    pushDownEffect,
    coverRightEffect,
    coverUpEffect,
    coverDownEffect,
    revealLeftEffect,
    revealRightEffect,
    revealUpEffect,
    revealDownEffect,
  ];
  final String name;

  final EffectImplementor _implementor;

  const Effect._(this.name, this._implementor);

  @override
  int get hashCode => name.hashCode ^ _implementor.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Effect &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          _implementor == other._implementor;

  bool get isMosaic =>
      this == mosaicEffect ||
      this == mosaicFadeEffect ||
      this == mosaicTLFadeEffect ||
      this == mosaicTRFadeEffect ||
      this == mosaicBLFadeEffect ||
      this == mosaicBRFadeEffect;

  bool supportsMedia(TransitionMedia from, TransitionMedia to) =>
      this != waterRefractionEffect ||
      (from == TransitionMedia.photo && to == TransitionMedia.photo);

  MediaSliderItemEffect createEffect({
    int? seed,
    int mosaicGridSize = 100,
    MosaicBackend mosaicBackend = MosaicBackend.canvas,
  }) {
    if (this == noiseDissolveEffect) {
      return ProceduralRevealEffect(
        ProceduralRevealKind.noiseDissolve,
        seed: seed,
      );
    }
    if (!isMosaic) return _implementor();
    if (this == mosaicEffect) {
      return MosaicTransitionEffect(
        gridSize: mosaicGridSize,
        seed: seed,
        backend: mosaicBackend,
      );
    }
    final direction = this == mosaicTLFadeEffect
        ? MosaicDirection.topLeft
        : this == mosaicTRFadeEffect
        ? MosaicDirection.topRight
        : this == mosaicBLFadeEffect
        ? MosaicDirection.bottomLeft
        : this == mosaicBRFadeEffect
        ? MosaicDirection.bottomRight
        : MosaicDirection.random;
    return MosaicFadeEffect(
      gridSize: mosaicGridSize,
      seed: seed,
      direction: direction,
      backend: mosaicBackend,
    );
  }

  @override
  String toString() => name;

  static MediaSliderItemEffect _createAccordionEffect() => AccordionEffect();
  static MediaSliderItemEffect _createNoiseDissolve() =>
      ProceduralRevealEffect(ProceduralRevealKind.noiseDissolve);
  static MediaSliderItemEffect _createRippleReveal() =>
      ProceduralRevealEffect(ProceduralRevealKind.rippleReveal);
  static MediaSliderItemEffect _createWaterRefraction() =>
      WaterRefractionEffect();
  static MediaSliderItemEffect _createBackgroundToForegroundEffect() =>
      BackgroundToForegroundEffect();
  static MediaSliderItemEffect _createCubeEffect() => CubeEffect();
  static MediaSliderItemEffect _createDefaultEffect() => DefaultEffect();
  static MediaSliderItemEffect _createDepthEffect() => DepthEffect();
  static MediaSliderItemEffect _createFlipHorizontalEffect() =>
      FlipHorizontalEffect();
  static MediaSliderItemEffect _createFlipVerticalEffect() =>
      FlipVerticalEffect();
  static MediaSliderItemEffect _createForegroundToBackgroundEffect() =>
      ForegroundToBackgroundEffect();
  static MediaSliderItemEffect _createParallaxEffect() => ParallaxEffect();
  static MediaSliderItemEffect _createRotateDownEffect() => RotateDownEffect();
  static MediaSliderItemEffect _createRotateUpEffect() => RotateUpEffect();
  static MediaSliderItemEffect _createStackEffect() => StackEffect();
  static MediaSliderItemEffect _createTabletEffect() => TabletEffect();
  static MediaSliderItemEffect _createZoomOutSlideEffect() => ZoomOutEffect();
  static MediaSliderItemEffect _createFadeEffect() => FadeEffect();
  static MediaSliderItemEffect _createMosaicEffect() =>
      MosaicTransitionEffect();
  static MediaSliderItemEffect _createMosaicFadeEffect() => MosaicFadeEffect();
  static MediaSliderItemEffect _createMosaicTLFadeEffect() =>
      MosaicFadeEffect(direction: MosaicDirection.topLeft);
  static MediaSliderItemEffect _createMosaicBRFadeEffect() =>
      MosaicFadeEffect(direction: MosaicDirection.bottomRight);
  static MediaSliderItemEffect _createLiquidMorphEffect() =>
      LiquidMorphEffect();
  static MediaSliderItemEffect _createBlindsEffect() => BlindsEffect();
  static MediaSliderItemEffect _createBlurFadeEffect() => BlurFadeEffect();
  static MediaSliderItemEffect _createZoomOverEffect() => ZoomOverEffect();

  static MediaSliderItemEffect _createMosaicTRFade() =>
      MosaicFadeEffect(direction: MosaicDirection.topRight);
  static MediaSliderItemEffect _createMosaicBLFade() =>
      MosaicFadeEffect(direction: MosaicDirection.bottomLeft);
  static MediaSliderItemEffect _createWipeLeft() =>
      RevealEffect(direction: AxisDirection.left);
  static MediaSliderItemEffect _createWipeRight() =>
      RevealEffect(direction: AxisDirection.right);
  static MediaSliderItemEffect _createWipeUp() =>
      RevealEffect(direction: AxisDirection.up);
  static MediaSliderItemEffect _createWipeDown() =>
      RevealEffect(direction: AxisDirection.down);
  static MediaSliderItemEffect _createCurtainHorizontal() =>
      RevealEffect(shape: RevealShape.curtain, direction: AxisDirection.left);
  static MediaSliderItemEffect _createCurtainVertical() =>
      RevealEffect(shape: RevealShape.curtain, direction: AxisDirection.up);
  static MediaSliderItemEffect _createDiagonalTopLeft() =>
      RevealEffect(shape: RevealShape.diagonal, origin: Alignment.topLeft);
  static MediaSliderItemEffect _createDiagonalTopRight() =>
      RevealEffect(shape: RevealShape.diagonal, origin: Alignment.topRight);
  static MediaSliderItemEffect _createDiagonalBottomLeft() =>
      RevealEffect(shape: RevealShape.diagonal, origin: Alignment.bottomLeft);
  static MediaSliderItemEffect _createDiagonalBottomRight() =>
      RevealEffect(shape: RevealShape.diagonal, origin: Alignment.bottomRight);
  static MediaSliderItemEffect _createIris() =>
      RevealEffect(shape: RevealShape.iris, origin: Alignment.center);
  static MediaSliderItemEffect _createFadeThroughBlack() =>
      FadeThroughColorEffect();
  static MediaSliderItemEffect _createFadeThroughWhite() =>
      FadeThroughColorEffect(color: Colors.white);
  static MediaSliderItemEffect _createPushRight() => DirectionalSlideEffect(
    mode: SlideMode.push,
    direction: AxisDirection.right,
  );
  static MediaSliderItemEffect _createPushUp() =>
      DirectionalSlideEffect(mode: SlideMode.push, direction: AxisDirection.up);
  static MediaSliderItemEffect _createPushDown() => DirectionalSlideEffect(
    mode: SlideMode.push,
    direction: AxisDirection.down,
  );
  static MediaSliderItemEffect _createCoverRight() => DirectionalSlideEffect(
    mode: SlideMode.cover,
    direction: AxisDirection.right,
  );
  static MediaSliderItemEffect _createCoverUp() => DirectionalSlideEffect(
    mode: SlideMode.cover,
    direction: AxisDirection.up,
  );
  static MediaSliderItemEffect _createCoverDown() => DirectionalSlideEffect(
    mode: SlideMode.cover,
    direction: AxisDirection.down,
  );
  static MediaSliderItemEffect _createRevealLeft() => DirectionalSlideEffect(
    mode: SlideMode.reveal,
    direction: AxisDirection.left,
  );
  static MediaSliderItemEffect _createRevealRight() => DirectionalSlideEffect(
    mode: SlideMode.reveal,
    direction: AxisDirection.right,
  );
  static MediaSliderItemEffect _createRevealUp() => DirectionalSlideEffect(
    mode: SlideMode.reveal,
    direction: AxisDirection.up,
  );
  static MediaSliderItemEffect _createRevealDown() => DirectionalSlideEffect(
    mode: SlideMode.reveal,
    direction: AxisDirection.down,
  );

  static Effect parse(String name) {
    return values.firstWhere(
      (element) => element.name == name,
      orElse: () => defaultEffect,
    );
  }
}
