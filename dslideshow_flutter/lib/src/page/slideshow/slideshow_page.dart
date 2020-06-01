import 'dart:io';

import 'package:dslideshow_flutter/src/injector.dart';
import 'package:dslideshow_flutter/src/model/effect.dart';
import 'package:dslideshow_flutter/src/page/common/common_header.dart';
import 'package:dslideshow_flutter/src/page/slideshow/timer_progress_bar.dart';
import 'package:dslideshow_flutter/src/page/slideshow/video_widget.dart';
import 'package:dslideshow_flutter/src/service/frontend.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:logging/logging.dart';
import 'package:media_slider_widget/media_slider.dart';
import 'package:path/path.dart' as path;

import 'fade_widget.dart';

class SlideShowPage extends StatefulWidget {
  SlideShowPage({Key key}) : super(key: key);

  @override
  _SlideShowPageState createState() => _SlideShowPageState();
}

class _SlideShowPageState extends State<SlideShowPage> with TickerProviderStateMixin {
  static final Logger _log = new Logger('_SlideShowPageState');
  static final bool isVideoSupport = !(Platform.isLinux || Platform.isWindows);
  AnimationController controller;

  int _listItemCount = 2;

  final FrontendService _frontendService = injector.get(FrontendService) as FrontendService;

  AnimationController _fadeController;

  Map<int, String> _mediaCache = new Map<int, String>();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: new Stack(
        children: <Widget>[
          new Container(
            height: MediaQuery.of(context).size.height,
            color: Colors.black,
            child: _createMediaSlider(),
          ),
          new Container(child: CommonHeaderWidget()),
          new Container(
              child: Positioned(
                  bottom: 0.0,
                  right: 0.0,
                  child: CustomPaint(
                    size: Size(MediaQuery.of(context).size.width, 3),
                    painter: TimerProgressBarPainter(controller.value * 100),
                  ))),
          FadeWidget(animation: _fadeController),
          Positioned(
              right: 0,
              child: RaisedButton(
//                padding: EdgeInsets.only(left: 500.0, right: 100),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/config');
                },
              )),

//              Text(
//                'You have times:',
//                style: TextStyle(color: Colors.white, fontSize: 10),
//              ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(duration: const Duration(seconds: 2), vsync: this);
    _fadeController.addStatusListener((status) {
      if (status == AnimationStatus.dismissed) {
        _fadeController.reset();
      }
    });

    controller = AnimationController(duration: const Duration(seconds: 5), vsync: this);
    controller.addListener(() {
      setState(() {});
    });
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _changeImage();
        controller.reset();
        controller.forward();
      }
    });
    controller.forward();
    _frontendService.onScreenStateChangePreparation.listen(_screenStateChangePreparation);
  }

  //TODO: https://github.com/google/flutter-desktop-embedding/issues/255
  void _changeImage() async {
    _log.info('Change image');
    await _frontendService.storageNext();
  }

  Widget _createMediaSlider() {
    final widget = MediaSlider.builder(
      slideEffect: Effect.cubeEffect.createEffect(),
      isAutoPlay: true,
      unlimitedMode: true,
      transitionTime: const Duration(milliseconds: 500),
      itemCount: _listItemCount,
      slideBuilder: (index) {
        _listItemCount = index + 2;

        return Container(
          child: Center(
            child: FutureBuilder<String>(
                future: _getMedia(index),
                builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                  if (snapshot.hasData) {
                    return _isVideo(snapshot.data)
                        ? (isVideoSupport ? VideoWidget(snapshot.data) : Container())
                        : Image.file(new File(snapshot.data));
                  } else {
                    return SizedBox(
                      child: CircularProgressIndicator(),
                      width: 60,
                      height: 60,
                    );
                  }
                }),
          ),
        );
      },
    );

    return widget;
  }

  Future<String> _getCurrentMedia() async {
    var item = await _frontendService.getStorageCurrentItem();
    return item.uri.path;
  }

  ///
  /// todo: check logic to call get next media item
  ///
  Future<String> _getMedia(int position) async {
    var item = _mediaCache[position];
    if (item != null) {
      return item;
    }
    item = await (true ? _getCurrentMedia() : _getNextMedia());
    if (_mediaCache.length > 10) {
      _mediaCache.remove(_mediaCache.keys.first);
    }
    _mediaCache[position] = item;
    return item;
  }

  Future<String> _getNextMedia() async {
    var item = await _frontendService.getStorageNextItem();
    return item.uri.path;
  }

  bool _isVideo(String fileName) => path.extension(fileName).toLowerCase() == '.mp4';

  void _screenStateChangePreparation(bool enabled) {
    // Screen OFF
    if (enabled == false) {
      controller.stop();
      _fadeController.forward();
    } else {
      controller.forward();
      _fadeController.reverse();
    }
  }
}
