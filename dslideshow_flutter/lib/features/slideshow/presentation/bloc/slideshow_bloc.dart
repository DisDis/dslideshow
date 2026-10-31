import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_common/rpc.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/bloc/slideshow_event.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/bloc/slideshow_state.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/bloc/status/slideshow_status_bloc.dart';
import 'package:dslideshow_flutter/src/effect/effect.dart';
import 'package:dslideshow_flutter/src/service/frontend.dart';
import 'package:dslideshow_flutter/src/service/cancellable_waits.dart';
import 'package:logging/logging.dart';

import 'slideshow_slide.dart';
import 'special_screen_scheduler.dart';

class SlideshowBloc extends Bloc<SlideshowEvent, SlideshowState> {
  static final _log = Logger('SlideshowBloc');
  static final _rnd = Random(DateTime.now().millisecondsSinceEpoch);

  final FrontendService frontendService;
  final SlideShowConfig config;
  final SlideshowStatusBloc statusBloc;

  // Логика эффектов (перенесена из State)
  final List<Effect> _effectPool = [];
  final List<Effect> _allowedEffects = <Effect>[];

  // Таймер отображения слайда
  Timer? _displayTimer;
  bool _closing = false;
  final _waits = CancellableWaits();
  late final SpecialScreenScheduler scheduler = SpecialScreenScheduler(config.specialScreens);
  bool _initialized = false;

  // Подписки
  late StreamSubscription<ButtonEvent> _onButtonEventSubscription;
  StreamSubscription? _onScreenStateSubscription;
  StreamSubscription? _onPauseSubscription;

  SlideshowBloc({required this.frontendService, required this.config, required this.statusBloc})
    : super(const SlideshowState(effect: Effect.fadeEffect)) {
    // 1. Инициализация
    on<SlideshowInitEvent>(_onInit);

    // 2. Цикл слайдшоу
    on<SlideshowLoadNextEvent>(_onLoadNext);
    on<SlideshowImageReadyEvent>(_onImageReady);
    on<SlideshowSpecialUnavailableEvent>((event, emit) {
      final slide = state.nextSlide;
      if (slide is! SpecialSlide ||
          slide.config.id != event.screenId ||
          state.isScreenLocked ||
          state.phase != SlideshowPhase.precaching) {
        return;
      }
      scheduler.skipped(slide);
      emit(state.copyWith(nextSlide: null, phase: SlideshowPhase.display));
      add(const SlideshowLoadNextEvent());
    });
    on<SlideshowTransitionCompleteEvent>(_onTransitionComplete);
    on<SlideshowTimerCompleteEvent>(_onTimerComplete);

    // 3. Управление состоянием
    on<SlideshowTogglePauseEvent>(_onTogglePause);
    on<SlideshowScreenStatePreparationEvent>(_onScreenStatePreparation);

    // Слушаем кнопки
    _onButtonEventSubscription = frontendService.onButtonEvent.listen(_onButtonEvent);
  }

  Future<void> _onInit(SlideshowInitEvent event, Emitter<SlideshowState> emit) async {
    if (_closing || emit.isDone || _initialized) return;
    _initialized = true;
    // Настройка эффектов
    _allowedEffects.addAll(
      config.effects.playable.map(
        (entry) => Effect(
          entry.key,
          options: entry.value.options.withDuration(config.effects.durationFor(entry.value.options)),
        ),
      ),
    );
    _log.info('Allowed effects: $_allowedEffects');

    // Подписки
    _onScreenStateSubscription = frontendService.onScreenStateChangePreparation.listen((enabled) {
      if (!_closing && !isClosed) {
        add(SlideshowScreenStatePreparationEvent(enabled));
      }
    });

    _onPauseSubscription = statusBloc.onPause.listen((isPaused) {
      if (!_closing && !isClosed) {
        add(SlideshowTogglePauseEvent(isPaused));
      }
    });

    // Синхронизация начального состояния паузы
    if (statusBloc.state.isPaused) {
      emit(state.copyWith(isPaused: true));
    }
    scheduler.setActive(!state.isPaused && !state.isScreenLocked);

    // Запуск первого кадра (reloadCurrent: true если пауза)
    add(const SlideshowLoadNextEvent());
  }

