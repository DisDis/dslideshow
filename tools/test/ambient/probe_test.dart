import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dslideshow_tools/src/ambient/cli.dart';
import 'package:dslideshow_tools/src/ambient/probe.dart';
import 'package:http/http.dart' as net;
import 'package:path/path.dart' as p;
import 'package:test/test.dart';

const photo = <String, dynamic>{
  'id': 'photo/../id',
  'mediaFile': {'baseUrl': 'https://lh3.googleusercontent.com/photo', 'mimeType': 'image/jpeg'},
};
const video = <String, dynamic>{
  'id': 'video-id',
  'mediaFile': {'baseUrl': 'https://lh3.googleusercontent.com/video', 'mimeType': 'video/mp4'},
};
const clientJson = {
  'installed': {'client_id': 'test-client', 'client_secret': 'test-secret'},
};

class FakeClock {
  double now = 0;
  final waits = <double>[];
  Future<void> sleep(Duration duration) async {
    final value = duration.inMicroseconds / 1000000;
    waits.add(value);
    now += value;
  }
}

class FakeHttp extends AmbientHttp {
  FakeHttp(Iterable<Object> values) : values = values.toList();
  List<Object> values;
  final calls = <Map<String, dynamic>>[];
  Future<net.StreamedResponse> Function()? response;
  @override
  Future<Map<String, dynamic>> json(
    String url, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? form,
    String? token,
    Duration? requestTimeout,
  }) async {
    calls.add({'url': url, 'body': body, 'form': form, 'token': token});
    if (values.isEmpty) throw StateError('Unexpected request: $url');
    final value = values.removeAt(0);
    if (value is Exception) throw value;
    return Map<String, dynamic>.from(value as Map);
  }

  @override
  Future<net.StreamedResponse> open(
    String url, {
    List<int>? data,
    Map<String, String>? headers,
    bool media = false,
    Duration? requestTimeout,
    String? method,
  }) async {
    if (response == null) {
      return super.open(
        url,
        data: data,
        headers: headers,
        media: media,
        requestTimeout: requestTimeout,
        method: method,
      );
    }
    return response!();
  }
}

({net.StreamedResponse response, Completer<void> closed}) response(
  List<int> bytes, {
  Map<String, String> headers = const {},
  int status = 200,
  Stream<List<int>>? body,
}) {
  final closed = Completer<void>();
  late StreamController<List<int>> controller;
  controller = StreamController<List<int>>(
    onListen: () {
      if (body != null) {
        unawaited(controller.addStream(body).then((_) => controller.close()));
      } else {
        controller.add(bytes);
        unawaited(controller.close());
      }
    },
    onCancel: () {
      if (!closed.isCompleted) closed.complete();
    },
  );
  return (response: net.StreamedResponse(controller.stream, status, headers: headers), closed: closed);
}

