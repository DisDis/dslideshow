import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_backend/storage.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/bloc/slideshow_event.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/bloc/slideshow_state.dart';
import 'package:dslideshow_flutter/src/effect/effect.dart';

import 'package:dslideshow_flutter/src/service/frontend.dart';

class SlideshowBloc extends Bloc<SlideshowEvent, SlideshowState> {
  final FrontendService frontendService;
  StreamSubscription? _onPushSubscription;
  final _scPause = StreamController<bool>.broadcast();
  Stream<bool> get onPause => _scPause.stream;

  SlideshowBloc({required this.frontendService})
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
      case ButtonType.back:
        _pushBackButton();
        break;
    }
  }

  void _pushBackButton() {
    add(SlideshowSystemInfoEvent(!state.isInfo));
  }

  void _pushMenuButton() {
    add(SlideshowMenuEvent(!state.isMenu));
  }

  void _pushPauseButton() {
    add(SlideshowPauseEvent(!state.isPaused));
  }

  Future _pushScreenToggleButton() async {
    add(SlideshowScreenLockEvent(!state.isScreenLock));
  }

  @override
  Future<void> close() {
    _onPushSubscription?.cancel();
    return super.close();
  }
}
