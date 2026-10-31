import 'dart:async';
import 'dart:convert';

import 'package:config_app/features/realtime/domain/services/realtime_service.dart';
import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_backend/serializers.dart';
import 'package:logging/logging.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;

class ClientServiceImpl implements RealtimeService, RealtimeDiagnostics {
  static final _log = Logger('ClientService');

  final WebSocketChannel Function(Uri) _channelFactory;
  final Duration connectionTimeout;
  final Duration requestTimeout;
  final _onDisconnect = StreamController<void>.broadcast();
  final _cleanupOperations = <Future<void>>{};
  _Connection? _connection;
  bool _isAuth = false;
  bool _disposed = false;
  int _requestTimeouts = 0;
  Future<void>? _disposal;
  String _authCode = '';
  Uri _connectUri = Uri.parse('http://127.0.0.1');

  ClientServiceImpl({
    WebSocketChannel Function(Uri)? channelFactory,
    this.connectionTimeout = const Duration(seconds: 10),
    this.requestTimeout = const Duration(seconds: 15),
  }) : _channelFactory = channelFactory ?? WebSocketChannel.connect {
    if (connectionTimeout <= Duration.zero || requestTimeout <= Duration.zero) {
      throw ArgumentError('Connection and request timeouts must be positive');
    }
  }

  WebSocketChannel? get channel => _connection?.channel;
  @override
  int get requestTimeouts => _requestTimeouts;
  bool get isAuth => _isAuth;

  @override
  Stream<void> get onDisconnect => _onDisconnect.stream;

  @override
  String get authCode => _authCode;

  @override
  Uri get connectUri => _connectUri;

  @override
  Future<WebSocketResult> connect(Uri uri, String code) async {
    _ensureActive();
    final previous = _connection;
    if (previous != null) _disconnect(previous, notify: false);

    late final WebSocketChannel transport;
    try {
      transport = _channelFactory(uri);
    } catch (error, stack) {
      _log.warning('WebSocket creation failed (${error.runtimeType})', error, stack);
      throw StateError('WebSocket connection failed');
    }
    final connection = _Connection(transport);
    // A stream may fail synchronously while its listener is being installed.
    // Callers still observe readiness errors through connect()/send().
    connection.ready.future.ignore();
    _connection = connection;
    _connectUri = uri;
    _authCode = code;
    _isAuth = false;
    try {
      unawaited(_waitForReady(connection));
      connection.subscription = transport.stream.listen(
        (message) {
          if (_isCurrent(connection)) _parseMessage(connection, message);
        },
        onError: (Object error, StackTrace stack) {
          if (!_isCurrent(connection)) return;
          _log.warning('WebSocket transport failed (${error.runtimeType})', error, stack);
          _disconnect(connection, error: StateError('WebSocket connection failed'));
        },
        onDone: () => _disconnect(connection),
      );
      await connection.ready.future;
      final result = await _send(
        connection,
        WSAuthCommand(userName: 'admin', id: WebSocketCommand.generateId(), code: code),
      );
      _ensureCurrent(connection);
      _isAuth = true;
      _log.info('WebSocket authenticated');
      return result;
    } catch (error) {
      if (_isCurrent(connection)) _disconnect(connection);
      rethrow;
    }
  }

  Future<void> _waitForReady(_Connection connection) async {
    if (!_isCurrent(connection)) return;
    connection.handshakeTimer = Timer(connectionTimeout, () {
      if (!_isCurrent(connection)) return;
      _disconnect(connection, error: TimeoutException('WebSocket connection timed out', connectionTimeout));
    });
    try {
      await connection.channel.ready;
      if (!_isCurrent(connection)) return;
      connection.handshakeTimer?.cancel();
      connection.isReady = true;
      connection.ready.complete();
    } catch (error, stack) {
      if (!_isCurrent(connection)) return;
      _log.warning('WebSocket connection failed (${error.runtimeType})', error, stack);
      _disconnect(connection, error: StateError('WebSocket connection failed'));
    }
  }

  @override
  void disconnect() {
    final connection = _connection;
    if (connection != null) _disconnect(connection);
  }

  void _disconnect(_Connection connection, {bool notify = true, Object? error}) {
    if (connection.closed) return;
    connection.closed = true;
    connection.handshakeTimer?.cancel();
    final isCurrent = identical(_connection, connection);
    if (isCurrent) {
      _connection = null;
      _isAuth = false;
      _authCode = '';
    }
    if (!connection.ready.isCompleted) {
      connection.ready.completeError(error ?? StateError('WebSocket disconnected'));
    }
    final requests = connection.pending.entries.toList();
    connection.pending.clear();
    for (final entry in requests) {
      entry.value.timer?.cancel();
      entry.value.result.completeError(WSErrorResult.byId('disconnect', entry.key));
    }
    _trackCleanup(_cleanup(() => connection.subscription?.cancel(), 'subscription cancellation'));
    _trackCleanup(_cleanup(() => connection.channel.sink.close(status.normalClosure), 'close'));
    if (isCurrent && notify && !_disposed) _onDisconnect.add(null);
    _log.info('WebSocket disconnected');
  }

