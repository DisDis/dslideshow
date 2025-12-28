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
  late StreamSubscription<ButtonEvent> _onButtonEventSubscription;

  SlideshowBloc({
    required this.frontendService,
    required this.config,
    required this.statusBloc,
  }) : super(const SlideshowState(item: MediaItem.empty)) {
    _onButtonEventSubscription = frontendService.onButtonEvent.listen(
      _onButtonEvent,
    );
  }

  void _onButtonEvent(ButtonEvent event) {
    if (statusBloc.state.isMenu) {
      // Skip button push
      return;
    }
    if (event.event == ButtonEventType.released) {
      switch (event.button) {
        case ButtonType.button0:
          if (event.durationMs > config.buttons.button0.minPressingMs) {
            statusBloc.executeAction(config.buttons.button0.action);
          }
          break;
        case ButtonType.button1:
          if (event.durationMs > config.buttons.button1.minPressingMs) {
            statusBloc.executeAction(config.buttons.button1.action);
          }
          break;
        case ButtonType.button2:
          if (event.durationMs > config.buttons.button2.minPressingMs) {
            statusBloc.executeAction(config.buttons.button2.action);
          }
          break;
        case ButtonType.button3:
          if (event.durationMs > config.buttons.button3.minPressingMs) {
            statusBloc.executeAction(config.buttons.button3.action);
          }
          break;
      }
    }
  }

  @override
  Future<void> close() {
    _onButtonEventSubscription.cancel();

    return super.close();
  }
}
