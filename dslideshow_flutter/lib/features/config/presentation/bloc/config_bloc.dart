import 'package:dslideshow_flutter/src/service/frontend.dart' show ButtonEvent;

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_flutter/features/config/data/config_access_repository.dart';
import 'package:dslideshow_flutter/features/config/presentation/bloc/config_event.dart';
import 'package:dslideshow_flutter/features/config/presentation/bloc/config_state.dart';
import 'package:logging/logging.dart';

class ConfigBloc extends Bloc<ConfigEvent, ConfigState> {
  ConfigBloc({required this.repository}) : _session = repository.createSession(), super(const ConfigState()) {
    on<ConfigInitialize>((event, emit) {
      if (_disposed || _initialized || state.exit != ConfigExitStatus.active) {
        return;
      }
      _initialized = true;
      _start(emit);
      _network(emit);
    });
    on<ConfigCompleted>(_completed);
    on<ConfigRetry>((event, emit) => _retry(emit));
    on<ConfigExit>((event, emit) => _exit(emit));
    on<ConfigNetworkUpdated>((event, emit) {
      if (_disposed || state.exit != ConfigExitStatus.active) return;
      _applyNetwork(event.info, emit);
    });
    on<ConfigButton>((event, emit) {
      if (_disposed || event.button.event != ButtonEventType.released) return;
      switch (event.button.button) {
        case ButtonType.button0:
          _exit(emit);
        case ButtonType.button3:
          _retry(emit);
        case ButtonType.button1 || ButtonType.button2:
          break;
      }
    });
    _buttons = repository.frontend.onButtonEvent.listen(
      (event) => _add(ConfigEvent.button(event)),
      onError: (Object error, StackTrace stack) =>
          _log.warning('Button stream failed type=${error.runtimeType}', error, stack),
    );
    _networkUpdates = repository.frontend.onSystemInfoUpdate.listen(
      (info) {
        _networkRevision++;
        _add(ConfigEvent.networkUpdated(info));
      },
      onError: (Object error, StackTrace stack) =>
          _log.warning('Network stream failed type=${error.runtimeType}', error, stack),
    );
  }

  static final _log = Logger('ConfigBloc');
  final ConfigAccessRepository repository;
  final ConfigAccessSession _session;
  late final StreamSubscription<ButtonEvent> _buttons;
  late final StreamSubscription<SystemInfo> _networkUpdates;
  int _networkRevision = 0;
  int _requestRevision = 0;
  bool _initialized = false;
  bool _disposed = false;
  final _closed = Completer<void>();

  void _add(ConfigEvent event) {
    if (!_disposed && !isClosed) add(event);
  }

  void _begin(ConfigOperation operation, Emitter<ConfigState> emit) {
    _log.info('Operation action=${operation.name} started');
    emit(state.copyWith(pending: {...state.pending, operation}));
  }

  ConfigFailureKind _failure(Object error, ConfigOperation operation) {
    if (error is Error) return ConfigFailureKind.unknown;
    return operation == ConfigOperation.network ? ConfigFailureKind.network : ConfigFailureKind.server;
  }

  void _start(Emitter<ConfigState> emit) {
    if (state.pending.contains(ConfigOperation.start)) return;
    emit(state.copyWith(access: ConfigAccessStatus.preparing, startFailure: null));
    _begin(ConfigOperation.start, emit);
    _session.start().then(
      (code) => _add(ConfigEvent.completed(ConfigOperation.start, code: code)),
      onError: (Object error) =>
          _add(ConfigEvent.completed(ConfigOperation.start, failure: _failure(error, ConfigOperation.start))),
    );
  }

  void _network(Emitter<ConfigState> emit) {
    if (state.pending.contains(ConfigOperation.network)) return;
    if (state.network == ConfigNetworkStatus.failed) {
      emit(state.copyWith(network: ConfigNetworkStatus.preparing, networkFailure: null, address: null));
    }
    _requestRevision = _networkRevision;
    _begin(ConfigOperation.network, emit);
    repository.frontend.getSystemInfo().then(
      (info) => _add(ConfigEvent.completed(ConfigOperation.network, info: info)),
      onError: (Object error) =>
          _add(ConfigEvent.completed(ConfigOperation.network, failure: _failure(error, ConfigOperation.network))),
    );
  }

