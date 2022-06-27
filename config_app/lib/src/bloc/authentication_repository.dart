import 'dart:async';

import 'package:config_app/src/service/client_service.dart';
import 'package:dslideshow_backend/command.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationRepository {
  final _client = ClientService();
  final _controller = StreamController<AuthenticationStatus>();
  late StreamSubscription<bool> _authSub;
  ClientService get client => _client;

  AuthenticationRepository() {
    _client.onDisconnect.listen((event) {
      _controller.add(AuthenticationStatus.unauthenticated);
      logOut();
    });
  }

  Stream<AuthenticationStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield AuthenticationStatus.unauthenticated;
    yield* _controller.stream;
  }

  Future<void> logIn({
    required Uri connectUrl,
    required String username,
    required String password,
  }) async {
    final result = await _client.connect(connectUrl, password);
    if (result is WebSocketErrorResult) {
      _controller.add(AuthenticationStatus.unauthenticated);
    } else {
      _controller.add(AuthenticationStatus.authenticated);
    }
  }

  void logOut() {
    _client.disconnect();
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  void dispose() {
    _controller.close();
    _authSub.cancel();
  }
}
