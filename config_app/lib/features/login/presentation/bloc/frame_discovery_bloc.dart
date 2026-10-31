import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dslideshow_common/frame_discovery.dart';
import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';

part 'frame_discovery_bloc.freezed.dart';

enum FrameDiscoveryStatus { initial, searching, completed, unavailable, failure }

@freezed
abstract class FrameDiscoveryState with _$FrameDiscoveryState {
  const factory FrameDiscoveryState({
    @Default(FrameDiscoveryStatus.initial) FrameDiscoveryStatus status,
    @Default([]) List<DiscoveredFrame> frames,
    @Default(false) bool limited,
    @Default(0) int unresolved,
  }) = _FrameDiscoveryState;
}

@freezed
sealed class FrameDiscoveryEvent with _$FrameDiscoveryEvent {
  const factory FrameDiscoveryEvent.search() = FrameSearchRequested;
  const factory FrameDiscoveryEvent.cancel() = FrameSearchCancelled;
  const factory FrameDiscoveryEvent.update(FrameDiscoverySession session, FrameDiscoveryUpdate update) = _Update;
  const factory FrameDiscoveryEvent.finish(FrameDiscoverySession session) = _Finish;
  const factory FrameDiscoveryEvent.failed(FrameDiscoverySession session) = _Failed;
}

class FrameDiscoveryBloc extends Bloc<FrameDiscoveryEvent, FrameDiscoveryState> with WidgetsBindingObserver {
  static const defaultSearchDuration = Duration(seconds: 8);

  FrameDiscoveryBloc({required this.provider, this.searchDuration = defaultSearchDuration})
    : super(const FrameDiscoveryState()) {
    on<FrameSearchRequested>(_search);
    on<FrameSearchCancelled>((event, emit) => _finish(emit, cancelled: true));
    on<_Finish>((event, emit) async {
      if (identical(event.session, _session)) await _finish(emit);
    });
    on<_Failed>((event, emit) async {
      if (identical(event.session, _session)) await _finish(emit, failed: true);
    });
    on<_Update>((event, emit) {
      if (!identical(event.session, _session)) return;
      switch (event.update) {
        case FrameResolved(:final frame):
          _frames[frame.serviceKey] = frame;
          final visible = {for (final previous in state.frames) previous.serviceKey: previous, ..._frames};
          emit(state.copyWith(frames: visible.values.toList()));
        case FrameLost(:final serviceKey):
          _frames.remove(serviceKey);
          emit(state.copyWith(frames: state.frames.where((frame) => frame.serviceKey != serviceKey).toList()));
        case FrameDiscoveryLimited():
          emit(state.copyWith(limited: true));
        case FrameResolveFailed():
          emit(state.copyWith(unresolved: state.unresolved + 1));
      }
    });
    WidgetsBinding.instance.addObserver(this);
  }

  static final _log = Logger('FrameDiscovery');
  final FrameDiscoveryProvider provider;
  final Duration searchDuration;
  final _frames = <String, DiscoveredFrame>{};
  FrameDiscoverySession? _session;
  StreamSubscription<FrameDiscoveryUpdate>? _subscription;
  Timer? _timer;

  Future<void> _search(FrameSearchRequested event, Emitter<FrameDiscoveryState> emit) async {
    if (state.status == FrameDiscoveryStatus.searching) return;
    _frames.clear();
    emit(state.copyWith(status: FrameDiscoveryStatus.searching, limited: false, unresolved: 0));
    _log.info('Search started retained=${state.frames.length}');
    FrameDiscoverySession session;
    try {
      session = provider.createSession();
    } catch (error, stack) {
      _log.warning('Search unavailable type=${error.runtimeType}', error, stack);
      emit(state.copyWith(status: FrameDiscoveryStatus.unavailable));
      return;
    }
    _session = session;
    _subscription = session.updates.listen(
      (update) {
        if (identical(_session, session)) add(FrameDiscoveryEvent.update(session, update));
      },
      onError: (Object error, StackTrace stack) {
        if (identical(_session, session)) {
          _log.warning('Search transport failed type=${error.runtimeType}', error, stack);
          add(FrameDiscoveryEvent.failed(session));
        }
      },
    );
    try {
      await session.start();
      if (identical(_session, session)) {
        _timer = Timer(searchDuration, () => add(FrameDiscoveryEvent.finish(session)));
      }
    } catch (error, stack) {
      if (!identical(_session, session)) return;
      _log.warning('Search unavailable type=${error.runtimeType}', error, stack);
      await _release();
      if (!emit.isDone) emit(state.copyWith(status: FrameDiscoveryStatus.unavailable));
    }
  }

  Future<void> _release() async {
    _timer?.cancel();
    _timer = null;
    final session = _session;
    final subscription = _subscription;
    _session = null;
    _subscription = null;
    Future<void> closeSession() async {
      try {
        await session?.close();
      } catch (error, stack) {
        _log.warning('Search cleanup failed type=${error.runtimeType}', error, stack);
      }
    }

    // Stop the producer before cancelling the consumer; await both owners.
    final closing = closeSession();
    try {
      await subscription?.cancel();
    } catch (error, stack) {
      _log.warning('Search unsubscribe failed type=${error.runtimeType}', error, stack);
    }
    await closing;
  }

  Future<void> _finish(Emitter<FrameDiscoveryState> emit, {bool cancelled = false, bool failed = false}) async {
    if (_session == null) return;
    await _release();
    final retain = cancelled || failed || state.limited || state.unresolved > 0;
    final frames = retain ? state.frames : _frames.values.toList();
    _log.info(
      'Search ${cancelled
          ? 'cancelled'
          : failed
          ? 'failed'
          : 'completed'} found=${frames.length} confirmed=${_frames.length} '
      'unresolved=${state.unresolved} limited=${state.limited}',
    );
    if (!emit.isDone) {
      emit(
        state.copyWith(status: failed ? FrameDiscoveryStatus.failure : FrameDiscoveryStatus.completed, frames: frames),
      );
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused || state == AppLifecycleState.hidden || state == AppLifecycleState.detached) {
      add(const FrameDiscoveryEvent.cancel());
    }
  }

  @override
  Future<void> close() async {
    WidgetsBinding.instance.removeObserver(this);
    if (_session != null) {
      _log.info('Search cancelled found=${state.frames.length}');
    }
    await _release();
    return super.close();
  }
}