  void _retry(Emitter<ConfigState> emit) {
    if (_disposed || !state.canRetry) return;
    if (state.phase == ConfigPhase.closeFailure) {
      _stop(emit);
    } else if (state.access == ConfigAccessStatus.failed) {
      _start(emit);
    } else {
      _network(emit);
    }
  }

  void _exit(Emitter<ConfigState> emit) {
    if (_disposed) return;
    if (state.exit == ConfigExitStatus.done || state.exit == ConfigExitStatus.closing) {
      return;
    }
    _log.info('Exit requested; cancelling page preparation');
    if (state.exit == ConfigExitStatus.failed) {
      // The user may leave after a failed stop instead of retrying it.
      emit(state.copyWith(exit: ConfigExitStatus.done));
    } else {
      _stop(emit);
    }
  }

  void _stop(Emitter<ConfigState> emit) {
    emit(state.copyWith(exit: ConfigExitStatus.closing, address: null, code: null, stopFailure: null));
    _begin(ConfigOperation.stop, emit);
    _session.release().then(
      (_) => _add(ConfigEvent.completed(ConfigOperation.stop)),
      onError: (Object error) =>
          _add(ConfigEvent.completed(ConfigOperation.stop, failure: _failure(error, ConfigOperation.stop))),
    );
  }

  void _completed(ConfigCompleted event, Emitter<ConfigState> emit) {
    if (_disposed || !state.pending.contains(event.operation)) return;
    _log.log(
      event.failure == null ? Level.INFO : Level.WARNING,
      'Operation action=${event.operation.name} ${event.failure == null ? 'completed' : 'failed reason=${event.failure!.name}'}',
    );
    emit(state.copyWith(pending: {...state.pending}..remove(event.operation)));
    if (event.operation == ConfigOperation.stop) {
      if (state.exit == ConfigExitStatus.done) return;
      emit(
        state.copyWith(
          exit: event.failure == null ? ConfigExitStatus.done : ConfigExitStatus.failed,
          stopFailure: event.failure,
        ),
      );
      return;
    }
    if (_disposed || state.exit != ConfigExitStatus.active) return;
    switch (event.operation) {
      case ConfigOperation.start:
        final failed = event.failure ?? (event.code?.trim().isNotEmpty == true ? null : ConfigFailureKind.unknown);
        emit(
          state.copyWith(
            access: failed == null ? ConfigAccessStatus.ready : ConfigAccessStatus.failed,
            code: failed == null ? event.code : null,
            startFailure: failed,
          ),
        );
      case ConfigOperation.network:
        if (_requestRevision != _networkRevision) {
          return;
        }
        if (event.failure != null) {
          emit(state.copyWith(network: ConfigNetworkStatus.failed, networkFailure: event.failure, address: null));
        } else {
          _applyNetwork(event.info!, emit);
        }
      case ConfigOperation.stop:
        break;
    }
  }

  void _applyNetwork(SystemInfo info, Emitter<ConfigState> emit) {
    try {
      final address = repository.addressFor(info);
      final next = address == null ? ConfigNetworkStatus.unavailable : ConfigNetworkStatus.ready;
      if (state.network != next || state.address != address) {
        _log.info('Network availability=${next.name}');
      }
      emit(state.copyWith(network: next, address: address, networkFailure: null));
    } catch (_) {
      emit(
        state.copyWith(network: ConfigNetworkStatus.failed, address: null, networkFailure: ConfigFailureKind.unknown),
      );
    }
  }

  @override
  Future<void> close() async {
    if (_disposed) return _closed.future;
    _disposed = true;
    final release = _session.release();
    _log.info('Page disposed; cancelling subscriptions and releasing access');
    unawaited(
      release.then(
        (_) {
          _log.info('Page access cleanup completed');
        },
        onError: (Object error, StackTrace stack) {
          _log.warning('Page access cleanup unconfirmed type=${error.runtimeType}', error, stack);
        },
      ),
    );
    try {
      await Future.wait([_buttons.cancel(), _networkUpdates.cancel()]);
    } finally {
      try {
        await super.close();
      } finally {
        _closed.complete();
      }
    }
  }
}
