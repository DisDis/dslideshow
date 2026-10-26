// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';

import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_common/rpc.dart';
import 'package:dslideshow_flutter/src/service/frontend.dart';
import 'package:dslideshow_flutter/src/service/cancellable_waits.dart';

part 'slideshow_status_bloc.freezed.dart';
part 'slideshow_status_event.dart';
part 'slideshow_status_state.dart';

class SlideshowStatusBloc
    extends Bloc<SlideshowStatusEvent, SlideshowStatusState> {
  static final _log = Logger('SlideshowStatusBloc');
  final FrontendService frontendService;
  final SlideShowConfig config;
  StreamSubscription? _onActionSubscription;
  int _screenLockGeneration = 0;
  SlideshowScreenLockEvent? _screenAction;
  final _waits = CancellableWaits();
  final _actionCompletions =
      Map<SlideshowStatusEvent, Completer<void>>.identity();

  final _scPause = StreamController<bool>.broadcast();
  Stream<bool> get onPause => _scPause.stream;

  SlideshowStatusBloc({required this.frontendService, required this.config})
    : super(const SlideshowStatusState()) {
    on<SlideshowChangeStorageStatusEvent>((event, emit) {
      emit(state.copyWith(storageStatus: event.value));
    });
    on<SlideshowDebugEvent>((event, emit) {
      emit(state.copyWith(isDebug: event.value));
    });
    on<SlideshowMenuEvent>((event, emit) {
      if (_waits.isClosed) return;
      final changed = state.isMenu != event.value;
      emit(state.copyWith(isMenu: event.value));
      if (changed) _publishFrontendState(isMenu: event.value);
      _completeAction(event);
    });
    on<SlideshowSystemInfoEvent>((event, emit) {
      emit(state.copyWith(isInfo: event.value));
    });
    on<SlideshowInternetEvent>((event, emit) {
      emit(state.copyWith(hasInternet: event.value));
    });

    on<SlideshowPauseEvent>((event, emit) {
      if (_waits.isClosed) return;
      final changed = state.isPaused != event.value;
      emit(state.copyWith(isPaused: event.value));
      if (changed) {
        _scPause.add(event.value);
        _publishFrontendState(isPaused: event.value);
      }
      _completeAction(event);
    });
    on<SlideshowScreenLockEvent>((event, emit) async {
      if (_waits.isClosed) return;
      final previous = _screenAction;
      if (previous != null) {
        _completeAction(
          previous,
          error: StateError('Screen control was superseded'),
        );
      }
      _screenAction = event;
      final generation = ++_screenLockGeneration;
      emit(state.copyWith(isScreenLock: event.value));
      try {
        final lockResult = await _waits.wait(
          frontendService.changeScreenLock(event.value),
        );
        if (emit.isDone || generation != _screenLockGeneration) return;
        _checkScreenResponse(lockResult);
        final screenResult = await _waits.wait(
          frontendService.screenTurn(!event.value),
        );
        if (emit.isDone || generation != _screenLockGeneration) return;
        _checkScreenResponse(screenResult);
        // Both backend RPCs accepted the intent. Native fade/power continues
        // independently and its actual phase is reported by the backend.
        _completeAction(event);
      } catch (error, stack) {
        _log.warning('Unable to apply screen control', error, stack);
        _completeAction(event, error: error, stack: stack);
      }
    });
    _onActionSubscription = frontendService.onAction.listen(
      (actionP) => executeAction(actionP.action, actionP.param),
    );
  }

  void executeAction(SlideshowAction action, [bool? value]) {
    if (_waits.isClosed) return;
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
      case SlideshowAction.none:
        break;
    }
  }

  /// Applies explicit remote intent and waits until its event is handled.
  /// Screen intent waits for backend acceptance; native operations continue
  /// independently.
  Future<void> executeActionAndWait(
    SlideshowAction action,
    bool value, {
    Duration timeout = const Duration(seconds: 2),
  }) {
    if (_waits.isClosed || isClosed) {
      return Future<void>.error(StateError('Slideshow status is closed'));
    }
    final SlideshowStatusEvent event = switch (action) {
      SlideshowAction.pause => SlideshowPauseEvent(value),
      SlideshowAction.showMenu => SlideshowMenuEvent(value),
      SlideshowAction.toggleScreen => SlideshowScreenLockEvent(value),
      _ => throw ArgumentError.value(
        action,
        'action',
        'Unsupported remote action',
      ),
    };
    final completion = Completer<void>();
    _actionCompletions[event] = completion;
    add(event);
    return completion.future.timeout(timeout).whenComplete(() {
      _actionCompletions.remove(event);
    });
  }

  void _checkScreenResponse(Object? result) {
    if (result is RpcErrorResult) throw RpcErrorResultException(result);
    if (result is! EmptyResult) {
      throw StateError('Unexpected screen control response');
    }
  }

  void _completeAction(
    SlideshowStatusEvent event, {
    Object? error,
    StackTrace? stack,
  }) {
    if (identical(_screenAction, event)) _screenAction = null;
    final completion = _actionCompletions.remove(event);
    if (completion == null) return;
    if (error == null) {
      completion.complete();
    } else {
      completion.completeError(error, stack);
    }
  }

  void _publishFrontendState({bool? isPaused, bool? isMenu}) {
    // Publishing follows every state path, including direct menu-close events.
    unawaited(
      Future<void>.sync(() async {
        await frontendService.updateFrontendState(
          isPaused: isPaused,
          isMenu: isMenu,
        );
      }).catchError((Object error, StackTrace stack) {
        _log.warning('Unable to publish frontend state', error, stack);
      }),
    );
  }

  void _showInfo([bool? value]) {
    add(SlideshowSystemInfoEvent(value ?? !state.isInfo));
  }

  void _showMenu([bool? value]) {
    bool tmp = value ?? !state.isMenu;
    add(SlideshowMenuEvent(tmp));
  }

  void _pause([bool? value]) {
    bool tmp = value ?? !state.isPaused;
    add(SlideshowPauseEvent(tmp));
  }

  Future _toggleScreen([bool? value]) async {
    add(SlideshowScreenLockEvent(value ?? !state.isScreenLock));
  }

  @override
  Future<void> close() async {
    _screenLockGeneration++;
    _waits.close();
    for (final completion in _actionCompletions.values) {
      completion.completeError(StateError('Slideshow status is closed'));
    }
    _actionCompletions.clear();
    _screenAction = null;
    await _onActionSubscription?.cancel();
    await _scPause.close();
    await super.close();
  }
}
