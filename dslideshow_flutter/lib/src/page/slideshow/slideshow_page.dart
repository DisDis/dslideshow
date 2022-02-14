import 'dart:async';
import 'dart:math';

import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_backend/src/command/hardware_commands.dart';
import 'package:dslideshow_backend/src/service/system_info/system_info.dart';
import 'package:dslideshow_backend/storage.dart';
import 'package:dslideshow_flutter/environment.dart';
import 'package:dslideshow_flutter/src/effect/effect.dart';
import 'package:dslideshow_flutter/src/effect/media_slider_item_effect.dart';
import 'package:dslideshow_flutter/src/injector.dart';
import 'package:dslideshow_flutter/src/page/common/common_header.dart';
import 'package:dslideshow_flutter/src/page/common/debug_widget.dart';
import 'package:dslideshow_flutter/src/page/common/state_notify_widget.dart';
import 'package:dslideshow_flutter/src/page/ota/ota_page.dart';
import 'package:dslideshow_flutter/src/page/slideshow/image_widget.dart';
import 'package:dslideshow_flutter/src/page/slideshow/video_widget.dart';
import 'package:dslideshow_flutter/src/redux/actions/change_debug_action.dart';
import 'package:dslideshow_flutter/src/redux/actions/change_menu_action.dart';
import 'package:dslideshow_flutter/src/redux/actions/change_pause_action.dart';
import 'package:dslideshow_flutter/src/redux/actions/change_screen_lock_action.dart';
import 'package:dslideshow_flutter/src/redux/state/global_state.dart';
import 'package:dslideshow_flutter/src/service/frontend.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart' as path;
import 'package:redux/redux.dart';

import 'fade_widget.dart';

class SlideShowPage extends StatefulWidget {
  SlideShowPage({Key? key}) : super(key: key);

  @override
  _SlideShowPageState createState() => _SlideShowPageState();
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

class _SlideShowPageState extends State<SlideShowPage> with TickerProviderStateMixin {
  static final Logger _log = Logger('_SlideShowPageState');
  static GlobalKey<StateNotifyState> _stateKey = GlobalKey<StateNotifyState>();

  late AnimationController _mediaItemLoopController;
  late AnimationController _effectController;

  Widget _currentWidget = _loaderWidget;
  Widget _nextWidget = _loaderWidget;
  Widget _transitionWidget = _loaderWidget;

  final FrontendService _frontendService = injector.get<FrontendService>();
  final AppConfig _appConfig = injector.get<AppConfig>();

  late AnimationController _fadeController;
  static final Random _rnd = Random();
  MediaSliderItemEffect _currentEffect = Effect.cubeEffect.createEffect();
  final List<Effect> _effectPool = [];
  final List<Effect> _allowedEffects = <Effect>[];

  final List<StreamSubscription> _subs = <StreamSubscription>[];

  Duration? _transitionTime;

  bool _screenState = true;
  bool _isPaused = false;

  bool get isItemChanging => _currentWidget != _nextWidget;

  Key _fadeWidgetKey = Key('fadeWidget');

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        body: Stack(
      children: <Widget>[
        Container(
          height: size.height,
          color: Colors.black,
          child: !isItemChanging ? _currentWidget : _transitionWidget,
        ),
        StateNotify(key: _stateKey, isPaused: _isPaused),
        FadeWidget(key: _fadeWidgetKey, animation: _fadeController),
        if (!isLinuxEmbedded)
          StoreConnector<GlobalState, Store<GlobalState>>(
              converter: (store) => store,
              builder: (context, Store<GlobalState> store) {
                return store.state.isDebug ? DebugWidget(_frontendService) : Container();
              }),
        CommonHeaderWidget(),
      ],
    ));
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

    _subs.add(_frontendService.onOTAReady.listen((value) {
      OTAPage.processingOTAReady(context, value);
    }));

    final allowedETmp = _appConfig.slideshow.allowedEffects;
    _log.info('Config effects = ${allowedETmp}');
    if (allowedETmp.isNotEmpty) {
      _allowedEffects.addAll(allowedETmp.map((e) => Effect.parse(e)));
    }

    if (_allowedEffects.isEmpty) {
      _allowedEffects.addAll(Effect.values);
    }
    _log.info('Allowed effects: ${_allowedEffects}');

    _transitionTime = Duration(milliseconds: _appConfig.slideshow.transitionTimeMs);
    final fadeTime = Duration(milliseconds: _appConfig.slideshow.fadeTimeMs);

    _effectController = AnimationController(duration: _transitionTime, vsync: this);
    //Curves.easeOutQuad;
    _effectController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _currentWidget = _nextWidget;
        });
        imageCache!.clear();
      }
    });

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
    if (_currentWidget == _loaderWidget) {
      _fetchNextMediaItem();
    }
  }

  void _fetchNextMediaItem() async {
    _log.info('Change image');
    await _frontendService.storageNext();
    var mediaItem = await _getCurrentMediaItem();
    var itemWidget = _isVideo(mediaItem) ? VideoWidget(mediaItem) : ImageWidget(mediaItem, _appConfig.slideshow);
    if (mediaItem.uri != null) {
      _log.info('file: "${path.basename(mediaItem.uri!.toFilePath())}"');
    }
    _log.info('imageCache.liveImageCount = ${imageCache!.liveImageCount}, .currentSize = ${imageCache!.currentSize}');

    final screenW = MediaQuery.of(context).size.width;
    final screenH = MediaQuery.of(context).size.height;
    try {
      if (itemWidget is ImageWidget) {
        await itemWidget.precache(context);
      }
      _nextWidget = Container(width: screenW, height: screenH, child: itemWidget);
    } catch (e, st) {
      _log.warning('Error file: "${path.basename(mediaItem.uri!.toFilePath())}"', e, st);
      _nextWidget = _loaderWidget;
    }

    _transitionWidget = AnimatedBuilder(
        key: Key('anim'),
        animation: _effectController,
        builder: (_, __) {
          return Stack(children: <Widget>[
            _currentEffect.transform(
                context, _currentWidget, true /*,0,0*/, _effectController.value /*, 2*/, screenW, screenH),
            _currentEffect.transform(
                context, _nextWidget, false /*1, 0*/, _effectController.value /*, 1*/, screenW, screenH)
          ]);
        },
        child: _loaderWidget);

    _effectController.reset();
    _mediaItemLoopController.reset();
    if (_effectPool.isEmpty) {
      _effectPool.addAll(_allowedEffects);
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

  bool _isVideo(MediaItem item) => item.uri == null ? false : path.extension(item.uri!.path).toLowerCase() == '.mp4';

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
      case ButtonType.select:
        _pushSelectButton();
        break;
    }
  }

  void _pushSelectButton() {
    final _store = _frontendService.store;
    _store.dispatch(ChangeDebugAction(!_store.state.isDebug));
  }

  void _pushMenuButton() {
    final _store = _frontendService.store;
    _store.dispatch(ChangeMenuAction(!_store.state.isMenu));
  }

  void _pushPauseButton() {
    final _store = _frontendService.store;
    var isPausedNewValue = !_store.state.isPaused;
    _store.dispatch(ChangePauseAction(isPausedNewValue));
    if (isPausedNewValue) {
      _mediaItemLoopController.stop();
    } else {
      _mediaItemLoopController.reset();
      _mediaItemLoopController.forward();
    }
    setState(() {
      _stateKey.currentState!.isPaused = _isPaused = isPausedNewValue;
    });
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
