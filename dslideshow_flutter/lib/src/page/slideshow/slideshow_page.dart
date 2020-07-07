import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_backend/src/command/hardware_commands.dart';
import 'package:dslideshow_backend/src/service/system_info/system_info.dart';
import 'package:dslideshow_backend/storage.dart';
import 'package:dslideshow_flutter/src/injector.dart';
import 'package:dslideshow_flutter/src/page/common/common_header.dart';
import 'package:dslideshow_flutter/src/page/common/debug_widget.dart';
import 'package:dslideshow_flutter/src/page/common/state_notify_widget.dart';
import 'package:dslideshow_flutter/src/page/slideshow/image_widget.dart';
import 'package:dslideshow_flutter/src/page/slideshow/timer_progress_bar.dart';
import 'package:dslideshow_flutter/src/page/slideshow/video_widget.dart';
import 'package:dslideshow_flutter/src/page/system_info_widget/system_info_widget.dart';
import 'package:dslideshow_flutter/src/redux/actions/change_debug_action.dart';
import 'package:dslideshow_flutter/src/redux/actions/change_internet_action.dart';
import 'package:dslideshow_flutter/src/redux/actions/change_pause_action.dart';
import 'package:dslideshow_flutter/src/redux/actions/change_screen_lock_action.dart';
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
  final AppConfig _appConfig = injector.get(AppConfig) as AppConfig;

  AnimationController _fadeController;
  final Random _rnd = Random(DateTime.now().millisecondsSinceEpoch);
  final Map<int, Widget> _mediaCache = Map<int, Widget>();
  Effect _currentEffect = Effect.cubeEffect;

  final List<StreamSubscription> _subs = <StreamSubscription>[];

  Duration _transitionTime;

  bool _screenState = true;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: StoreConnector<GlobalState, Store<GlobalState>>(
          converter: (store) => store,
          onDidChange: (newStore) {
            _stateKey.currentState.isPaused = newStore.state.isPaused;
          },
          builder: (context, Store<GlobalState> store) {
            return Container(
              child: Stack(
                children: <Widget>[
                  Container(
                    height: size.height,
                    color: Colors.black,
                    child: _createMediaSlider(),
                  ),
                  //  /* remove it to get it transparent */ if (store.state.isDebug) DebugWidget(),
                  if (store.state.isDebug)
                    Container(
                      color: Colors.black,
                      child: DebugWidget(),
                    ),
                  Container(
                    child: Positioned(
                      bottom: 0.0,
                      right: 0.0,
                      child: CustomPaint(
                        size: Size(size.width, 3),
                        painter: TimerProgressBarPainter(_mediaItemLoopController.value * 100),
                      ),
                    ),
                  ),
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
                  Container(child: CommonHeaderWidget()),
                ],
              ),
            );
          }),
    );
  }

  @override
  void dispose() {
    _mediaItemLoopController.dispose();
    _fadeController.dispose();
    _subs.forEach((element) {
      element.cancel();
    });
    _subs.clear();
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

    _transitionTime = Duration(milliseconds: _appConfig.slideshow.transitionTimeMs);
    final fadeTime = Duration(milliseconds: _appConfig.slideshow.fadeTimeMs);
    _fadeController = AnimationController(duration: fadeTime, vsync: this);
    _fadeController.addStatusListener((status) {
      if (status == AnimationStatus.dismissed) {
        _fadeController.reset();
      }
    });

    final displayTime = Duration(milliseconds: _appConfig.slideshow.displayTimeMs);
    _mediaItemLoopController = AnimationController(duration: displayTime, vsync: this);

    _mediaItemLoopController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _fetchNextMediaItem();
      }
    });

    _mediaItemLoopController.forward();

    _subs.add(_frontendService.onScreenStateChangePreparation.listen(_screenStateChangePreparation));
    _subs.add(_frontendService.onSystemInfoUpdate.listen(_systemInfoChanged));
    _subs.add(_frontendService.onPushButton.listen(_pushButton));
  }

  Widget _createMediaSlider() {
    final widget = MediaSlider.builder(
      key: _sliderKey,
      isAutoPlay: false,
      slideEffect: _currentEffect.createEffect(),
      unlimitedMode: true,
      transitionTime: _transitionTime,
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
              ),
            ),
          );
        }
        return Container(
            width: MediaQuery.of(context).size.width, height: MediaQuery.of(context).size.height, child: data);
      },
    );

    return widget;
  }

  void _fetchNextMediaItem() async {
    _log.info('Change image');
    // cached next image
    await _frontendService.storageNext();
    var item = await _getMediaWidget(_listItemCount - 1);
    if (item is ImageWidget) {
      await precacheImage(item.provider, context);
    }

    _listItemCount++;
    _currentEffect = Effect.values.elementAt(_rnd.nextInt(Effect.values.length));
    await _sliderKey.currentState.nextSlide();
    _mediaItemLoopController.reset();
    _mediaItemLoopController.forward();
    setState(() {});
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

  bool _isVideo(MediaItem item) => item.uri == null ? false : path.extension(item.uri.path).toLowerCase() == '.mp4';
  void _pushButton(ButtonType event) {
    switch (event) {
      case ButtonType.pause:
        _pushPauseButton();
        break;
      case ButtonType.screentoggle:
        _pushScreenToggleButton();
        break;
      case ButtonType.menu:
        _pushMenuButton();
        break;
    }
  }

  void _pushMenuButton() {
    final _store = _frontendService.store;
    _store.dispatch(ChangeDebugAction(!_store.state.isDebug));
  }

  void _pushPauseButton() {
    final _store = _frontendService.store;
    var isPausedNewValue = !_store.state.isPaused;
    _store.dispatch(ChangePauseAction(isPausedNewValue));
    if (isPausedNewValue) {
      _mediaItemLoopController.stop();
    } else {
      _mediaItemLoopController.forward();
    }
  }

  Future _pushScreenToggleButton() async {
    final _store = _frontendService.store;
    var isScreenLockNewValue = !_store.state.isScreenLock;
    //_frontendService.LEDControl(LEDType.power, !_store.state.hasInternet);
    //_store.dispatch(ChangeInternetAction(!_store.state.hasInternet));
    _store.dispatch(ChangeScreenLockAction(isScreenLockNewValue));
    await _frontendService.changeScreenLock(isScreenLockNewValue);
    if (isScreenLockNewValue) {
      _frontendService.screenTurn(false);
    } else {
      _frontendService.screenTurn(true);
    }
  }

  void _restorePlayPauseState() {
    final _store = _frontendService.store;
    if (_store.state.isPaused) {
      _mediaItemLoopController.stop();
    } else {
      _mediaItemLoopController.forward();
    }
  }

  void _screenStateChangePreparation(bool enabled) async {
    // Screen OFF
    _screenState = enabled;
    if (enabled == false) {
      _mediaItemLoopController.stop();
      _fadeController.forward();
    } else {
      await Future<void>.delayed(Duration(seconds: 4));
      // Double check, after delay
      if (_screenState == enabled) {
        _fadeController.reverse();
        _restorePlayPauseState();
      }
    }
  }

  void _systemInfoChanged(SystemInfo info) {
    _log.info(info.updateInfo);
  }
}
