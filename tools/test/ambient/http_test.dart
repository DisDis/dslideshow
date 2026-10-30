import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dslideshow_tools/src/ambient/cli.dart';
import 'package:dslideshow_tools/src/ambient/probe.dart';
import 'package:dslideshow_tools/src/repository.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart' as p;
import 'package:test/test.dart';

import '../support/ambient_loopback.dart';
import 'probe_test.dart' show photo, video, clientJson;

void main() {
  late HttpServer server;
  late Directory root;
  late File client;
  late List<Map<String, Object?>> requests;
  late bool photosOnly;
  late String redirect;
  late Completer<void> hangingRequest;
  late bool hangMedia;
  late StreamSubscription<HttpRequest> subscription;
  AmbientHttp transport() => AmbientHttp(client: AmbientLoopbackClient(server.port));

  setUp(() async {
    root = Directory.systemTemp.createTempSync('ambient-http-');
    client = File(p.join(root.path, 'client.json'))..writeAsStringSync(jsonEncode(clientJson));
    requests = [];
    photosOnly = false;
    redirect = 'https://attacker.invalid/collect';
    hangingRequest = Completer<void>();
    hangMedia = false;
    server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
    subscription = server.listen((request) async {
      final bytes = await request.fold<List<int>>([], (all, chunk) => all..addAll(chunk));
      requests.add({
        'method': request.method,
        'path': request.uri.toString(),
        'authorization': request.headers.value('authorization'),
        'body': utf8.decode(bytes),
      });
      void reply(Object value, {String mime = 'application/json', int status = 200}) {
        final body = value is List<int> ? value : utf8.encode(jsonEncode(value));
        request.response.statusCode = status;
        request.response.headers.set(HttpHeaders.contentTypeHeader, mime);
        request.response.contentLength = body.length;
        request.response.add(body);
        unawaited(request.response.close());
      }

      switch ((request.method, request.uri.path)) {
        case ('POST', '/device/code'):
          reply({
            'device_code': 'secret-device-code',
            'user_code': 'CODE',
            'verification_url': 'https://www.google.com/device',
            'expires_in': 10,
            'interval': 0.001,
          });
        case ('POST', '/token'):
          reply({
            'access_token': 'secret-access-token',
            'refresh_token': 'secret-refresh',
            'scope': ambientScope,
            'expires_in': 3600,
          });
        case ('POST', '/v1/devices'):
          reply({
            'id': 'created-device',
            'mediaSourcesSet': false,
            'settingsUri': 'https://photos.google.com/settings',
            'pollingConfig': {'pollInterval': '0.001s'},
          });
        case ('GET', '/v1/devices/created-device'):
          reply({
            'id': 'created-device',
            'mediaSourcesSet': true,
            'mediaSources': [
              {'id': 'album', 'displayName': 'Test album'},
            ],
          });
        case ('GET', '/v1/mediaItems'):
          reply({
            'mediaItems': photosOnly ? [photo] : [photo, video],
          });
        case ('GET', '/photo=d'):
          if (hangMedia) {
            request.response.headers.contentType = ContentType('image', 'jpeg');
            request.response.add([255, 216, 255]);
            await request.response.flush();
            hangingRequest.complete();
          } else {
            reply([255, 216, 255, ...utf8.encode('jpeg-test')], mime: 'image/jpeg');
          }
        case ('GET', '/video=dv'):
          reply([0, 0, 0, 24, ...ascii.encode('ftypmp42video-test')], mime: 'video/mp4');
        case ('GET', '/redirect'):
          request.response.statusCode = 302;
          request.response.headers.set(HttpHeaders.locationHeader, redirect);
          request.response.contentLength = 0;
          unawaited(request.response.close());
        case ('GET', '/bad-json'):
          reply(utf8.encode('<html>error</html>'), mime: 'text/html');
        case ('GET', '/large-json'):
          reply(List.filled(jsonLimit + 1, 32));
        case ('GET', '/hang'):
          hangingRequest.complete();
        case ('GET', '/hang-json-body'):
        case ('GET', '/hang-error-body'):
          if (request.uri.path == '/hang-error-body') request.response.statusCode = 403;
          request.response.headers.contentType = ContentType.json;
          request.response.add(utf8.encode('{'));
          await request.response.flush();
          hangingRequest.complete();
        case ('DELETE', '/v1/devices/created-device'):
          request.response.statusCode = 204;
          unawaited(request.response.close());
        case ('DELETE', '/v1/devices/missing-request'):
          reply({
            'error': {'status': 'NOT_FOUND'},
          }, status: 404);
        default:
          reply({
            'error': {
              'status': 'PERMISSION_DENIED',
              'message': 'Denied test-secret https://private.test/secret',
              'details': [
                {'reason': 'ACCESS_TOKEN_SCOPE_INSUFFICIENT'},
              ],
            },
          }, status: 403);
      }
    });
  });
  tearDown(() async {
    await subscription.cancel();
    await server.close(force: true);
    root.deleteSync(recursive: true);
  });

  Future<({int status, Map<String, dynamic> report, Directory output, List<String> messages})> cli([
    List<String> extra = const [],
  ]) async {
    final messages = <String>[];
    var now = 0.0;
    final state = p.join(root.path, 'state');
    final status = await runAmbient(
      ['--client-file', client.path, '--state-dir', state, ...extra],
      http: transport(),
      defaultStateDirectory: state,
      say: messages.add,
      monotonic: () => now,
      wall: () => now,
      sleep: (duration) async {
        now += duration.inMicroseconds / 1000000;
      },
    );
    final runs = Directory(p.join(state, 'runs')).listSync().whereType<Directory>().toList()
      ..sort((a, b) => a.path.compareTo(b.path));
    final output = runs.last;
    return (
      status: status,
      report: jsonDecode(File(p.join(output.path, 'report.json')).readAsStringSync()) as Map<String, dynamic>,
      output: output,
      messages: messages,
    );
  }

  test('full CLI performs real OAuth, creates/selects/lists/downloads and reuses device', () async {
    final run = await cli();
    expect(run.status, 0);
    expect(run.report['source']['id'], 'album');
    expect((run.report['downloads'] as List).map((d) => d['kind']), unorderedEquals(['photo', 'video']));
    for (final item in run.report['downloads'] as List) {
      final file = File(p.join(run.output.path, item['file'] as String));
      expect(file.lengthSync(), item['bytes']);
      expect(file.statSync().mode & 0x1ff, 0x180);
    }
    expect(run.messages.join('\n'), isNot(contains('secret-access-token')));
    expect(jsonEncode(run.report), isNot(contains('secret-refresh')));
    expect(File(p.join(run.output.path, 'media.json')).readAsStringSync(), isNot(contains('baseUrl')));
    final creates = requests
        .where((r) => r['method'] == 'POST' && (r['path'] as String).startsWith('/v1/devices'))
        .toList();
    expect(creates, hasLength(1));
    expect(creates.single['path'], contains('requestId='));
    expect(jsonDecode(File(p.join(root.path, 'state/state.json')).readAsStringSync())['device_id'], 'created-device');
    expect((await cli()).status, 0);
    expect(
      requests.where((r) => r['method'] == 'POST' && (r['path'] as String).startsWith('/v1/devices')),
      hasLength(1),
    );
  });
  test('no returned video makes CLI incomplete rather than successful', () async {
    photosOnly = true;
    final run = await cli();
    expect(run.status, 2);
    expect(run.report['counts']['video'], 0);
    expect(run.report['errors'], contains(equals({'kind': 'video', 'wanted': 1, 'downloaded': 0})));
  });
  test('delete invokes real DELETE and clears only owned identity', () async {
    await cli();
    final run = await cli(['--delete-device']);
    expect(run.status, 0);
    expect(requests.any((r) => r['method'] == 'DELETE' && r['path'] == '/v1/devices/created-device'), isTrue);
    final state = jsonDecode(File(p.join(root.path, 'state/state.json')).readAsStringSync()) as Map;
    expect(state, isNot(contains('device_id')));
    expect(state, contains('refresh_token'));
  });
  test('delete can recover saved request ID after lost create response; NOT_FOUND accepted', () async {
    final file = File(p.join(root.path, 'state/state.json'));
    saveAmbientJson(file, {
      'client_id': 'test-client',
      'access_token': 'access',
      'expires_at': 3600,
      'refresh_token': 'refresh',
      'request_id': 'missing-request',
      'source_id': 'album',
    });
    final run = await cli(['--delete-device']);
    expect(run.status, 0);
    final state = jsonDecode(file.readAsStringSync()) as Map;
    expect(state, isNot(contains('request_id')));
    expect(state['refresh_token'], 'refresh');
  });
  test('untrusted redirect receives no bearer token and trusted media redirect is followed', () async {
    final client = transport();
    addTearDown(client.close);
    await expectLater(
      client.open(
        'https://lh3.googleusercontent.com/redirect',
        media: true,
        headers: {'Authorization': 'Bearer private-token'},
      ),
      throwsA(isA<ProbeError>()),
    );
    expect(requests, hasLength(1));
    expect(requests.single['path'], '/redirect');
    redirect = 'https://lh4.googleusercontent.com/photo=d';
    final response = await client.open('https://lh3.googleusercontent.com/redirect', media: true);
    expect(await response.stream.toBytes(), [255, 216, 255, ...utf8.encode('jpeg-test')]);
    expect(requests, hasLength(3));
  });
  test('API redirects are refused; error reasons survive safe diagnostics', () async {
    final client = transport();
    addTearDown(client.close);
    client.secrets.add('test-secret');
    await expectLater(
      client.json('https://photosambient.googleapis.com/redirect'),
      throwsA(isA<ApiError>().having((e) => e.status, 'status', 302)),
    );
    try {
      await client.json('https://photosambient.googleapis.com/denied');
      fail('Unexpected success');
    } on ApiError catch (error) {
      expect(error.status, 403);
      final message = client.clean(error);
      expect(message, contains('ACCESS_TOKEN_SCOPE_INSUFFICIENT'));
      expect(message, isNot(contains('test-secret')));
      expect(message, isNot(contains('private.test')));
    }
  });
  test('bad JSON and bounded JSON response fail with closed HTTP streams', () async {
    final client = transport();
    addTearDown(client.close);
    await expectLater(client.json('https://photosambient.googleapis.com/bad-json'), throwsA(isA<ProbeError>()));
    await expectLater(client.json('https://photosambient.googleapis.com/large-json'), throwsA(isA<ProbeError>()));
    // A later response on the same client still completes after both failures.
    await expectLater(client.json('https://photosambient.googleapis.com/denied'), throwsA(isA<ApiError>()));
  });
  test('request timeout aborts a real pending request and client remains usable', () async {
    final client = transport();
    addTearDown(client.close);
    final failed = expectLater(
      client.open('https://photosambient.googleapis.com/hang', requestTimeout: const Duration(milliseconds: 100)),
      throwsA(isA<ProbeError>()),
    );
    await hangingRequest.future.timeout(const Duration(seconds: 2));
    await failed;
    await expectLater(client.json('https://photosambient.googleapis.com/denied'), throwsA(isA<ApiError>()));
  });
  for (final path in ['hang-json-body', 'hang-error-body']) {
    test('short request timeout also bounds pending $path after headers arrive', () async {
      final client = transport();
      addTearDown(client.close);
      expect(client.timeout, const Duration(seconds: 30));
      final failed = expectLater(
        client.json('https://photosambient.googleapis.com/$path', requestTimeout: const Duration(milliseconds: 100)),
        throwsA(isA<TimeoutException>()),
      );
      await hangingRequest.future.timeout(const Duration(seconds: 3));
      await failed.timeout(const Duration(seconds: 3));
    });
    test('cancellation while reading $path remains interruption after headers arrive', () async {
      final client = transport();
      addTearDown(client.close);
      final failed = expectLater(
        client.json('https://photosambient.googleapis.com/$path'),
        throwsA(isA<ProbeInterrupted>()),
      );
      await hangingRequest.future.timeout(const Duration(seconds: 3));
      client.close();
      await failed.timeout(const Duration(seconds: 3));
    });
  }
  for (final (signal, expected) in [(ProcessSignal.sigint, 130), (ProcessSignal.sigterm, 143)]) {
    test('CLI preserves exit $expected on a real signal during a pending media body', () async {
      hangMedia = true;
      final state = Directory(p.join(root.path, 'cancel-state'));
      final process = await Process.start(findDartExecutable(), [
        '--suppress-analytics',
        'run',
        'test/support/ambient_cancel_fixture.dart',
        '${server.port}',
        client.path,
        state.path,
      ]);
      final output = process.stdout.transform(utf8.decoder).join();
      final errors = process.stderr.transform(utf8.decoder).join();
      addTearDown(() async {
        process.kill(ProcessSignal.sigkill);
        await process.exitCode;
      });
      await hangingRequest.future.timeout(const Duration(seconds: 10));
      expect(process.kill(signal), isTrue);
      expect(await process.exitCode.timeout(const Duration(seconds: 5)), expected);
      final text = '${await output}\n${await errors}';
      expect(text, isNot(contains('secret-access-token')));
      expect(text, isNot(contains('secret-refresh')));
      final run = Directory(p.join(state.path, 'runs')).listSync().whereType<Directory>().single;
      final report = jsonDecode(File(p.join(run.path, 'report.json')).readAsStringSync()) as Map;
      expect(report['exit_code'], expected);
      expect(report['errors'], [
        {'error': 'Interrupted by user'},
      ]);
      expect(run.listSync().whereType<File>().any((file) => p.extension(file.path) == '.part'), isFalse);
    });
  }
  test('CLI logs connect operation with outcome and never attach secret transport exceptions', () async {
    final records = <LogRecord>[];
    final old = Logger.root.level;
    Logger.root.level = Level.ALL;
    final capture = Logger.root.onRecord.listen(records.add);
    addTearDown(() async {
      await capture.cancel();
      Logger.root.level = old;
    });
    final run = await cli();
    expect(run.status, 0);
    final logs = records.where((r) => r.loggerName == 'ambient').toList();
    expect(logs.any((r) => r.message.contains('result=started') && r.message.contains('operation=')), isTrue);
    expect(logs.any((r) => r.message.contains('result=finished') && r.message.contains('success=2')), isTrue);
    expect(logs.every((r) => r.error == null), isTrue);
    expect(logs.map((r) => r.message).join('\n'), isNot(contains('secret-access-token')));
    expect(logs.map((r) => r.message).join('\n'), isNot(contains('secret-refresh')));
  });
}
