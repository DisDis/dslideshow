import 'dart:convert';

import 'package:dslideshow_backend/serializers.dart';
import 'package:dslideshow_common/rpc.dart';
import 'package:test/test.dart';

void main() {
  test(
    'RPC telemetry command and snapshot survive the production JSON codec',
    () {
      final request = serializers.deserialize(
        jsonDecode(
          jsonEncode(
            serializers.serialize(const GetRpcTelemetryCommand(id: 42)),
          ),
        ),
      ) as GetRpcTelemetryCommand;
      expect(request.id, 42);
      final original = GetRpcTelemetryResult(
        id: 42,
        snapshot: RpcTelemetrySnapshot(
          nodes: [
            RpcNodeSnapshot(
              node: RpcNode.backend,
              sessionId: 'run',
              sampledAt: DateTime.utc(2026),
              elapsedMicros: 10,
              connections: [
                const RpcConnectionSnapshot(
                  peer: RpcNode.frontend,
                  outgoing: RpcQueueSnapshot(
                    capacity: 25,
                    inFlight: 25,
                    queued: 7,
                    oldestInFlight: RpcPendingSnapshot(
                      commandType: 'echo',
                      ageMicros: 20000000,
                    ),
                  ),
                  incoming: RpcHandlerSnapshot(active: 2),
                ),
              ],
            ),
          ],
        ),
      );
      final result = serializers.deserialize(
        jsonDecode(jsonEncode(serializers.serialize(original))),
      ) as GetRpcTelemetryResult;
      final channel = result.snapshot.nodes.single.connections.single;
      expect(result.id, 42);
      expect(channel.outgoing.inFlight, 25);
      expect(channel.outgoing.queued, 7);
      expect(channel.outgoing.oldestInFlight!.ageMicros, 20000000);
      expect(channel.incoming.active, 2);
    },
  );
}
