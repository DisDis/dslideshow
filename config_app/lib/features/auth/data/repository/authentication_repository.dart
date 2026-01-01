import 'dart:async';

import 'package:config_app/features/auth/domain/repository/authentication_repository.dart';
import 'package:config_app/features/realtime/domain/services/realtime_service.dart';
import 'package:dslideshow_backend/command.dart';
import 'package:logging/logging.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  static final Logger _log = Logger('AuthenticationRepository');
  final RealtimeService client;
  final _controller = StreamController<AuthenticationStatus>();
  // late StreamSubscription<bool> _authSub;

  AuthenticationRepositoryImpl({required this.client}) {
    client.onDisconnect.listen((event) {
      _controller.add(AuthenticationStatus.unauthenticated);
      logOut();
    });
  }

  @override
  Stream<AuthenticationStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield AuthenticationStatus.unauthenticated;
    yield* _controller.stream;
  }

  @override
  Future<void> logIn({
    required Uri connectUrl,
    required String username,
    required String password,
  }) async {
    _log.finest(
        "Try to logIn U:$username P(${password.length}), url:$connectUrl");
    try {
      final result = await client.connect(connectUrl, password);
      if (result is WebSocketErrorResult) {
        _controller.add(AuthenticationStatus.unauthenticated);
      } else {
        _controller.add(AuthenticationStatus.authenticated);
      }
      _log.finest('authenticated');
    } catch (e, st) {
      _log.severe("Error", e, st);
      rethrow;
    }
  }

  @override
  void logOut() {
    client.disconnect();
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  @override
  void dispose() {
    _controller.close();
    // _authSub.cancel();
  }
}
