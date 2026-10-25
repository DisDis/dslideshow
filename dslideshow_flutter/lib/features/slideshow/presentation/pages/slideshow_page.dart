import 'dart:async';
import 'dart:io';

import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_backend/storage.dart';
import 'package:dslideshow_flutter/environment.dart';
import 'package:dslideshow_flutter/features/header/presentation/widgets/buttons_hint/buttons_hint.dart';
import 'package:dslideshow_flutter/features/header/presentation/widgets/common_header.dart';
import 'package:dslideshow_flutter/features/menu/presentation/widgets/mainmenu.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/bloc/slideshow_bloc.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/bloc/slideshow_event.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/bloc/slideshow_state.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/bloc/status/slideshow_status_bloc.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/widgets/debug_widget.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/widgets/fade_widget.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/widgets/fixed_animation_controller.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/widgets/image_widget.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/widgets/slideshow_loader_widget.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/widgets/state_notify_widget.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/widgets/system_info_widget.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/widgets/video_widget.dart';
import 'package:dslideshow_flutter/src/effect/media_slider_item_effect.dart';
import 'package:dslideshow_flutter/src/injector.dart';
import 'package:dslideshow_flutter/src/service/frontend.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';

class SlideShowPage extends StatelessWidget {
  const SlideShowPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: <Widget>[
          // Рендеринг слайдшоу (Stateful часть для анимаций)
          const _SlideshowRenderer(),

          // Оверлеи (Инфо, Меню, Дебаг, Fade)
          const _SlideshowOverlays(),

          // Хедер
          const CommonHeaderWidget(),
        ],
      ),
    );
  }
}

// Отдельный виджет для Оверлеев (для чистоты кода)
class _SlideshowOverlays extends StatelessWidget {
  const _SlideshowOverlays();

  @override
  Widget build(BuildContext context) {
    final FrontendService frontendService = injector();
    final AppConfig appConfig = injector();
    // Координаты для подсказок (под физическими кнопками)
    final double hintLeft = appConfig.slideshow.buttons.hintOffsetX.toDouble();
    final double hintTop = appConfig.slideshow.buttons.hintOffsetY.toDouble();

    return BlocBuilder<SlideshowStatusBloc, SlideshowStatusState>(
      builder: (context, state) {
        return Stack(
          children: <Widget>[
            Positioned(
              left: hintLeft,
              top: hintTop,
              child: ButtonsHintWidget(buttons: appConfig.slideshow.buttons),
            ),
            StateNotify(isPaused: state.isPaused),
            if (state.isInfo) const SystemInfoWidget(),
            if (state.isMenu) const MainMenuWidget(),
            if (!isLinuxEmbedded && state.isDebug)
              DebugWidget(frontendService, appConfig),
          ],
        );
      },
    );
  }
}

// Stateful виджет для управления контроллерами анимации и прекэшем
// Логика принятия решений вынесена в Bloc, здесь только исполнение.
class _SlideshowRenderer extends StatefulWidget {
  const _SlideshowRenderer();

  @override
  _SlideshowRendererState createState() => _SlideshowRendererState();
}

