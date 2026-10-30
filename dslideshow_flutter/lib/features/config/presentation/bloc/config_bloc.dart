import 'package:dslideshow_flutter/src/service/frontend.dart' show ButtonEvent;

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_flutter/features/config/data/config_access_repository.dart';
import 'package:dslideshow_flutter/features/config/presentation/bloc/config_event.dart';
import 'package:dslideshow_flutter/features/config/presentation/bloc/config_state.dart';
import 'package:logging/logging.dart';

class ConfigBloc extends Bloc<ConfigEvent, ConfigState> {
  ConfigBloc({required this.repository, this.operationTimeout = const Duration(seconds: 15)})
    : _session = repository.createSession(),
      super(const ConfigState()) {
    on<ConfigInitialize>((event, emit) {
      if (_disposed || _initialized || state.exit != ConfigExitStatus.active) {
        return;
      }
      _initialized = true;
      _start(emit);
      _network(emit);
    });
    on<ConfigCompleted>(_completed);
    on<ConfigTimedOut>(_timedOut);
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
      onError: (Object error) => _log.warning('Button stream failed type=${error.runtimeType}'),
    );
    _networkUpdates = repository.frontend.onSystemInfoUpdate.listen((info) {
      _networkRevision++;
      _add(ConfigEvent.networkUpdated(info));
    }, onError: (Object error) => _log.warning('Network stream failed type=${error.runtimeType}'));
  }

  static final _log = Logger('ConfigBloc');
  final ConfigAccessRepository repository;
  final Duration operationTimeout;
  final ConfigAccessSession _session;
  late final StreamSubscription<ButtonEvent> _buttons;
  late final StreamSubscription<SystemInfo> _networkUpdates;
  final _ids = <ConfigOperation, int>{};
  final _timers = <ConfigOperation, Timer>{};
  int _nextId = 0;
  int _networkRevision = 0;
  int _requestRevision = 0;
  bool _initialized = false;
  bool _disposed = false;
  final _closed = Completer<void>();

  void _add(ConfigEvent event) {
    if (!_disposed && !isClosed) add(event);
  }

  int _begin(ConfigOperation operation, Emitter<ConfigState> emit) {
    final id = ++_nextId;
    _ids[operation] = id;
    _log.info('Operation action=${operation.name} started');
    emit(state.copyWith(pending: {...state.pending, operation}));
    _timers[operation]?.cancel();
    _timers[operation] = Timer(operationTimeout, () => _add(ConfigEvent.timedOut(operation, id)));
    return id;
  }

  ConfigFailureKind _failure(Object error, ConfigOperation operation) {
    if (error is TimeoutException) return ConfigFailureKind.timeout;
    if (error is Error) return ConfigFailureKind.unknown;
    return operation == ConfigOperation.network ? ConfigFailureKind.network : ConfigFailureKind.server;
  }

  void _start(Emitter<ConfigState> emit) {
    if (state.pending.contains(ConfigOperation.start)) return;
    emit(state.copyWith(access: ConfigAccessStatus.preparing, startFailure: null));
    final id = _begin(ConfigOperation.start, emit);
    _session.start().then(
      (code) => _add(ConfigEvent.completed(ConfigOperation.start, id, code: code)),
      onError: (Object error) =>
          _add(ConfigEvent.completed(ConfigOperation.start, id, failure: _failure(error, ConfigOperation.start))),
    );
  }

  void _network(Emitter<ConfigState> emit) {
    if (state.pending.contains(ConfigOperation.network)) return;
    if (state.network == ConfigNetworkStatus.failed) {
      emit(state.copyWith(network: ConfigNetworkStatus.preparing, networkFailure: null, address: null));
    }
    _requestRevision = _networkRevision;
    final id = _begin(ConfigOperation.network, emit);
    repository.frontend.getSystemInfo().then(
      (info) => _add(ConfigEvent.completed(ConfigOperation.network, id, info: info)),
      onError: (Object error) =>
          _add(ConfigEvent.completed(ConfigOperation.network, id, failure: _failure(error, ConfigOperation.network))),
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
      // Explicit second return acknowledges the unconfirmed server outcome.
      emit(state.copyWith(exit: ConfigExitStatus.done));
    } else {
      _stop(emit);
    }
  }

  void _stop(Emitter<ConfigState> emit) {
    emit(state.copyWith(exit: ConfigExitStatus.closing, address: null, code: null, stopFailure: null));
    final id = _begin(ConfigOperation.stop, emit);
    _session.release().then(
      (_) => _add(ConfigEvent.completed(ConfigOperation.stop, id)),
      onError: (Object error) =>
          _add(ConfigEvent.completed(ConfigOperation.stop, id, failure: _failure(error, ConfigOperation.stop))),
    );
  }

  void _completed(ConfigCompleted event, Emitter<ConfigState> emit) {
    if (_disposed || _ids[event.operation] != event.id) return;
    _timers.remove(event.operation)?.cancel();
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
        if (state.startFailure == ConfigFailureKind.timeout) return;
        final failed = event.failure ?? (event.code?.trim().isNotEmpty == true ? null : ConfigFailureKind.unknown);
        emit(
          state.copyWith(
            access: failed == null ? ConfigAccessStatus.ready : ConfigAccessStatus.failed,
            code: failed == null ? event.code : null,
            startFailure: failed,
          ),
        );
      case ConfigOperation.network:
        if (_requestRevision != _networkRevision || state.networkFailure == ConfigFailureKind.timeout) {
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

  void _timedOut(ConfigTimedOut event, Emitter<ConfigState> emit) {
    if (_disposed || _ids[event.operation] != event.id || !state.pending.contains(event.operation)) {
      return;
    }
    if (event.operation == ConfigOperation.network && _requestRevision != _networkRevision) {
      return;
    }
    if (state.exit != ConfigExitStatus.active && event.operation != ConfigOperation.stop) {
      return;
    }
    _log.warning('Operation action=${event.operation.name} timeout; awaiting remote result');
    switch (event.operation) {
      case ConfigOperation.start:
        emit(state.copyWith(access: ConfigAccessStatus.failed, code: null, startFailure: ConfigFailureKind.timeout));
      case ConfigOperation.network:
        emit(
          state.copyWith(network: ConfigNetworkStatus.failed, address: null, networkFailure: ConfigFailureKind.timeout),
        );
      case ConfigOperation.stop:
        emit(state.copyWith(exit: ConfigExitStatus.failed, stopFailure: ConfigFailureKind.timeout));
    }
  }

  @override
  Future<void> close() async {
    if (_disposed) return _closed.future;
    _disposed = true;
    for (final timer in _timers.values) {
      timer.cancel();
    }
    final release = _session.release();
    _log.info('Page disposed; cancelling subscriptions and releasing access');
    unawaited(
      release.then(
        (_) {
          _log.info('Page access cleanup completed');
        },
        onError: (Object error) {
          _log.warning('Page access cleanup unconfirmed type=${error.runtimeType}');
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
