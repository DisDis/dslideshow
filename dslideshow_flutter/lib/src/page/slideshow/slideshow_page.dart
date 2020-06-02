import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:dslideshow_backend/storage.dart';
import 'package:dslideshow_flutter/src/injector.dart';
import 'package:dslideshow_flutter/src/page/common/common_header.dart';
import 'package:dslideshow_flutter/src/page/common/debug_widget.dart';
import 'package:dslideshow_flutter/src/page/common/state_notify_widget.dart';
import 'package:dslideshow_flutter/src/page/slideshow/image_widget.dart';
import 'package:dslideshow_flutter/src/page/slideshow/timer_progress_bar.dart';
import 'package:dslideshow_flutter/src/page/slideshow/video_widget.dart';
import 'package:dslideshow_flutter/src/redux/state/global_state.dart';
import 'package:dslideshow_flutter/src/service/frontend.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:logging/logging.dart';
import 'package:media_slider_widget/effect.dart';
import 'package:media_slider_widget/media_slider.dart';
import 'package:path/path.dart' as path;
import 'package:redux/redux.dart';

import 'fade_widget.dart';

class SlideShowPage extends StatefulWidget {
  SlideShowPage({Key key}) : super(key: key);

  @override
  _SlideShowPageState createState() => _SlideShowPageState();
}

class _SlideShowPageState extends State<SlideShowPage> with TickerProviderStateMixin {
  static final Logger _log = Logger('_SlideShowPageState');
  static GlobalKey<MediaSliderState> _sliderKey = GlobalKey<MediaSliderState>();
  static GlobalKey<StateNotifyState> _stateKey = GlobalKey<StateNotifyState>();

  AnimationController _mediaItemLoopController;

  int _listItemCount = 2;

  final FrontendService _frontendService = injector.get(FrontendService) as FrontendService;
  AnimationController _fadeController;
  Random _rnd = Random(DateTime.now().millisecondsSinceEpoch);
  Map<int, Widget> _mediaCache = Map<int, Widget>();
  Effect _currentEffect = Effect.cubeEffect;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        child: Stack(
          children: <Widget>[
            Container(
              height: size.height,
              color: Colors.black,
              child: _createMediaSlider(),
            ),
            Container(child: CommonHeaderWidget()),
            Container(
                child: Positioned(
                    bottom: 0.0,
                    right: 0.0,
                    child: CustomPaint(
                      size: Size(size.width, 3),
                      painter: TimerProgressBarPainter(_mediaItemLoopController.value * 100),
                    ))),
            StoreConnector<GlobalState, Store<GlobalState>>(
                converter: (store) => store,
                //rebuildOnChange: true,
                onDidChange: (newStore) {
                  _stateKey.currentState.isPaused = newStore.state.isPaused;
                },
                builder: (context, Store<GlobalState> store) {
                  return StateNotify(key: _stateKey, isPaused: store.state.isPaused);
                }),
            FadeWidget(animation: _fadeController),
            DebugWidget(),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _mediaItemLoopController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  Widget getMediaFromCache(int position) {
    var item = _mediaCache[position];
    if (item != null) {
      return item;
    }
    return null;
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

    _mediaItemLoopController = AnimationController(duration: const Duration(seconds: 5), vsync: this);
    _mediaItemLoopController.addListener(() {
      setState(() {});
    });

    _mediaItemLoopController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _fetchNextMediaItem();

        _mediaItemLoopController.reset();
        _mediaItemLoopController.forward();
      }
    });

    _mediaItemLoopController.forward();

    _frontendService.onScreenStateChangePreparation.listen(_screenStateChangePreparation);
  }

  Widget _createMediaSlider() {
    final widget = MediaSlider.builder(
      key: _sliderKey,
      isAutoPlay: false,
      slideEffect: _currentEffect.createEffect(),
      unlimitedMode: true,
      transitionTime: const Duration(milliseconds: 500),
      itemCount: _listItemCount,
      slideBuilder: (index) {
        var data = getMediaFromCache(index);
        if (data == null) {
          return Container(
              child: Center(
                  child: SizedBox(
            child: CircularProgressIndicator(),
            width: 60,
            height: 60,
          )));
        }
        return Container(
          child: Center(child: data),
        );
      },
    );

    return widget;
  }

  void _fetchNextMediaItem() async {
    _log.info('Change image');
    // cached next image
    await _frontendService.storageNext();
    var item = await _getMediaWidget(_listItemCount - 1);
    if (item is ImageWidget){
//      if (!item.provider.resolve(ImageConfiguration.empty).completer.hasListeners){
        final _completer = new Completer<void>();
        item.provider.resolve(ImageConfiguration.empty).completer.addListener(new ImageStreamListener((info, bool sync){
//          _log.info('image loaded');
          _completer.complete();
        }));
        await _completer.future;
//      }

    }

    _listItemCount++;
    _currentEffect = Effect.values.elementAt(_rnd.nextInt(Effect.values.length));
    _sliderKey.currentState.nextSlide();
  }

  Future<MediaItem> _getCurrentMediaItem() async {
    var item = await _frontendService.getStorageCurrentItem();
    return item;
  }

  Future<Widget> _getMediaWidget(int position) async {
    var itemWidget = _mediaCache[position];
    if (itemWidget != null) {
      return itemWidget;
    }

    var mediaItem = await _getCurrentMediaItem();
    itemWidget = _isVideo(mediaItem) ? VideoWidget(mediaItem) : ImageWidget(mediaItem);

    if (_mediaCache.length > 10) {
      _mediaCache.remove(_mediaCache.keys.first);
    }
    _mediaCache[position] = itemWidget;
    return itemWidget;
  }

  //TODO: https://github.com/google/flutter-desktop-embedding/issues/255
  bool _isVideo(MediaItem item) => path.extension(item.uri.path).toLowerCase() == '.mp4';

  void _screenStateChangePreparation(bool enabled) {
    // Screen OFF
    if (enabled == false) {
      _mediaItemLoopController.stop();
      _fadeController.forward();
    } else {
      _mediaItemLoopController.forward();
      _fadeController.reverse();
    }
  }
}
