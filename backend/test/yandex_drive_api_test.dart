import 'dart:async';
import 'dart:convert';

import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_backend/src/service/storage/cloud_storage_transfer.dart';
import 'package:dslideshow_backend/src/service/yandex_drive/yandex_drive_api.dart';
import 'package:dslideshow_backend/src/service/yandex_drive/yandex_drive_paths.dart';
import 'package:dslideshow_common/log.dart';
import 'package:fake_async/fake_async.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:logging/logging.dart';
import 'package:test/test.dart';

class _TrackedClient extends MockClient {
  _TrackedClient(MockClientStreamHandler handler) : super.streaming(handler);

  int closeCalls = 0;

  @override
  void close() {
    closeCalls++;
    super.close();
  }
}

void main() {
  test('the ya.ru device address from Yandex produces a valid authorization response', () async {
    final api = YandexDriveApi(
      clientFactory: () => MockClient(
        (request) async => http.Response(
          jsonEncode({
            'device_code': 'private-device',
            'user_code': 'short-code',
            'verification_url': 'https://ya.ru/device',
            'interval': 5,
            'expires_in': 300,
          }),
          200,
        ),
      ),
    );
    addTearDown(api.close);
    final response = await api.startDevice('application');
    expect(response.verificationUrl, Uri.parse('https://ya.ru/device'));
    expect(response.userCode, 'short-code');
    expect(response.expiresIn, 300);
  });

  test('device URL validation still rejects HTTP and a foreign host', () async {
    for (final uri in ['http://ya.ru/device', 'https://ya.ru.example/device']) {
      final api = YandexDriveApi(
        clientFactory: () => MockClient(
          (request) async => http.Response(
            jsonEncode({
              'device_code': 'private-device',
              'user_code': 'short-code',
              'verification_url': uri,
              'interval': 5,
              'expires_in': 300,
            }),
            200,
          ),
        ),
      );
      await expectLater(
        api.startDevice('application'),
        throwsA(isA<CloudStorageException>().having((error) => error.code, 'code', DriveFailure.invalidResponse)),
      );
      api.close();
    }
  });
  test('device authorization keeps safe OAuth failure codes without response descriptions or POST retries', () async {
    for (final entry in {
      'invalid_client': DriveFailure.invalidClient,
      'invalid_scope': DriveFailure.invalidScope,
      'unauthorized_client': DriveFailure.clientUnavailable,
      'unknown-provider-error': DriveFailure.invalidResponse,
    }.entries) {
      var calls = 0;
      final api = YandexDriveApi(
        clientFactory: () => MockClient((request) async {
          calls++;
          return http.Response(
            jsonEncode({
              'error': entry.key,
              'error_description': 'private-client-secret and https://provider.example/private-token',
            }),
            400,
          );
        }),
      );
      try {
        await api.startDevice('application');
        fail('Expected an OAuth failure');
      } on CloudStorageException catch (error) {
        expect(error.code, entry.value);
        expect(error.toString(), isNot(contains('private')));
      } finally {
        api.close();
      }
      expect(calls, 1);
    }
  });
  test('device and token requests use documented forms and preserve user code separately', () async {
    final api = YandexDriveApi(
      clientFactory: () => MockClient((request) async {
        expect(request.method, 'POST');
        if (request.url.path == '/device/code') {
          expect(request.bodyFields['scope'], 'cloud_api:disk.read cloud_api:disk.info');
          return http.Response(
            jsonEncode({
              'device_code': 'private-device',
              'user_code': 'short-code',
              'verification_url': 'https://oauth.yandex.ru/device',
              'interval': 5,
              'expires_in': 300,
            }),
            200,
          );
        }
        expect(request.url.path, '/token');
        expect(request.bodyFields['code'], 'private-device');
        return http.Response(jsonEncode({'access_token': 'private-token', 'expires_in': 3600}), 200);
      }),
    );
    final device = await api.startDevice('application');
    expect(device.userCode, 'short-code');
    expect(device.deviceCode, 'private-device');
    final tokens = await api.token({'grant_type': 'device_code', 'code': device.deviceCode});
    expect(tokens.accessToken, 'private-token');
    api.close();
  });
  test('remote paths keep full structure, deduplicate overlapping roots and reject traversal', () {
    expect(YandexDrivePaths.relative('disk:/Camera/2026/a.jpg', '123'), 'yandex.drive.123/Camera/2026/a.jpg');
    expect(YandexDrivePaths.distinctRoots(['disk:/Camera/2026', '/Camera', 'disk:/Other']), [
      'disk:/Camera',
      'disk:/Other',
    ]);
    expect(() => YandexDrivePaths.relative('disk:/../a.jpg', '123'), throwsFormatException);
    expect(() => YandexDrivePaths.relative('disk:/a.jpg', '../123'), throwsFormatException);
    expect(() => YandexDrivePaths.normalize('disk:/a\\b.jpg'), throwsFormatException);
  });

  test('bounded GET retry honors Retry-After without exposing provider response', () async {
    var attempts = 0;
    final waits = <Duration>[];
    final api = YandexDriveApi(
      delay: (delay) async => waits.add(delay),
      clientFactory: () => MockClient((request) async {
        attempts++;
        if (attempts < 3) return http.Response('private-provider-error', 429, headers: {'retry-after': '1'});
        return http.Response(
          jsonEncode({
            'user': {'uid': '123'},
          }),
          200,
        );
      }),
    );
    expect((await api.identity('private-token')).uid, '123');
    expect(attempts, 3);
    expect(waits, [const Duration(seconds: 1), const Duration(seconds: 1)]);
    api.close();
  });

  test('oversized JSON and invalid identity return safe errors', () async {
    final api = YandexDriveApi(
      clientFactory: () => MockClient((_) async => http.Response('private${'x' * (2 * 1024 * 1024)}', 200)),
    );
    await expectLater(
      api.identity('secret'),
      throwsA(isA<CloudStorageException>().having((e) => e.code, 'code', DriveFailure.invalidResponse)),
    );
    api.close();
  });

  test('download follows HTTPS links without forwarding OAuth to content host', () async {
    final seen = <http.Request>[];
    final api = YandexDriveApi(
      clientFactory: () => MockClient((request) async {
        seen.add(request);
        if (request.url.path.endsWith('resources/download'))
          return http.Response(jsonEncode({'href': 'https://content.example/photo'}), 200);
        expect(request.headers.containsKey('Authorization'), isFalse);
        return http.Response.bytes([1, 2, 3], 200);
      }),
    );
    final download = await api.download('private-token', 'disk:/photo.jpg');
    expect(await download.response.stream.toBytes(), [1, 2, 3]);
    expect(seen.length, 2);
    expect(seen.first.headers['Authorization'], 'OAuth private-token');
    download.close();
    api.close();
  });

  test('token service failures are classified before decoding and POST is not retried', () async {
    for (final entry in {429: DriveFailure.rateLimited, 503: DriveFailure.serviceUnavailable}.entries) {
      var requests = 0;
      final api = YandexDriveApi(
        clientFactory: () => MockClient((_) async {
          requests++;
          return http.Response('<html>temporary outage</html>', entry.key);
        }),
      );
      await expectLater(
        api.token({'grant_type': 'device_code', 'code': 'private'}),
        throwsA(isA<CloudStorageException>().having((error) => error.code, 'code', entry.value)),
      );
      expect(requests, 1);
      api.close();
    }
  });

  test('download rejects a redirect that downgrades to HTTP', () async {
    final api = YandexDriveApi(
      clientFactory: () => MockClient((request) async {
        if (request.url.path.endsWith('resources/download'))
          return http.Response(jsonEncode({'href': 'https://content.example/photo'}), 200);
        return http.Response('', 302, headers: {'location': 'http://content.example/unsafe'});
      }),
    );
    await expectLater(
      api.download('private', 'disk:/photo.jpg'),
      throwsA(isA<CloudStorageException>().having((e) => e.code, 'code', DriveFailure.invalidResponse)),
    );
    api.close();
  });

  group('request diagnostics', () {
    late List<LogRecord> records;
    setUp(() {
      records = [];
      final previousLevel = Logger.root.level;
      Logger.root.level = Level.ALL;
      final subscription = Logger.root.onRecord.listen(records.add);
      addTearDown(() async {
        await subscription.cancel();
        Logger.root.level = previousLevel;
      });
    });

    void expectDiagnostics() {
      expect(records.where((record) => record.error != null), isNotEmpty);
      expect(
        records
            .where((record) => record.error != null)
            .every((record) => record.stackTrace != null && record.stackTrace.toString().isNotEmpty),
        isTrue,
      );
      expect(records.every((record) => record.loggerName == 'YandexDriveApi' && record.level == Level.FINE), isTrue);
    }

    test('download link 503 reports its stage, status and exhausted GET attempts', () async {
      var calls = 0;
      final api = YandexDriveApi(
        delay: (_) async {},
        clientFactory: () => MockClient((request) async {
          calls++;
          expect(request.url.path, endsWith('/resources/download'));
          return http.Response('private-response-body', 503);
        }),
      );
      addTearDown(api.close);
      await expectLater(
        api.download('private-token', 'disk:/private-folder/private-photo.jpg'),
        throwsA(isA<CloudStorageException>().having((error) => error.code, 'code', DriveFailure.serviceUnavailable)),
      );
      expect(calls, 3);
      final retries = records.where((record) => record.message.startsWith('Request retrying')).toList();
      expect(retries, hasLength(2));
      final failed = records.singleWhere((record) => record.message.startsWith('Request failed'));
      expect(failed.message, contains('operation=downloadLink method=GET status=503 attempt=3'));
      expect(failed.message, contains('reason=serviceUnavailable type=CloudStorageException'));
      expect(
        [...retries, failed].every((record) => record.message.contains('responseBody=private-response-body')),
        isTrue,
      );
      expectDiagnostics();
    });

    test('content server 502 is distinguished from a successful download link request', () async {
      var calls = 0;
      final api = YandexDriveApi(
        clientFactory: () => MockClient((request) async {
          calls++;
          if (request.url.path.endsWith('/resources/download')) {
            return http.Response(
              jsonEncode({'href': 'https://content.example/private-photo?token=private-signed'}),
              200,
            );
          }
          return http.Response('file IO failure: LRC groups are unavailable in the local route table', 502);
        }),
      );
      addTearDown(api.close);
      await expectLater(
        api.download('private-oauth', 'disk:/private-folder/photo.jpg'),
        throwsA(isA<CloudStorageException>().having((error) => error.code, 'code', DriveFailure.serviceUnavailable)),
      );
      expect(calls, 2);
      expect(
        records.any(
          (record) =>
              record.message.startsWith('Request completed operation=downloadLink') &&
              record.message.contains('status=200'),
        ),
        isTrue,
      );
      final failed = records.singleWhere((record) => record.message.startsWith('Request failed'));
      expect(failed.message, contains('operation=downloadContent method=GET status=502 redirect=0'));
      expect(failed.message, contains('reason=serviceUnavailable'));
      expect(
        failed.message,
        contains('responseBody=file IO failure: LRC groups are unavailable in the local route table'),
      );
      expectDiagnostics();
    });

    test('a transport exception preserves original diagnostics before domain mapping', () async {
      final api = YandexDriveApi(
        clientFactory: () => MockClient((request) async {
          if (request.url.path.endsWith('/resources/download')) {
            return http.Response(
              jsonEncode({'href': 'https://content.example/private-photo?token=private-signed'}),
              200,
            );
          }
          throw http.ClientException('private-transport-detail', request.url);
        }),
      );
      addTearDown(api.close);
      await expectLater(
        api.download('private-oauth', 'disk:/private-folder/photo.jpg'),
        throwsA(isA<CloudStorageException>().having((error) => error.code, 'code', DriveFailure.network)),
      );
      final failed = records.singleWhere((record) => record.message.startsWith('Request failed'));
      expect(failed.message, contains('operation=downloadContent method=GET status=none'));
      expect(failed.message, contains('reason=network type=ClientException'));
      expect(failed.error.toString(), contains('private-transport-detail'));
      expect(failed.message, isNot(contains('responseBody=')));
      expectDiagnostics();
    });

    test('recovery is visible after a transient download link failure without changing retry policy', () async {
      var calls = 0;
      final api = YandexDriveApi(
        delay: (_) async {},
        clientFactory: () => MockClient((request) async {
          calls++;
          if (calls == 1) return http.Response('private-provider-body', 503);
          if (request.url.path.endsWith('/resources/download')) {
            return http.Response(
              jsonEncode({'href': 'https://content.example/private-photo?token=private-signed'}),
              200,
            );
          }
          return http.Response.bytes([1, 2, 3], 200);
        }),
      );
      addTearDown(api.close);
      final download = await api.download('private-oauth', 'disk:/private-folder/photo.jpg');
      addTearDown(download.close);
      expect(await download.response.stream.toBytes(), [1, 2, 3]);
      expect(calls, 3);
      expect(records.where((record) => record.message.startsWith('Request retrying')), hasLength(1));
      expect(records.where((record) => record.message.startsWith('Request failed')), isEmpty);
      expect(
        records.any((record) => record.message.contains('operation=downloadLink method=GET status=200 attempt=2')),
        isTrue,
      );
      expect(records.any((record) => record.message.startsWith('Response accepted operation=downloadContent')), isTrue);
      final retry = records.singleWhere((record) => record.message.startsWith('Request retrying'));
      expect(retry.message, contains('responseBody=private-provider-body'));
      expect(
        records
            .where((record) => !record.message.startsWith('Request retrying'))
            .any((record) => record.message.contains('responseBody=')),
        isFalse,
      );
      expectDiagnostics();
    });

    test('OAuth 503 keeps the POST operation and status without automatic retries', () async {
      var calls = 0;
      final api = YandexDriveApi(
        clientFactory: () => MockClient((request) async {
          calls++;
          return http.Response('private-response-body', 503);
        }),
      );
      addTearDown(api.close);
      await expectLater(
        api.token({
          'grant_type': 'refresh_token',
          'refresh_token': 'private-refresh',
          'client_secret': 'private-secret',
        }),
        throwsA(isA<CloudStorageException>().having((error) => error.code, 'code', DriveFailure.serviceUnavailable)),
      );
      expect(calls, 1);
      expect(records.where((record) => record.message.startsWith('Request retrying')), isEmpty);
      final failed = records.singleWhere((record) => record.message.startsWith('Request failed'));
      expect(failed.message, contains('operation=token method=POST status=503 attempt=1'));
      expect(failed.message, contains('responseBody=private-response-body'));
      expectDiagnostics();
    });

    test('REST 403 retains the JSON error description without changing the failure code', () async {
      final body = jsonEncode({
        'error': 'ForbiddenError',
        'description': 'Access refused for https://provider.example/private?token=fake-secret',
      });
      final api = YandexDriveApi(clientFactory: () => MockClient((_) async => http.Response(body, 403)));
      addTearDown(api.close);
      await expectLater(
        api.identity('private-token'),
        throwsA(isA<CloudStorageException>().having((error) => error.code, 'code', DriveFailure.authorizationDenied)),
      );
      final failed = records.singleWhere((record) => record.message.startsWith('Request failed'));
      expect(failed.message, contains('operation=identity method=GET status=403 attempt=1'));
      expect(failed.message, contains('responseBody=$body'));
      expectDiagnostics();
    });

    test('a recognized OAuth 400 logs its body while returning the protocol error', () async {
      final body = jsonEncode({'error': 'authorization_pending', 'error_description': 'Waiting for user\nsecond line'});
      var calls = 0;
      final api = YandexDriveApi(
        clientFactory: () => MockClient((_) async {
          calls++;
          return http.Response(body, 400);
        }),
      );
      addTearDown(api.close);
      expect((await api.token({'grant_type': 'device_code', 'code': 'private-device'})).error, 'authorization_pending');
      expect(calls, 1);
      final rejected = records.singleWhere((record) => record.message.startsWith('Request rejected'));
      expect(rejected.message, contains('operation=token method=POST status=400 attempt=1'));
      expect(rejected.message, contains('responseBody=$body'));
      expect(records.where((record) => record.message.startsWith('Request failed')), isEmpty);
    });

    test('an interrupted OAuth error body keeps partial text and the original parsing transport failure', () async {
      const partial = '{"error":"invalid_client","description":"partial response';
      final error = http.ClientException('original OAuth response interruption');
      final stack = StackTrace.fromString('#0 original-oauth-body-source\n#1 original-oauth-body-caller');
      final body = StreamController<List<int>>()
        ..add(utf8.encode(partial))
        ..addError(error, stack);
      addTearDown(body.close);
      final api = YandexDriveApi(
        clientFactory: () => MockClient.streaming((_, __) async => http.StreamedResponse(body.stream, 400)),
      );
      addTearDown(api.close);
      await expectLater(
        api.token({'grant_type': 'device_code'}),
        throwsA(isA<CloudStorageException>().having((failure) => failure.code, 'code', DriveFailure.network)),
      );
      final failed = records.singleWhere((record) => record.message.startsWith('Request failed'));
      expect(failed.message, contains('status=400'));
      expect(failed.message, contains('responseBody=$partial\n[response body incomplete]'));
      expect(failed.error, same(error));
      expect(failed.stackTrace.toString(), stack.toString());
      expectDiagnostics();
    });

    test('an oversized error body is bounded and its unfinished stream and clients are closed', () async {
      var cancelled = false;
      final body = StreamController<List<int>>(onCancel: () => cancelled = true);
      addTearDown(body.close);
      body.add(utf8.encode('${'x' * 4096}unlogged-tail'));
      final clients = <_TrackedClient>[];
      final api = YandexDriveApi(
        clientFactory: () {
          final client = _TrackedClient((request, _) async {
            if (request.url.path.endsWith('/resources/download')) {
              return http.StreamedResponse(Stream.value(utf8.encode('{"href":"https://content.example/file"}')), 200);
            }
            return http.StreamedResponse(body.stream, 500);
          });
          clients.add(client);
          return client;
        },
      );
      addTearDown(api.close);
      await expectLater(
        api.download('private-token', 'disk:/file.jpg'),
        throwsA(isA<CloudStorageException>().having((error) => error.code, 'code', DriveFailure.serviceUnavailable)),
      );
      final failed = records.singleWhere((record) => record.message.startsWith('Request failed'));
      expect(failed.message, contains('responseBody=${'x' * 4096}\n[response body truncated after 4096 bytes]'));
      expect(failed.message, isNot(contains('unlogged-tail')));
      expect(cancelled, isTrue);
      expect(clients, hasLength(2));
      expect(clients.every((client) => client.closeCalls == 1), isTrue);
      expectDiagnostics();
    });

    test('empty and malformed UTF-8 HTTP bodies remain visible without changing the HTTP failure', () async {
      for (final entry in <List<int>, String>{
        []: '<empty>',
        [0xD0, 0x9E, 0xFF, 10, 0x78]: 'О\uFFFD\nx',
      }.entries) {
        records.clear();
        final api = YandexDriveApi(clientFactory: () => MockClient((_) async => http.Response.bytes(entry.key, 503)));
        addTearDown(api.close);
        await expectLater(
          api.token({'grant_type': 'device_code'}),
          throwsA(isA<CloudStorageException>().having((error) => error.code, 'code', DriveFailure.serviceUnavailable)),
        );
        final failed = records.singleWhere((record) => record.message.startsWith('Request failed'));
        expect(failed.message, contains('responseBody=${entry.value}'));
        expectDiagnostics();
      }
    });

    test('a stalled error body times out, cancels reading and retains the HTTP status', () {
      fakeAsync((clock) {
        var cancelled = false;
        final body = StreamController<List<int>>(
          onCancel: () async {
            cancelled = true;
          },
        );
        final api = YandexDriveApi(
          timeout: const Duration(seconds: 2),
          clientFactory: () => MockClient.streaming((_, __) async => http.StreamedResponse(body.stream, 503)),
        );
        DriveFailure? failure;
        unawaited(
          api
              .token({'grant_type': 'device_code'})
              .then<void>(
                (_) => fail('Expected an HTTP error'),
                onError: (Object error, StackTrace stack) {
                  expect(error, isA<CloudStorageException>());
                  failure = (error as CloudStorageException).code;
                },
              ),
        );
        clock.flushMicrotasks();
        expect(failure, isNull);
        clock.elapse(const Duration(seconds: 2));
        expect(
          failure,
          DriveFailure.serviceUnavailable,
          reason: '${records.map((record) => record.message).join('\n')}\n${clock.pendingTimersDebugString}',
        );
        expect(cancelled, isTrue);
        final read = records.singleWhere((record) => record.message.startsWith('HTTP error response body read failed'));
        expect(read.error, isA<TimeoutException>());
        final failed = records.singleWhere((record) => record.message.startsWith('Request failed'));
        expect(failed.message, contains('status=503'));
        expect(failed.message, contains('[response body incomplete]'));
        expectDiagnostics();
        api.close();
        unawaited(body.close());
        clock.flushMicrotasks();
        expect(clock.pendingTimers, isEmpty);
      });
    });

    test('disabled FINE diagnostics do not read the HTTP error body', () async {
      Logger.root.level = Level.INFO;
      var listened = false;
      final body = Stream<List<int>>.multi((controller) {
        listened = true;
        controller.close();
      });
      final api = YandexDriveApi(
        clientFactory: () => MockClient.streaming((_, __) async => http.StreamedResponse(body, 503)),
      );
      addTearDown(api.close);
      await expectLater(
        api.token({'grant_type': 'device_code'}),
        throwsA(isA<CloudStorageException>().having((error) => error.code, 'code', DriveFailure.serviceUnavailable)),
      );
      expect(listened, isFalse);
      expect(records, isEmpty);
    });

    test('partial HTTP body and original read failure reach LogRecord and console with the full stack', () async {
      final error = StateError('original-body-read-error https://provider.example/private?code=fake-secret');
      final stack = StackTrace.fromString('#0 original-body-source\n#1 original-body-caller\n#2 final-stack-marker');
      const partial = 'file IO failure: LRC groups are unavailable\nsecond response line';
      final body = StreamController<List<int>>()
        ..add(utf8.encode(partial))
        ..addError(error, stack);
      addTearDown(body.close);
      final api = YandexDriveApi(
        clientFactory: () => MockClient.streaming((_, __) async => http.StreamedResponse(body.stream, 503)),
      );
      addTearDown(api.close);
      final console = <String>[];
      await runZoned(() async {
        initLog('yandex-test');
        await expectLater(
          api.token({'grant_type': 'device_code'}),
          throwsA(isA<CloudStorageException>().having((error) => error.code, 'code', DriveFailure.serviceUnavailable)),
        );
      }, zoneSpecification: ZoneSpecification(print: (_, __, ___, line) => console.add(line)));
      final read = records.singleWhere((record) => record.message.startsWith('HTTP error response body read failed'));
      expect(read.error, same(error));
      expect(read.stackTrace.toString(), stack.toString());
      final failed = records.singleWhere((record) => record.message.startsWith('Request failed'));
      expect(failed.message, contains('responseBody=$partial\n[response body incomplete]'));
      expectDiagnostics();
      final output = console.join('\n');
      expect(output, contains('operation=token method=POST status=503'));
      expect(output, contains(error.toString()));
      expect(output, contains(stack.toString()));
      expect(output, contains(failed.stackTrace.toString()));
      expect(output, contains('responseBody=$partial\n[response body incomplete]'));
    });
  });
}