void main() {
  late Directory root;
  late File client;
  late FakeClock clock;
  late List<String> messages;
  setUp(() {
    root = Directory.systemTemp.createTempSync('ambient-probe-');
    client = File(p.join(root.path, 'client.json'))..writeAsStringSync(jsonEncode(clientJson));
  });
  tearDown(() => root.deleteSync(recursive: true));
  Probe fixture([List<Object> values = const [], List<String> changes = const []]) {
    clock = FakeClock();
    messages = [];
    final options = ambientParser(defaultStateDirectory: p.join(root.path, 'state'))
        .parse(['--client-file', client.path, ...changes]);
    final probe = Probe(
      options,
      http: FakeHttp(values),
      sleep: clock.sleep,
      monotonic: () => clock.now,
      wall: () => clock.now,
      say: messages.add,
      prompt: (_) async => '2',
    );
    probe.output = privateDirectory(Directory(p.join(root.path, 'output')));
    probe.load();
    addTearDown(probe.http.close);
    return probe;
  }

  void authorized(Probe probe) => probe.state.addAll({'access_token': 'access', 'expires_at': 3600});

  test('pending and slow_down respect server intervals and private token storage', () async {
    final probe = fixture([
      {
        'device_code': 'private-device-code',
        'user_code': 'ABCD',
        'verification_url': 'https://www.google.com/device',
        'expires_in': 100,
        'interval': 2,
      },
      ApiError(428, {'error': 'authorization_pending'}),
      ApiError(403, {'error': 'slow_down'}),
      {'access_token': 'private-access', 'refresh_token': 'private-refresh', 'expires_in': 3600, 'scope': ambientScope},
    ]);
    expect(await probe.token(), 'private-access');
    expect(clock.waits, [2, 2, 7]);
    final form = (probe.http as FakeHttp).calls.last['form'] as Map;
    expect(form['grant_type'], 'urn:ietf:params:oauth:grant-type:device_code');
    expect(form['client_secret'], 'test-secret');
    expect(messages.join('\n'), isNot(contains('private-device-code')));
    expect(probe.statePath.statSync().mode & 0x1ff, 0x180);
    expect(probe.statePath.parent.statSync().mode & 0x1ff, 0x1c0);
  });
  test('denied, expired and unknown OAuth errors are never retried', () async {
    for (final code in ['access_denied', 'expired_token', 'unrecognized_error']) {
      final probe = fixture([
        {
          'device_code': 'secret',
          'user_code': 'A',
          'verification_url': 'https://www.google.com/device',
          'expires_in': 60,
        },
        ApiError(403, {'error': code}),
      ]);
      await expectLater(probe.authorize(), throwsA(isA<ApiError>().having((e) => e.code, 'code', code)));
      expect((probe.http as FakeHttp).calls, hasLength(2));
    }
  });
  test('authorization deadline bounds polling without sleeping beyond expiry', () async {
    final probe = fixture([
      {
        'device_code': 'code',
        'user_code': 'A',
        'verification_url': 'https://www.google.com/device',
        'expires_in': 4,
        'interval': 5,
      },
    ]);
    await expectLater(probe.authorize(), throwsA(isA<ProbeError>()));
    expect(clock.waits, isEmpty);
  });
  test('401 refreshes once and retains previous refresh token', () async {
    final probe = fixture([
      ApiError(401, {
        'error': {'status': 'UNAUTHENTICATED'},
      }),
      {'access_token': 'new-access', 'expires_in': 3600},
      {'id': 'device'},
    ]);
    probe.state.addAll({'access_token': 'old-access', 'refresh_token': 'refresh', 'expires_at': 3600});
    expect(await probe.api('devices/device'), {'id': 'device'});
    final calls = (probe.http as FakeHttp).calls;
    expect(calls.first['token'], 'old-access');
    expect(calls.last['token'], 'new-access');
    expect(probe.state['refresh_token'], 'refresh');
  });
  test('permission reason survives diagnostics while secret and signed URL are redacted', () async {
    final probe = fixture([
      ApiError(403, {
        'error': {
          'status': 'PERMISSION_DENIED',
          'message': 'Denied test-secret https://example.test/private',
          'details': [
            {'reason': 'SERVICE_DISABLED'},
          ],
        },
      }),
    ]);
    authorized(probe);
    try {
      await probe.api('devices/id');
      fail('request unexpectedly succeeded');
    } on ApiError catch (error) {
      final message = probe.http.clean(error);
      expect(message, contains('SERVICE_DISABLED'));
      expect(message, isNot(contains('test-secret')));
      expect(message, isNot(contains('example.test')));
    }
    expect((probe.http as FakeHttp).calls, hasLength(1));
  });
  test('changing OAuth client is rejected before network', () {
    final probe = fixture();
    probe.save();
    client.writeAsStringSync(
      jsonEncode({
        'installed': {'client_id': 'different', 'client_secret': 'other'},
      }),
    );
    expect(probe.load, throwsA(isA<ProbeError>()));
    expect((probe.http as FakeHttp).calls, isEmpty);
  });
  test('create request ID survives failed POST and restart', () async {
    var probe = fixture([const ProbeError('connection lost')]);
    authorized(probe);
    await expectLater(probe.device(), throwsA(isA<ProbeError>()));
    final id = (jsonDecode(probe.statePath.readAsStringSync()) as Map)['request_id'];
    probe = fixture([
      {'id': 'device', 'mediaSourcesSet': true},
    ]);
    authorized(probe);
    await probe.device();
    final uri = Uri.parse((probe.http as FakeHttp).calls.single['url'] as String);
    expect(uri.queryParameters, {'requestId': id});
    expect(probe.state['device_id'], 'device');
  });
  test('selection polling uses server duration and preserves created device', () async {
    final probe = fixture([
      {
        'id': 'device',
        'settingsUri': 'https://photos.google.com/settings',
        'mediaSourcesSet': false,
        'pollingConfig': {'pollInterval': '2.5s'},
      },
      {
        'id': 'device',
        'mediaSourcesSet': true,
        'mediaSources': [
          {'id': 'album'},
        ],
      },
    ]);
    authorized(probe);
    expect((await probe.device())['mediaSourcesSet'], isTrue);
    expect(clock.waits, [2.5]);
    expect(probe.state['device_id'], 'device');
  });
  test('selection timeout retains device so another run can resume', () async {
    final probe = fixture(
      [
        {
          'id': 'device',
          'settingsUri': 'https://photos.google.com/settings',
          'mediaSourcesSet': false,
          'pollingConfig': {'pollInterval': '10s'},
        },
      ],
      ['--selection-timeout', '5'],
    );
    authorized(probe);
    await expectLater(probe.device(), throwsA(isA<ProbeError>()));
    expect(jsonDecode(probe.statePath.readAsStringSync())['device_id'], 'device');
  });
  test('source selection ignores highlights, remembers choice and rejects foreign IDs', () async {
    final probe = fixture();
    final device = {
      'mediaSources': [
        {'id': 'highlights'},
        {'id': 'first', 'displayName': 'A'},
        {'id': 'second', 'displayName': 'B'},
      ],
    };
    expect(await probe.source(device), 'second');
    expect(await probe.source(device), 'second');
    final invalid = fixture([], ['--source-id', 'foreign-library-album-id']);
    await expectLater(invalid.source(device), throwsA(isA<ProbeError>()));
  });
  test('pagination deduplicates IDs and strips signed URLs from saved metadata', () async {
    final probe = fixture([
      {
        'mediaItems': [photo],
        'nextPageToken': 'next',
      },
      {
        'mediaItems': [photo, video],
      },
    ]);
    authorized(probe);
    expect(await probe.listMedia('device', 'album'), hasLength(2));
    final query = Uri.parse((probe.http as FakeHttp).calls.last['url'] as String).queryParameters;
    expect(query['mediaSourceId'], 'album');
    expect(query['pageToken'], 'next');
    expect(probe.report['counts'], {'photo': 1, 'video': 1, 'unknown': 0});
    expect(probe.report['truncated'], isFalse);
    expect(File(p.join(probe.output.path, 'media.json')).readAsStringSync(), isNot(contains('baseUrl')));
  });
  test('page cap reports partial; repeated tokens terminate with failure', () async {
    final probe = fixture(
      [
        {
          'mediaItems': [photo],
          'nextPageToken': 'next',
        },
      ],
      ['--max-pages', '1'],
    );
    authorized(probe);
    await probe.listMedia('device', 'album');
    expect(probe.report['truncated'], isTrue);
    final repeated = fixture([
      {'nextPageToken': 'same'},
      {'nextPageToken': 'same'},
    ]);
    authorized(repeated);
    await expectLater(repeated.listMedia('device', 'album'), throwsA(isA<ProbeError>()));
  });
  test('invalid media shapes and malformed credentials fail before unsafe use', () async {
    client.writeAsStringSync(jsonEncode({'installed': 'not-an-object'}));
    expect(() => fixture(), throwsA(isA<ProbeError>()));
    client.writeAsStringSync(jsonEncode(clientJson));
    final probe = fixture([
      {
        'mediaItems': [
          {'id': 'bad', 'mediaFile': null},
        ],
      },
    ]);
    authorized(probe);
    await expectLater(probe.listMedia('device', 'album'), throwsA(isA<ProbeError>()));
  });
  test('server duration and unknown MIME parsing have explicit boundaries', () {
    expect(serverDuration('1.250s'), 1.25);
    for (final value in [null, 5, 'forever', '-1s', '0s', 'NaNs']) {
      expect(() => serverDuration(value), throwsA(isA<ProbeError>()));
    }
    expect(MediaKind.fromMime('application/pdf'), MediaKind.unknown);
  });
  test('media host allowlist rejects credentials, alternate ports and suffix confusion', () {
    for (final value in [
      'http://lh3.googleusercontent.com/x',
      'https://googleusercontent.com.evil.test/x',
      'https://user@lh3.googleusercontent.com/x',
      'https://lh3.googleusercontent.com:444/x',
      'https://lh3.googleusercontent.com/x#secret',
    ]) {
      expect(() => mediaUrl(value), throwsA(isA<ProbeError>()));
    }
    expect(mediaUrl('https://lh3.googleusercontent.com/x'), 'https://lh3.googleusercontent.com/x');
  });
  test('stream limit, truncation, MIME and partial-response failures remove temporary file', () async {
    for (final scenario in [
      (utf8.encode('12345'), {'content-type': 'image/jpeg'}, 200, 4),
      (utf8.encode('123'), {'content-type': 'image/jpeg', 'content-length': '10'}, 200, 20),
      (utf8.encode('<html>'), {'content-type': 'text/html'}, 200, 20),
      (utf8.encode('123'), {'content-type': 'image/jpeg'}, 206, 20),
    ]) {
      final probe = fixture([], ['--max-download-bytes', '${scenario.$4}']);
      authorized(probe);
      final fixtureResponse = response(scenario.$1, headers: scenario.$2, status: scenario.$3);
      (probe.http as FakeHttp).response = () async => fixtureResponse.response;
      await expectLater(probe.download(photo), throwsA(isA<ProbeError>()));
      await fixtureResponse.closed.future.timeout(const Duration(seconds: 2));
      expect(probe.output.listSync(), isEmpty);
    }
  });
  test('cancellation during download closes stream and removes partial file', () async {
    final probe = fixture();
    authorized(probe);
    final stream = StreamController<List<int>>();
    final started = Completer<void>();
    (probe.http as FakeHttp).response = () async => net.StreamedResponse(
      stream.stream.transform(
        StreamTransformer.fromHandlers(
          handleData: (chunk, sink) {
            started.complete();
            probe.cancel();
            sink.add(chunk);
          },
        ),
      ),
      200,
      headers: {'content-type': 'image/jpeg'},
    );
    final work = probe.download(photo);
    final error = expectLater(work, throwsA(isA<ProbeInterrupted>()));
    stream.add([255, 216, 255]);
    await started.future;
    await error;
    await stream.close();
    expect(probe.output.listSync(), isEmpty);
  });
  test('download deadline cancels stream without retaining partial media', () async {
    final probe = fixture([], ['--download-timeout', '1']);
    authorized(probe);
    final fixtureResponse = response(
      [],
      headers: {'content-type': 'image/jpeg'},
      body:
          Stream<List<int>>.fromIterable([
            [255, 216, 255],
          ]).map((chunk) {
            clock.now += 2;
            return chunk;
          }),
    );
    (probe.http as FakeHttp).response = () async => fixtureResponse.response;
    await expectLater(probe.download(photo), throwsA(isA<ProbeError>()));
    await fixtureResponse.closed.future.timeout(const Duration(seconds: 2));
    expect(probe.output.listSync(), isEmpty);
  });
  test('octet-stream requires real media signature and transcodes use response extension', () async {
    final probe = fixture();
    authorized(probe);
    for (final valid in [true, false]) {
      final fixtureResponse = response(
        valid ? [255, 216, 255, ...utf8.encode('jpeg')] : utf8.encode('<html>'),
        headers: {'content-type': 'application/octet-stream'},
      );
      (probe.http as FakeHttp).response = () async => fixtureResponse.response;
      if (valid) {
        final result = await probe.download(photo);
        File(p.join(probe.output.path, result['file'] as String)).deleteSync();
      } else {
        await expectLater(probe.download(photo), throwsA(isA<ProbeError>()));
      }
      await fixtureResponse.closed.future.timeout(const Duration(seconds: 2));
      expect(probe.output.listSync(), isEmpty);
    }
    final bytes = [137, 80, 78, 71, 13, 10, 26, 10, ...utf8.encode('png')];
    (probe.http as FakeHttp).response = () async =>
        response(bytes, headers: {'content-type': 'image/png; charset=binary'}).response;
    final result = await probe.download(photo);
    expect(result['mime_type'], 'image/png');
    expect(result['file'], endsWith('.png'));
    expect(File(p.join(probe.output.path, result['file'] as String)).readAsBytesSync(), bytes);
  });
  test('state lock prevents concurrent probes and releases after failure', () async {
    final directory = Directory(p.join(root.path, 'state'));
    await withStateLock(directory, () async {
      await expectLater(
        withStateLock(directory, () async => fail('Second lock succeeded')),
        throwsA(isA<ProbeError>()),
      );
    });
    await expectLater(
      withStateLock(directory, () async => throw const ProbeError('fixture')),
      throwsA(isA<ProbeError>()),
    );
    expect(await withStateLock(directory, () async => 42), 42);
  });
  test('existing output parent permissions survive; new state, run and JSON files remain private', () async {
    final parent = Directory(p.join(root.path, 'public-output'))..createSync();
    expect(Process.runSync('chmod', ['755', '--', parent.path]).exitCode, 0);
    client.writeAsStringSync('{}');
    final state = Directory(p.join(root.path, 'private-state'));
    final output = StringBuffer();
    final errors = StringBuffer();
    expect(
      await runAmbient(
        ['--client-file', client.path, '--output-dir', parent.path],
        defaultStateDirectory: state.path,
        output: output,
        errors: errors,
      ),
      1,
      reason: errors.toString(),
    );
    expect(output.toString(), contains('Результаты: '));
    expect(output.toString(), contains('Код результата: 1;'));
    expect(
      errors.toString(),
      contains('Ошибка на этапе authorization: OAuth JSON должен содержать client_id и client_secret'),
    );
    expect('${output.toString()}${errors.toString()}', isNot(contains('test-secret')));
    expect(parent.statSync().mode & 0x1ff, 0x1ed);
    expect(state.statSync().mode & 0x1ff, 0x1c0);
    final run = parent.listSync().whereType<Directory>().single;
    expect(run.statSync().mode & 0x1ff, 0x1c0);
    expect(File(p.join(run.path, 'report.json')).statSync().mode & 0x1ff, 0x180);
    saveAmbientJson(File(p.join(parent.path, 'result.json')), {'complete': true});
    expect(parent.statSync().mode & 0x1ff, 0x1ed);
    expect(File(p.join(parent.path, 'result.json')).statSync().mode & 0x1ff, 0x180);
  });
  test('CLI help needs no credentials or network and invalid limits are usage errors', () async {
    final helpOutput = StringBuffer();
    final helpErrors = StringBuffer();
    expect(
      await runAmbient(
        ['--help'],
        defaultStateDirectory: p.join(root.path, 'state'),
        output: helpOutput,
        errors: helpErrors,
      ),
      0,
      reason: helpErrors.toString(),
    );
    expect(helpOutput.toString(), startsWith('Usage: dslideshow_tools ambient [options]\n'));
    expect(helpOutput.toString(), contains('--client-file'));
    expect(helpErrors.toString(), isEmpty);
    final invalidOutput = StringBuffer();
    final invalidErrors = StringBuffer();
    expect(
      await runAmbient(
        ['--client-file', client.path, '--page-size', '101'],
        defaultStateDirectory: p.join(root.path, 'state'),
        output: invalidOutput,
        errors: invalidErrors,
      ),
      64,
      reason: invalidErrors.toString(),
    );
    expect(invalidOutput.toString(), isEmpty);
    expect(invalidErrors.toString(), startsWith('Invalid counts, limits or display name; see --help\n'));
    expect(invalidErrors.toString(), contains('--page-size'));
    expect('${helpOutput.toString()}${invalidErrors.toString()}', isNot(contains('test-secret')));
  });
  test('CLI injected output retains stage diagnostics and redacts credentials and authorized URLs', () async {
    final output = StringBuffer();
    final errors = StringBuffer();
    final transport = FakeHttp([
      ApiError(403, {
        'error': {
          'status': 'PERMISSION_DENIED',
          'message': 'Denied test-secret https://private.test/signed?token=private-token',
        },
      }),
    ]);
    expect(
      await runAmbient(
        ['--client-file', client.path],
        defaultStateDirectory: p.join(root.path, 'state'),
        http: transport,
        output: output,
        errors: errors,
      ),
      1,
      reason: errors.toString(),
    );
    expect(output.toString(), contains('Код результата: 1;'));
    expect(errors.toString(), contains('Ошибка на этапе authorization: '));
    expect(errors.toString(), contains('PERMISSION_DENIED'));
    expect(errors.toString(), contains('[redacted]'));
    expect(errors.toString(), contains('[url]'));
    for (final secret in ['test-secret', 'private.test', 'private-token']) {
      expect('${output.toString()}${errors.toString()}', isNot(contains(secret)));
    }
  });
}
