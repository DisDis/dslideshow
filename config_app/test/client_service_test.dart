import 'dart:async';
import 'dart:convert';

import 'package:config_app/features/realtime/data/services/client_service.dart';
import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_backend/serializers.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logging/logging.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'package:web_socket_channel/web_socket_channel.dart';

final _uri = Uri.parse('ws://photoframe.test:8080');

void main() {
  ClientServiceImpl clientFor(
    _ControlledChannel channel, {
    Duration connectionTimeout = const Duration(seconds: 10),
    Duration requestTimeout = const Duration(seconds: 15),
  }) {
    final client = ClientServiceImpl(
      channelFactory: (_) => channel,
      connectionTimeout: connectionTimeout,
      requestTimeout: requestTimeout,
    );
    addTearDown(client.dispose);
    return client;
  }

  Future<void> connect(
    WidgetTester tester,
    ClientServiceImpl client,
    _ControlledChannel channel,
  ) async {
    final connected = client.connect(_uri, 'access-code');
    await tester.pump();
    final auth = channel.sent.single as WSAuthCommand;
    channel.receive(WSResultOk.byCommand(auth));
    await tester.pump();
    await connected;
  }

  group('ClientService connection', () {
    testWidgets('authenticates after handshake and responds to server hello', (
      tester,
    ) async {
      final channel = _ControlledChannel();
      final client = clientFor(channel);
      final connected = client.connect(_uri, 'access-code');
      await tester.pump();

      final auth = channel.sent.single as WSAuthCommand;
      expect(auth.userName, 'admin');
      expect(auth.code, 'access-code');
      expect(client.connectUri, _uri);
      expect(client.authCode, 'access-code');
      expect(client.isAuth, isFalse);

      channel.receive(const WSHelloCommand(id: 20000));
      channel.receive(WSResultOk.byCommand(auth));
      await tester.pump();

      expect(await connected, WSResultOk.byCommand(auth));
      expect(client.isAuth, isTrue);
      expect(channel.sent.last, const WSResultOk(id: 20000));
    });

    testWidgets('does not send authentication before channel is ready', (
      tester,
    ) async {
      final channel = _ControlledChannel(initiallyReady: false);
      final client = clientFor(channel);
      final connected = client.connect(_uri, 'access-code');
      await tester.pump();
      expect(channel.sent, isEmpty);

      channel.completeReady();
      await tester.pump();
      final auth = channel.sent.single as WSAuthCommand;
      channel.receive(WSResultOk.byCommand(auth));
      await tester.pump();
      await connected;
    });

    testWidgets('fails and cleans up when handshake fails', (tester) async {
      final channel = _ControlledChannel(initiallyReady: false);
      final client = clientFor(channel);
      final connected = client.connect(_uri, 'access-code');
      final failed = expectLater(connected, throwsA(isA<StateError>()));

      channel.failReady(StateError('handshake failed'));
      await tester.pump();
      await failed;

      expect(channel.sent, isEmpty);
      expect(client.channel, isNull);
      expect(client.isAuth, isFalse);
      expect(channel.sink.closeCount, 1);
      expect(channel.events.cancelCount, 1);
    });

    testWidgets('limits the handshake wait', (tester) async {
      final channel = _ControlledChannel(initiallyReady: false);
      final client = clientFor(
        channel,
        connectionTimeout: const Duration(seconds: 2),
      );
      final connected = client.connect(_uri, 'access-code');
      final failed = expectLater(connected, throwsA(isA<TimeoutException>()));
      await tester.pump();
      await tester.pump(const Duration(seconds: 3));
      await failed;

      expect(client.channel, isNull);
      expect(channel.sent, isEmpty);
      expect(channel.sink.closeCount, 1);
      channel.completeReady();
      await tester.pump();
      expect(channel.sent, isEmpty);
    });

    testWidgets('returns a future error when channel creation throws', (
      tester,
    ) async {
      final client = ClientServiceImpl(
        channelFactory: (_) => throw StateError('connection failed'),
      );
      addTearDown(client.dispose);
      await expectLater(
        client.connect(_uri, 'access-code'),
        throwsA(isA<StateError>()),
      );
      expect(client.channel, isNull);
      expect(client.isAuth, isFalse);
    });

    testWidgets('reconnect ignores callbacks already queued by old channel', (
      tester,
    ) async {
      final oldChannel = _ControlledChannel();
      final newChannel = _ControlledChannel();
      final channels = [oldChannel, newChannel].iterator;
      final client = ClientServiceImpl(
        channelFactory: (_) {
          expect(channels.moveNext(), isTrue);
          return channels.current;
        },
      );
      addTearDown(client.dispose);
      await connect(tester, client, oldChannel);
      await connect(tester, client, newChannel);

      oldChannel.events.finishAfterCancellation();
      oldChannel.events.errorAfterCancellation(StateError('stale error'));
      oldChannel.events.dataAfterCancellation(
        jsonEncode(serializers.serialize(const WSHelloCommand(id: 21000))),
      );
      await tester.pump();

      expect(client.channel, same(newChannel));
      expect(client.isAuth, isTrue);
      expect(newChannel.sink.closeCount, 0);
      expect(newChannel.sent, hasLength(1));
      expect(oldChannel.events.cancelCount, 1);
    });

    testWidgets('old handshake completion does not authenticate new channel', (
      tester,
    ) async {
      final oldChannel = _ControlledChannel(initiallyReady: false);
      final newChannel = _ControlledChannel();
      final channels = [oldChannel, newChannel].iterator;
      final client = ClientServiceImpl(
        channelFactory: (_) {
          expect(channels.moveNext(), isTrue);
          return channels.current;
        },
      );
      addTearDown(client.dispose);
      final firstConnection = client.connect(_uri, 'old-code');
      final firstFailed = expectLater(
        firstConnection,
        throwsA(isA<StateError>()),
      );
      await tester.pump();
      await connect(tester, client, newChannel);
      oldChannel.completeReady();
      await tester.pump();
      await firstFailed;

      expect(oldChannel.sent, isEmpty);
      expect(client.channel, same(newChannel));
      expect(newChannel.sink.closeCount, 0);
      expect(newChannel.sent, hasLength(1));
    });
  });

  group('ClientService requests', () {
    testWidgets('registers requests before synchronously delivered response', (
      tester,
    ) async {
      final channel = _ControlledChannel();
      final client = clientFor(channel);
      await connect(tester, client, channel);
      channel.sink.onSend = (message) {
        if (message is WSEchoCommand) {
          channel.receive(WSEchoResult(msg: message.msg, id: message.id));
        }
      };

      expect(
        await client.send(const WSEchoCommand(msg: 'hello', id: 22000)),
        const WSEchoResult(msg: 'hello', id: 22000),
      );
    });

    testWidgets('returns server errors to the matching request', (
      tester,
    ) async {
      final channel = _ControlledChannel();
      final client = clientFor(channel);
      await connect(tester, client, channel);
      final result = client.send(const WSConfigDownloadCommand(id: 22001));
      final failed = expectLater(
        result,
        throwsA(const WSErrorResult(error: 'permission denied', id: 22001)),
      );
      await tester.pump();
      channel.receive(
        const WSErrorResult(error: 'permission denied', id: 22001),
      );
      await tester.pump();
      await failed;
      expect(client.channel, same(channel));
    });

    testWidgets('times out one request and ignores its late response', (
      tester,
    ) async {
      final channel = _ControlledChannel();
      final client = clientFor(
        channel,
        requestTimeout: const Duration(seconds: 2),
      );
      await connect(tester, client, channel);
      final expired = client.send(const WSConfigDownloadCommand(id: 22002));
      expect(client.requestTimeouts, 0);
      final failed = expectLater(expired, throwsA(isA<TimeoutException>()));
      await tester.pump();
      await tester.pump(const Duration(seconds: 3));
      await failed;

      expect(client.requestTimeouts, 1);

      final next = client.send(const WSConfigDownloadCommand(id: 22003));
      await tester.pump();
      channel.receive(const WSResultOk(id: 22002));
      channel.receive(const WSResultOk(id: 22003));
      await tester.pump();
      expect(await next, const WSResultOk(id: 22003));
      expect(
        client.requestTimeouts,
        1,
        reason: 'late and successful replies do not increment timeouts',
      );
      expect(client.channel, same(channel));
      expect(channel.sink.closeCount, 0);
    });

    testWidgets('disconnect fails all pending requests and cancels listener', (
      tester,
    ) async {
      final channel = _ControlledChannel();
      final client = clientFor(channel);
      await connect(tester, client, channel);
      final first = expectLater(
        client.send(const WSConfigDownloadCommand(id: 22004)),
        throwsA(_disconnected),
      );
      final second = expectLater(
        client.send(const WSConfigDownloadCommand(id: 22005)),
        throwsA(_disconnected),
      );
      var disconnects = 0;
      final subscription = client.onDisconnect.listen((_) => disconnects++);
      addTearDown(subscription.cancel);
      await tester.pump();

      client.disconnect();
      client.disconnect();
      await tester.pump();
      await Future.wait([first, second]);

      expect(client.channel, isNull);
      expect(client.isAuth, isFalse);
      expect(channel.sink.closeCodes, [status.normalClosure]);
      expect(channel.events.cancelCount, 1);
      expect(disconnects, 1);
    });

    for (final failWithError in [false, true]) {
      testWidgets(
        'remote ${failWithError ? 'error' : 'close'} fails pending requests',
        (tester) async {
          final channel = _ControlledChannel();
          final client = clientFor(channel);
          await connect(tester, client, channel);
          final failed = expectLater(
            client.send(const WSConfigDownloadCommand(id: 22006)),
            throwsA(_disconnected),
          );
          await tester.pump();
          if (failWithError) {
            channel.events.fail(StateError('connection lost'));
          } else {
            channel.events.finish();
          }
          await tester.pump();
          await failed;
          expect(client.channel, isNull);
          expect(client.isAuth, isFalse);
        },
      );
    }

    for (final synchronous in [false, true]) {
      testWidgets(
        'disconnect handles ${synchronous ? 'synchronous' : 'asynchronous'} sink close failure',
        (tester) async {
          final channel = _ControlledChannel();
          final client = clientFor(channel);
          await connect(tester, client, channel);
          channel.sink.closeFailure = StateError('close failed');
          channel.sink.throwOnClose = synchronous;
          final failed = expectLater(
            client.send(const WSConfigDownloadCommand(id: 22007)),
            throwsA(_disconnected),
          );
          await tester.pump();

          client.disconnect();
          await tester.pump();
          await failed;
          expect(client.channel, isNull);
          expect(channel.events.cancelCount, 1);
        },
      );
    }

    testWidgets('send failure completes request and releases its timeout', (
      tester,
    ) async {
      final channel = _ControlledChannel();
      final client = clientFor(channel);
      await connect(tester, client, channel);
      channel.sink.onSend = (_) => throw StateError('write failed');

      await expectLater(
        client.send(const WSConfigDownloadCommand(id: 22008)),
        throwsA(isA<StateError>()),
      );
      await tester.pump(const Duration(seconds: 16));
    });
  });

  test('dispose closes notifications and rejects further connection', () async {
    final channel = _ControlledChannel();
    final client = clientFor(channel);
    channel.sink.onSend = (message) {
      if (message is WSAuthCommand) {
        channel.receive(WSResultOk.byCommand(message));
      }
    };
    await client.connect(_uri, 'access-code');
    final notificationsClosed = client.onDisconnect.drain<void>();
    final requestFailed = expectLater(
      client.send(const WSConfigDownloadCommand(id: 23000)),
      throwsA(_disconnected),
    );
    await Future<void>.value();

    await client.dispose();
    await client.dispose();
    await requestFailed;
    await notificationsClosed;
    expect(client.channel, isNull);
    expect(channel.events.cancelCount, 1);
    expect(channel.sink.closeCount, 1);
    await expectLater(client.connect(_uri, 'code'), throwsA(anything));
  });

  testWidgets('dispose cancels an unfinished handshake and its timer', (
    tester,
  ) async {
    final channel = _ControlledChannel(initiallyReady: false);
    // This test disposes explicitly inside the fake clock. Awaiting its cached
    // disposal future again from a real-clock teardown would require that
    // already-finished fake zone to process another microtask.
    final client = ClientServiceImpl(channelFactory: (_) => channel);
    final connectionFailed = expectLater(
      client.connect(_uri, 'access-code'),
      throwsA(isA<StateError>()),
    );
    await tester.pump();

    final disposed = client.dispose();
    var disposalCompleted = false;
    unawaited(disposed.then((_) => disposalCompleted = true));
    // Closing the broadcast stream may schedule an event after asynchronous
    // transport cleanup. Advance each event turn without waiting indefinitely.
    for (var turn = 0; turn < 5 && !disposalCompleted; turn++) {
      await tester.pump();
    }
    expect(disposalCompleted, isTrue);
    await disposed;
    await connectionFailed;
    await tester.pump(const Duration(seconds: 11));

    expect(client.channel, isNull);
    expect(channel.sent, isEmpty);
    expect(channel.events.cancelCount, 1);
    expect(channel.sink.closeCount, 1);
  });

  testWidgets('cleans up when stream subscription throws synchronously', (
    tester,
  ) async {
    final channel = _ControlledChannel();
    channel.events.listenFailure = StateError('listen failed');
    final client = clientFor(channel);

    await expectLater(
      client.connect(_uri, 'access-code'),
      throwsA(isA<StateError>()),
    );
    await tester.pump();
    expect(client.channel, isNull);
    expect(channel.sent, isEmpty);
    expect(channel.sink.closeCount, 1);
  });

  for (final isResponse in [false, true]) {
    testWidgets(
      '${isResponse ? 'response' : 'one-way command'} write failure disconnects current channel',
      (tester) async {
        final channel = _ControlledChannel();
        final client = clientFor(channel);
        await connect(tester, client, channel);
        final pendingFailed = expectLater(
          client.send(const WSConfigDownloadCommand(id: 23001)),
          throwsA(_disconnected),
        );
        await tester.pump();
        channel.sink.onSend = (_) => throw StateError('write failed');

        expect(
          () => isResponse
              ? client.response(const WSResultOk(id: 23002))
              : client.sendOneWay(const WSEchoCommand(msg: 'hello', id: 23002)),
          throwsA(isA<StateError>()),
        );
        await tester.pump();
        await pendingFailed;
        expect(client.channel, isNull);
        expect(channel.events.cancelCount, 1);
        expect(channel.sink.closeCount, 1);
      },
    );
  }

  testWidgets('logs omit auth, config, result and malformed message contents', (
    tester,
  ) async {
    final records = <LogRecord>[];
    final originalLevel = Logger.root.level;
    Logger.root.level = Level.ALL;
    final logs = Logger.root.onRecord.listen(records.add);
    addTearDown(() async {
      await logs.cancel();
      Logger.root.level = originalLevel;
    });
    final channel = _ControlledChannel();
    final client = clientFor(channel);
    final connected = client.connect(_uri, 'unique-auth-secret');
    await tester.pump();
    channel.receive(WSResultOk.byCommand(channel.sent.single as WSAuthCommand));
    await tester.pump();
    await connected;

    final upload = client.send(
      const WSConfigUploadCommand(content: 'unique-upload-secret', id: 24000),
    );
    await tester.pump();
    channel.receive(const WSResultOk(id: 24000));
    final download = client.send(const WSConfigDownloadCommand(id: 24001));
    await tester.pump();
    channel.receive(
      const WSConfigDownloadResult(
        content: 'unique-download-secret',
        id: 24001,
      ),
    );
    client.response(
      const WSErrorResult(error: 'unique-response-secret', id: 24002),
    );
    channel.events.add('{"secret":"unique-malformed-secret"');
    await tester.pump();
    await upload;
    await download;

    final invalidChannel = _ControlledChannel();
    final invalidClient = clientFor(invalidChannel);
    await connect(tester, invalidClient, invalidChannel);
    invalidChannel.events.add(
      jsonEncode({'secret': 'unique-invalid-type-secret'}),
    );
    await tester.pump();

    final renderedLogs = records
        .where((record) => record.loggerName == 'ClientService')
        .map(
          (record) => '${record.message} ${record.error} ${record.stackTrace}',
        )
        .join('\n');
    expect(records, isNotEmpty);
    for (final secret in [
      'unique-auth-secret',
      'unique-upload-secret',
      'unique-download-secret',
      'unique-response-secret',
      'unique-malformed-secret',
      'unique-invalid-type-secret',
    ]) {
      expect(renderedLogs, isNot(contains(secret)), reason: secret);
    }
  });
}

