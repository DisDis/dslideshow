import 'dart:async';

import 'package:config_app/features/auth/data/repository/authentication_repository.dart';
import 'package:config_app/features/auth/domain/repository/authentication_repository.dart';
import 'package:config_app/features/realtime/domain/services/realtime_service.dart';
import 'package:dslideshow_backend/command.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logging/logging.dart';

void main() {
  late _FakeRealtimeService client;
  late AuthenticationRepositoryImpl repository;
  late List<AuthenticationStatus> statuses;
  late StreamSubscription<AuthenticationStatus> statusSubscription;

  Future<void> logIn() => repository.logIn(
    connectUrl: Uri.parse('ws://example.test/ws?token=query-secret'),
    username: 'username-secret',
    password: 'password-secret',
  );

  setUp(() {
    client = _FakeRealtimeService();
    repository = AuthenticationRepositoryImpl(client: client);
    statuses = [];
    statusSubscription = repository.status.listen(statuses.add);
  });

  tearDown(() async {
    repository.dispose();
    await statusSubscription.cancel();
    await client.close();
  });

  test('reports initial status and successful login without a startup delay', () async {
    await _flushEvents();
    expect(statuses, [AuthenticationStatus.unauthenticated]);

    final login = logIn();
    client.connections.single.complete(const WSResultOk(id: 1));
    await login;
    await _flushEvents();

    expect(statuses, [AuthenticationStatus.unauthenticated, AuthenticationStatus.authenticated]);
  });

  test('disconnect changes status without disconnecting the client again', () async {
    final login = logIn();
    client.connections.single.complete(const WSResultOk(id: 1));
    await login;

    client.emitDisconnect();
    await _flushEvents();

    expect(statuses.last, AuthenticationStatus.unauthenticated);
    expect(client.disconnectCalls, 0);
  });

  test('queued disconnect from a previous login does not close a new connection', () async {
    final firstLogin = logIn();
    client.connections[0].complete(const WSResultOk(id: 1));
    await firstLogin;
    client.emitDisconnect();

    final secondLogin = logIn();
    client.connections[1].complete(const WSResultOk(id: 2));
    await secondLogin;
    await _flushEvents();

    expect(statuses.last, AuthenticationStatus.authenticated);
    expect(client.disconnectCalls, 0);
  });

  test('a login after a completed disconnect can authenticate again', () async {
    final firstLogin = logIn();
    client.connections[0].complete(const WSResultOk(id: 1));
    await firstLogin;
    client.emitDisconnect();
    await _flushEvents();
    expect(statuses.last, AuthenticationStatus.unauthenticated);

    final secondLogin = logIn();
    client.connections[1].complete(const WSResultOk(id: 2));
    await secondLogin;
    await _flushEvents();

    expect(statuses.last, AuthenticationStatus.authenticated);
    expect(client.disconnectCalls, 0);
  });

  test('a login after logout can authenticate again', () async {
    final firstLogin = logIn();
    client.connections[0].complete(const WSResultOk(id: 1));
    await firstLogin;
    repository.logOut();

    final secondLogin = logIn();
    client.connections[1].complete(const WSResultOk(id: 2));
    await secondLogin;
    await _flushEvents();

    expect(statuses.last, AuthenticationStatus.authenticated);
    expect(client.disconnectCalls, 1);
  });

  test('logout invalidates an unfinished login', () async {
    final login = logIn();
    repository.logOut();
    client.connections.single.complete(const WSResultOk(id: 1));
    await login;
    await _flushEvents();

    expect(statuses, [AuthenticationStatus.unauthenticated]);
    expect(client.disconnectCalls, 1);
  });

  test('disconnect invalidates an unfinished login', () async {
    final login = logIn();
    client.emitDisconnect();
    await _flushEvents();
    client.connections.single.complete(const WSResultOk(id: 1));
    await login;
    await _flushEvents();

    expect(statuses, [AuthenticationStatus.unauthenticated]);
    expect(client.disconnectCalls, 0);
  });

  test('a transport failure during login still reaches the current caller', () async {
    final login = logIn();
    final failure = StateError('transport failed');
    final loginExpectation = expectLater(login, throwsA(same(failure)));
    client.emitDisconnect();
    await _flushEvents();
    client.connections.single.completeError(failure);
    await loginExpectation;
    await _flushEvents();

    expect(statuses, [AuthenticationStatus.unauthenticated]);
    expect(client.disconnectCalls, 0);
  });

  test('the latest concurrent login owns the authentication status', () async {
    final firstLogin = logIn();
    final secondLogin = logIn();
    client.connections[1].complete(const WSResultOk(id: 2));
    await secondLogin;
    client.connections[0].complete(const WSErrorResult(id: 1, error: 'rejected'));
    await firstLogin;
    await _flushEvents();

    expect(statuses, [AuthenticationStatus.unauthenticated, AuthenticationStatus.authenticated]);
  });

  test('late login failure after logout is ignored', () async {
    final login = logIn();
    repository.logOut();
    client.connections.single.completeError(StateError('old connection failed'));
    await login;
    await _flushEvents();

    expect(statuses, [AuthenticationStatus.unauthenticated]);
  });

  test('dispose cancels the disconnect subscription and closes status', () async {
    var done = false;
    statusSubscription.onDone(() => done = true);
    await _flushEvents();
    expect(client.hasDisconnectListener, isTrue);

    repository.dispose();
    repository.dispose();
    client.emitDisconnect();
    await _flushEvents();

    expect(client.hasDisconnectListener, isFalse);
    expect(done, isTrue);
    expect(client.disconnectCalls, 0);
  });

  test('dispose ignores late login success and prevents further operations', () async {
    final login = logIn();
    repository.dispose();
    client.connections.single.complete(const WSResultOk(id: 1));
    await login;
    await _flushEvents();
    repository.logOut();

    expect(statuses, [AuthenticationStatus.unauthenticated]);
    expect(client.disconnectCalls, 0);
    await expectLater(logIn(), throwsStateError);
    expect(client.connections, hasLength(1));
  });

  test('dispose ignores late login errors', () async {
    final login = logIn();
    repository.dispose();
    client.connections.single.completeError(StateError('old connection failed'));
    await login;
    await _flushEvents();

    expect(statuses, [AuthenticationStatus.unauthenticated]);
    expect(client.hasDisconnectListener, isFalse);
  });

  test('current login errors reach the caller and retain their original diagnostics', () async {
    final records = <LogRecord>[];
    final previousLevel = Logger.root.level;
    Logger.root.level = Level.ALL;
    final logSubscription = Logger.root.onRecord.listen(records.add);
    addTearDown(() async {
      await logSubscription.cancel();
      Logger.root.level = previousLevel;
    });
    final failure = StateError('exception-secret');
    final login = logIn();
    final loginExpectation = expectLater(login, throwsA(same(failure)));
    client.connections.single.completeError(failure);
    await loginExpectation;
    await _flushEvents();

    expect(statuses.last, AuthenticationStatus.unauthenticated);
    final authRecords = records.where((record) => record.loggerName == 'AuthenticationRepository').toList();
    expect(authRecords, isNotEmpty);
    final messages = authRecords.map((record) => record.message).join('\n');
    for (final secret in ['query-secret', 'username-secret', 'password-secret', 'exception-secret', 'example.test']) {
      expect(messages, isNot(contains(secret)));
    }
    final diagnostic = authRecords.singleWhere((record) => record.error != null);
    expect(diagnostic.error, same(failure));
    expect(diagnostic.stackTrace, isNotNull);
  });
}

Future<void> _flushEvents() => Future<void>.delayed(Duration.zero);

class _FakeRealtimeService implements RealtimeService {
  final _disconnects = StreamController<void>.broadcast();
  final connections = <Completer<WebSocketResult>>[];
  int disconnectCalls = 0;

  bool get hasDisconnectListener => _disconnects.hasListener;

  @override
  String authCode = '';

  @override
  Uri connectUri = Uri.parse('ws://example.test');

  @override
  Stream<void> get onDisconnect => _disconnects.stream;

  @override
  Future<WebSocketResult> connect(Uri uri, String code) {
    connectUri = uri;
    authCode = code;
    final result = Completer<WebSocketResult>();
    connections.add(result);
    return result.future;
  }

  void emitDisconnect() => _disconnects.add(null);

  @override
  void disconnect() {
    ++disconnectCalls;
    emitDisconnect();
  }

  Future<void> close() => _disconnects.close();

  @override
  Future<WebSocketResult> send(WebSocketCommand cmd, {Duration? timeout}) => throw UnimplementedError();

  @override
  void sendOneWay(WebSocketCommand cmd) => throw UnimplementedError();

  @override
  void response(WebSocketResult result) => throw UnimplementedError();
}
