import 'dart:convert';

import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_backend/src/service/storage/cloud_storage_transfer.dart';
import 'package:dslideshow_backend/src/service/yandex_drive/yandex_drive_api.dart';
import 'package:dslideshow_backend/src/service/yandex_drive/yandex_drive_paths.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:test/test.dart';

void main() {
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
}
