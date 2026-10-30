import 'dart:io';

import 'package:dslideshow_tools/src/benchmarks/camera.dart';
import 'package:test/test.dart';

Map<String, dynamic> config(List<Map<String, dynamic>> cameras) => {
  'slideshow': {
    'specialScreens': [
      {
        'type': 'cameras',
        'options': {'cameras': cameras},
      },
    ],
  },
};
void main() {
  test('IPv4 endpoints group paths, hide credentials and retain skipped indices', () {
    final result = cameraEndpoints(
      config([
        {'url': 'http://camera.local/snapshot'},
        {'url': 'http://[::1]/snapshot'},
        {'url': 'rtsp://192.168.1.10/stream'},
        {},
        {'url': 'http://192.168.1.10:invalid/snapshot'},
        {'url': 'http://user:secret@192.168.1.10/snapshot?token=private'},
        {'url': 'http://192.168.1.10:80/other'},
        {'url': 'https://192.168.1.10/snapshot'},
        {'url': 'https://192.168.1.10:8080/snapshot'},
      ]),
    );
    expect(result, {
      ('0A01A8C0', 80): [5, 6],
      ('0A01A8C0', 443): [7],
      ('0A01A8C0', 8080): [8],
    });
    expect(cameraEndpoints({}), isEmpty);
  });
  test('only owned TCP sockets count and MQTT remains separate', () {
    final text =
        'header\n0: 0100007F:AAAA 0A01A8C0:0050 01 0 0 0 1000 0 101 1\n1: 0100007F:AAAA 0A01A8C0:0050 01 0 0 0 1000 0 102 1\n2: 0100007F:AAAA 0A01A8C0:0050 02 0 0 0 1000 0 103 1\n3: 0100007F:AAAA 0A01A8C0:075B 08 0 0 0 1000 0 104 1\n';
    final (states, mqtt) = tcpStates(
      text,
      {'socket:[101]', 'socket:[102]', 'socket:[104]'},
      {
        ('0A01A8C0', 80): [0, 2],
      },
    );
    expect(states, {'0,2:01': 2});
    expect(mqtt, {'08': 1});
    final (emptyStates, emptyMqtt) = tcpStates('header\n', {}, {});
    expect(emptyStates, isEmpty);
    expect(emptyMqtt, isEmpty);
  });
  test('HTTP probe reads headers and closes without waiting for body', () async {
    final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
    addTearDown(() => server.close(force: true));
    final paths = <String>[];
    server.listen((request) async {
      paths.add(request.uri.path);
      request.response.contentLength = 1000000;
      request.response.write('x');
      try {
        await request.response.flush();
      } on Object {
        /* Client intentionally closes. */
      }
    });
    final sample = await cameraHttpHeaders('127.0.0.1:${server.port}', timeout: const Duration(seconds: 5));
    expect(paths, ['/info']);
    expect(sample['status'], 200);
    expect(sample.containsKey('exception_type'), isFalse);
  });
  test('stalled HTTP headers respect overall deadline', () async {
    final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
    addTearDown(() => server.close(force: true));
    server.listen((request) {});
    final result = await cameraHttpProbe(
      '127.0.0.1:${server.port}',
      duration: const Duration(milliseconds: 80),
    ).timeout(const Duration(seconds: 2));
    final sample = (result['samples'] as List).single as Map;
    expect(sample['exception_type'], 'TimeoutError');
    expect(sample.containsKey('status'), isFalse);
  });
  test('HTTP target rejects credentials, URLs and paths', () async {
    for (final authority in [
      'http://localhost:80',
      'user:secret@localhost:80',
      'localhost:80/path',
      'localhost',
      'localhost:80?token=secret',
    ]) {
      await expectLater(cameraHttpProbe(authority, duration: const Duration(milliseconds: 1)), throwsArgumentError);
    }
  });
}
