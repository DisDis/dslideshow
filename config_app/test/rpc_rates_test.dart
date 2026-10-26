import 'package:config_app/features/device/presentation/rpc_rates.dart';
import 'package:dslideshow_common/rpc.dart';
import 'package:flutter_test/flutter_test.dart';

RpcTelemetrySnapshot sample(
  int seconds,
  int sent,
  int replies, {
  String session = 'one',
  bool stale = false,
}) => RpcTelemetrySnapshot(
  nodes: [
    RpcNodeSnapshot(
      node: RpcNode.backend,
      sessionId: session,
      sampledAt: DateTime.utc(2026),
      elapsedMicros: seconds * 1000000,
      stale: stale,
      connections: [
        RpcConnectionSnapshot(
          peer: RpcNode.frontend,
          outgoing: RpcQueueSnapshot(
            capacity: 25,
            sent: sent,
            responses: replies,
          ),
          incoming: const RpcHandlerSnapshot(),
        ),
      ],
    ),
  ],
);

void main() {
  test(
    'rates use source time, ignore stale snapshots and reset on restart',
    () {
      final rates = RpcRates();
      rates.update(sample(1, 10, 8));
      expect(rates.forConnection(RpcNode.backend, RpcNode.frontend), isNull);
      rates.update(sample(3, 30, 20));
      final rate = rates.forConnection(RpcNode.backend, RpcNode.frontend)!;
      expect(rate.sent, 10);
      expect(rate.responses, 6);
      rates.update(sample(8, 999, 999, stale: true));
      rates.update(sample(3, 30, 20));
      expect(rates.forConnection(RpcNode.backend, RpcNode.frontend), rate);
      rates.update(sample(1, 0, 0, session: 'restarted'));
      expect(rates.forConnection(RpcNode.backend, RpcNode.frontend), isNull);
      rates.update(sample(2, 3, 2, session: 'restarted'));
      expect(rates.forConnection(RpcNode.backend, RpcNode.frontend)!.sent, 3);
    },
  );

  test('old traffic does not leak into the ten second window', () {
    final rates = RpcRates();
    rates.update(sample(1, 1000, 1000));
    rates.update(sample(30, 1010, 1010));
    expect(rates.forConnection(RpcNode.backend, RpcNode.frontend), isNull);
    rates.update(sample(31, 1011, 1012));
    final rate = rates.forConnection(RpcNode.backend, RpcNode.frontend)!;
    expect(rate.sent, 1);
    expect(rate.responses, 2);
    rates.clear();
    expect(rates.forConnection(RpcNode.backend, RpcNode.frontend), isNull);
  });
}
