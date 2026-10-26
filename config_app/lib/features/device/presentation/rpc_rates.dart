import 'package:dslideshow_common/rpc.dart';

/// Uses source monotonic timestamps, not the panel's network arrival times.
class RpcRates {
  final _history = <RpcNode, List<RpcNodeSnapshot>>{};
  static const _windowMicros = 10 * 1000 * 1000;

  void clear() => _history.clear();

  void update(RpcTelemetrySnapshot snapshot) {
    for (final node in snapshot.nodes) {
      if (node.stale) continue;
      final samples = _history.putIfAbsent(node.node, () => []);
      if (samples.isNotEmpty &&
          (samples.last.sessionId != node.sessionId ||
              samples.last.elapsedMicros > node.elapsedMicros)) {
        samples.clear();
      }
      if (samples.isNotEmpty &&
          samples.last.elapsedMicros == node.elapsedMicros) {
        continue;
      }
      samples.removeWhere(
        (sample) => sample.elapsedMicros < node.elapsedMicros - _windowMicros,
      );
      samples.add(node);
      // Bound memory even if a server produces unexpectedly frequent samples.
      if (samples.length > 12) samples.removeAt(0);
    }
  }

  ({double sent, double responses})? forConnection(RpcNode node, RpcNode peer) {
    final samples = _history[node];
    if (samples == null || samples.length < 2) return null;
    final first = samples.first, last = samples.last;
    final elapsed = (last.elapsedMicros - first.elapsedMicros) / 1000000;
    if (elapsed <= 0) return null;
    RpcQueueSnapshot? outgoing(RpcNodeSnapshot sample) {
      for (final connection in sample.connections) {
        if (connection.peer == peer) return connection.outgoing;
      }
      return null;
    }

    final before = outgoing(first), after = outgoing(last);
    if (before == null ||
        after == null ||
        after.sent < before.sent ||
        after.responses < before.responses) {
      return null;
    }
    return (
      sent: (after.sent - before.sent) / elapsed,
      responses: (after.responses - before.responses) / elapsed,
    );
  }
}
