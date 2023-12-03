import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_backend/storage.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/bloc/slideshow_event.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/bloc/slideshow_state.dart';
import 'package:dslideshow_flutter/src/effect/effect.dart';

import 'package:dslideshow_flutter/src/service/frontend.dart';

class SlideshowBloc extends Bloc<SlideshowEvent, SlideshowState> {
  final FrontendService frontendService;
  final SlideShowConfig config;
  StreamSubscription? _onPushSubscription;
  final _scPause = StreamController<bool>.broadcast();
  Stream<bool> get onPause => _scPause.stream;

  SlideshowBloc({required this.frontendService, required this.config})
      : super(SlideshowState(
            storageStatus: StorageStatusEnum.done,
            hasInternet: true,
            isScreenLock: false,
            isDebug: false,
            isMenu: false,
            isPaused: false,
            isInfo: false,
            item: MediaItem.empty,
            effect: Effect.cubeEffect.createEffect())) {
    // on<SlideshowInitialEvent>((event, emit) {
    _onPushSubscription = frontendService.onPushButton.listen(_pushButton);
    // });
    on<SlideshowPauseEvent>((event, emit) {
      emit(state.copyWith(isPaused: event.value));
      _scPause.add(event.value);
    });
    on<SlideshowScreenLockEvent>((event, emit) async {
      emit(state.copyWith(isScreenLock: event.value));
      await frontendService.changeScreenLock(event.value);
      if (event.value) {
        frontendService.screenTurn(false);
      } else {
        frontendService.screenTurn(true);
      }
    });
    on<SlideshowChangeStorageStatusEvent>((event, emit) {
      emit(state.copyWith(storageStatus: event.value));
    });
    on<SlideshowDebugEvent>((event, emit) {
      emit(state.copyWith(isDebug: event.value));
    });
    on<SlideshowMenuEvent>((event, emit) {
      emit(state.copyWith(isMenu: event.value));
    });
    on<SlideshowSystemInfoEvent>((event, emit) {
      emit(state.copyWith(isInfo: event.value));
    });
  }

  void _executeAction(SlideshowAction action) {
    switch (action) {
      case SlideshowAction.pause:
        _pause();
        break;
      case SlideshowAction.toggleScreen:
        _toggleScreen();
        break;
      case SlideshowAction.showMenu:
        _showMenu();
        break;
      case SlideshowAction.showInfo:
        _showInfo();
        break;
    }
  }

  void _pushButton(ButtonType event) {
    switch (event) {
      case ButtonType.button0:
        _executeAction(config.buttons.button0);
        break;
      case ButtonType.button2:
        _executeAction(config.buttons.button2);
        break;
      case ButtonType.button1:
        _executeAction(config.buttons.button1);
        break;
      case ButtonType.button3:
        _executeAction(config.buttons.button3);
        break;
    }
  }

  void _showInfo() {
    add(SlideshowSystemInfoEvent(!state.isInfo));
  }

  void _showMenu() {
    add(SlideshowMenuEvent(!state.isMenu));
  }

  void _pause() {
    add(SlideshowPauseEvent(!state.isPaused));
  }

  Future _toggleScreen() async {
    add(SlideshowScreenLockEvent(!state.isScreenLock));
  }

  @override
  Future<void> close() {
    _onPushSubscription?.cancel();
    return super.close();
  }
}