final _disconnected = isA<WSErrorResult>().having(
  (error) => error.error,
  'error',
  'disconnect',
);

class _ControlledChannel implements WebSocketChannel {
  _ControlledChannel({bool initiallyReady = true}) {
    if (initiallyReady) completeReady();
  }

  final events = _ControlledStream();
  final _ready = Completer<void>();

  @override
  final _ControlledSink sink = _ControlledSink();

  List<WebSocketResult> get sent => sink.sent;

  void completeReady() => _ready.complete();
  void failReady(Object error) => _ready.completeError(error);
  void receive(WebSocketResult message) =>
      events.add(jsonEncode(serializers.serialize(message)));

  @override
  Stream<dynamic> get stream => events;
  @override
  Future<void> get ready => _ready.future;
  @override
  String? get protocol => null;
  @override
  int? get closeCode => null;
  @override
  String? get closeReason => null;

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _ControlledSink implements WebSocketSink {
  final sent = <WebSocketResult>[];
  final closeCodes = <int?>[];
  void Function(WebSocketResult)? onSend;
  Object? closeFailure;
  bool throwOnClose = false;
  int get closeCount => closeCodes.length;

  @override
  void add(dynamic event) {
    final message =
        serializers.deserialize(jsonDecode(event as String)) as WebSocketResult;
    sent.add(message);
    onSend?.call(message);
  }

  @override
  Future<void> close([int? closeCode, String? closeReason]) {
    closeCodes.add(closeCode);
    if (closeFailure case final failure?) {
      if (throwOnClose) throw failure;
      return Future<void>.error(failure);
    }
    return Future<void>.value();
  }

  @override
  Future<void> get done => Future<void>.value();

  @override
  Future<void> addStream(Stream<dynamic> stream) async {
    await for (final event in stream) {
      add(event);
    }
  }

  @override
  void addError(Object error, [StackTrace? stackTrace]) => throw error;
}

/// Delivers events synchronously and can reproduce callbacks queued before
/// subscription cancellation, after a replacement connection has been opened.
class _ControlledStream extends Stream<dynamic> {
  _ControlledSubscription? _subscription;
  Object? listenFailure;
  int get cancelCount => _subscription?.cancelCount ?? 0;

