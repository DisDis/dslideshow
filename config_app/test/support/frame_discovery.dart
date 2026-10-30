import 'dart:async';

import 'package:config_app/features/auth/domain/repository/authentication_repository.dart';
import 'package:dslideshow_common/frame_discovery.dart';

class ControlledFrameSession implements FrameDiscoverySession {
  final controller = StreamController<FrameDiscoveryUpdate>(sync: true, onCancel: () async {});
  Completer<void>? startGate;
  Object? startError;
  Object? closeError;
  int starts = 0;
  int closes = 0;
  final closed = Completer<void>();

  @override
  Stream<FrameDiscoveryUpdate> get updates => controller.stream;
  @override
  Future<void> start() async {
    starts++;
    await startGate?.future;
    if (startError case final error?) throw error;
  }

  @override
  Future<void> close() async {
    closes++;
    unawaited(controller.close());
    closed.complete();
    if (closeError case final error?) throw error;
  }
}

class ControlledFrameProvider implements FrameDiscoveryProvider {
  final sessions = <ControlledFrameSession>[];
  ControlledFrameSession Function()? next;
  @override
  ControlledFrameSession createSession() {
    final session = next?.call() ?? ControlledFrameSession();
    sessions.add(session);
    return session;
  }
}

const firstFrame = DiscoveredFrame(
  serviceKey: 'frame-a',
  hostname: 'living-room.local',
  address: '192.0.2.8',
  port: 9091,
);
const secondFrame = DiscoveredFrame(
  serviceKey: 'frame-b',
  hostname: 'living-room.local',
  address: '192.0.2.9',
  port: 8080,
);

class LoginCapture implements AuthenticationRepository {
  final requests = <({Uri uri, String username, String password})>[];
  @override
  Future<void> logIn({required Uri connectUrl, required String username, required String password}) async {
    requests.add((uri: connectUrl, username: username, password: password));
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
