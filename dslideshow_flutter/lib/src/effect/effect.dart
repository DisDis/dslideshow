import 'media_slider_item_effects.dart';
import 'media_slider_item_effect.dart';

typedef EffectImplementor = MediaSliderItemEffect Function();

class Effect {
  static const Effect cubeEffect = Effect._('Cube', _createCubeEffect);
  static const Effect accordionEffect = Effect._('Accordion', _createAccordionEffect);
  static const Effect backgroundToForegroundEffect =
      Effect._('Background To Foreground', _createBackgroundToForegroundEffect);
  static const Effect foregroundToBackgroundEffect =
      Effect._('Foreground To Background', _createForegroundToBackgroundEffect);
  static const Effect defaultEffect = Effect._('Default', _createDefaultEffect);
  static const Effect depthEffect = Effect._('Depth', _createDepthEffect);
  static const Effect flipHorizontalEffect = Effect._('Flip Horizontal', _createFlipHorizontalEffect);
  static const Effect flipVerticalEffect = Effect._('Flip Vertical', _createFlipVerticalEffect);
  static const Effect parallaxEffect = Effect._('Parallax', _createParallaxEffect);
  static const Effect stackEffect = Effect._('Stack', _createStackEffect);
  static const Effect tabletEffect = Effect._('Tablet', _createTabletEffect);
  static const Effect rotateDownEffect = Effect._('Rotate Down', _createRotateDownEffect);
  static const Effect rotateUpEffect = Effect._('Rotate Up', _createRotateUpEffect);
  static const Effect zoomOutSlideEffect = Effect._('Zoom Out', _createZoomOutSlideEffect);
  static const Effect fadeEffect = Effect._('Fade', _createFadeEffect);

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
    fadeEffect
  ];
  final String name;

  final EffectImplementor _implementor;

  const Effect._(this.name, this._implementor);

  @override
  int get hashCode => name.hashCode ^ _implementor.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Effect && runtimeType == other.runtimeType && name == other.name && _implementor == other._implementor;

  MediaSliderItemEffect createEffect() => _implementor();

  @override
  String toString() => name;

  static MediaSliderItemEffect _createAccordionEffect() => AccordionEffect();
  static MediaSliderItemEffect _createBackgroundToForegroundEffect() => BackgroundToForegroundEffect();
  static MediaSliderItemEffect _createCubeEffect() => CubeEffect();
  static MediaSliderItemEffect _createDefaultEffect() => DefaultEffect();
  static MediaSliderItemEffect _createDepthEffect() => DepthEffect();
  static MediaSliderItemEffect _createFlipHorizontalEffect() => FlipHorizontalEffect();
  static MediaSliderItemEffect _createFlipVerticalEffect() => FlipVerticalEffect();
  static MediaSliderItemEffect _createForegroundToBackgroundEffect() => ForegroundToBackgroundEffect();
  static MediaSliderItemEffect _createParallaxEffect() => ParallaxEffect();
  static MediaSliderItemEffect _createRotateDownEffect() => RotateDownEffect();
  static MediaSliderItemEffect _createRotateUpEffect() => RotateUpEffect();
  static MediaSliderItemEffect _createStackEffect() => StackEffect();
  static MediaSliderItemEffect _createTabletEffect() => TabletEffect();
  static MediaSliderItemEffect _createZoomOutSlideEffect() => ZoomOutEffect();
  static MediaSliderItemEffect _createFadeEffect() => FadeEffect();

  static Effect parse(String name) {
    return values.firstWhere((element) => element.name == name, orElse: () => defaultEffect);
  }
}
