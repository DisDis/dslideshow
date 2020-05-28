import 'dart:io';

import 'package:dslideshow_flutter/src/app_reducer.dart';
import 'package:dslideshow_flutter/src/data_model/global_state.dart';
import 'package:dslideshow_flutter/src/injector.dart';
import 'package:dslideshow_flutter/src/page/common/common_header.dart';
import 'package:dslideshow_flutter/src/page/common/debug_widget.dart';
import 'package:dslideshow_flutter/src/page/common/system_info_widget.dart';
import 'package:dslideshow_flutter/src/page/slideshow/timer_progress_bar.dart';
import 'package:dslideshow_flutter/src/page/slideshow/video_widget.dart';
import 'package:dslideshow_flutter/src/service/frontend.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart' as path;
import 'package:dslideshow_flutter/environment.dart' as environment;
import 'package:dslideshow_backend/src/service/storage/storage.dart';

import 'fade_widget.dart';

class SlideShowPage extends StatefulWidget {
  SlideShowPage({Key key}) : super(key: key);

  @override
  _SlideShowPageState createState() => _SlideShowPageState();
}

class _SlideShowPageState extends State<SlideShowPage> with TickerProviderStateMixin {
  static final Logger _log = new Logger('_SlideShowPageState');
  AnimationController controller;
  int _listItemCount = 2;
  // Outside build method
  PageController _pageController;

  final FrontendService _frontendService = injector.get(FrontendService) as FrontendService;

  AnimationController _fadeController;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(duration: const Duration(seconds: 2), vsync: this);
    _fadeController.addStatusListener((status) {
      if (status == AnimationStatus.dismissed) {
        _fadeController.reset();
      }
    });

    _pageController = PageController(initialPage: 1, keepPage: false);
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

  void _changeImage() async {
    _log.info('Change image');
    await _frontendService.storageNext();
    _pageController.animateToPage(_pageController.page.toInt() + 1,
        duration: Duration(milliseconds: 500), curve: Curves.easeIn);
  }

  Future<String> _getCurrentMedia() async {
    var item = await _frontendService.getStorageCurrentItem();
    return item.uri.path;
  }

  Future<String> _getNextMedia() async {
    var item = await _frontendService.getStorageNextItem();
    return item.uri.path;
  }

  Map<int, String> _mediaCache = new Map<int, String>();
  Future<String> _getMedia(int position, int length) async {
    var item = _mediaCache[position];
    if (item != null) {
      return item;
    }
    item = await (length == position ? _getCurrentMedia() : _getNextMedia());
    if (_mediaCache.length > 10) {
      _mediaCache.remove(_mediaCache.keys.first);
    }
    _mediaCache[position] = item;
    return item;
  }

  bool _isVideo(String fileName) {
    return path.extension(fileName).toLowerCase() == '.mp4';
  }

  //TODO: https://github.com/google/flutter-desktop-embedding/issues/255
  static final bool isVideoSupport = !(Platform.isLinux || Platform.isWindows);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: new Stack(
      children: <Widget>[
        new Container(
          height: MediaQuery.of(context).size.height,
          color: Colors.black,
          child: PageView.builder(
            controller: _pageController,
            itemBuilder: (context, position) {
              _listItemCount = position + 2;
              return Center(
                child: FutureBuilder<String>(
                    future: _getMedia(position, _pageController.page.toInt()),
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
              );
            },
            itemCount: _listItemCount,
          ),
        ),
        new Container(
          child: CommonHeaderWidget(),
        ),
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
        DebugWidget()
      ],
    ));
  }

  @override
  void dispose() {
    _pageController.dispose();
    controller.dispose();
    super.dispose();
  }

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
