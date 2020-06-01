import 'package:dslideshow_flutter/src/model/effect.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:media_slider_widget/media_slider.dart';

void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Media Item Slider',
      home: MyHomePage(title: 'Media Item Slider'),
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
              transitionTime: const Duration(milliseconds: 500),
              itemCount: letters.length,
              slideBuilder: (index) => Container(
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
              ),
              slideEffect: _slideTransitionEffect.createEffect(),
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
