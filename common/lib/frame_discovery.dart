import 'package:freezed_annotation/freezed_annotation.dart';

part 'frame_discovery.freezed.dart';

const frameServiceType = '_dslideshow._tcp';

@freezed
abstract class DiscoveredFrame with _$DiscoveredFrame {
  const DiscoveredFrame._();

  const factory DiscoveredFrame({
    required String serviceKey,
    required String hostname,
    required String address,
    required int port,
  }) = _DiscoveredFrame;

  Uri get connectUri => Uri(scheme: 'ws', host: address, port: port, path: '/ws');
}

@freezed
sealed class FrameDiscoveryUpdate with _$FrameDiscoveryUpdate {
  const factory FrameDiscoveryUpdate.resolved(DiscoveredFrame frame) = FrameResolved;
  const factory FrameDiscoveryUpdate.lost(String serviceKey) = FrameLost;
  const factory FrameDiscoveryUpdate.limited() = FrameDiscoveryLimited;
  const factory FrameDiscoveryUpdate.resolveFailed() = FrameResolveFailed;
}

abstract interface class FrameDiscoverySession {
  Stream<FrameDiscoveryUpdate> get updates;
  Future<void> start();
  Future<void> close();
}

abstract interface class FrameDiscoveryProvider {
  FrameDiscoverySession createSession();
}
