import 'dart:async';

import 'package:dslideshow_backend/config.dart';
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
import 'package:dslideshow_flutter/features/slideshow/presentation/widgets/slideshow_loader_widget.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/widgets/state_notify_widget.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/widgets/system_info_widget.dart';
import 'package:dslideshow_flutter/src/effect/media_slider_item_effect.dart';
import 'package:dslideshow_flutter/src/effect/fade_effect.dart';
import 'package:dslideshow_flutter/src/injector.dart';
import 'package:dslideshow_flutter/src/service/frontend.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';

import '../bloc/slideshow_slide.dart';
import '../sessions/slide_content_sessions.dart' show PlaceholderSlideSession;
import '../sessions/slide_session.dart';
import '../sessions/slide_session_factory.dart';

class SlideShowPage extends StatelessWidget {
  final SlideSessionFactory sessionFactory;

  const SlideShowPage({super.key, this.sessionFactory = const SlideSessionFactory()});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: <Widget>[
          // Рендеринг слайдшоу (Stateful часть для анимаций)
          _SlideshowRenderer(sessionFactory: sessionFactory),

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
            Positioned(left: hintLeft, top: hintTop, child: const ButtonsHintWidget()),
            StateNotify(isPaused: state.isPaused),
            if (state.isInfo) const SystemInfoWidget(),
            if (state.isMenu) const MainMenuWidget(),
            if (!isLinuxEmbedded && state.isDebug) DebugWidget(frontendService, appConfig),
          ],
        );
      },
    );
  }
}

// Stateful виджет для управления контроллерами анимации и прекэшем
// Логика принятия решений вынесена в Bloc, здесь только исполнение.
class _SlideshowRenderer extends StatefulWidget {
  final SlideSessionFactory sessionFactory;

  const _SlideshowRenderer({required this.sessionFactory});

  @override
  _SlideshowRendererState createState() => _SlideshowRendererState();
}

class _SlideshowRendererState extends State<_SlideshowRenderer> with TickerProviderStateMixin {
  static final Logger _log = Logger('_SlideshowRendererState');

  late FixedAnimationController _effectController;
  late AnimationController _fadeController; // Для Screen Lock

