import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_flutter/src/service/frontend.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'buttons_hint_event.dart';
part 'buttons_hint_state.dart';
part 'buttons_hint_bloc.freezed.dart';

class ButtonsHintBloc extends Bloc<ButtonsHintEvent, ButtonsHintState> {
  final FrontendService frontendService;

  StreamSubscription? _onPushSubscription;

  ButtonsHintBloc({required this.frontendService})
      : super(ButtonsHintDisplayState(
          isShow: false,
          normalColor: Colors.white,
          pushColor: Colors.blue.shade500,
          button0Icon: Icons.arrow_back,
          button0isPush: false,
          button1Icon: Icons.arrow_circle_down,
          button1isPush: false,
          button2Icon: Icons.arrow_circle_up,
          button2isPush: false,
          button3Icon: Icons.check_circle_outline_outlined,
          button3isPush: false,
        )) {
    on<ButtonsHintPushButtonEvent>(_onPushButtonEvent);
    on<ButtonsHintShowEvent>(_onShowEvent);
    _onPushSubscription = frontendService.onPushButton.listen(_pushButton);
  }

  FutureOr<void> _onPushButtonEvent(ButtonsHintPushButtonEvent event, emit) async {
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

  void _pushButton(ButtonType event) {
    add(ButtonsHintPushButtonEvent(button: event));
  }

  @override
  Future<void> close() {
    _onPushSubscription?.cancel();
    _onPushSubscription = null;

    return super.close();
  }

  FutureOr<void> _onShowEvent(ButtonsHintShowEvent event, Emitter<ButtonsHintState> emit) {
    emit(state.copyWith(isShow: event.isShow));
  }
}
