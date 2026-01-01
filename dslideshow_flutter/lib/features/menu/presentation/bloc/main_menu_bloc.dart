import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_flutter/features/menu/presentation/widgets/mainmenu_model.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/bloc/status/slideshow_status_bloc.dart';
import 'package:dslideshow_flutter/src/route_bloc.dart';
import 'package:dslideshow_flutter/src/service/frontend.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'main_menu_event.dart';
part 'main_menu_state.dart';
part 'main_menu_bloc.freezed.dart';

class MainMenuBloc extends Bloc<MainMenuEvent, MainMenuState> {
  final RouteBloc routeBloc;
  final FrontendService frontendService;
  final SlideShowMenuConfig config;
  final SlideshowStatusBloc slideshowStatusBloc;

  StreamSubscription? _onButtonEventSubscription;

  MainMenuBloc({
    required this.routeBloc,
    required this.frontendService,
    required this.slideshowStatusBloc,
    required this.config,
  }) : super(MainMenuState(selectedIndex: -1)) {
    on<MainMenuSelectEvent>(_onSelectItem);
    on<MainMenuExecuteEvent>(_onExecuteItem);
    _onButtonEventSubscription = frontendService.onButtonEvent.listen(
      _onButtonEvent,
    );
  }

  void _onButtonEvent(ButtonEvent event) {
    if (!slideshowStatusBloc.state.isMenu) {
      // Skip button push
      return;
    }
    if (event.event == ButtonEventType.released && event.durationMs > config.minPressingMs) {
      switch (event.button) {
        case ButtonType.button0:
          add(MainMenuEvent.execute(MenuCommand.returnToSlideshow));
          break;
        case ButtonType.button2:
          add(MainMenuEvent.select(state.selectedIndex - 1));
          break;
        case ButtonType.button1:
          add(MainMenuEvent.select(state.selectedIndex + 1));
          break;
        case ButtonType.button3:
          add(MainMenuEvent.execute());
          break;
      }
    }
  }

  FutureOr<void> _onSelectItem(MainMenuSelectEvent event, emit) {
    int index = event.index;
    if (index >= options.length) {
      index = 0;
    } else if (index < 0) {
      index = options.length - 1;
    }
    emit(state.copyWith(selectedIndex: index));
  }

  FutureOr<void> _onExecuteItem(
    MainMenuExecuteEvent event,
    Emitter<MainMenuState> emit,
  ) async {
    MenuCommand? command = event.command;
    if (command == null) {
      if (state.selectedIndex != -1) {
        command = options[state.selectedIndex].command;
      }
    }
    if (command == null) {
      //Skip
      return;
    }
    switch (command) {
      case MenuCommand.config:
        routeBloc.add(ChangePageEvent(RoutePage.config));
        break;
      case MenuCommand.update:
        routeBloc.add(ChangePageEvent(RoutePage.ota));
        break;

      case MenuCommand.powerOff:
        _powerOff();
        break;

      case MenuCommand.restartApp:
        _restartApp();
        break;
      case MenuCommand.returnToSlideshow:
        break;
    }
    slideshowStatusBloc.add(SlideshowMenuEvent(false));
  }

  void _powerOff() {
    frontendService.powerOff();
  }

  void _restartApp() {
    frontendService.restartApp();
  }

  @override
  Future<void> close() {
    _onButtonEventSubscription?.cancel();
    _onButtonEventSubscription = null;

    return super.close();
  }
}
