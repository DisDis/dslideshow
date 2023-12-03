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

  SlideshowBloc({
    required this.frontendService,
    required this.config,
    required this.statusBloc,
  }) : super(const SlideshowState(item: MediaItem.empty)) {
    _onPushSubscription = frontendService.onPushButton.listen(_pushButton);
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
    statusBloc.add(SlideshowSystemInfoEvent(!statusBloc.state.isInfo));
  }

  void _showMenu() {
    statusBloc.add(SlideshowMenuEvent(!statusBloc.state.isMenu));
  }

  void _pause() {
    statusBloc.add(SlideshowPauseEvent(!statusBloc.state.isPaused));
  }

  Future _toggleScreen() async {
    statusBloc.add(SlideshowScreenLockEvent(!statusBloc.state.isScreenLock));
  }

  @override
  Future<void> close() {
    _onPushSubscription?.cancel();
    return super.close();
  }
}
