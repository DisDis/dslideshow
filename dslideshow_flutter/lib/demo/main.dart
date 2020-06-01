import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:media_slider_widget/effects/media_slider_item_effects.dart';
import 'package:media_slider_widget/media_slider.dart';
import 'package:media_slider_widget/media_slider_item_effect.dart';

void main() => runApp(MyApp());

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

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Carousel Slider Demo',
      home: MyHomePage(title: 'Flutter Carousel Slider'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Color> colors = [
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.indigo,
    Colors.purple,
  ];
  final List<String> letters = [
    "A",
    "B",
    "C",
    "D",
    "E",
    "F",
    "G",
  ];

  Effect _slideTransitionEffect = Effect.cubeEffect;
  bool _isPlaying = false;
  GlobalKey<MediaSliderState> _sliderKey = GlobalKey<MediaSliderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.transform),
            onPressed: () {
              showDialog<void>(
                context: context,
                builder: (context) => AlertDialog(
                  scrollable: true,
                  title: Text("Effects"),
                  content: StatefulBuilder(
                    builder: (context, setState) => Column(
                      mainAxisSize: MainAxisSize.min,
                      children: Effect.values
                          .map((Effect e) => _getEffectRadioButton(value: e, currentValue: _slideTransitionEffect))
                          .toList(),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          Container(
            height: 400,
            child: MediaSlider.builder(
              key: _sliderKey,
              unlimitedMode: true,
              autoSliderTransitionTime: Duration(seconds: 1),
              itemCount: letters.length,
              slideBuilder: (index) {
                return Container(
                  color: colors[index],
                  child: Center(
                    child: Text(
                      letters[index],
                      style: TextStyle(
                        fontSize: 200,
                        color: Colors.white,
                      ),
                    ),
                  ),
                );
              },
              slideEffect: _slideTransitionEffect.createEffect(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ConstrainedBox(
              constraints: BoxConstraints(minWidth: 240, maxWidth: 600),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    iconSize: 48,
                    icon: Icon(Icons.skip_previous),
                    onPressed: () {
                      _sliderKey.currentState.previousSlide();
                    },
                  ),
                  IconButton(
                    iconSize: 64,
                    icon: Icon(
                      _isPlaying ? Icons.pause_circle_outline : Icons.play_circle_outline,
                    ),
                    onPressed: () {
                      setState(
                        () {
                          _isPlaying = !_isPlaying;
                          _sliderKey.currentState.setPlaying(_isPlaying);
                        },
                      );
                    },
                  ),
                  IconButton(
                    iconSize: 48,
                    icon: Icon(Icons.skip_next),
                    onPressed: () {
                      _sliderKey.currentState.nextSlide();
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getEffectRadioButton({@required Effect value, @required Effect currentValue}) {
    return Row(
      children: <Widget>[
        Radio(
          value: value,
          groupValue: currentValue,
          onChanged: (Effect value) {
            setState(() {
              _slideTransitionEffect = value;
              Navigator.of(context).pop();
            });
          },
        ),
        Text(
          value.name,
          style: TextStyle(fontSize: 16),
        )
      ],
    );
  }
}
