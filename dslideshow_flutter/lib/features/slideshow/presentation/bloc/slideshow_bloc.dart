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

  void _pushButton(ButtonType event) {
    if (statusBloc.state.isMenu) {
      // Skip button push
      return;
    }
    switch (event) {
      case ButtonType.button0:
        statusBloc.executeAction(config.buttons.button0);
        break;
      case ButtonType.button2:
        statusBloc.executeAction(config.buttons.button2);
        break;
      case ButtonType.button1:
        statusBloc.executeAction(config.buttons.button1);
        break;
      case ButtonType.button3:
        statusBloc.executeAction(config.buttons.button3);
        break;
    }
  }

  @override
  Future<void> close() {
    _onPushSubscription?.cancel();
    _onPushSubscription = null;

    return super.close();
  }
}
