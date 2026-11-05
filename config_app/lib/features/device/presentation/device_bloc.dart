import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:config_app/features/device/data/device_repository.dart';
import 'package:dslideshow_backend/command.dart';
import 'package:flutter/widgets.dart';
import 'package:logging/logging.dart';

import 'device_state.dart';
import 'rpc_rates.dart';

/// Owns the visible device page, including polling and application lifecycle.
class DeviceBloc extends Cubit<DeviceState> {
  static const _rpcInterval = Duration(seconds: 5);
  static final _log = Logger('DeviceBloc');

  final DeviceRepository repository;
  final bool telemetry;
  final Duration stateInterval;
  final Duration metricsInterval;
  final rpcRates = RpcRates();

  Timer? _stateTimer;
  Timer? _metricsTimer;
  Timer? _rpcTimer;
  AppLifecycleListener? _lifecycle;
  StreamSubscription? _disconnectSubscription;
  Future<void>? _stateFuture;
  Future<void>? _metricsFuture;
  Future<void>? _rpcFuture;
  int? _rpcGeneration;
  bool _rpcQueued = false;
  int? _stateGeneration;
  int? _metricsGeneration;
  bool _stateQueued = false;
  bool _metricsQueued = false;
  bool _closing = false;
  int _generation = 0;

  DeviceBloc(
    this.repository, {
    required this.telemetry,
    this.stateInterval = const Duration(seconds: 1),
    this.metricsInterval = const Duration(seconds: 10),
  }) : super(const DeviceState()) {
    if (stateInterval <= Duration.zero || metricsInterval <= Duration.zero) {
      throw ArgumentError('Polling intervals must be positive');
    }
  }

  bool get _canUpdate => state.started && state.active && state.connected && !_closing;

  void start() {
    if (state.started || _closing) return;
    _lifecycle = AppLifecycleListener(onStateChange: (value) => setActive(value == AppLifecycleState.resumed));
    final lifecycle = WidgetsBinding.instance.lifecycleState;
    emit(
      state.copyWith(
        started: true,
        active: state.active && (lifecycle == null || lifecycle == AppLifecycleState.resumed),
      ),
    );
    _disconnectSubscription = repository.onDisconnect.listen((_) {
      if (_closing || !state.connected) return;
      _invalidate();
      _log.warning('Device disconnected; controls disabled');
      emit(state.copyWith(connected: false, failure: const DeviceFailure(DeviceFailureKind.disconnected)));
    });
    if (state.active) {
      _startTimers();
      unawaited(refresh());
    }
  }

  void setActive(bool active) {
    if (_closing || state.active == active) return;
    emit(state.copyWith(active: active));
    if (!active) {
      _invalidate();
    } else if (_canUpdate) {
      _startTimers();
      unawaited(refresh());
    }
  }

  void setDetailsExpanded(bool expanded) {
    if (_closing || state.detailsExpanded == expanded) return;
    _log.fine('State details expanded=$expanded');
    emit(state.copyWith(detailsExpanded: expanded));
  }

  Future<void> refresh() {
    final snapshot = _refreshState(queue: true);
    if (!telemetry) return snapshot;
    // The independent read-only lanes must not delay controls or state polling.
    return Future.wait([snapshot, _refreshMetrics(queue: true), _refreshRpc(queue: true)]).then((_) {});
  }

  Future<void> _refreshRpc({bool queue = false}) {
    if (!_canUpdate || !telemetry) return Future<void>.value();
    if (_rpcFuture != null) {
      if (queue && _rpcGeneration != _generation) _rpcQueued = true;
      return _rpcFuture!;
    }
    _rpcQueued = false;
    final generation = _generation;
    _rpcGeneration = generation;
    _rpcFuture = _loadRpc(generation).whenComplete(() {
      _rpcFuture = null;
      _rpcGeneration = null;
      if (_canUpdate && _rpcQueued) unawaited(_refreshRpc());
    });
    return _rpcFuture!;
  }

  Future<void> _loadRpc(int generation) async {
    try {
      final snapshot = await repository.getRpcTelemetry();
      if (!_isCurrent(generation)) return;
      rpcRates.update(snapshot);
      emit(state.copyWith(rpc: snapshot, rpcStale: false, webSocketTimeouts: repository.webSocketTimeouts));
    } catch (error, stack) {
      if (!_isCurrent(generation)) return;
      _logUnexpected('RPC telemetry failed', error, stack);
      emit(state.copyWith(rpcStale: true, webSocketTimeouts: repository.webSocketTimeouts));
    }
  }

  Future<void> _refreshState({bool queue = false}) {
    if (!_canUpdate) return Future<void>.value();
    if (state.commandInFlight || _stateFuture != null) {
      if (queue && (state.commandInFlight || _stateGeneration != _generation)) _stateQueued = true;
      return _stateFuture ?? Future<void>.value();
    }
    _stateQueued = false;
    final generation = _generation;
    _stateGeneration = generation;
    emit(state.copyWith(loading: state.frame == null));
    _stateFuture = _loadFrame(generation).whenComplete(() {
      _stateFuture = null;
      _stateGeneration = null;
      if (_closing) return;
      emit(state.copyWith(loading: false));
      if (_canUpdate && !state.commandInFlight && _stateQueued) unawaited(_refreshState());
    });
    return _stateFuture!;
  }

