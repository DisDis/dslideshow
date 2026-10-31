import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/bloc/status/slideshow_status_bloc.dart';
import 'package:dslideshow_flutter/features/theme/presentation/src/theme_colors.dart';
import 'package:dslideshow_flutter/src/service/frontend.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';

part 'buttons_hint_event.dart';
part 'buttons_hint_state.dart';
part 'buttons_hint_bloc.freezed.dart';

enum ButtonsHintMode { slideshow, contextual }

class ButtonsHintBloc extends Bloc<ButtonsHintEvent, ButtonsHintState> {
  ButtonsHintBloc({
    required FrontendService frontendService,
    required SlideshowStatusBloc statusBloc,
    required AppConfig appConfig,
  }) : this._(
         frontendService: frontendService,
         statusBloc: statusBloc,
         appConfig: appConfig,
         mode: ButtonsHintMode.slideshow,
       );

  ButtonsHintBloc.contextual({required FrontendService frontendService})
    : this._(frontendService: frontendService, mode: ButtonsHintMode.contextual);

  ButtonsHintBloc._({required this.frontendService, required this.mode, this._statusBloc, this._appConfig})
    : super(
        ButtonsHintState.display(
          isShow: mode == ButtonsHintMode.contextual,
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
    on<ButtonsHintShowEvent>((event, emit) {
      if (!_closing) {
        emit(state.copyWith(isShow: mode == ButtonsHintMode.contextual || event.isShow));
      }
    });
    on<ButtonsHintUpdateButtonsEvent>((event, emit) {
      if (_closing || mode == ButtonsHintMode.contextual) return;
      final menu = _statusBloc!.state.isMenu;
      _log.fine('Slideshow hint profile menu=$menu');
      emit(
        state.copyWith(
          isShow: true,
          button0Icon: menu
              ? Icons.arrow_back
              : getIconDataBySlideshowAction(_appConfig!.slideshow.buttons.button0.action),
          button1Icon: menu
              ? Icons.arrow_circle_down
              : getIconDataBySlideshowAction(_appConfig!.slideshow.buttons.button1.action),
          button2Icon: menu
              ? Icons.arrow_circle_up
              : getIconDataBySlideshowAction(_appConfig!.slideshow.buttons.button2.action),
          button3Icon: menu
              ? Icons.check_circle_outline_outlined
              : getIconDataBySlideshowAction(_appConfig!.slideshow.buttons.button3.action),
        ),
      );
      _resetHideTimer();
    });
    on<ButtonsHintButtonChanged>(_buttonChanged);
    on<ButtonsHintClearPress>((event, emit) {
      if (!_closing) _setPressed(event.button, false, emit);
    });
    _buttons = frontendService.onButtonEvent.listen(
      (event) {
        if (!_closing) {
          add(ButtonsHintEvent.buttonChanged(button: event.button, type: event.event));
        }
      },
      onError: (Object error, StackTrace stack) =>
          _log.warning('Button hint stream failed type=${error.runtimeType}', error, stack),
    );
    if (mode == ButtonsHintMode.slideshow) {
      _status = _statusBloc!.stream.listen((status) {
        if (!_closing && status.isMenu != _menu) {
          _menu = status.isMenu;
          add(const ButtonsHintEvent.updateButtons());
        }
      });
      _menu = _statusBloc.state.isMenu;
      add(const ButtonsHintEvent.updateButtons());
    }
    _log.info('Button hints started mode=${mode.name}');
  }

  static final _log = Logger('ButtonsHintBloc');
  final FrontendService frontendService;
  final ButtonsHintMode mode;
  final SlideshowStatusBloc? _statusBloc;
  final AppConfig? _appConfig;
  late final StreamSubscription<ButtonEvent> _buttons;
  StreamSubscription<SlideshowStatusState>? _status;
  Timer? _hideTimer;
  final _pressTimers = <ButtonType, Timer>{};
  bool _menu = false;
  bool _closing = false;
  final _closed = Completer<void>();

  void _resetHideTimer() {
    _hideTimer?.cancel();
    if (mode == ButtonsHintMode.contextual || _menu || _closing) return;
    _hideTimer = Timer(const Duration(seconds: 5), () {
      if (!_closing) add(const ButtonsHintEvent.show(isShow: false));
    });
  }

  void _buttonChanged(ButtonsHintButtonChanged event, Emitter<ButtonsHintState> emit) {
    if (_closing) return;
    _pressTimers.remove(event.button)?.cancel();
    _log.fine('Button hint button=${event.button.name} type=${event.type.name}');
    _setPressed(event.button, true, emit);
    _resetHideTimer();
    if (event.type == ButtonEventType.released) {
      _pressTimers[event.button] = Timer(const Duration(milliseconds: 200), () {
        if (!_closing) add(ButtonsHintEvent.clearPress(button: event.button));
      });
    }
  }

  void _setPressed(ButtonType button, bool pressed, Emitter<ButtonsHintState> emit) {
    emit(switch (button) {
      ButtonType.button0 => state.copyWith(isShow: true, button0isPush: pressed),
      ButtonType.button1 => state.copyWith(isShow: true, button1isPush: pressed),
      ButtonType.button2 => state.copyWith(isShow: true, button2isPush: pressed),
      ButtonType.button3 => state.copyWith(isShow: true, button3isPush: pressed),
    });
  }

  IconData getIconDataBySlideshowAction(SlideshowAction action) => switch (action) {
    SlideshowAction.none => Icons.cancel,
    SlideshowAction.pause => Icons.pause,
    SlideshowAction.showInfo => Icons.info,
    SlideshowAction.showMenu => Icons.menu,
    SlideshowAction.toggleScreen => Icons.power_off,
  };

  @override
  Future<void> close() async {
    if (_closing) return _closed.future;
    _closing = true;
    _hideTimer?.cancel();
    for (final timer in _pressTimers.values) {
      timer.cancel();
    }
    _log.info('Button hints closing mode=${mode.name}; timers cancelled');
    try {
      await Future.wait([_buttons.cancel(), if (_status != null) _status!.cancel()]);
    } finally {
      try {
        await super.close();
      } finally {
        _closed.complete();
        _log.info('Button hints closed mode=${mode.name}');
      }
    }
  }
}