  Future<void> _cleanup(FutureOr<void> Function() action, String operation) =>
      Future<void>.sync(action).timeout(connectionTimeout).catchError((Object error, StackTrace stack) {
        _log.warning('WebSocket $operation failed (${error.runtimeType})', error, stack);
      });

  void _trackCleanup(Future<void> operation) {
    _cleanupOperations.add(operation);
    unawaited(operation.then((_) => _cleanupOperations.remove(operation)));
  }

  @override
  Future<WebSocketResult> send(WebSocketCommand cmd, {Duration? timeout}) async {
    _ensureActive();
    if (timeout != null && timeout <= Duration.zero) {
      throw ArgumentError.value(timeout, 'timeout', 'Must be positive');
    }
    final connection = _connection;
    if (connection == null) throw StateError('WebSocket is not connected');
    return _send(connection, cmd, timeout: timeout);
  }

  Future<WebSocketResult> _send(_Connection connection, WebSocketCommand cmd, {Duration? timeout}) async {
    await connection.ready.future;
    _ensureCurrent(connection);
    if (connection.pending.containsKey(cmd.id)) {
      throw StateError('RPC request ID is already pending');
    }
    final request = _PendingRequest();
    connection.pending[cmd.id] = request;
    final deadline = timeout ?? requestTimeout;
    request.timer = Timer(deadline, () {
      if (connection.pending.remove(cmd.id) != request) return;
      _requestTimeouts++;
      _log.warning('RPC timed out id=${cmd.id}');
      request.result.completeError(TimeoutException('RPC request timed out', deadline));
    });
    try {
      _write(connection, cmd);
    } catch (_) {
      final pending = connection.pending.remove(cmd.id);
      if (pending != null) {
        pending.timer?.cancel();
        pending.result.completeError(StateError('RPC request could not be sent'));
      }
      _disconnect(connection);
    }
    return request.result.future;
  }

  @override
  void sendOneWay(WebSocketCommand cmd) {
    _ensureActive();
    final connection = _connection;
    if (connection == null) throw StateError('WebSocket is not connected');
    try {
      _write(connection, cmd);
    } catch (_) {
      _disconnect(connection);
      rethrow;
    }
  }

  @override
  void response(WebSocketResult result) {
    _ensureActive();
    final connection = _connection;
    if (connection == null) throw StateError('WebSocket is not connected');
    try {
      _write(connection, result);
    } catch (_) {
      _disconnect(connection);
      rethrow;
    }
  }

  void _write(_Connection connection, WebSocketResult result) {
    _ensureCurrent(connection);
    if (!connection.isReady) throw StateError('WebSocket is not ready');
    try {
      final message = json.encode(serializers.serialize(result));
      connection.channel.sink.add(message);
      _log.fine('RPC sent ${result.runtimeType} id=${result.id}');
    } catch (error, stack) {
      _log.warning('RPC send failed (${error.runtimeType})', error, stack);
      throw StateError('RPC request could not be sent');
    }
  }

  void _parseMessage(_Connection connection, dynamic message) {
    try {
      final result = serializers.deserialize(json.decode(message.toString())) as WebSocketResult;
      _log.fine('RPC received ${result.runtimeType} id=${result.id}');
      if (result is WebSocketCommand) {
        _write(connection, switch (result) {
          WSHelloCommand() => WSResultOk.byCommand(result),
          _ => WSErrorResult.byCommand('Unknown command', result),
        });
      } else {
        final request = connection.pending.remove(result.id);
        if (request == null) return;
        request.timer?.cancel();
        if (result is WebSocketErrorResult) {
          request.result.completeError(result);
        } else {
          request.result.complete(result);
        }
      }
    } catch (error, stack) {
      // Parser exceptions can contain the entire payload, including secrets.
      _log.warning('RPC message rejected (${error.runtimeType})', error, stack);
      _disconnect(connection);
    }
  }

  bool _isCurrent(_Connection connection) => !_disposed && !connection.closed && identical(_connection, connection);

  void _ensureCurrent(_Connection connection) {
    _ensureActive();
    if (!_isCurrent(connection)) throw StateError('WebSocket disconnected');
  }

  void _ensureActive() {
    if (_disposed) throw StateError('WebSocket client is disposed');
  }

  Future<void> dispose() => _disposal ??= _dispose();

  Future<void> _dispose() async {
    _disposed = true;
    final connection = _connection;
    if (connection != null) _disconnect(connection, notify: false);
    await Future.wait(_cleanupOperations.toList());
    await _onDisconnect.close();
  }
}

class _Connection {
  final WebSocketChannel channel;
  final ready = Completer<void>();
  final pending = <int, _PendingRequest>{};
  StreamSubscription<dynamic>? subscription;
  Timer? handshakeTimer;
  bool isReady = false;
  bool closed = false;

  _Connection(this.channel);
}

class _PendingRequest {
  final result = Completer<WebSocketResult>();
  Timer? timer;
}
