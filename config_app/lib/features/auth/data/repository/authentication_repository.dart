import 'dart:async';

import 'package:config_app/features/auth/domain/repository/authentication_repository.dart';
import 'package:config_app/features/realtime/domain/services/realtime_service.dart';
import 'package:dslideshow_backend/command.dart';
import 'package:logging/logging.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  static final Logger _log = Logger('AuthenticationRepository');
  final RealtimeService client;
  final _controller = StreamController<AuthenticationStatus>();
  StreamSubscription<dynamic>? _disconnectSubscription;
  AuthenticationStatus _status = AuthenticationStatus.unauthenticated;
  int _generation = 0;
  int? _disconnectedGeneration;
  bool _disposed = false;

  AuthenticationRepositoryImpl({required this.client}) {
    _controller.add(_status);
    _observeDisconnects(_generation);
  }

  @override
  Stream<AuthenticationStatus> get status => _controller.stream;

  @override
  Future<void> logIn({required Uri connectUrl, required String username, required String password}) async {
    if (_disposed) {
      throw StateError('Authentication repository is disposed');
    }
    final generation = ++_generation;
    _cancelDisconnectSubscription();
    _log.fine('Authentication started');
    try {
      // Canceling the previous subscription drops any queued disconnect from
      // that attempt. The new listener only owns this login generation.
      _observeDisconnects(generation);
      final result = await client.connect(connectUrl, password);
      if (!_isCurrent(generation) || _disconnectedGeneration == generation) {
        return;
      }
      if (result is WebSocketErrorResult) {
        _setStatus(AuthenticationStatus.unauthenticated);
        _log.fine('Authentication rejected');
      } else {
        _setStatus(AuthenticationStatus.authenticated);
        _log.fine('Authentication succeeded');
      }
    } catch (error, stack) {
      if (!_isCurrent(generation)) {
        return;
      }
      _setStatus(AuthenticationStatus.unauthenticated);
      _log.warning('Authentication failed', error, stack);
      rethrow;
    }
  }

  @override
  void logOut() {
    if (_disposed) {
      return;
    }
    ++_generation;
    _cancelDisconnectSubscription();
    try {
      client.disconnect();
    } finally {
      _setStatus(AuthenticationStatus.unauthenticated);
    }
  }

  @override
  void dispose() {
    if (_disposed) {
      return;
    }
    _disposed = true;
    ++_generation;
    _cancelDisconnectSubscription();
    unawaited(_controller.close());
  }

  bool _isCurrent(int generation) => !_disposed && generation == _generation;

  void _observeDisconnects(int generation) {
    _disconnectSubscription = client.onDisconnect.listen((_) {
      if (!_isCurrent(generation)) {
        return;
      }
      _disconnectedGeneration = generation;
      _setStatus(AuthenticationStatus.unauthenticated);
    });
  }

  void _cancelDisconnectSubscription() {
    final subscription = _disconnectSubscription;
    _disconnectSubscription = null;
    if (subscription != null) {
      unawaited(subscription.cancel());
    }
  }

  void _setStatus(AuthenticationStatus status) {
    if (_disposed || status == _status) {
      return;
    }
    _status = status;
    _controller.add(status);
  }
}
