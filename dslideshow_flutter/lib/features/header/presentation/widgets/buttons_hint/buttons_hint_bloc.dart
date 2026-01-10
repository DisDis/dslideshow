import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/bloc/status/slideshow_status_bloc.dart';
import 'package:dslideshow_flutter/features/theme/presentation/src/theme_colors.dart';
import 'package:dslideshow_flutter/src/service/frontend.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'buttons_hint_event.dart';
part 'buttons_hint_state.dart';
part 'buttons_hint_bloc.freezed.dart';

class ButtonsHintBloc extends Bloc<ButtonsHintEvent, ButtonsHintState> {
  final FrontendService frontendService;
  final SlideshowStatusBloc statusBloc;
  final AppConfig appConfig;

  late StreamSubscription<ButtonEvent> _onButtonEventSubscription;
  late StreamSubscription _onStatusSubscription;
  late SlideshowStatusState _currentStatus;
  late Timer _hideHintTimer;
  DateTime _lastButtonActive = DateTime.now();

  ButtonsHintBloc({
    required this.frontendService,
    required this.statusBloc,
    required this.appConfig,
  }) : super(
         ButtonsHintDisplayState(
           isShow: false,
           normalColor: ThemeColors.buttonsHintColor,
           pushColor: ThemeColors.buttonsHintPressedColor,
           button0Icon: Icons.arrow_back,
           button0isPush: false,
           button1Icon: Icons.arrow_circle_down,
           button1isPush: false,
           button2Icon: Icons.arrow_circle_up,
           button2isPush: false,
           button3Icon: Icons.check_circle_outline_outlined,
           button3isPush: false,
         ),
       ) {
    on<ButtonsHintPushButtonEvent>(_onPushButtonEvent);
    on<ButtonsHintShowEvent>(_onShowEvent);
    _onButtonEventSubscription = frontendService.onButtonEvent.listen(
      _onButtonEvent,
    );
    on<ButtonsHintUpdateButtonsEvent>(_onUpdateButtons);
    _hideHintTimer = Timer(Duration(seconds: 5), _hideHint);
    _startAutoHideHint();
    _currentStatus = statusBloc.state;
    _onStatusChanged(_currentStatus, true);
    _onStatusSubscription = statusBloc.stream.listen(_onStatusChanged);
  }

  void _startAutoHideHint([bool isForce = false]) {
    if (isForce || !_hideHintTimer.isActive) {
      _hideHintTimer = Timer(Duration(seconds: 5), _hideHint);
    }
  }

  void _hideHint() {
    if (!_currentStatus.isMenu) {
      if ((DateTime.now().difference(_lastButtonActive).inSeconds > 5)) {
        add(ButtonsHintShowEvent(isShow: false));
      } else {
        _startAutoHideHint(true);
      }
    }
  }

  FutureOr<void> _onStatusChanged(
    SlideshowStatusState state, [
    bool isForceUpdate = false,
  ]) {
    if (isForceUpdate || _currentStatus.isMenu != state.isMenu) {
      _currentStatus = state;
      add(ButtonsHintUpdateButtonsEvent());
    }
    _currentStatus = state;
  }

  FutureOr<void> _onPushButtonEvent(
    ButtonsHintPushButtonEvent event,
    emit,
  ) async {
    switch (event.button) {
      case ButtonType.button0:
        emit(state.copyWith(button0isPush: true));
        await Future.delayed(Duration(milliseconds: 200));
        emit(state.copyWith(button0isPush: false));
        break;
      case ButtonType.button1:
        emit(state.copyWith(button1isPush: true));
        await Future.delayed(Duration(milliseconds: 200));
        emit(state.copyWith(button1isPush: false));
        break;
      case ButtonType.button2:
        emit(state.copyWith(button2isPush: true));
        await Future.delayed(Duration(milliseconds: 200));
        emit(state.copyWith(button2isPush: false));
        break;
      case ButtonType.button3:
        emit(state.copyWith(button3isPush: true));
        await Future.delayed(Duration(milliseconds: 200));
        emit(state.copyWith(button3isPush: false));
        break;
    }
  }

  void _onButtonEvent(ButtonEvent event) {
    _lastButtonActive = DateTime.now();
    if (event.event == ButtonEventType.released) {
      add(ButtonsHintPushButtonEvent(button: event.button));
    }
    if (!_currentStatus.isMenu && !state.isShow){
      _onStatusChanged(_currentStatus, true);
    }
  }

  @override
  Future<void> close() {
    _onButtonEventSubscription.cancel();
    _onStatusSubscription.cancel();
    return super.close();
  }

  FutureOr<void> _onShowEvent(
    ButtonsHintShowEvent event,
    Emitter<ButtonsHintState> emit,
  ) {
    emit(state.copyWith(isShow: event.isShow));
  }

  FutureOr<void> _onUpdateButtons(
    ButtonsHintUpdateButtonsEvent event,
    Emitter<ButtonsHintState> emit,
  ) {
    if (_currentStatus.isMenu) {
      emit(
        state.copyWith(
          isShow: true,
          button0Icon: Icons.arrow_back,
          button1Icon: Icons.arrow_circle_down,
          button2Icon: Icons.arrow_circle_up,
          button3Icon: Icons.check_circle_outline_outlined,
        ),
      );
    } else {
      emit(
        state.copyWith(
          isShow: true,
          button0Icon: getIconDataBySlideshowAction(
            appConfig.slideshow.buttons.button0.action,
          ),
          button1Icon: getIconDataBySlideshowAction(
            appConfig.slideshow.buttons.button1.action,
          ),
          button2Icon: getIconDataBySlideshowAction(
            appConfig.slideshow.buttons.button2.action,
          ),
          button3Icon: getIconDataBySlideshowAction(
            appConfig.slideshow.buttons.button3.action,
          ),
        ),
      );
      _startAutoHideHint(true);
    }
  }

  IconData getIconDataBySlideshowAction(SlideshowAction action) {
    switch (action) {
      case SlideshowAction.none:
        return Icons.cancel;
      case SlideshowAction.pause:
        return Icons.pause;
      case SlideshowAction.showInfo:
        return Icons.info;
      case SlideshowAction.showMenu:
        return Icons.menu;
      case SlideshowAction.toggleScreen:
        return Icons.power_off;
    }
  }
}
