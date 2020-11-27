import 'dart:async';
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
import 'package:media_slider_widget/media_slider_item_effect.dart';
import 'package:path/path.dart' as path;
import 'package:redux/redux.dart';

import 'fade_widget.dart';

class SlideShowPage extends StatefulWidget {
  SlideShowPage({Key key}) : super(key: key);

  @override
  _SlideShowPageState createState() => _SlideShowPageState();
}

class _SlideShowPageState extends State<SlideShowPage>
    with TickerProviderStateMixin {
  static final Logger _log = Logger('_SlideShowPageState');
  static GlobalKey<StateNotifyState> _stateKey = GlobalKey<StateNotifyState>();

  AnimationController _mediaItemLoopController;
  AnimationController _effectController;

  Widget _currentWidget = null;
  Widget _nextWidget = null;

  final FrontendService _frontendService =
      injector.get(FrontendService) as FrontendService;
  final AppConfig _appConfig = injector.get(AppConfig) as AppConfig;

  AnimationController _fadeController;
  static final Random _rnd = Random();
  MediaSliderItemEffect _currentEffect = Effect.cubeEffect.createEffect();
  final List<Effect> _effectPool = [];

  final List<StreamSubscription> _subs = <StreamSubscription>[];

  Duration _transitionTime;

  bool _screenState = true;

  bool get isItemChaging => _currentWidget != _nextWidget;

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
                  // if (!store.state.isDebug)
                  //   Container(
                  //     child: Positioned(
                  //       bottom: 0.0,
                  //       right: 0.0,
                  //       child: CustomPaint(
                  //         size: Size(size.width, 3),
                  //         painter: TimerProgressBarPainter(_mediaItemLoopController.value * 100),
                  //       ),
                  //     ),
                  //   ),
                  StoreConnector<GlobalState, Store<GlobalState>>(
                      converter: (store) => store,
                      //rebuildOnChange: true,
                      onDidChange: (newStore) {
                        _stateKey.currentState.isPaused =
                            newStore.state.isPaused;
                      },
                      builder: (context, Store<GlobalState> store) {
                        return StateNotify(
                            key: _stateKey, isPaused: store.state.isPaused);
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
    _effectController.dispose();
    _mediaItemLoopController.dispose();
    _fadeController.dispose();
    _subs.forEach((element) {
      element.cancel();
    });
    _subs.clear();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _transitionTime =
        Duration(milliseconds: _appConfig.slideshow.transitionTimeMs);
    final fadeTime = Duration(milliseconds: _appConfig.slideshow.fadeTimeMs);

    _effectController =
        AnimationController(duration: _transitionTime, vsync: this);
    //Curves.easeOutQuad;
    _effectController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _currentWidget = _nextWidget;
        });
        imageCache.clear();
      }
    });
    // _effectController.addListener(() {
    //   setState(() {});
    // });

    _fadeController = AnimationController(duration: fadeTime, vsync: this);
    _fadeController.addStatusListener((status) {
      if (status == AnimationStatus.dismissed) {
        _fadeController.reset();
      }
    });

    final displayTime =
        Duration(milliseconds: _appConfig.slideshow.displayTimeMs);
    _mediaItemLoopController =
        AnimationController(duration: displayTime, vsync: this);

    _mediaItemLoopController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _fetchNextMediaItem();
      }
    });

    _mediaItemLoopController.forward();

    _subs.add(_frontendService.onScreenStateChangePreparation
        .listen(_screenStateChangePreparation));
    _subs.add(_frontendService.onSystemInfoUpdate.listen(_systemInfoChanged));
    _subs.add(_frontendService.onPushButton.listen(_pushButton));
  }

  final _loaderWidget = Container(
    key: Key('loader'),
    child: Center(
      child: SizedBox(
        child: CircularProgressIndicator(),
        width: 60,
        height: 60,
      ),
    ),
  );

  Widget _createMediaSlider() {
    final screenW = MediaQuery.of(context).size.width;
    final screenH = MediaQuery.of(context).size.height;

    final _currentWidgetC =
    _currentWidget == null ? _loaderWidget : Container(width: screenW, height: screenH, child: _currentWidget);
    final _nextWidgetC = Container(width: screenW, height: screenH, child: _nextWidget);

    return !isItemChaging
        ? _currentWidgetC
        : AnimatedBuilder(
        animation: _effectController,
        builder: (_, __) {
          return Stack(children: <Widget>[
            Transform.translate(
                offset: Offset(-_effectController.value * screenW, 0.0),
                child: _currentEffect.transform(context, _currentWidgetC, 0, 0, _effectController.value, 2)),
            Transform.translate(
                offset: Offset(screenW - _effectController.value * screenW, 0.0),
                child: _currentEffect.transform(context, _nextWidgetC, 1, 0, _effectController.value, 1))
          ]);
        },
        child: _loaderWidget);
  }

  void _fetchNextMediaItem() async {
    _log.info('Change image');
    await _frontendService.storageNext();
    var mediaItem = await _getCurrentMediaItem();
    var itemWidget = _isVideo(mediaItem) ? VideoWidget(mediaItem) : ImageWidget(mediaItem);
    if (mediaItem != null) {
      _log.info('file: "${path.basename(mediaItem.uri.toFilePath())}"');
    }
    _log.info('imageCache.liveImageCount = ${imageCache.liveImageCount}, .currentSize = ${imageCache.currentSize}');

    if (itemWidget is ImageWidget) {
      await precacheImage(itemWidget.provider, context);
    }
    _nextWidget = itemWidget;

    _effectController.reset();
    _mediaItemLoopController.reset();
    if (_effectPool.isEmpty) {
      _effectPool.addAll(Effect.values);
      _effectPool.shuffle(_rnd);
    }
    _currentEffect = _effectPool.removeLast().createEffect();
    setState(() {});
    await _effectController.forward().orCancel;
    _mediaItemLoopController.forward();
  }

  Future<MediaItem> _getCurrentMediaItem() async {
    var item = await _frontendService.getStorageCurrentItem();
    return item;
  }

  bool _isVideo(MediaItem item) => item.uri == null
      ? false
      : path.extension(item.uri.path).toLowerCase() == '.mp4';

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
