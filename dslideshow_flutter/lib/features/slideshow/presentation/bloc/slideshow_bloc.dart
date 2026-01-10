import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/bloc/slideshow_event.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/bloc/slideshow_state.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/bloc/status/slideshow_status_bloc.dart';
import 'package:dslideshow_flutter/src/effect/effect.dart';
import 'package:dslideshow_flutter/src/service/frontend.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart' as path;

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

  // Подписки
  late StreamSubscription<ButtonEvent> _onButtonEventSubscription;
  StreamSubscription? _onScreenStateSubscription;
  StreamSubscription? _onPauseSubscription;

  SlideshowBloc({
    required this.frontendService,
    required this.config,
    required this.statusBloc,
  }) : super(
         const SlideshowState(
           currentItem: null,
           nextItem: null,
           effect: Effect.fadeEffect,
         ),
       ) {
    // 1. Инициализация
    on<SlideshowInitEvent>(_onInit);

    // 2. Цикл слайдшоу
    on<SlideshowLoadNextEvent>(_onLoadNext);
    on<SlideshowImageReadyEvent>(_onImageReady);
    on<SlideshowTransitionCompleteEvent>(_onTransitionComplete);
    on<SlideshowTimerCompleteEvent>(_onTimerComplete);

    // 3. Управление состоянием
    on<SlideshowTogglePauseEvent>(_onTogglePause);
    on<SlideshowScreenStatePreparationEvent>(_onScreenStatePreparation);

    // Слушаем кнопки
    _onButtonEventSubscription = frontendService.onButtonEvent.listen(
      _onButtonEvent,
    );
  }

  Future<void> _onInit(
    SlideshowInitEvent event,
    Emitter<SlideshowState> emit,
  ) async {
    // Настройка эффектов
    final allowedETmp = config.allowedEffects;
    if (allowedETmp.isNotEmpty) {
      _allowedEffects.addAll(allowedETmp.map((e) => Effect.parse(e)));
    }
    if (_allowedEffects.isEmpty) {
      _allowedEffects.addAll(Effect.values);
    }
    _log.info('Allowed effects: $_allowedEffects');

    // Подписки
    _onScreenStateSubscription = frontendService.onScreenStateChangePreparation
        .listen((enabled) {
          add(SlideshowScreenStatePreparationEvent(enabled));
        });

    _onPauseSubscription = statusBloc.onPause.listen((isPaused) {
      if (!isClosed){
       add(SlideshowTogglePauseEvent(isPaused));
      }
    });

    // Синхронизация начального состояния паузы
    if (statusBloc.state.isPaused) {
      emit(state.copyWith(isPaused: true));
    }

    // Запуск первого кадра (reloadCurrent: true если пауза)
    add(const SlideshowLoadNextEvent());
  }

  Future<void> _onLoadNext(
    SlideshowLoadNextEvent event,
    Emitter<SlideshowState> emit,
  ) async {
    if (state.isPaused && state.currentItem != null) {
      return;
    }

    emit(state.copyWith(phase: SlideshowPhase.loadingNext));

    // Логика загрузки
    if (!state.isPaused) {
      await frontendService.storageNext();
    }

    final mediaItem = await frontendService.getStorageCurrentItem();
    if (mediaItem.uri != null) {
      _log.info('file: "${path.basename(mediaItem.uri!.toFilePath())}"');
    }

    // Выбор эффекта
    if (_effectPool.isEmpty) {
      _effectPool.addAll(_allowedEffects);
      _effectPool.shuffle(_rnd);
    }
    final nextEffect = _effectPool.removeLast();

    emit(
      state.copyWith(
        nextItem: mediaItem,
        effect: nextEffect,
        phase: SlideshowPhase.precaching, // Теперь ждем UI для precache
      ),
    );
  }

  void _onImageReady(
    SlideshowImageReadyEvent event,
    Emitter<SlideshowState> emit,
  ) {
    // Картинка готова, начинаем анимацию
    emit(state.copyWith(phase: SlideshowPhase.transition));
  }

  void _onTransitionComplete(
    SlideshowTransitionCompleteEvent event,
    Emitter<SlideshowState> emit,
  ) {
    // Анимация завершена
    // imageCache.clear() должен вызываться в UI, здесь мы просто обновляем стейт
    emit(
      state.copyWith(
        currentItem: state.nextItem,
        nextItem: null,
        phase: SlideshowPhase.display,
      ),
    );

    _startDisplayTimer();
  }

  void _onTimerComplete(
    SlideshowTimerCompleteEvent event,
    Emitter<SlideshowState> emit,
  ) {
    add(const SlideshowLoadNextEvent());
  }

  void _startDisplayTimer() {
    _displayTimer?.cancel();
    if (state.isPaused || state.isScreenLocked) return;

    final displayTimeMs = config.displayTimeMs;
    _displayTimer = Timer(Duration(milliseconds: displayTimeMs), () {
      add(const SlideshowTimerCompleteEvent());
    });
  }

  void _onTogglePause(
    SlideshowTogglePauseEvent event,
    Emitter<SlideshowState> emit,
  ) {
    emit(state.copyWith(isPaused: event.isPaused));
    if (event.isPaused) {
      _displayTimer?.cancel();
    } else {
      if (state.phase == SlideshowPhase.display) {
        _startDisplayTimer();
      }
    }
  }

  // Та самая сложная логика Fade Out / Screen Lock
  Future<void> _onScreenStatePreparation(
    SlideshowScreenStatePreparationEvent event,
    Emitter<SlideshowState> emit,
  ) async {
    final enabled = event.enabled;
    // _screenState = enabled;

    if (enabled == false) {
      // Screen OFF preparation
      _displayTimer?.cancel();
      // Включаем fadeOut анимацию
      emit(state.copyWith(fadeOut: true));
      // Саму блокировку можно выставить чуть позже или сразу, зависит от FrontendService,
      // но для UI главное начать fadeOut.
      emit(state.copyWith(isScreenLocked: true));
    } else {
      // Screen ON preparation
      final fadeTimeMs = config.fadeTimeMs;
      // Ждем, как в оригинале: delay(fadeTime + 1 sec)
      // В блоке нельзя делать delay внутри обработчика блокируя его, но async работает.
      await Future<void>.delayed(Duration(milliseconds: fadeTimeMs + 1000));

      // Double check (через current state) - в оригинале проверялось поле _screenState
      // Здесь мы полагаем, что если бы пришло событие OFF, isScreenLocked был бы true
      // Но событие ON приходит для подготовки.

      // Инвертируем fadeOut -> fadeIn
      emit(state.copyWith(fadeOut: false, isScreenLocked: false));

      if (!state.isPaused) {
        if (state.phase == SlideshowPhase.display) {
          _startDisplayTimer();
        } else {
          // Если застряли на переходе, перезагружаем
          add(const SlideshowLoadNextEvent());
        }
      }
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
  Future<void> close() {
    _onButtonEventSubscription.cancel();
    _onScreenStateSubscription?.cancel();
    _onPauseSubscription?.cancel();
    _displayTimer?.cancel();
    return super.close();
  }
}