  Future<void> _onLoadNext(SlideshowLoadNextEvent event, Emitter<SlideshowState> emit) async {
    if (_closing) return;
    if ((state.isPaused || state.isScreenLocked) && state.currentSlide != null) {
      return;
    }
    if (state.phase == SlideshowPhase.loadingNext ||
        state.phase == SlideshowPhase.precaching ||
        state.phase == SlideshowPhase.ready ||
        state.phase == SlideshowPhase.transition) {
      return;
    }

    emit(state.copyWith(phase: SlideshowPhase.loadingNext));

    final special = scheduler.next();
    if (special != null) {
      emit(state.copyWith(nextSlide: special, effect: _nextEffect(special), phase: SlideshowPhase.precaching));
      return;
    }

    _log.fine('event=loadStarted');
    try {
      if (!state.isPaused) {
        final result = await _waits.wait(frontendService.storageNext());
        if (emit.isDone || _closing) return;
        if (result is RpcErrorResult) throw RpcErrorResultException(result);
      }

      final mediaItem = await _waits.wait(frontendService.getStorageCurrentItem());
      if (emit.isDone || _closing || mediaItem == null) return;
      final nextSlide = MediaSlide(mediaItem);
      final effect = _nextEffect(nextSlide);
      _log.fine('event=loadCompleted');
      emit(state.copyWith(nextSlide: nextSlide, effect: effect, phase: SlideshowPhase.precaching));
    } catch (error, stack) {
      if (emit.isDone || _closing) return;
      _displayTimer?.cancel();
      _log.warning('event=loadFailed type=${error.runtimeType}', error, stack);
      // Retain the visible slide and its session after a source error.
      emit(state.copyWith(nextSlide: null, phase: SlideshowPhase.error));
    }
  }

  Effect _nextEffect(SlideshowSlide incoming) {
    final compatible = _allowedEffects
        .where(
          (effect) => effect.supportsMedia(
            state.currentSlide?.transitionMedia ?? TransitionMedia.special,
            incoming.transitionMedia,
          ),
        )
        .toList();
    // A photo-only selection must still allow videos, GIFs and clocks to play.
    if (compatible.isEmpty) {
      return Effect.fadeEffect.configured(BasicEffectOptions(durationMs: config.effects.defaultDurationMs));
    }
    _effectPool.removeWhere((effect) => !compatible.contains(effect));
    if (_effectPool.isEmpty) {
      _effectPool.addAll(compatible);
      _effectPool.shuffle(_rnd);
    }
    return _effectPool.removeLast();
  }

  void _onImageReady(SlideshowImageReadyEvent event, Emitter<SlideshowState> emit) {
    if (state.phase != SlideshowPhase.precaching) return;
    // A sleeping renderer cancels camera preparation and retries on wake.
    // Ignore a readiness event that was queued just before that cancellation.
    if (state.isScreenLocked && state.nextSlide is SpecialSlide) return;
    // Картинка готова, начинаем анимацию
    emit(
      state.copyWith(
        phase: (state.isPaused && state.currentSlide != null) || state.isScreenLocked
            ? SlideshowPhase.ready
            : SlideshowPhase.transition,
      ),
    );
  }

  void _onTransitionComplete(SlideshowTransitionCompleteEvent event, Emitter<SlideshowState> emit) {
    final slide = state.nextSlide;
    if (slide != null) scheduler.shown(slide);
    // Анимация завершена
    // imageCache.clear() должен вызываться в UI, здесь мы просто обновляем стейт
    emit(state.copyWith(currentSlide: state.nextSlide, nextSlide: null, phase: SlideshowPhase.display));

    _startDisplayTimer();
  }

