import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:config_app/src/web_client/web_client.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

class _Transport extends http.BaseClient {
  _Transport(this.handle);
  final Future<http.StreamedResponse> Function(http.BaseRequest) handle;
  var closeCount = 0;
  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) =>
      handle(request);
  @override
  void close() => closeCount++;
}

http.StreamedResponse _response(int status, [String body = '']) =>
    http.StreamedResponse(Stream.value(utf8.encode(body)), status);

WebClient _client(_Transport transport) => WebClient(
  host: 'frame.example',
  port: 8443,
  code: 'private /?#%',
  scheme: 'https',
  clientFactory: () => transport,
);

void main() {
  test('media URI preserves scheme, code and each nested filename segment', () {
    final uri = WebClient(
      host: '::1',
      port: 8443,
      code: ' /?#%',
      scheme: 'https',
    ).getMediaItemUri('album one/photo?#% ж.jpg');
    expect(uri.scheme, 'https');
    expect(uri.host, '::1');
    expect(uri.port, 8443);
    expect(uri.pathSegments, [
      'cache',
      ' /?#%',
      'get',
      'album one',
      'photo?#% ж.jpg',
    ]);
    expect(uri.query, isEmpty);
    expect(uri.fragment, isEmpty);
  });

  test('media list uses the HTTP contract and closes its transport', () async {
    final transport = _Transport((request) async {
      expect(request.method, 'GET');
      expect(request.url.scheme, 'https');
      expect(request.url.pathSegments, ['cache', 'private /?#%', 'list']);
      expect(
        request.headers['content-type'],
        'application/json; charset=utf-8',
      );
      return _response(200, '{"items":["nested/one.jpg","two.jpg"]}');
    });
    expect(await _client(transport).getMediaItems(), [
      'nested/one.jpg',
      'two.jpg',
    ]);
    expect(transport.closeCount, 1);
  });

  for (final result in [
    (503, 'private error'),
    (200, 'bad JSON'),
    (200, '{"items":false}'),
  ]) {
    test(
      'invalid media list ${result.$1}/${result.$2} fails and closes',
      () async {
        final transport = _Transport(
          (_) async => _response(result.$1, result.$2),
        );
        await expectLater(
          _client(transport).getMediaItems(),
          throwsFormatException,
        );
        expect(transport.closeCount, 1);
      },
    );
  }

  test('stream upload reaches a real local HTTP server with multipart and a nested name', () async {
    final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
    addTearDown(() => server.close(force: true));
    final received = Completer<void>();
    final payload = [0, 1, 2, 254, 255];
    final listener = server.listen((request) async {
      try {
        expect(request.method, 'POST');
        expect(request.uri.pathSegments, ['upload', 'private /?#%', '']);
        expect(request.headers.contentType!.mimeType, 'multipart/form-data');
        final body = await request.fold<List<int>>(
          [],
          (all, chunk) => all..addAll(chunk),
        );
        final text = latin1.decode(body);
        expect(text, contains('name="file"; filename="nested/file name.jpg"'));
        expect(text, contains(latin1.decode(payload)));
        request.response
          ..statusCode = 200
          ..write('File uploaded');
        await request.response.close();
        received.complete();
      } catch (error, stack) {
        received.completeError(error, stack);
        await request.response.close();
      }
    });
    addTearDown(listener.cancel);
    var opens = 0;
    final progress = <(int, int)>[];
    await WebClient(
      host: server.address.address,
      port: server.port,
      code: 'private /?#%',
    ).uploadMediaStream(
      serverPath: 'nested/file name.jpg',
      length: () async => payload.length,
      openRead: () {
        opens++;
        return Stream.fromIterable([payload.sublist(0, 2), payload.sublist(2)]);
      },
      cancellation: MediaUploadCancellation(),
      onProgress: (sent, total) => progress.add((sent, total)),
    );
    await received.future;
    expect(opens, 1);
    expect(progress.last, (5, 5));
  });

  for (final size in <int?>[null, -1]) {
    test(
      'unknown or invalid length $size never opens content or HTTP',
      () async {
        var opens = 0;
        var sends = 0;
        final transport = _Transport((_) async {
          sends++;
          return _response(200);
        });
        await expectLater(
          _client(transport).uploadMediaStream(
            serverPath: 'file.jpg',
            length: () async => size,
            openRead: () {
              opens++;
              return Stream.value([1]);
            },
            cancellation: MediaUploadCancellation(),
            onProgress: (_, _) {},
          ),
          throwsA(
            isA<MediaUploadException>().having(
              (e) => e.failure,
              'failure',
              MediaUploadFailure.lengthUnknown,
            ),
          ),
        );
        expect((opens, sends, transport.closeCount), (0, 0, 0));
      },
    );
  }

  test('rejected response closes HTTP and reports a safe failure', () async {
    final transport = _Transport((request) async {
      await request.finalize().drain<void>();
      return _response(507, 'private server path or access code');
    });
    await expectLater(
      _client(transport).uploadMediaStream(
        serverPath: 'file.jpg',
        length: () async => 1,
        openRead: () => Stream.value([1]),
        cancellation: MediaUploadCancellation(),
        onProgress: (_, _) {},
      ),
      throwsA(
        isA<MediaUploadException>().having(
          (e) => e.failure,
          'failure',
          MediaUploadFailure.transferFailed,
        ),
      ),
    );
    expect(transport.closeCount, 1);
  });

  for (final content in [
    [1],
    [1, 2, 3],
  ]) {
    test(
      'source byte count ${content.length} differing from metadata is rejected',
      () async {
        final transport = _Transport((request) async {
          await request.finalize().drain<void>();
          return _response(200);
        });
        await expectLater(
          _client(transport).uploadMediaStream(
            serverPath: 'file.jpg',
            length: () async => 2,
            openRead: () => Stream.value(content),
            cancellation: MediaUploadCancellation(),
            onProgress: (_, _) {},
          ),
          throwsA(
            isA<MediaUploadException>().having(
              (e) => e.failure,
              'failure',
              MediaUploadFailure.sourceUnavailable,
            ),
          ),
        );
        expect(transport.closeCount, 1);
      },
    );
  }

  test(
    'cancelled selection never reads metadata, content or creates transport',
    () async {
      var reads = 0;
      final cancellation = MediaUploadCancellation()..cancel();
      final transport = _Transport((_) async {
        reads++;
        return _response(200);
      });
      await expectLater(
        _client(transport).uploadMediaStream(
          serverPath: 'file.jpg',
          length: () async {
            reads++;
            return 1;
          },
          openRead: () {
            reads++;
            return Stream.value([1]);
          },
          cancellation: cancellation,
          onProgress: (_, _) {},
        ),
        throwsA(isA<MediaUploadCancelled>()),
      );
      expect(reads, 0);
    },
  );
}
