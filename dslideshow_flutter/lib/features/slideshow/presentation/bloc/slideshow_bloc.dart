import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_backend/storage.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/bloc/status/slideshow_status_bloc.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/bloc/slideshow_event.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/bloc/slideshow_state.dart';

import 'package:dslideshow_flutter/src/service/frontend.dart';

class SlideshowBloc extends Bloc<SlideshowEvent, SlideshowState> {
  final FrontendService frontendService;
  final SlideShowConfig config;
  final SlideshowStatusBloc statusBloc;
  StreamSubscription? _onPushSubscription;
  StreamSubscription? _onActionSubscription;

  SlideshowBloc({
    required this.frontendService,
    required this.config,
    required this.statusBloc,
  }) : super(const SlideshowState(item: MediaItem.empty)) {
    _onPushSubscription = frontendService.onPushButton.listen(_pushButton);
    _onActionSubscription = frontendService.onAction.listen((actionP) => _executeAction(actionP.action, actionP.param));
  }

  void _executeAction(SlideshowAction action, [bool? value]) {
    switch (action) {
      case SlideshowAction.pause:
        _pause(value);
        break;
      case SlideshowAction.toggleScreen:
        _toggleScreen(value);
        break;
      case SlideshowAction.showMenu:
        _showMenu(value);
        break;
      case SlideshowAction.showInfo:
        _showInfo(value);
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

  void _showInfo([bool? value]) {
    statusBloc.add(SlideshowSystemInfoEvent(value ?? !statusBloc.state.isInfo));
  }

  void _showMenu([bool? value]) {
    statusBloc.add(SlideshowMenuEvent(value ?? !statusBloc.state.isMenu));
  }

  void _pause([bool? value]) {
    statusBloc.add(SlideshowPauseEvent(value ?? !statusBloc.state.isPaused));
  }

  Future _toggleScreen([bool? value]) async {
    statusBloc.add(SlideshowScreenLockEvent(value ?? !statusBloc.state.isScreenLock));
  }

  @override
  Future<void> close() {
    _onPushSubscription?.cancel();
    _onActionSubscription?.cancel();
    return super.close();
  }
}
