import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:media_slider_widget/effects/media_slider_item_effects.dart';
import 'package:media_slider_widget/media_slider.dart';
import 'package:media_slider_widget/media_slider_item_effect.dart';

void main() => runApp(MyApp());

enum Effects {
  CubeEffect,
  AccordionEffect,
  BackgroundToForegroundEffect,
  ForegroundToBackgroundEffect,
  DefaultEffect,
  DepthEffect,
  FlipHorizontalEffect,
  FlipVerticalEffect,
  ParallaxEffect,
  StackEffect,
  TabletEffect,
  RotateDownEffect,
  RotateUpEffect,
  ZoomOutSlideEffect,
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

  Effects _transform = Effects.CubeEffect;
  MediaSliderItemEffect _slideEffect = CubeEffect();

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
              showDialog(
                barrierDismissible: true,
                context: context,
                builder: (context) {
                  return AlertDialog(
                    scrollable: true,
                    title: Text("Effects"),
                    content: StatefulBuilder(
                      builder: (context, setState) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            _getEffectRadio(Effects.CubeEffect, _transform, setState),
                            _getEffectRadio(Effects.ZoomOutSlideEffect, _transform, setState),
                            _getEffectRadio(Effects.RotateUpEffect, _transform, setState),
                            _getEffectRadio(Effects.RotateDownEffect, _transform, setState),
                            _getEffectRadio(Effects.TabletEffect, _transform, setState),
                            _getEffectRadio(Effects.StackEffect, _transform, setState),
                            _getEffectRadio(Effects.ParallaxEffect, _transform, setState),
                            _getEffectRadio(Effects.ForegroundToBackgroundEffect, _transform, setState),
                            _getEffectRadio(Effects.FlipVerticalEffect, _transform, setState),
                            _getEffectRadio(Effects.DepthEffect, _transform, setState),
                            _getEffectRadio(Effects.BackgroundToForegroundEffect, _transform, setState),
                            _getEffectRadio(Effects.AccordionEffect, _transform, setState),
                            _getEffectRadio(Effects.DefaultEffect, _transform, setState),
                            _getEffectRadio(Effects.FlipHorizontalEffect, _transform, setState),
                          ],
                        );
                      },
                    ),
                  );
                },
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
              slideEffect: _slideEffect,
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
                      _sliderKey.currentState.previousPage();
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
                      _sliderKey.currentState.nextPage();
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

  MediaSliderItemEffect _getEffect(Effects transform) {
    switch (transform) {
      case Effects.CubeEffect:
        return CubeEffect();
      case Effects.AccordionEffect:
        return AccordionEffect();
      case Effects.BackgroundToForegroundEffect:
        return BackgroundToForegroundEffect();
      case Effects.ForegroundToBackgroundEffect:
        return ForegroundToBackgroundEffect();
      case Effects.DefaultEffect:
        return DefaultEffect();
      case Effects.DepthEffect:
        return DepthEffect();
      case Effects.FlipHorizontalEffect:
        return FlipHorizontalEffect();
      case Effects.FlipVerticalEffect:
        return FlipVerticalEffect();
      case Effects.ParallaxEffect:
        return ParallaxEffect();
      case Effects.StackEffect:
        return StackEffect();
      case Effects.TabletEffect:
        return TabletEffect();
      case Effects.RotateDownEffect:
        return RotateDownEffect();
      case Effects.RotateUpEffect:
        return RotateUpEffect();
      case Effects.ZoomOutSlideEffect:
        return ZoomOutEffect();
    }
    return CubeEffect();
  }

  Widget _getEffectRadio(value, groupValue, state) {
    return _getRadio(value, groupValue, (value) {
      setState(() {
        _transform = value;
        _slideEffect = _getEffect(value);
        state(() {});
        Navigator.of(context).pop();
      });
    });
  }

  Widget _getRadio(value, groupValue, onChange) {
    return Row(
      children: <Widget>[
        Radio(
          value: value,
          groupValue: groupValue,
          onChanged: onChange,
        ),
        Text(
          value.toString().split('.').last,
          style: TextStyle(fontSize: 16),
        )
      ],
    );
  }
}
