import 'dart:async';

import 'package:config_app/features/device/data/device_repository.dart';
import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_common/rpc.dart';
import 'package:flutter/foundation.dart';

import 'rpc_rates.dart';

/// Own one monitor per visible device page and dispose it when leaving the page.
class DeviceMonitor extends ChangeNotifier {
  final DeviceRepository repository;
  final bool telemetry;
  final Duration stateInterval;
  final Duration metricsInterval;

  FrameState? frame;
  SystemInfo? metrics;
  RpcTelemetrySnapshot? rpc;
  bool rpcStale = true;
  final rpcRates = RpcRates();
  int? get webSocketTimeouts => repository.webSocketTimeouts;
  DateTime? metricsSampledAt;
  bool loading = false;
  bool stale = true;
  bool metricsStale = true;
  DeviceFailure? failure;
  DeviceFailure? metricsFailure;
  FrameControl? pendingControl;

  Timer? _stateTimer;
  Timer? _metricsTimer;
  StreamSubscription? _disconnectSubscription;
  Future<void>? _stateFuture;
  Future<void>? _metricsFuture;
  Future<void>? _rpcFuture;
  int? _rpcGeneration;
  bool _rpcQueued = false;
  int? _stateGeneration;
  int? _metricsGeneration;
  bool _commandPending = false;
  bool _stateQueued = false;
  bool _metricsQueued = false;
  bool _started = false;
  bool _active = true;
  bool _disconnected = false;
  bool _disposed = false;
  int _generation = 0;

  DeviceMonitor(
    this.repository, {
    required this.telemetry,
    this.stateInterval = const Duration(seconds: 1),
    this.metricsInterval = const Duration(seconds: 10),
  }) {
    if (stateInterval <= Duration.zero || metricsInterval <= Duration.zero) {
      throw ArgumentError('Polling intervals must be positive');
    }
  }

  bool get busy => pendingControl != null;

  bool get canControl =>
      _canUpdate && frame != null && !stale && !_commandPending;

  bool get _canUpdate => _started && _active && !_disconnected && !_disposed;

  void start() {
    if (_started || _disposed) return;
    _started = true;
    _disconnectSubscription = repository.onDisconnect.listen((_) {
      if (_disposed || _disconnected) return;
      _disconnected = true;
      _invalidate();
      failure = const DeviceFailure(DeviceFailureKind.disconnected);
      notifyListeners();
    });
    if (_active) {
      _startTimers();
      unawaited(refresh());
    }
  }

  /// Suspend polling and invalidate all outstanding responses when hidden.
  void setActive(bool active) {
    if (_disposed || _active == active) return;
    _active = active;
    if (!active) {
      _invalidate();
      notifyListeners();
    } else if (_canUpdate) {
      _startTimers();
      unawaited(refresh());
    }
  }

  Future<void> refresh() {
    final state = _refreshState(queue: true);
    if (!telemetry) return state;
    // Explicit refresh waits for both results, while each polling lane owns its
    // own request so slow system metrics never delay state polling or actions.
    return Future.wait([
      state,
      _refreshMetrics(queue: true),
      _refreshRpc(queue: true),
    ]).then((_) {});
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
      if (_canUpdate && _rpcQueued) _refreshRpc();
    });
    return _rpcFuture!;
  }

  Future<void> _loadRpc(int generation) async {
    try {
      final snapshot = await repository.getRpcTelemetry();
      if (!_isCurrent(generation)) return;
      rpc = snapshot;
      rpcStale = false;
      rpcRates.update(snapshot);
    } catch (_) {
      if (!_isCurrent(generation)) return;
      rpcStale = true;
    }
    if (_isCurrent(generation)) notifyListeners();
  }

  Future<void> _refreshState({bool queue = false}) {
    if (!_canUpdate) return Future<void>.value();
    if (_commandPending || _stateFuture != null) {
      if (queue && (_commandPending || _stateGeneration != _generation)) {
        _stateQueued = true;
      }
      return _stateFuture ?? Future<void>.value();
    }
    _stateQueued = false;
    final generation = _generation;
    _stateGeneration = generation;
    loading = frame == null;
    _stateFuture = _loadFrame(generation).whenComplete(() {
      _stateFuture = null;
      _stateGeneration = null;
      if (_disposed) return;
      loading = false;
      notifyListeners();
      if (_canUpdate && !_commandPending && _stateQueued) {
        unawaited(_refreshState());
      }
    });
    notifyListeners();
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
      final state = await repository.getState();
      if (!_isCurrent(generation)) return;
      frame = state;
      stale = false;
      failure = null;
    } catch (error) {
      if (!_isCurrent(generation)) return;
      stale = true;
      failure = _failure(error, DeviceFailureKind.load);
    }
    if (_isCurrent(generation)) notifyListeners();
  }

  Future<void> _loadMetrics(int generation) async {
    try {
      final info = await repository.getSystemInfo();
      if (!_isCurrent(generation)) return;
      metrics = info;
      metricsSampledAt = DateTime.fromMillisecondsSinceEpoch(
        info.updateInfo.lastUpdate,
        isUtc: true,
      );
      metricsStale = false;
      metricsFailure = null;
    } catch (error) {
      if (!_isCurrent(generation)) return;
      metricsStale = true;
      metricsFailure = _failure(error, DeviceFailureKind.load);
    }
    if (_isCurrent(generation)) notifyListeners();
  }

  Future<void> setControl(FrameControl control, bool enabled) async {
    if (!canControl) return;
    final generation = _generation;
    _commandPending = true;
    pendingControl = control;
    failure = null;
    notifyListeners();
    try {
      // Await state polling only. Metrics are read-only and may take longer;
      // they must not hold up an action. A hidden page/disconnect invalidates
      // this intention before it can be sent.
      await _stateFuture;
      if (!_isCurrent(generation) || stale) return;
      final state = await repository.setControl(control, enabled);
      if (!_isCurrent(generation)) return;
      frame = state;
      stale = false;
    } catch (error) {
      if (!_isCurrent(generation)) return;
      // A timed out action may have been applied; wait for a fresh state before
      // permitting another action, and never replay the original command.
      stale = true;
      failure = _failure(error, DeviceFailureKind.command);
    } finally {
      _commandPending = false;
      if (_isCurrent(generation)) {
        pendingControl = null;
      }
      if (!_disposed) {
        notifyListeners();
        if (_canUpdate && _stateQueued) unawaited(_refreshState());
      }
    }
  }

  bool _isCurrent(int generation) => _canUpdate && generation == _generation;

  DeviceFailure _failure(Object error, DeviceFailureKind fallback) =>
      error is DeviceFailure ? error : DeviceFailure(fallback);

  void _startTimers() {
    _stateTimer = Timer.periodic(stateInterval, (_) {
      unawaited(_refreshState());
      if (telemetry) _refreshRpc();
    });
    if (telemetry) {
      _metricsTimer = Timer.periodic(metricsInterval, (_) {
        unawaited(_refreshMetrics());
      });
    }
  }

  void _invalidate() {
    ++_generation;
    _stateTimer?.cancel();
    _metricsTimer?.cancel();
    _stateTimer = null;
    _metricsTimer = null;
    _stateQueued = false;
    _metricsQueued = false;
    _rpcQueued = false;
    rpcStale = true;
    rpcRates.clear();
    loading = false;
    pendingControl = null;
    stale = true;
    metricsStale = true;
  }

  @override
  void dispose() {
    if (_disposed) return;
    _disposed = true;
    _invalidate();
    unawaited(_disconnectSubscription?.cancel());
    _disconnectSubscription = null;
    super.dispose();
  }
}