  SlideSession? _current;
  SlideSession? _next;
  final Set<SlideSession> _retired = {};
  Widget _transitionWidget = slideShowLoaderWidget;
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
      duration: Duration(milliseconds: _appConfig.slideshow.effects.defaultDurationMs),
      vsync: this,
      animationBehavior: AnimationBehavior.preserve,
    );

    _effectController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _promoteNext();

        // Сообщаем блоку, что переход завершен
        context.read<SlideshowBloc>().add(const SlideshowTransitionCompleteEvent());
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
    for (final session in [_current, _next, ..._retired]) {
      if (session != null) _releaseSession(session);
    }
    _retired.clear();
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
            (_next?.cancelPreparationOnSleep ?? false)) {
          // Retry the same special-screen turn after waking.
          _loadGeneration++;
          _replaceNext(null);
          _nextEffect = null;
        }
        _updateActivity(state);
        final animate = !state.isScreenLocked && (!state.isPaused || state.currentSlide == null);
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
          if (!state.isScreenLocked || slide is MediaSlide) {
            unawaited(_prepareNext(slide, size, state.effect.createEffect()));
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
                  : _current?.view ?? slideShowLoaderWidget,
            ),

            // Fade Widget (Черный экран поверх)
            FadeWidget(animation: _fadeController),
          ],
        );
      },
    );
  }

  void _updateActivity(SlideshowState state) {
    final transitioning = state.phase == SlideshowPhase.transition;
    final playing = !state.isPaused && !state.isScreenLocked;
    final screenOn = !state.isScreenLocked;
    _current?.setActivity(
      role: transitioning ? SlideSessionRole.outgoing : SlideSessionRole.current,
      playing: playing,
      screenOn: screenOn,
    );
    _next?.setActivity(
      role: transitioning ? SlideSessionRole.incoming : SlideSessionRole.pending,
      playing: playing,
      screenOn: screenOn,
    );
  }

  void _replaceNext(SlideSession? session) {
    final previous = _next;
    _next = session;
    if (previous != null) _releaseSession(previous);
  }

  void _promoteNext() {
    final previous = _current;
    setState(() {
      _current = _next;
      _next = null;
    });
    if (previous == null) return;
    _retired.add(previous);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_retired.remove(previous)) _releaseSession(previous);
    });
  }

  bool _acceptsPreparation(int generation, SlideSession session) =>
      mounted && generation == _loadGeneration && identical(_next, session) && !session.disposed;

  Future<void> _prepareNext(SlideshowSlide slide, Size size, MediaSliderItemEffect effect) async {
    final generation = ++_loadGeneration;
    final slideshow = context.read<SlideshowBloc>();
    SlideSession? session;
    _nextEffect = null;
    _replaceNext(null);
    try {
      session = widget.sessionFactory.create(
        slide,
        config: _appConfig.slideshow,
        size: size,
        pixelRatio: MediaQuery.devicePixelRatioOf(context),
        vsync: this,
      );
      // Own pending resources before the first await, including native video.
      _next = session;
      final ready = await session.prepare(context);
      if (!_acceptsPreparation(generation, session)) return;
      if (!ready) {
        if (slide is SpecialSlide) {
          _replaceNext(null);
          slideshow.add(SlideshowSpecialUnavailableEvent(slide.config.id));
          return;
        }
        throw StateError('Media preparation unavailable');
      }
      await effect.prepare();
      if (!_acceptsPreparation(generation, session)) return;
      session.commitPreparation();
      setState(() => _nextEffect = effect);
      _updateActivity(slideshow.state);
      slideshow.add(const SlideshowImageReadyEvent());
    } catch (e, st) {
      if (!mounted || generation != _loadGeneration) return;
      if (session != null && !identical(_next, session)) return;
      _replaceNext(null);
      if (slide is SpecialSlide) {
        _log.warning('Special screen unavailable: ${slide.config.id}', e, st);
        slideshow.add(SlideshowSpecialUnavailableEvent(slide.config.id));
      } else {
        _log.warning('Error loading slide: ${(slide as MediaSlide).item.uri}', e, st);
        setState(() {
          _next = PlaceholderSlideSession();
          _nextEffect = effect;
        });
        slideshow.add(const SlideshowImageReadyEvent());
      }
    }
  }

  void _startTransition(SlideshowState state, Size size) {
    // Capture both views and their sampling geometry before either owner moves.
    final outgoing = _current?.createEffectInput(size) ?? EffectSlideInput(view: slideShowLoaderWidget);
    final incoming = _next?.createEffectInput(size) ?? EffectSlideInput(view: slideShowLoaderWidget);
    // Получаем эффект из стейта
    var currentEffect = _nextEffect ?? state.effect.createEffect();
    _nextEffect = null;
    var durationMs = state.effect.options.durationMs == 0
        ? _appConfig.slideshow.effects.defaultDurationMs
        : state.effect.options.durationMs;
    if (!currentEffect.supportsInputs(outgoing, incoming)) {
      _log.warning('${currentEffect.runtimeType} does not support prepared inputs; using Fade.');
      currentEffect = FadeEffect();
      durationMs = _appConfig.slideshow.effects.defaultDurationMs;
    }
    _effectController.duration = Duration(milliseconds: durationMs);
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
      if (!state.isScreenLocked && (!state.isPaused || state.currentSlide == null)) {
        _effectController.forward(from: 0);
      }
    } catch (e, stack) {
      _log.info('Animation skip', e, stack);
    }
  }

  void _releaseSession(SlideSession session) {
    unawaited(
      session.dispose().catchError((Object e, StackTrace st) {
        _log.warning('Slide disposal failed', e, st);
      }),
    );
  }
}
