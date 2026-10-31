import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_flutter/features/menu/presentation/widgets/mainmenu_model.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/bloc/status/slideshow_status_bloc.dart';
import 'package:dslideshow_flutter/src/route_bloc.dart';
import 'package:dslideshow_flutter/src/service/frontend.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dslideshow_common/rpc.dart';
import 'package:dslideshow_flutter/src/service/cancellable_waits.dart';
import 'package:logging/logging.dart';

part 'main_menu_event.dart';
part 'main_menu_state.dart';
part 'main_menu_bloc.freezed.dart';

class MainMenuBloc extends Bloc<MainMenuEvent, MainMenuState> {
  static final _log = Logger('MainMenuBloc');
  final _waits = CancellableWaits();
  bool _executing = false;
  Future<void>? _closeFuture;
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
    _onButtonEventSubscription = frontendService.onButtonEvent.listen(_onButtonEvent);
  }

  void _onButtonEvent(ButtonEvent event) {
    if (_waits.isClosed || slideshowStatusBloc.isClosed || !slideshowStatusBloc.state.isMenu) {
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

  void _onSelectItem(MainMenuSelectEvent event, Emitter<MainMenuState> emit) {
    if (_waits.isClosed) return;
    int index = event.index;
    if (index >= options.length) {
      index = 0;
    } else if (index < 0) {
      index = options.length - 1;
    }
    emit(state.copyWith(selectedIndex: index));
  }

  FutureOr<void> _onExecuteItem(MainMenuExecuteEvent event, Emitter<MainMenuState> emit) async {
    if (_waits.isClosed || _executing) return;
    final command = event.command ?? (state.selectedIndex < 0 ? null : options[state.selectedIndex].command);
    if (command == null) return;
    _executing = true;
    _log.info('command start action=${command.name}');
    try {
      if (routeBloc.isClosed || slideshowStatusBloc.isClosed) {
        throw StateError('Menu dependencies are closed');
      }
      switch (command) {
        case MenuCommand.config:
          routeBloc.add(ChangePageEvent(RoutePage.config));
        case MenuCommand.update:
          routeBloc.add(ChangePageEvent(RoutePage.ota));
        case MenuCommand.powerOff:
          final result = await _waits.wait(frontendService.powerOff());
          if (_waits.isClosed) return;
          _checkResponse(result);
        case MenuCommand.restartApp:
          final result = await _waits.wait(frontendService.restartApp());
          if (_waits.isClosed) return;
          _checkResponse(result);
        case MenuCommand.returnToSlideshow:
          break;
      }
      if (_waits.isClosed || emit.isDone || slideshowStatusBloc.isClosed) {
        return;
      }
      slideshowStatusBloc.add(SlideshowMenuEvent(false));
      _log.info('command completed action=${command.name}');
    } catch (error, stack) {
      if (!_waits.isClosed) {
        _log.warning(
          'command failed'
          ' action=${command.name} errorType=${error.runtimeType}',
          error,
          stack,
        );
      }
    } finally {
      if (_waits.isClosed) {
        _log.info(
          'command cancelled'
          ' action=${command.name}',
        );
      }
      _executing = false;
    }
  }

  void _checkResponse(Object? result) {
    if (result is RpcErrorResult) throw RpcErrorResultException(result);
    if (result is! EmptyResult) {
      throw StateError('Unexpected menu command response');
    }
  }

  @override
  Future<void> close() => _closeFuture ??= _closeMenu().whenComplete(() => super.close());

  Future<void> _closeMenu() async {
    _waits.close();
    await _onButtonEventSubscription?.cancel();
    _onButtonEventSubscription = null;
  }
}
