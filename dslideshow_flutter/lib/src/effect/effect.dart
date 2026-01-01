import 'package:dslideshow_flutter/src/effect/blinds_effect.dart';
import 'package:dslideshow_flutter/src/effect/blure_fade_effect.dart';
import 'package:dslideshow_flutter/src/effect/liquid_morph_effect.dart';
import 'package:dslideshow_flutter/src/effect/mosaic_fade_effect.dart';
import 'package:dslideshow_flutter/src/effect/zoom_over_effect.dart';

import 'media_slider_item_effects.dart';
import 'media_slider_item_effect.dart';
import 'mosaic_transition_effect.dart';

typedef EffectImplementor = MediaSliderItemEffect Function();

class Effect {
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
  static const Effect blurFadeEffect = Effect._('BlurFade', _createBlurFadeEffect);
  static const Effect zoomOverEffect = Effect._('ZoomOver', _createZoomOverEffect);  
  

  static const Iterable<Effect> values = [
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

  MediaSliderItemEffect createEffect() => _implementor();

  @override
  String toString() => name;

  static MediaSliderItemEffect _createAccordionEffect() => AccordionEffect();
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
  
  static Effect parse(String name) {
    return values.firstWhere(
      (element) => element.name == name,
      orElse: () => defaultEffect,
    );
  }
}
