// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_flutter/src/service/frontend.dart';

part 'slideshow_status_bloc.freezed.dart';
part 'slideshow_status_event.dart';
part 'slideshow_status_state.dart';

class SlideshowStatusBloc extends Bloc<SlideshowStatusEvent, SlideshowStatusState> {
  final FrontendService frontendService;
  final SlideShowConfig config;

  final _scPause = StreamController<bool>.broadcast();
  Stream<bool> get onPause => _scPause.stream;

  SlideshowStatusBloc({
    required this.frontendService,
    required this.config,
  }) : super(const SlideshowStatusState()) {
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
  }
}