class _SlideshowRendererState extends State<_SlideshowRenderer>
    with TickerProviderStateMixin {
  static final Logger _log = Logger('_SlideshowRendererState');

  late FixedAnimationController _effectController;
  late AnimationController _fadeController; // Для Screen Lock

  Widget _currentWidget = slideShowLoaderWidget;
  Widget _nextWidget = slideShowLoaderWidget;
  Widget _transitionWidget = slideShowLoaderWidget;
  VideoSession? _currentVideo;
  VideoSession? _nextVideo;
  ImageWidget? _currentImage;
  ImageWidget? _nextImage;
  SlideshowPhase? _lastPhase;
  int _loadGeneration = 0;
  MediaSliderItemEffect? _nextEffect;

  final AppConfig _appConfig = injector();

  @override
  void initState() {
    super.initState();
    context.read<SlideshowBloc>().add(const SlideshowInitEvent());

    _effectController = FixedAnimationController(
      duration: Duration(milliseconds: _appConfig.slideshow.transitionTimeMs),
      vsync: this,
      animationBehavior: AnimationBehavior.preserve,
    );

    _effectController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        final oldVideo = _currentVideo;
        final oldImage = _currentImage;
        // Меняем виджеты местами
        setState(() {
          _currentWidget = _nextWidget;
          _currentVideo = _nextVideo;
          _currentImage = _nextImage;
          _nextVideo = null;
          _nextImage = null;
          _nextWidget = slideShowLoaderWidget;
        });
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (oldVideo != null) _releaseVideo(oldVideo);
          oldImage?.dispose();
        });

        // Сообщаем блоку, что переход завершен
        context.read<SlideshowBloc>().add(
          const SlideshowTransitionCompleteEvent(),
        );
      }
    });

    _fadeController = AnimationController(
      duration: Duration(milliseconds: _appConfig.slideshow.fadeTimeMs),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _loadGeneration++;
    if (_currentVideo != null) _releaseVideo(_currentVideo!);
    if (_nextVideo != null) _releaseVideo(_nextVideo!);
    _currentImage?.dispose();
    _nextImage?.dispose();
    _effectController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocConsumer<SlideshowBloc, SlideshowState>(
      listener: (context, state) {
        final phaseChanged = _lastPhase != state.phase;
        _lastPhase = state.phase;
        final playing = !state.isPaused && !state.isScreenLocked;
        if (_currentVideo != null) _playVideo(_currentVideo!, playing);
        if (_nextVideo != null && state.phase == SlideshowPhase.transition) {
          _playVideo(_nextVideo!, playing);
        }
        // 1. Логика затемнения экрана (Screen Lock)
        if (state.fadeOut) {
          _fadeController.forward();
        } else {
          _fadeController.reverse();
        }

        // 2. Логика Precache (Загрузка изображения)
        if (phaseChanged &&
            state.phase == SlideshowPhase.precaching &&
            state.nextItem != null) {
          _handlePrecache(state.nextItem!, size, state.effect.createEffect());
        }

        // 3. Логика запуска Транзакции
        if (phaseChanged && state.phase == SlideshowPhase.transition) {
          _startTransition(state, size);
        }
        if (state.phase == SlideshowPhase.display) {
          _transitionWidget = slideShowLoaderWidget;
        }
      },
      buildWhen: (prev, curr) {
        // Перерисовываем только если мы в фазе транзакции (чтобы показать transitionWidget)
        // Или если это первоначальная загрузка
        return prev.phase != curr.phase;
      },
      builder: (context, state) {
        return Stack(
          children: [
            // Основной контент
            SizedBox(
              width: size.width,
              height: size.height,
              // Если идет транзакция, показываем transitionWidget (где крутится анимация),
              // иначе просто текущий виджет.
              child: state.phase == SlideshowPhase.transition
                  ? _transitionWidget
                  : _currentWidget,
            ),

            // Fade Widget (Черный экран поверх)
            FadeWidget(animation: _fadeController),
          ],
        );
      },
    );
  }

  // Создание виджета и прекэш
  Future<void> _handlePrecache(
    MediaItem mediaItem,
    Size size,
    MediaSliderItemEffect effect,
  ) async {
    final generation = ++_loadGeneration;
    final video = mediaItem.isVideo
        ? VideoSession(File(mediaItem.uri!.toFilePath()))
        : null;
    final itemWidget = mediaItem.isVideo
        ? VideoWidget(mediaItem, session: video)
        : ImageWidget(
            mediaItem,
            _appConfig.slideshow,
            size,
            pixelRatio: MediaQuery.devicePixelRatioOf(context),
          );

    try {
      if (itemWidget is ImageWidget) {
        await itemWidget.precache(context);
      }
      await video?.prepare();
      await effect.prepare();

      if (mounted && generation == _loadGeneration) {
        if (_nextVideo != null) _releaseVideo(_nextVideo!);
        _nextImage?.dispose();
        setState(() {
          _nextVideo = video;
          _nextImage = itemWidget is ImageWidget ? itemWidget : null;
          _nextEffect = effect;
          _nextWidget = SizedBox(
            width: size.width,
            height: size.height,
            child: itemWidget,
          );
        });
        // Сообщаем блоку, что картинка готова к показу
        context.read<SlideshowBloc>().add(const SlideshowImageReadyEvent());
      } else {
        if (video != null) _releaseVideo(video);
        if (itemWidget is ImageWidget) itemWidget.dispose();
      }
    } catch (e, st) {
      if (video != null) _releaseVideo(video);
      if (itemWidget is ImageWidget) itemWidget.dispose();
      if (!mounted || generation != _loadGeneration) return;
      _log.warning(
        'Error loading file: "${mediaItem.uri?.toFilePath()}"',
        e,
        st,
      );
      // В случае ошибки загружаем лоадер как fallback
      setState(() {
        if (_nextVideo != null) _releaseVideo(_nextVideo!);
        _nextImage?.dispose();
        _nextVideo = null;
        _nextImage = null;
        _nextEffect = effect;
        _nextWidget = slideShowLoaderWidget;
      });
      // Все равно сообщаем о готовности, чтобы не заблокировать очередь
      // ignore: use_build_context_synchronously
      context.read<SlideshowBloc>().add(const SlideshowImageReadyEvent());
    }
  }

  // Создание виджета перехода (старая логика AnimatedBuilder + createTransformWidget)
  void _startTransition(SlideshowState state, Size size) {
    // Получаем эффект из стейта
    final currentEffect = _nextEffect ?? state.effect.createEffect();
    _nextEffect = null;
    // Capture both slides: completion promotes _nextWidget before Bloc rebuilds.
    final outgoing = _currentWidget;
    final incoming = _nextWidget;

    setState(() {
      _transitionWidget = AnimatedBuilder(
        key: UniqueKey(), // Важно для пересоздания анимации
        animation: _effectController,
        builder: (context, _) {
          return currentEffect.createTransformWidget(
            context,
            outgoing,
            incoming,
            _effectController,
            size.width,
            size.height,
          );
        },
      );
    });

    // Запускаем анимацию
    try {
      _effectController.forward(from: 0);
    } catch (e) {
      _log.info('Animation skip', e);
    }
  }

  void _playVideo(VideoSession session, bool playing) {
    unawaited(
      session.setPlaying(playing).catchError((Object e, StackTrace st) {
        _log.warning('Video playback failed', e, st);
      }),
    );
  }

  void _releaseVideo(VideoSession session) {
    unawaited(
      session.dispose().catchError((Object e, StackTrace st) {
        _log.warning('Video disposal failed', e, st);
      }),
    );
  }
}
