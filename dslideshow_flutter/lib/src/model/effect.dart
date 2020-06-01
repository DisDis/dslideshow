import 'package:media_slider_widget/effects/media_slider_item_effects.dart';
import 'package:media_slider_widget/media_slider_item_effect.dart';

typedef EffectImplementor = MediaSliderItemEffect Function();

class Effect {
  static const Effect cubeEffect = const Effect._('Cube', _createCubeEffect);
  static const Effect accordionEffect = const Effect._('Accordion', _createAccordionEffect);
  static const Effect backgroundToForegroundEffect =
  const Effect._('Background To Foreground', _createBackgroundToForegroundEffect);
  static const Effect foregroundToBackgroundEffect =
  const Effect._('Foreground To Background', _createForegroundToBackgroundEffect);
  static const Effect defaultEffect = const Effect._('Default', _createDefaultEffect);
  static const Effect depthEffect = const Effect._('Depth', _createDepthEffect);
  static const Effect flipHorizontalEffect = const Effect._('Flip Horizontal', _createFlipHorizontalEffect);
  static const Effect flipVerticalEffect = const Effect._('Flip Vertical', _createFlipVerticalEffect);
  static const Effect parallaxEffect = const Effect._('Parallax', _createParallaxEffect);
  static const Effect stackEffect = const Effect._('Stack', _createStackEffect);
  static const Effect tabletEffect = const Effect._('Tablet', _createTabletEffect);
  static const Effect rotateDownEffect = const Effect._('Rotate Down', _createRotateDownEffect);
  static const Effect rotateUpEffect = const Effect._('Rotate Up', _createRotateUpEffect);
  static const Effect zoomOutSlideEffect = const Effect._('Zoom Out', _createZoomOutSlideEffect);

  static const Iterable<Effect> values = const [
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
  String toString() => 'Effect{name: $name}';

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
}
