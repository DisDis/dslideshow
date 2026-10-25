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

import '../bloc/slideshow_slide.dart';
import '../sessions/cameras_screen_session.dart';
import '../sessions/special_screen_session.dart';
import '../widgets/special_screen_renderers.dart';

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
  SpecialScreenSession? _currentSpecial;
  SpecialScreenSession? _nextSpecial;
  SlideshowPhase? _lastPhase;
  bool _screenLocked = false;
  int _loadGeneration = 0;
  MediaSliderItemEffect? _nextEffect;

  final AppConfig _appConfig = injector();

  @override
  void initState() {
    super.initState();
    final slideshow = context.read<SlideshowBloc>();
    _screenLocked = slideshow.state.isScreenLocked;
    slideshow.add(const SlideshowInitEvent());

    _effectController = FixedAnimationController(
      duration: Duration(milliseconds: _appConfig.slideshow.transitionTimeMs),
      vsync: this,
      animationBehavior: AnimationBehavior.preserve,
    );

    _effectController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        final oldVideo = _currentVideo;
        final oldImage = _currentImage;
        final oldSpecial = _currentSpecial;
        // Меняем виджеты местами
        setState(() {
          _currentWidget = _nextWidget;
          _currentVideo = _nextVideo;
          _currentImage = _nextImage;
          _currentSpecial = _nextSpecial;
          _nextSpecial = null;
          _nextVideo = null;
          _nextImage = null;
          _nextWidget = slideShowLoaderWidget;
        });
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (oldVideo != null) _releaseVideo(oldVideo);
          oldImage?.dispose();
          oldSpecial?.dispose();
        });

        // Сообщаем блоку, что переход завершен
        context.read<SlideshowBloc>().add(
          const SlideshowTransitionCompleteEvent(),
        );
      }
    });

    _fadeController = AnimationController(
      duration: Duration(milliseconds: _appConfig.slideshow.fadeTimeMs),
      // A renderer created while asleep must wake from black, not opacity 0.
      value: slideshow.state.fadeOut ? 1 : 0,
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
    _currentSpecial?.dispose();
    _nextSpecial?.dispose();
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
        final waking = _screenLocked && !state.isScreenLocked;
        _screenLocked = state.isScreenLocked;
        _lastPhase = state.phase;
        if (state.isScreenLocked &&
            state.phase == SlideshowPhase.precaching &&
            state.nextSlide is SpecialSlide) {
          // Sleeping cancels preparation, without consuming this screen's turn.
          _loadGeneration++;
          _nextSpecial?.dispose();
          _nextSpecial = null;
        }
        final playing = !state.isPaused && !state.isScreenLocked;
        final animate =
            !state.isScreenLocked &&
            (!state.isPaused || state.currentSlide == null);
        _currentSpecial?.setActive(!state.isScreenLocked);
        if (_nextSpecial != null) {
          if (state.isScreenLocked) {
            _nextSpecial!.setActive(false);
          } else if (state.phase == SlideshowPhase.transition) {
            _nextSpecial!.setActive(true);
          }
        }
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
        if ((phaseChanged || (waking && state.nextSlide is SpecialSlide)) &&
            state.phase == SlideshowPhase.precaching &&
            state.nextSlide != null) {
          final slide = state.nextSlide!;
          if (slide is SpecialSlide && !state.isScreenLocked) {
            _handleSpecialPrecache(slide, size, state.effect.createEffect());
          } else if (slide is MediaSlide) {
            _handlePrecache(slide.item, size, state.effect.createEffect());
          }
        }

        // 3. Логика запуска Транзакции
        if (phaseChanged && state.phase == SlideshowPhase.transition) {
          _startTransition(state, size);
        } else if (state.phase == SlideshowPhase.transition) {
          if (animate && !_effectController.isAnimating) {
            _effectController.forward();
          } else if (!animate && _effectController.isAnimating) {
            _effectController.stop(canceled: false);
          }
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
  Future<void> _handleSpecialPrecache(
    SpecialSlide slide,
    Size size,
    MediaSliderItemEffect effect,
  ) async {
    final generation = ++_loadGeneration;
    final renderer = SpecialScreenRenderers.definitions[slide.config.type];
    if (renderer == null) {
      context.read<SlideshowBloc>().add(
        SlideshowSpecialUnavailableEvent(slide.config.id),
      );
      return;
    }
    final session = renderer.createSession(slide.config, slide.cameraIndex);
    _nextSpecial?.dispose();
    _nextSpecial = session;
    try {
      final locked = context.read<SlideshowBloc>().state.isScreenLocked;
      final ready = !locked && await session.prepare();
      if (ready) await effect.prepare();
      if (!mounted || generation != _loadGeneration) return;
      if (!ready) {
        session.dispose();
        _nextSpecial = null;
        context.read<SlideshowBloc>().add(
          SlideshowSpecialUnavailableEvent(slide.config.id),
        );
        return;
      }
      if (session is CamerasScreenSession) {
        slide.cameraIndex = session.cameraIndex;
      }
      if (_nextVideo != null) _releaseVideo(_nextVideo!);
      _nextImage?.dispose();
      setState(() {
        _nextVideo = null;
        _nextImage = null;
        _nextEffect = effect;
        _nextWidget = SizedBox(
          width: size.width,
          height: size.height,
          child: renderer.build(session),
        );
      });
      context.read<SlideshowBloc>().add(const SlideshowImageReadyEvent());
    } catch (e, st) {
      if (!session.closed) session.dispose();
      if (!mounted || generation != _loadGeneration) return;
      _nextSpecial = null;
      _log.warning('Special screen unavailable: ${slide.config.id}', e, st);
      context.read<SlideshowBloc>().add(
        SlideshowSpecialUnavailableEvent(slide.config.id),
      );
    }
  }

  Future<void> _handlePrecache(
    MediaItem mediaItem,
    Size size,
    MediaSliderItemEffect effect,
  ) async {
    final generation = ++_loadGeneration;
    _nextSpecial?.dispose();
    _nextSpecial = null;
    final video = mediaItem.isVideo
        ? VideoSession(File(mediaItem.uri!.toFilePath()))
        : null;
    final itemWidget = mediaItem.uri == null
        ? slideShowLoaderWidget
        : mediaItem.isVideo
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
      if (!state.isScreenLocked &&
          (!state.isPaused || state.currentSlide == null)) {
        _effectController.forward(from: 0);
      }
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
