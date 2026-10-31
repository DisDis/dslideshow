import 'package:logging/logging.dart';

import 'telemetry_snapshot.dart';

/// One collector per isolate. Peers form a tree rooted at the backend:
/// backend -> frontend -> OTA, and backend -> web. Reads use ordinary RPCs.
class RpcTelemetry {
  static final _log = Logger('RpcTelemetry');
  final RpcNode node;
  final String sessionId;
  final Stopwatch _clock = Stopwatch()..start();
  final _connections = <RpcConnectionMetrics>[];
  final _peers = <Future<RpcTelemetrySnapshot> Function()>[];

  RpcTelemetry(this.node) : sessionId = '${node.name}-${DateTime.now().microsecondsSinceEpoch}';

  RpcConnectionMetrics addConnection(RpcNode peer) {
    final metrics = RpcConnectionMetrics(peer);
    _connections.add(metrics);
    return metrics;
  }

  void addPeer(Future<RpcTelemetrySnapshot> Function() read) {
    _peers.add(read);
  }

  RpcNodeSnapshot localSnapshot() => RpcNodeSnapshot(
    node: node,
    sessionId: sessionId,
    sampledAt: DateTime.now().toUtc(),
    elapsedMicros: _clock.elapsedMicroseconds,
    connections: _connections.map((item) => item.snapshot()).toList(),
  );

  Future<RpcTelemetrySnapshot> collect() async {
    final peers = await Future.wait(_peers.map(_collectPeer));
    return RpcTelemetrySnapshot(nodes: [localSnapshot(), for (final snapshot in peers) ...snapshot.nodes]);
  }

  Future<RpcTelemetrySnapshot> _collectPeer(Future<RpcTelemetrySnapshot> Function() read) async {
    try {
      return await read();
    } catch (error) {
      _log.fine('Peer telemetry unavailable type=${error.runtimeType}');
      return const RpcTelemetrySnapshot();
    }
  }
}

class _Durations {
  int count = 0, total = 0, maximum = 0;
  void add(int micros) {
    count++;
    total += micros;
    if (micros > maximum) maximum = micros;
  }

  RpcDurationSnapshot snapshot() => RpcDurationSnapshot(count: count, totalMicros: total, maxMicros: maximum);
}

class RpcConnectionMetrics {
  final RpcNode peer;
  final Stopwatch _clock = Stopwatch()..start();
  int capacity = 0;
  int _submitted = 0, _sent = 0, _responses = 0;
  int _transportErrors = 0, _responseErrors = 0;
  int _maxQueued = 0, _maxInFlight = 0;
  int _handlersActive = 0, _handlersMax = 0;
  int _handlersCompleted = 0, _handlerErrors = 0;
  final _queued = <RpcRequestMeasurement>{};
  final _inFlight = <RpcRequestMeasurement>{};
  final _slotWait = _Durations(), _responseWait = _Durations();
  final _handlerDuration = _Durations();
  RpcConnectionMetrics(this.peer);

  int get _waitingForSlot {
    final waiting = _queued.length + _inFlight.length - capacity;
    return waiting > 0 ? waiting : 0;
  }

  RpcRequestMeasurement enqueue(String? commandType) {
    final request = RpcRequestMeasurement._(this, commandType, _clock.elapsedMicroseconds);
    _submitted++;
    _queued.add(request);
    if (_waitingForSlot > _maxQueued) _maxQueued = _waitingForSlot;
    return request;
  }

  void recordResponseError() => _responseErrors++;
  int handlerStarted() {
    _handlersActive++;
    if (_handlersActive > _handlersMax) _handlersMax = _handlersActive;
    return _clock.elapsedMicroseconds;
  }

  void handlerFinished(int started, {required bool error}) {
    _handlersActive--;
    _handlersCompleted++;
    if (error) _handlerErrors++;
    _handlerDuration.add(_clock.elapsedMicroseconds - started);
  }

  RpcPendingSnapshot? _oldest(Iterable<RpcRequestMeasurement> requests) => requests.isEmpty
      ? null
      : RpcPendingSnapshot(
          commandType: requests.first.commandType,
          ageMicros: _clock.elapsedMicroseconds - requests.first.started,
        );

  RpcConnectionSnapshot snapshot() => RpcConnectionSnapshot(
    peer: peer,
    outgoing: RpcQueueSnapshot(
      capacity: capacity,
      queued: _waitingForSlot,
      inFlight: _inFlight.length,
      maxQueued: _maxQueued,
      maxInFlight: _maxInFlight,
      submitted: _submitted,
      sent: _sent,
      responses: _responses,
      transportErrors: _transportErrors,
      responseErrors: _responseErrors,
      slotWait: _slotWait.snapshot(),
      responseWait: _responseWait.snapshot(),
      oldestQueued: _oldest(_queued.skip(_queued.length - _waitingForSlot)),
      oldestInFlight: _oldest(_inFlight),
    ),
    incoming: RpcHandlerSnapshot(
      active: _handlersActive,
      maxActive: _handlersMax,
      completed: _handlersCompleted,
      errors: _handlerErrors,
      duration: _handlerDuration.snapshot(),
    ),
  );
}

/// Metadata only: never retains command payloads, URLs or authentication data.
class RpcRequestMeasurement {
  final RpcConnectionMetrics _metrics;
  final String? commandType;
  final int started;
  int? _dispatched;
  bool _finished = false;
  RpcRequestMeasurement._(this._metrics, this.commandType, this.started);

  void dispatch() {
    _metrics._queued.remove(this);
    _metrics._inFlight.add(this);
    _dispatched = _metrics._clock.elapsedMicroseconds;
    _metrics._slotWait.add(_dispatched! - started);
    _metrics._sent++;
    if (_metrics._inFlight.length > _metrics._maxInFlight) {
      _metrics._maxInFlight = _metrics._inFlight.length;
    }
  }

  void response() => _metrics._responses++;
  void failed() => _metrics._transportErrors++;
  void finish() {
    if (_finished) return;
    _finished = true;
    _metrics._queued.remove(this);
    _metrics._inFlight.remove(this);
    if (_dispatched != null) {
      _metrics._responseWait.add(_metrics._clock.elapsedMicroseconds - _dispatched!);
    }
  }
}