  void _onTimerComplete(SlideshowTimerCompleteEvent event, Emitter<SlideshowState> emit) {
    if (_closing || state.phase != SlideshowPhase.display) return;
    add(const SlideshowLoadNextEvent());
  }

  void _startDisplayTimer() {
    _displayTimer?.cancel();
    if (_closing || state.isPaused || state.isScreenLocked) return;

    final current = state.currentSlide;
    final displayTimeMs = current is SpecialSlide ? current.config.displayTimeMs : config.displayTimeMs;
    _displayTimer = Timer(Duration(milliseconds: displayTimeMs), () {
      if (_closing || isClosed) return;
      add(const SlideshowTimerCompleteEvent());
    });
  }

  void _onTogglePause(SlideshowTogglePauseEvent event, Emitter<SlideshowState> emit) {
    if (state.isPaused == event.isPaused) return;
    emit(state.copyWith(isPaused: event.isPaused));
    scheduler.setActive(!state.isPaused && !state.isScreenLocked);
    if (event.isPaused) {
      _displayTimer?.cancel();
    } else if (!state.isScreenLocked) {
      if (state.phase == SlideshowPhase.ready) {
        emit(state.copyWith(phase: SlideshowPhase.transition));
      }
      if (state.phase == SlideshowPhase.display) {
        _startDisplayTimer();
      }
    }
  }

  void _onScreenStatePreparation(SlideshowScreenStatePreparationEvent event, Emitter<SlideshowState> emit) {
    final locked = !event.enabled;
    if (state.isScreenLocked == locked && state.fadeOut == locked) return;
    if (locked) {
      scheduler.setActive(false);
      _displayTimer?.cancel();
      emit(state.copyWith(fadeOut: true, isScreenLocked: true));
      return;
    }

    // ON means either fade cancellation or a completed hardware wake. Never
    // delay this reversal: an old delayed ON could override a newer OFF.
    emit(state.copyWith(fadeOut: false, isScreenLocked: false));
    scheduler.setActive(!state.isPaused);
    if (!state.isPaused || state.currentSlide == null) {
      if (state.phase == SlideshowPhase.ready) {
        emit(state.copyWith(phase: SlideshowPhase.transition));
      } else if (state.phase == SlideshowPhase.display) {
        _startDisplayTimer();
      } else if (state.phase == SlideshowPhase.initial) {
        add(const SlideshowLoadNextEvent());
      }
      // Loading, precaching and transitions already have their own completion.
    }
  }

  void _onButtonEvent(ButtonEvent event) {
    if (statusBloc.state.isMenu) return;
    if (event.event == ButtonEventType.released) {
      final btnConfig = config.buttons;
      switch (event.button) {
        case ButtonType.button0:
          if (event.durationMs > btnConfig.button0.minPressingMs) {
            statusBloc.executeAction(btnConfig.button0.action);
          }
          break;
        case ButtonType.button1:
          if (event.durationMs > btnConfig.button1.minPressingMs) {
            statusBloc.executeAction(btnConfig.button1.action);
          }
          break;
        case ButtonType.button2:
          if (event.durationMs > btnConfig.button2.minPressingMs) {
            statusBloc.executeAction(btnConfig.button2.action);
          }
          break;
        case ButtonType.button3:
          if (event.durationMs > btnConfig.button3.minPressingMs) {
            statusBloc.executeAction(btnConfig.button3.action);
          }
          break;
      }
    }
  }

  @override
  Future<void> close() async {
    _closing = true;
    if (state.phase == SlideshowPhase.loadingNext) {
      _log.fine('event=loadCancelled reason=closed');
    }
    scheduler.close();
    _waits.close();
    _displayTimer?.cancel();
    await Future.wait([
      _onButtonEventSubscription.cancel(),
      if (_onScreenStateSubscription != null) _onScreenStateSubscription!.cancel(),
      if (_onPauseSubscription != null) _onPauseSubscription!.cancel(),
    ]);
    await super.close();
  }
}
