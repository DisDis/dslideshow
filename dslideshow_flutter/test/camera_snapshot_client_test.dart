import 'dart:async';
import 'dart:convert';

import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_flutter/src/service/camera_snapshot_client.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

final png = base64Decode(
  'iVBORw0KGgoAAAANSUhEUgAAAAIAAAACCAYAAABytg0kAAAAEUlEQVR4nGP4z8DwH4QZYAwAR8oH+WdZbrcAAAAASUVORK5CYII=',
);

class HeldClient extends http.BaseClient {
  final response = Completer<http.StreamedResponse>();
  bool closed = false;
  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) =>
      response.future;
  @override
  void close() {
    closed = true;
    if (!response.isCompleted) response.completeError(StateError('closed'));
  }
}

class IgnoringCloseClient extends HeldClient {
  @override
  void close() {
    closed = true;
  }
}

void main() {
  test(
    'cancels a stalled response body and immediately starts the next request',
    () async {
      final bodyCancelled = Completer<void>();
      final body = StreamController<List<int>>(
        onCancel: () => bodyCancelled.complete(),
      );
      var requests = 0;
      final loader = CameraSnapshotClient(
        maxConcurrent: 1,
        createClient: () => MockClient.streaming((_, _) async {
          requests++;
          return requests == 1
              ? http.StreamedResponse(body.stream, 200)
              : http.StreamedResponse(Stream.value(png), 200);
        }),
      );
      addTearDown(loader.dispose);
      addTearDown(body.close);
      final camera = CameraConfig(id: 'a', url: 'http://camera/snapshot');
      final first = expectLater(
        loader.fetch('first', camera),
        throwsStateError,
      );
      await Future<void>.delayed(Duration.zero);
      final second = loader.fetch('second', camera);
      loader.cancel('first');
      await first;
      await bodyCancelled.future;
      expect(await second, png);
      expect(requests, 2);
    },
  );

  test(
    'cancellation frees its slot before an uncooperative request completes',
    () async {
      final clients = <IgnoringCloseClient>[];
      final loader = CameraSnapshotClient(
        maxConcurrent: 1,
        createClient: () {
          final client = IgnoringCloseClient();
          clients.add(client);
          return client;
        },
      );
      addTearDown(() {
        loader.dispose();
        for (final client in clients) {
          if (!client.response.isCompleted) {
            client.response.completeError(StateError('late cancellation'));
          }
        }
      });
      final camera = CameraConfig(id: 'a', url: 'http://camera/snapshot');
      final first = expectLater(
        loader.fetch('first', camera),
        throwsStateError,
      );
      final second = loader.fetch('second', camera)..ignore();
      loader.cancel('first');
      await first;
      await Future<void>.delayed(Duration.zero);
      expect(clients, hasLength(2));
      clients.last.response.complete(
        http.StreamedResponse(Stream.value(png), 200),
      );
      expect(await second, png);
    },
  );
  test(
    'loads the original URL directly and supports optional basic auth',
    () async {
      final client = CameraSnapshotClient(
        createClient: () => MockClient((request) async {
          expect(request.url.toString(), 'https://camera/snapshot?token=123');
          expect(
            request.headers['authorization'],
            'Basic ${base64Encode(utf8.encode('user:pass'))}',
          );
          return http.Response.bytes(png, 200);
        }),
      );
      addTearDown(client.dispose);
      expect(
        await client.fetch(
          'one',
          CameraConfig(
            id: 'a',
            url: 'https://camera/snapshot?token=123',
            username: 'user',
            password: 'pass',
          ),
        ),
        png,
      );
    },
  );
  test('rejects RTSP, non-images, HTTP errors and oversized bodies', () async {
    final camera = CameraConfig(id: 'a', url: 'http://camera/snapshot');
    final bad = CameraSnapshotClient(
      createClient: () => MockClient((_) async => http.Response('<html>', 200)),
    );
    addTearDown(bad.dispose);
    await expectLater(
      bad.fetch('rtsp', CameraConfig(id: 'a', url: 'rtsp://camera/live')),
      throwsFormatException,
    );
    await expectLater(bad.fetch('html', camera), throwsFormatException);
    final large = CameraSnapshotClient(
      maxBytes: 3,
      createClient: () =>
          MockClient((_) async => http.Response.bytes(png, 200)),
    );
    addTearDown(large.dispose);
    await expectLater(large.fetch('large', camera), throwsStateError);
    final offline = CameraSnapshotClient(
      createClient: () =>
          MockClient((_) async => http.Response('Unavailable', 503)),
    );
    addTearDown(offline.dispose);
    await expectLater(offline.fetch('offline', camera), throwsStateError);
  });
  test(
    'bounded loading, queued cancellation and disposal close active requests',
    () async {
      final clients = <HeldClient>[];
      final loader = CameraSnapshotClient(
        maxConcurrent: 1,
        createClient: () {
          final client = HeldClient();
          clients.add(client);
          return client;
        },
      );
      final camera = CameraConfig(id: 'a', url: 'http://camera/snapshot');
      final first = expectLater(loader.fetch('1', camera), throwsStateError);
      final second = expectLater(loader.fetch('2', camera), throwsStateError);
      expect(clients, hasLength(1));
      loader.cancel('2');
      await second;
      loader.dispose();
      await first;
      expect(clients.single.closed, true);
      await expectLater(loader.fetch('3', camera), throwsStateError);
    },
  );
  test('timeout closes a stalled request', () async {
    final held = HeldClient();
    final loader = CameraSnapshotClient(
      timeout: const Duration(milliseconds: 10),
      createClient: () => held,
    );
    addTearDown(loader.dispose);
    await expectLater(
      loader.fetch(
        'timeout',
        CameraConfig(id: 'a', url: 'http://camera/snapshot'),
      ),
      throwsA(isA<TimeoutException>()),
    );
    expect(held.closed, true);
  });
}
