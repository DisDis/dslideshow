import 'dart:async';
import 'dart:math';

import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_backend/storage.dart';
import 'package:dslideshow_flutter/environment.dart';
import 'package:dslideshow_flutter/src/effect/effect.dart';
import 'package:dslideshow_flutter/src/effect/media_slider_item_effect.dart';
import 'package:dslideshow_flutter/src/injector.dart';
import 'package:dslideshow_flutter/src/page/common/common_header.dart';
import 'package:dslideshow_flutter/src/page/common/debug_widget.dart';
import 'package:dslideshow_flutter/src/page/common/state_notify_widget.dart';
import 'package:dslideshow_flutter/src/page/slideshow/image_widget.dart';
import 'package:dslideshow_flutter/src/page/slideshow/slideshow_bloc.dart';
import 'package:dslideshow_flutter/src/page/slideshow/slideshow_state.dart';
import 'package:dslideshow_flutter/src/page/slideshow/video_widget.dart';
import 'package:dslideshow_flutter/src/service/frontend.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart' as path;
import 'package:flutter_bloc/flutter_bloc.dart';

import 'fade_widget.dart';

class SlideShowPage extends StatefulWidget {
  const SlideShowPage({Key? key}) : super(key: key);

  @override
  _SlideShowPageState createState() => _SlideShowPageState();
}

final _loaderWidget = Container(
  key: const Key('loader'),
  child: const Center(
    child: SizedBox(
      child: CircularProgressIndicator(),
      width: 60,
      height: 60,
    ),
  ),
);

class _SlideShowPageState extends State<SlideShowPage> with TickerProviderStateMixin {
  static final Logger _log = Logger('_SlideShowPageState');
  static final stateKey = GlobalKey<StateNotifyState>();

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

  late Duration _transitionTime;

  bool _screenState = true;

  bool get isItemChanging => _currentWidget != _nextWidget;

  late SlideshowBloc bloc;

  final Key _fadeWidgetKey = const Key('fadeWidget');

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
        BlocSelector<SlideshowBloc, SlideshowState, IndicatorState>(selector: (state) {
          return IndicatorState(
              storageStatus: state.storageStatus,
              isDebug: state.isDebug,
              isPaused: state.isPaused,
              isMenu: state.isMenu,
              hasInternet: state.hasInternet);
        }, builder: (context, state) {
          return StateNotify(key: stateKey, isPaused: state.isPaused);
        }),
        FadeWidget(key: _fadeWidgetKey, animation: _fadeController),
        if (!isLinuxEmbedded)
          BlocBuilder<SlideshowBloc, SlideshowState>(builder: (context, state) {
            return state.isDebug ? DebugWidget(_frontendService) : Container();
          }),
        const CommonHeaderWidget(),
      ],
    ));
  }

  @override
  void dispose() {
    _effectController.dispose();
    _mediaItemLoopController.dispose();
    _fadeController.dispose();
    for (var element in _subs) {
      element.cancel();
    }
    _subs.clear();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    final allowedETmp = _appConfig.slideshow.allowedEffects;
    _log.info('Config effects = $allowedETmp');
    if (allowedETmp.isNotEmpty) {
      _allowedEffects.addAll(allowedETmp.map((e) => Effect.parse(e)));
    }

    if (_allowedEffects.isEmpty) {
      _allowedEffects.addAll(Effect.values);
    }
    _log.info('Allowed effects: $_allowedEffects');

    _transitionTime = Duration(milliseconds: _appConfig.slideshow.transitionTimeMs);
    final fadeTime = Duration(milliseconds: _appConfig.slideshow.fadeTimeMs);

    _effectController = AnimationController(duration: _transitionTime, vsync: this);
    _effectController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _currentWidget = _nextWidget;
        });
        imageCache.clear();
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
    if (_currentWidget == _loaderWidget) {
      _fetchNextMediaItem();
    }
    bloc = context.read<SlideshowBloc>();

    _subs.add(bloc.onPause.listen((isPausedNewValue) {
      if (isPausedNewValue) {
        _mediaItemLoopController.stop();
      } else {
        _mediaItemLoopController.reset();
        _mediaItemLoopController.forward();
      }
      stateKey.currentState!.isPaused = isPausedNewValue;
    }));
  }

  void _fetchNextMediaItem() async {
    _log.info('Change image');
    await _frontendService.storageNext();
    final mediaItem = await _getCurrentMediaItem();
    final itemWidget = _isVideo(mediaItem) ? VideoWidget(mediaItem) : ImageWidget(mediaItem, _appConfig.slideshow);
    if (mediaItem.uri != null) {
      _log.info('file: "${path.basename(mediaItem.uri!.toFilePath())}"');
    }
    //_log.info('imageCache.liveImageCount = ${imageCache!.liveImageCount}, .currentSize = ${imageCache!.currentSize}');

    final size = MediaQuery.of(context).size;
    final screenW = size.width;
    final screenH = size.height;
    try {
      if (itemWidget is ImageWidget) {
        await itemWidget.precache(context);
      }
      _nextWidget = SizedBox(width: screenW, height: screenH, child: itemWidget);
    } catch (e, st) {
      _log.warning('Error file: "${path.basename(mediaItem.uri!.toFilePath())}"', e, st);
      _nextWidget = _loaderWidget;
    }

    _transitionWidget = AnimatedBuilder(
        key: const Key('anim'),
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
    try {
      await _effectController.forward().orCancel;
    } catch (e) {
      _log.info('Skip error', e);
    }
    _mediaItemLoopController.forward();
  }

  Future<MediaItem> _getCurrentMediaItem() async {
    var item = await _frontendService.getStorageCurrentItem();
    return item;
  }

  bool _isVideo(MediaItem item) => item.uri == null ? false : path.extension(item.uri!.path).toLowerCase() == '.mp4';

  void _restorePlayPauseState() {
    if (bloc.state.isPaused) {
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
      await Future<void>.delayed(const Duration(seconds: 4));
      // Double check, after delay
      if (_screenState == enabled) {
        _fadeController.reverse();
        _restorePlayPauseState();
      }
    }
  }
}