  void add(dynamic data) => _subscription?.data(data);
  void fail(Object error) => _subscription?.error(error);
  void finish() => _subscription?.finish();
  void dataAfterCancellation(dynamic data) =>
      _subscription?.data(data, ignoreCancellation: true);
  void errorAfterCancellation(Object error) =>
      _subscription?.error(error, ignoreCancellation: true);
  void finishAfterCancellation() =>
      _subscription?.finish(ignoreCancellation: true);

  @override
  StreamSubscription<dynamic> listen(
    void Function(dynamic)? onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) {
    if (listenFailure case final error?) throw error;
    if (_subscription != null) throw StateError('Already subscribed');
    return _subscription = _ControlledSubscription(onData, onError, onDone);
  }
}

class _ControlledSubscription implements StreamSubscription<dynamic> {
  _ControlledSubscription(this._onData, this._onError, this._onDone);

  void Function(dynamic)? _onData;
  Function? _onError;
  void Function()? _onDone;
  bool _cancelled = false;
  int cancelCount = 0;

  void data(dynamic data, {bool ignoreCancellation = false}) {
    if (!_cancelled || ignoreCancellation) _onData?.call(data);
  }

  void error(Object error, {bool ignoreCancellation = false}) {
    if (_cancelled && !ignoreCancellation) return;
    final handler = _onError;
    if (handler is void Function(Object, StackTrace)) {
      handler(error, StackTrace.current);
    } else if (handler != null) {
      Function.apply(handler, [error]);
    } else {
      Zone.current.handleUncaughtError(error, StackTrace.current);
    }
  }

  void finish({bool ignoreCancellation = false}) {
    if (!_cancelled || ignoreCancellation) _onDone?.call();
  }

  @override
  Future<void> cancel() async {
    _cancelled = true;
    cancelCount++;
  }

  @override
  void onData(void Function(dynamic)? handleData) => _onData = handleData;
  @override
  void onError(Function? handleError) => _onError = handleError;
  @override
  void onDone(void Function()? handleDone) => _onDone = handleDone;
  @override
  bool get isPaused => false;
  @override
  void pause([Future<void>? resumeSignal]) {}
  @override
  void resume() {}
  @override
  Future<E> asFuture<E>([E? futureValue]) {
    final done = Completer<E>();
    onDone(() => done.complete(futureValue));
    onError(
      (Object error, StackTrace trace) => done.completeError(error, trace),
    );
    return done.future;
  }
}