  Future<void> _refreshMetrics({bool queue = false}) {
    if (!_canUpdate || !telemetry) return Future<void>.value();
    if (_metricsFuture != null) {
      if (queue && _metricsGeneration != _generation) _metricsQueued = true;
      return _metricsFuture!;
    }
    _metricsQueued = false;
    final generation = _generation;
    _metricsGeneration = generation;
    _metricsFuture = _loadMetrics(generation).whenComplete(() {
      _metricsFuture = null;
      _metricsGeneration = null;
      if (_canUpdate && _metricsQueued) unawaited(_refreshMetrics());
    });
    return _metricsFuture!;
  }

  Future<void> _loadFrame(int generation) async {
    try {
      final frame = await repository.getState();
      if (!_isCurrent(generation)) return;
      if (state.failure != null) _log.info('Frame state refreshed after failure');
      emit(state.copyWith(frame: frame, stale: false, failure: null));
    } catch (error, stack) {
      if (!_isCurrent(generation)) return;
      _logUnexpected('Frame state failed', error, stack);
      emit(state.copyWith(stale: true, failure: _failure(error, DeviceFailureKind.load)));
    }
  }

  Future<void> _loadMetrics(int generation) async {
    try {
      final metrics = await repository.getSystemInfo();
      if (!_isCurrent(generation)) return;
      emit(
        state.copyWith(
          metrics: metrics,
          metricsSampledAt: DateTime.fromMillisecondsSinceEpoch(metrics.updateInfo.lastUpdate, isUtc: true),
          metricsStale: false,
          metricsFailure: null,
        ),
      );
    } catch (error, stack) {
      if (!_isCurrent(generation)) return;
      _logUnexpected('System metrics failed', error, stack);
      emit(state.copyWith(metricsStale: true, metricsFailure: _failure(error, DeviceFailureKind.load)));
    }
  }

  Future<void> setControl(FrameControl control, bool enabled) async {
    if (_closing || !state.canControl) return;
    final generation = _generation;
    _log.info('Control started control=${control.name} enabled=$enabled');
    emit(state.copyWith(commandInFlight: true, pendingControl: control, failure: null));
    try {
      // Wait for the current state read, not metrics. Hidden/disconnected pages
      // invalidate an intention before sending it across the network.
      await _stateFuture;
      if (!_isCurrent(generation) || state.stale) {
        _log.info('Control cancelled before send control=${control.name}');
        return;
      }
      final frame = await repository.setControl(control, enabled);
      if (!_isCurrent(generation)) {
        _log.info('Control response ignored after page deactivation control=${control.name}');
        return;
      }
      _log.info('Control confirmed control=${control.name} enabled=$enabled');
      emit(state.copyWith(frame: frame, stale: false));
    } catch (error, stack) {
      _logUnexpected('Control failed control=${control.name}', error, stack);
      if (!_isCurrent(generation)) return;
      _log.warning('Control not confirmed control=${control.name}; refresh required before another action');
      // A network timeout may have an unknown result. Never replay the action.
      emit(state.copyWith(stale: true, failure: _failure(error, DeviceFailureKind.command)));
    } finally {
      if (!_closing) {
        emit(state.copyWith(commandInFlight: false, pendingControl: null));
        if (_canUpdate && _stateQueued) unawaited(_refreshState());
      }
    }
  }

  bool _isCurrent(int generation) => _canUpdate && generation == _generation;

  DeviceFailure _failure(Object error, DeviceFailureKind fallback) =>
      error is DeviceFailure ? error : DeviceFailure(fallback);

  void _logUnexpected(String action, Object error, StackTrace stack) {
    // DeviceRepository already logs the original cause before categorizing it.
    if (error is! DeviceFailure) _log.warning(action, error, stack);
  }

  void _startTimers() {
    _log.fine('Polling started telemetry=$telemetry rpcIntervalSeconds=${_rpcInterval.inSeconds}');
    _stateTimer = Timer.periodic(stateInterval, (_) => unawaited(_refreshState()));
    if (telemetry) {
      _rpcTimer = Timer.periodic(_rpcInterval, (_) => unawaited(_refreshRpc()));
      _metricsTimer = Timer.periodic(metricsInterval, (_) => unawaited(_refreshMetrics()));
    }
  }

  void _invalidate() {
    _log.fine('Polling stopped');
    ++_generation;
    _stateTimer?.cancel();
    _metricsTimer?.cancel();
    _rpcTimer?.cancel();
    _stateTimer = null;
    _metricsTimer = null;
    _rpcTimer = null;
    _stateQueued = false;
    _metricsQueued = false;
    _rpcQueued = false;
    rpcRates.clear();
    if (!_closing) {
      emit(state.copyWith(rpcStale: true, loading: false, pendingControl: null, stale: true, metricsStale: true));
    }
  }

  @override
  Future<void> close() async {
    _closing = true;
    _invalidate();
    _lifecycle?.dispose();
    await _disconnectSubscription?.cancel();
    await super.close();
  }
}
