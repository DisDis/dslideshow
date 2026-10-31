import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:config_app/features/ota/presentation/bloc/ota_client.dart';
import 'package:config_app/features/ota/presentation/bloc/ota_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:logging/logging.dart';

import 'support/ota_panel_support.dart';

class _TrackingClient extends http.BaseClient {
  _TrackingClient(this.inner);
  final http.Client inner;
  int closes = 0;
  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) => inner.send(request);
  @override
  void close() {
    closes++;
    inner.close();
  }
}

void main() {
  test('loopback upload streams a pathless picked file with code before file and closes transport', () async {
    final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
    addTearDown(() => server.close(force: true));
    final bodies = <String>[];
    server.listen((request) async {
      expect(request.uri.path, '/ota_upload');
      bodies.add(await utf8.decoder.bind(request).join());
      request.response.write('Firmware uploaded; installation accepted');
      await request.response.close();
    });
    final transport = _TrackingClient(http.Client());
    final client = OTAClient(baseUri: Uri.parse('http://127.0.0.1:${server.port}'), clientFactory: () => transport);
    addTearDown(client.close);
    final file = TestFirmwareFile(bytes: utf8.encode('firmware-content'));
    final progress = <int>[];
    await client.uploadFile(
      code: '00 text-code',
      file: file,
      length: file.content.length,
      cancellation: Completer<void>().future,
      onProgress: (sent, total) {
        expect(total, file.content.length);
        progress.add(sent);
      },
    );
    expect(file.path, isNull);
    expect(file.byteReads, 0);
    expect(file.streamReads, 1);
    expect(progress.last, file.content.length);
    expect(bodies.single, contains('00 text-code'));
    expect(bodies.single, contains('firmware-content'));
    expect(bodies.single.indexOf('name="code"'), lessThan(bodies.single.indexOf('name="file"')));
    expect(transport.closes, 1);
  });

  test('aborting a loopback request closes the source stream and transport', () async {
    final records = <LogRecord>[];
    final previousLevel = Logger.root.level;
    Logger.root.level = Level.ALL;
    final logs = Logger.root.onRecord.listen(records.add);
    addTearDown(() async {
      await logs.cancel();
      Logger.root.level = previousLevel;
    });
    final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
    addTearDown(() => server.close(force: true));
    final incomingDone = Completer<void>();
    server.listen((request) async {
      try {
        await request.drain<void>();
      } catch (_) {
        /* The peer is intentionally aborted. */
      }
      if (!incomingDone.isCompleted) incomingDone.complete();
      await request.response.close().catchError((Object _) {});
    });
    final listening = Completer<void>();
    final cancelled = Completer<void>();
    final cleanup = Completer<void>();
    final chunks = StreamController<Uint8List>(
      onListen: () => listening.complete(),
      onCancel: () {
        if (!cancelled.isCompleted) cancelled.complete();
        return cleanup.future;
      },
    );
    addTearDown(chunks.close);
    final file = TestFirmwareFile()..streamFactory = () => chunks.stream;
    final cancellation = Completer<void>();
    final transport = _TrackingClient(http.Client());
    final client = OTAClient(
      baseUri: Uri.parse('http://127.0.0.1:${server.port}'),
      clientFactory: () => transport,
      timeout: const Duration(seconds: 5),
    );
    addTearDown(client.close);
    final uploading = client.uploadFile(
      code: 'code',
      file: file,
      length: 500,
      cancellation: cancellation.future,
      onProgress: (_, _) {},
    );
    final failed = expectLater(
      uploading,
      throwsA(isA<OtaClientException>().having((e) => e.failure, 'failure', OtaFailure.cancelled)),
    );
    await listening.future.timeout(const Duration(seconds: 5));
    chunks.add(Uint8List.fromList([1]));
    cancellation.complete();
    await cancelled.future.timeout(const Duration(seconds: 5));
    var closed = false;
    final closing = client.close().then((_) => closed = true);
    await Future<void>(() {});
    expect(closed, isFalse);
    cleanup.completeError(StateError('synthetic-source-secret'));
    await failed;
    await closing;
    expect(transport.closes, 1);
    final cleanupLog = records.singleWhere((record) => record.message.contains('event=sourceCleanupFailed'));
    expect(cleanupLog.level, Level.WARNING);
    expect(cleanupLog.stackTrace, isNotNull);
    expect(cleanupLog.message, isNot(contains('operationId=')));
    expect(records.map((record) => '${record.message} ${record.error}').join(), contains('synthetic-source-secret'));
  });

  test('init validates real response schema and logs original transport errors', () async {
    final records = <LogRecord>[];
    final level = Logger.root.level;
    Logger.root.level = Level.ALL;
    final logs = Logger.root.onRecord.listen(records.add);
    addTearDown(() async {
      await logs.cancel();
      Logger.root.level = level;
    });
    final responses = <http.Response>[
      http.Response('{"version":{"frontend":"2.3.4","backend":"2.3.4"}}', 200),
      http.Response('{"version":{"frontend":17},"secret":"synthetic-body-secret"}', 200),
      http.Response('synthetic-body-secret', 503),
    ];
    for (var i = 0; i < responses.length; i++) {
      final transport = _TrackingClient(
        MockClient((request) async {
          expect(request.url.path, '/ota_start');
          expect(request.url.queryParameters['format'], 'json');
          return responses[i];
        }),
      );
      final client = OTAClient(baseUri: Uri.parse('http://frame.local'), clientFactory: () => transport);
      if (i == 0) {
        expect(await client.start(cancellation: Completer<void>().future), '2.3.4');
      } else {
        await expectLater(client.start(cancellation: Completer<void>().future), throwsA(isA<OtaClientException>()));
      }
      expect(transport.closes, 1);
      client.close();
    }
    final failing = OTAClient(
      baseUri: Uri.parse('http://frame.local'),
      clientFactory: () => MockClient((_) async {
        throw http.ClientException('http://frame.local/synthetic-url-secret');
      }),
    );
    addTearDown(failing.close);
    await expectLater(failing.start(cancellation: Completer<void>().future), throwsA(isA<OtaClientException>()));
    final text = records.map((record) => '${record.message} ${record.error}').join();
    expect(text, contains('synthetic-url-secret'));
    expect(text, isNot(contains('synthetic-body-secret')));
    expect(
      records.any((record) => record.message.startsWith('event=requestFailed ') && record.level == Level.WARNING),
      isTrue,
    );
  });
}
