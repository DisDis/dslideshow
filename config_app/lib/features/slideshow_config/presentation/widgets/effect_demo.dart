// ignore_for_file: implementation_imports

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/widgets/image_widget.dart';
import 'package:flutter/material.dart';
import 'package:dslideshow_backend/storage.dart';
import 'package:dslideshow_flutter/src/effect/effect.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/widgets/slideshow_loader_widget.dart';
import 'package:dslideshow_flutter/src/effect/media_slider_item_effect.dart';

class EffectDemoWidget extends StatefulWidget {
  final Effect currentEffect;
  const EffectDemoWidget({super.key, required this.currentEffect});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  EffectDemoWidgetState createState() => EffectDemoWidgetState();
}

class EffectDemoWidgetState extends State<EffectDemoWidget> with TickerProviderStateMixin {
  bool get isItemChanging => _currentWidget != _nextWidget;
  late AnimationController _mediaItemLoopController;
  late AnimationController _effectController;
  late final MediaSliderItemEffect _currentEffect = widget.currentEffect.createEffect();
  late final String effectTitle = widget.currentEffect.name;
  static const int transitionTimeMsValue = 1000;
  static const int displayTimeValue = 200;
  static const int repeatEffect = 2;
  // ignore: unused_field
  final AppConfig _appConfig = AppConfig.fromJson({});

  // final Directory _folder = new Directory(path.join(environment.externalStorage.path, 'images'));

  // Random _rnd = new Random();

  Widget _currentWidget = slideShowLoaderWidget;
  Widget _nextWidget = slideShowLoaderWidget;
  Widget _transitionWidget = slideShowLoaderWidget;

  @override
  void initState() {
    super.initState();

    const transitionTime = Duration(milliseconds: 2000);
    const displayTime = Duration(milliseconds: displayTimeValue);

    _effectController = AnimationController(duration: transitionTime, vsync: this);

    _effectController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _currentWidget = _nextWidget;
        });
      }
    });

    _mediaItemLoopController = AnimationController(duration: displayTime, vsync: this);

    _mediaItemLoopController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _fetchNextMediaItem();
      }
    });

    _mediaItemLoopController.forward();
  }

  @override
  void dispose() {
    _effectController.dispose();
    _mediaItemLoopController.dispose();
    super.dispose();
  }

  final List<MediaItem> _mediaItems = [];

  Future<MediaItem> _getNextItem() async {
    if (_mediaItems.isEmpty) {
      final items = [
        Uri.parse('http://192.168.50.143:8080/cache/123/get/AIwhur2ZikzgWevRNwD38jU4WO5PqyMIURfz-xN_RYDP0dEJpWbkNXPRIDqY2UItoHTLKZsVKUSg_2560x1600.jpeg'),
        Uri.parse('http://192.168.50.143:8080/cache/123/get/AIwhur2NgCqrUIjqXOzX1FjCNTeIs4GqGX9kifFSbhvi9vSJiND3SAqTbXQqTs15oC_cqj2Z-8Oi_2560x1600.jpeg'),
        Uri.parse(
            'http://192.168.50.143:8080/cache/123/get/AIwhur23zNAQK1bHNZGzQv6CIEHUX_VxDW3P0RS4MPGycT8x2pE25sa57-RBG-74P76mecaE6OQk13-kaHBKNpEt6OeoyhX8Jw_2560x1600.jpeg')
      ];
      _mediaItems.addAll(items.map((e) => MediaItem(e.path, e)));
    }
    return _mediaItems.removeLast(); //removeAt(_rnd.nextInt(_mediaItems.length));
  }

//
  void _fetchNextMediaItem() async {
    var mediaItem = await _getNextItem();
    Widget itemWidget;
    itemWidget = CachedNetworkImage(
      imageUrl: mediaItem.uri.toString(),
      errorWidget: (BuildContext context, String url, error) {
        return Row(
          children: [Text('Not found "${mediaItem.id}'), const Icon(Icons.error)],
        );
      },
    );

    if (itemWidget is ImageWidget) {
      // ignore: use_build_context_synchronously
      await itemWidget.precache(context);
    }
    // ignore: use_build_context_synchronously
    final size = MediaQuery.of(context).size;
    final screenW = size.width;
    final screenH = size.height;
    _nextWidget = SizedBox(width: screenW, height: screenH, child: itemWidget);
    _transitionWidget = AnimatedBuilder(
        key: const Key('anim'),
        animation: _effectController,
        builder: (_, __) {
          return Stack(children: <Widget>[
            _currentEffect.transform(context, _currentWidget, true /*,0,0*/, _effectController.value /*, 2*/, screenW, screenH),
            _currentEffect.transform(context, _nextWidget, false /*1, 0*/, _effectController.value /*, 1*/, screenW, screenH)
          ]);
        },
        child: slideShowLoaderWidget);

    _effectController.reset();
    _mediaItemLoopController.reset();
    setState(() {});
    try{
    await _effectController.forward().orCancel;
    } catch(_){

    }
    _mediaItemLoopController.forward();
  }

  // _changeEffect() {
  //   _effectCountdown = repeatEffect;
  //   if (_effectPool.isEmpty) {
  //     _effectPool.addAll(Effect.values);
  //     //_effectPool.shuffle(_rnd);
  //   }
  //   var tmp = _effectPool.removeLast();
  //   effectTitle = tmp.name;
  //   _currentEffect = tmp.createEffect();
  // }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Container(
      height: size.height,
      color: Colors.black,
      child: !isItemChanging ? _currentWidget : _transitionWidget,
    )
        // This trailing comma makes auto-formatting nicer for build methods.
        ;
  }
}
