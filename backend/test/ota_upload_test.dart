import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart' as crypto;
import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_backend/src/service/ota/ota_installer.dart';
import 'package:dslideshow_backend/src/service/ota/ota_page.dart';
import 'package:dslideshow_backend/src/service/ota/ota_page_localizations.dart';
import 'package:dslideshow_backend/src/service/ota/ota_service.dart';
import 'package:dslideshow_backend/src/service/ota/release_info.dart';
import 'package:dslideshow_backend/src/service/upload/streaming_upload.dart';
import 'package:dslideshow_common/rpc.dart';
import 'package:dslideshow_common/version.dart';
import 'package:fake_async/fake_async.dart';
import 'package:path/path.dart' as path;
import 'package:pub_semver/pub_semver.dart';
import 'package:shelf/shelf.dart';
import 'package:test/test.dart';

import 'helpers/capture_logs.dart';

const _boundary = 'ota-test-boundary';
final _inputTag = RegExp(r'<input\b[^>]*>');
final _formTag = RegExp(r'<form\b[^>]*>');
final _scriptTag = RegExp(r'<script>(.*?)</script>', dotAll: true);
final _codeConstraint = RegExp(r'\b(?:pattern|minlength|maxlength|inputmode)\s*=');

String _field(String name, String value) =>
    '--$_boundary\r\n'
    'Content-Disposition: form-data; name="$name"\r\n\r\n'
    '$value\r\n';

String _fileHeader([String filename = 'update.deb']) =>
    '--$_boundary\r\n'
    'Content-Disposition: form-data; name="file"; filename="$filename"\r\n'
    'Content-Type: application/octet-stream\r\n\r\n';

List<int> _multipart(
  String code, {
  String filename = 'update.deb',
  String data = 'package contents',
  String extra = '',
}) => utf8.encode(
  '${_field('code', code)}${_fileHeader(filename)}$data\r\n'
  '$extra--$_boundary--\r\n',
);

Request _request(Stream<List<int>> body, {int? contentLength, String endpoint = '/ota_upload', String? accept}) =>
    Request(
      'POST',
      Uri.parse('http://localhost$endpoint'),
      headers: {
        'content-type': 'multipart/form-data; boundary=$_boundary',
        if (contentLength != null) 'content-length': '$contentLength',
        if (accept != null) 'accept': accept,
      },
      body: body,
    );

Future<void> _until(bool Function() condition) async {
  final watch = Stopwatch()..start();
  while (!condition()) {
    if (watch.elapsed > const Duration(seconds: 3)) {
      fail('Timed out waiting for asynchronous OTA state');
    }
    await Future<void>.delayed(const Duration(milliseconds: 1));
  }
}

class _Remote implements RemoteService {
  final infos = <OTAInfo>[];
  final progressTimes = <int>[];
  final watch = Stopwatch()..start();
  bool failSends = false;
  Completer<RpcResult>? blockedReady;
  bool readyRequested = false;
  Completer<RpcResult>? blockedAll;
  final commands = <RpcCommand>[];

  @override
  Future<RpcResult> send<T extends RpcCommand>(T command) async {
    commands.add(command);
    if (failSends) throw StateError('frontend disconnected');
    if (command is OTAReadyCommand && blockedReady != null) {
      readyRequested = true;
      return blockedReady!.future;
    }
    if (command is OTAGetInfoCommand && command.info != null) {
      infos.add(command.info!);
      if (command.info!.status == OTAStatus.uploading &&
          command.info!.uploadingPercent > 0 &&
          command.info!.uploadingPercent < 100) {
        progressTimes.add(watch.elapsedMicroseconds);
      }
    }
    return blockedAll?.future ?? EmptyResult.respond(command);
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _Installer implements FirmwareInstaller {
  final files = <String>[];
  final data = <List<int>>[];
  Completer<int>? pending;
  Object? installError;
  Object? restartError;
  int exitCode = 1;
  int restarts = 0;
  void Function(String)? emitOutput;

  @override
  Future<int> install(File package, {required void Function(String) onOutput}) async {
    files.add(package.path);
    data.add(await package.readAsBytes());
    emitOutput = onOutput;
    onOutput('fake installer output');
    if (installError case final error?) throw error;
    return pending?.future ?? exitCode;
  }

  @override
  Future<void> restart() async {
    restarts++;
    if (restartError case final error?) throw error;
  }
}

enum _Fault { none, write, flush, close }

class _Writer implements UploadFileWriter {
  final RandomAccessFile file;
  final _Fault fault;
  final Completer<void> closeEntered = Completer<void>();
  final Completer<void>? closeGate;
  final Completer<void>? firstWrite;

  _Writer(this.file, {this.fault = _Fault.none, this.closeGate, this.firstWrite});

  FileSystemException get _noSpace => const FileSystemException('full', '', OSError('No space left', 28));

  @override
  Future<void> write(List<int> bytes) async {
    if (fault == _Fault.write) throw _noSpace;
    await file.writeFrom(bytes);
    if (firstWrite != null && !firstWrite!.isCompleted) firstWrite!.complete();
  }

  @override
  Future<void> flush() async {
    if (fault == _Fault.flush) throw _noSpace;
    await file.flush();
  }

  @override
  Future<void> close() async {
    closeEntered.complete();
    await closeGate?.future;
    await file.close();
    if (fault == _Fault.close) throw _noSpace;
  }
}

void main() {
  late Directory directory;
  late _Remote remote;
  late _Installer installer;
  final services = <OTAService>[];

  OTAService service({
    UploadLimits limits = const UploadLimits(maxFiles: 1, maxParts: 2),
    UploadWriterFactory? writerFactory,
    StreamingUploadReceiver? configUploadReceiver,
    Future<ReleaseInfo?> Function()? latestRelease,
    HttpClient Function()? downloadClientFactory,
    Duration restartDelay = const Duration(seconds: 5),
    Duration autostopDelay = const Duration(minutes: 5),
    Duration networkTimeout = const Duration(seconds: 60),
    bool alwaysEnabled = true,
    int port = 0,
  }) {
    final config = AppConfig.fromJson({
      'ota': {'alwaysEnabled': alwaysEnabled, 'autoUpdateEnabled': false},
    })..fullConfigFilename = path.join(directory.path, 'config.json');
    final result = OTAService(
      config: config,
      frontendService: remote,
      startServer: false,
      firmwareDirectory: directory,
      installer: installer,
      uploadReceiver: StreamingUploadReceiver(limits: limits, writerFactory: writerFactory),
      configUploadReceiver: configUploadReceiver,
      latestRelease: latestRelease,
      downloadClientFactory: downloadClientFactory,
      restartDelay: restartDelay,
      autostopDelay: autostopDelay,
      networkTimeout: networkTimeout,
      port: port,
    );
    services.add(result);
    return result;
  }

  Future<void> closeService(OTAService service) async {
    if (services.remove(service)) await service.close();
  }

  Future<Response> upload(OTAService ota, {String data = 'package contents'}) async {
    return ota.handler(_request(Stream.value(_multipart(ota.code, data: data))));
  }

  setUp(() async {
    directory = await Directory.systemTemp.createTemp('ota-upload-test-');
    remote = _Remote();
    installer = _Installer();
  });

  tearDown(() async {
    for (final ota in services.toList()) {
      await closeService(ota);
    }
    services.clear();
    await directory.delete(recursive: true);
  });

  for (final (endpoint, action, fileType) in [
    ('/ota_start', '/ota_upload', '.deb'),
    ('/ota_download_config', '/ota_download_config', null),
    ('/ota_upload_config', '/ota_upload_config', '.json'),
  ]) {
    test('$endpoint provides an autonomous native form and slideshow exit', () async {
      final ota = service();
      final response = await ota.handler(Request('GET', Uri.parse('http://localhost$endpoint')));
      final html = await response.readAsString();
      expect(response.statusCode, 200);
      expect(response.headers['content-type'], contains('text/html'));
      expect(response.headers['cache-control'], 'no-store');
      expect(html, contains('<html lang="en">'));
      expect(html, contains('DSlideshow · OTA'));
      expect(html, contains(' · DSlideshow</title>'));
      expect(html, contains('frontend: <strong class="version-number">${ApplicationInfo.frontendVersion}</strong>'));
      expect(html, contains('backend: <strong class="version-number">${ApplicationInfo.backendVersion}</strong>'));
      final form = _formTag.firstMatch(html)!.group(0)!;
      expect(form, contains('method="post"'));
      expect(form, contains('action="$action"'));
      final inputs = _inputTag.allMatches(html).map((match) => match.group(0)!).toList();
      final code = inputs.singleWhere((input) => input.contains('name="code"'));
      expect(code, contains('type="text"'));
      expect(_codeConstraint.hasMatch(code), isFalse, reason: 'Codes can contain arbitrary text');
      if (fileType != null) {
        final file = inputs.singleWhere((input) => input.contains('name="file"'));
        expect(form, contains('enctype="multipart/form-data"'));
        expect(file, contains('accept="$fileType"'));
        expect(file, isNot(contains('multiple')));
        expect(html.indexOf(code), lessThan(html.indexOf(file)));
      }
      expect(html, contains('href="/ota_stop"'));
      expect(html, isNot(contains('src="http')));
      expect(html, isNot(contains('href="http')));
      if (endpoint == '/ota_start') {
        expect(html, contains('href="/ota_download_config"'));
        expect(html, contains('href="/ota_upload_config"'));
        expect(html, contains('data-uploading-label="Uploading…"'));
        final scripts = _scriptTag.allMatches(html).toList();
        expect(scripts, hasLength(1));
        final scriptHash = base64.encode(crypto.sha256.convert(utf8.encode(scripts.single.group(1)!)).bytes);
        expect(response.headers['content-security-policy'], contains("script-src 'sha256-$scriptHash'"));
      } else {
        expect(html, isNot(contains('<script')));
        expect(response.headers['content-security-policy'], isNot(contains('script-src')));
      }
    });
  }

  test('browser language preferences select RU while unsupported languages use EN', () async {
    final ota = service();
    final response = await ota.handler(
      Request('GET', Uri.parse('http://localhost/ota_start'), headers: {'accept-language': 'ru-RU, en;q=0.5'}),
    );
    final html = await response.readAsString();
    expect(html, contains('<html lang="ru">'));
    expect(html, contains('Отменить и вернуться к слайдшоу'));
    expect(html, contains('data-uploading-label="Загрузка…"'));
    expect(html, contains('DSlideshow · OTA'));
    expect(html, contains('frontend: <strong class="version-number">${ApplicationInfo.frontendVersion}</strong>'));
    expect(html, contains('backend: <strong class="version-number">${ApplicationInfo.backendVersion}</strong>'));
    for (final (header, expected) in <(String?, OtaPageLanguage)>[
      (null, OtaPageLanguage.en),
      ('fr', OtaPageLanguage.en),
      ('en;q=0.5,ru;q=0.9', OtaPageLanguage.ru),
      ('ru;q=0,en;q=1', OtaPageLanguage.en),
      ('en;q=0,*;q=1', OtaPageLanguage.ru),
      ('ru;q=NaN', OtaPageLanguage.en),
    ]) {
      expect(otaPageLanguage(header), expected, reason: '$header');
    }
  });

  test('result pages escape interpolated content and versions', () {
    final html = renderOtaResultPage(
      frontendVersion: '<img src=x>',
      backendVersion: '"<&',
      language: OtaPageLanguage.en,
      title: '<script>title</script>',
      message: '<b>message</b>',
      error: true,
    );
    expect(html, contains('&lt;script&gt;title&lt;/script&gt;'));
    expect(html, contains('&lt;b&gt;message&lt;/b&gt;'));
    expect(html, isNot(contains('<script>')));
    expect(html, isNot(contains('<img src=x>')));
  });

  test('return to slideshow sends the exit command and preserves plain API response', () async {
    final ota = service();
    final response = await ota.handler(Request('GET', Uri.parse('http://localhost/ota_stop')));
    expect(await response.readAsString(), 'Return to normal mode');
    expect(remote.commands.whereType<OTAReadyCommand>().single.ready, isFalse);
    final htmlResponse = await ota.handler(
      Request('GET', Uri.parse('http://localhost/ota_stop'), headers: {'accept': 'text/html'}),
    );
    expect(htmlResponse.statusCode, 200);
    final html = await htmlResponse.readAsString();
    expect(htmlResponse.headers['content-type'], contains('text/html'));
    expect(html, contains('href="/ota_start"'));
    expect(html, isNot(contains('href="/ota_stop"')));
  });

  test('configuration download returns original damaged bytes as an attachment after authorization', () async {
    final ota = service();
    final original = [0xff, ...utf8.encode('{broken config')];
    await File(ota.config.fullConfigFilename).writeAsBytes(original);
    Request download(String code) => Request(
      'POST',
      Uri.parse('http://localhost/ota_download_config'),
      body: Uri(queryParameters: {'code': code}).query,
    );
    final response = await ota.handler(download(ota.code));
    expect(response.statusCode, 200);
    expect(await response.read().expand((bytes) => bytes).toList(), original);
    expect(response.headers['content-disposition'], 'attachment; filename="config.json"');
    expect(response.headers['cache-control'], 'no-store');
    final denied = await ota.handler(download('wrong'));
    expect(denied.statusCode, 403);
    expect(await denied.readAsString(), 'Incorrect code');
    final missing = await ota.handler(Request('POST', Uri.parse('http://localhost/ota_download_config'), body: ''));
    expect(missing.statusCode, 400);
    final repeated = await ota.handler(
      Request('POST', Uri.parse('http://localhost/ota_download_config'), body: 'code=${ota.code}&code=${ota.code}'),
    );
    expect(repeated.statusCode, 400);
    await File(ota.config.fullConfigFilename).delete();
    final unavailable = await ota.handler(download(ota.code));
    expect(unavailable.statusCode, 500);
    expect(await unavailable.readAsString(), isNot(contains(directory.path)));
    final htmlUnavailable = await ota.handler(
      Request(
        'POST',
        Uri.parse('http://localhost/ota_download_config'),
        headers: {'accept': 'text/html'},
        body: 'code=${ota.code}',
      ),
    );
    expect(htmlUnavailable.statusCode, 500);
    expect(await htmlUnavailable.readAsString(), contains('The saved configuration could not be read.'));
  });

  test('configuration import changes saved bytes while active services and installer remain untouched', () async {
    final ota = service();
    final oldPort = ota.config.webServer.port;
    const content = '{"web":{"port":8123},"future-setting":"keep"}\n';
    final response = await ota.handler(
      _request(
        Stream.value(_multipart(ota.code, filename: 'config.json', data: content)),
        endpoint: '/ota_upload_config',
      ),
    );
    expect(response.statusCode, 200);
    expect(await response.readAsString(), 'Config updated');
    expect(await File(ota.config.fullConfigFilename).readAsString(), content);
    expect(ota.config.webServer.port, oldPort);
    expect(ota.busy, isFalse);
    expect(installer.files, isEmpty);
    expect(installer.restarts, 0);
    final rejected = await ota.handler(
      _request(
        Stream.value(_multipart(ota.code, filename: 'config.json', data: '{bad')),
        endpoint: '/ota_upload_config',
        accept: 'text/html',
      ),
    );
    expect(rejected.statusCode, 400);
    expect(rejected.headers['content-type'], contains('text/html'));
    expect(await rejected.readAsString(), contains('href="/ota_start"'));
    expect(await File(ota.config.fullConfigFilename).readAsString(), content);
    expect(ota.busy, isFalse);
  });

  test('closing a pending configuration transfer cancels input and retains the previous file', () async {
    final ota = service();
    const oldConfig = '{"web":{"port":8081}}';
    await File(ota.config.fullConfigFilename).writeAsString(oldConfig);
    final body = StreamController<List<int>>();
    addTearDown(() => body.close());
    final pending = ota.handler(_request(body.stream, endpoint: '/ota_upload_config'));
    body.add(utf8.encode('${_field('code', ota.code)}${_fileHeader('config.json')}{'));
    expect(ota.busy, isTrue);
    expect((await upload(ota)).statusCode, 409);
    await closeService(ota);
    expect((await pending).statusCode, 408);
    expect(await File(ota.config.fullConfigFilename).readAsString(), oldConfig);
    expect(ota.busy, isFalse);
    expect(directory.listSync().map((entry) => path.basename(entry.path)), ['config.json']);
    expect((await ota.handler(Request('GET', Uri.parse('http://localhost/ota_start')))).statusCode, 503);
  });

  test('HTTP remains usable while a frontend notification is in flight', () async {
    remote.blockedAll = Completer<RpcResult>();
    addTearDown(() => remote.blockedAll!.complete(const EmptyResult(id: 1)));
    final ota = service();
    await ota.start();
    final client = HttpClient();
    addTearDown(() => client.close(force: true));
    final request = await client.getUrl(Uri.parse('http://127.0.0.1:${ota.boundPort}/ota_start'));
    final response = await request.close();
    expect(response.statusCode, 200);
    expect(await utf8.decoder.bind(response).join(), contains('action="/ota_upload"'));
    expect(remote.commands, hasLength(1));
    final configRequest = await client.getUrl(Uri.parse('http://127.0.0.1:${ota.boundPort}/ota_upload_config'));
    final configResponse = await configRequest.close();
    expect(configResponse.statusCode, 200);
    await configResponse.drain<void>();
    await closeService(ota);
    expect(ota.boundPort, isNull);
  });

  test('failed bind leaves the lifecycle queue reusable and retry clears the startup error', () async {
    final occupied = await ServerSocket.bind(InternetAddress.anyIPv4, 0);
    addTearDown(() => occupied.close());
    final ota = service(port: occupied.port, alwaysEnabled: false);
    ota.enabled = true;
    await _until(() => ota.info.status == OTAStatus.issue);
    expect(ota.enabled, isFalse);
    expect(ota.boundPort, isNull);
    expect(ota.info.errorText, isNotNull);
    await occupied.close();
    await ota.start();
    expect(ota.enabled, isTrue);
    expect(ota.boundPort, isNotNull);
    expect(ota.info.status, OTAStatus.ready);
    expect(ota.info.errorText, isNull);
  });

  test('unknown Content-Length saves one package before HTTP 200 and install', () async {
    final ota = service();
    final response = await ota.handler(_request(Stream.value(_multipart(ota.code)), accept: 'text/html'));
    expect(response.statusCode, 200);
    expect(response.headers['content-type'], contains('text/html'));
    final html = await response.readAsString();
    expect(html, contains('The file was received and passed to the installer.'));
    expect(html, isNot(contains('href="/ota_stop"')));
    await _until(() => installer.data.isNotEmpty);
    expect(installer.data.single, utf8.encode('package contents'));
    expect(installer.files.single, path.join(directory.path, 'update.deb'));
    expect(directory.listSync().whereType<File>().length, 1);
    expect(remote.infos.every((info) => info.uploadingPercent.isFinite), isTrue);
    await _until(() => remote.infos.any((info) => info.uploadingPercent == 100));
  });

  test('success and installer both wait for writer close and rename', () async {
    final gate = Completer<void>();
    addTearDown(() {
      if (!gate.isCompleted) gate.complete();
    });
    final created = Completer<_Writer>();
    final ota = service(
      writerFactory: (file) async {
        final writer = _Writer(await file.open(mode: FileMode.write), closeGate: gate);
        created.complete(writer);
        return writer;
      },
    );
    var responded = false;
    final response = upload(ota).then((response) {
      responded = true;
      return response;
    });
    final writer = await created.future;
    await writer.closeEntered.future;
    expect(responded, isFalse);
    expect(installer.files, isEmpty);
    expect(File(path.join(directory.path, 'update.deb')).existsSync(), isFalse);
    gate.complete();
    expect((await response).statusCode, 200);
    await _until(() => installer.data.isNotEmpty);
    expect(installer.data.single, utf8.encode('package contents'));
  });

  for (final codeFirst in [true, false]) {
    test('rejects ${codeFirst ? 'wrong code' : 'file before code'} before reading file body', () async {
      var readBody = false;
      var createdWriter = false;
      final ota = service(
        writerFactory: (file) async {
          createdWriter = true;
          return _Writer(await file.open(mode: FileMode.write));
        },
      );
      Stream<List<int>> body() async* {
        yield utf8.encode('${codeFirst ? _field('code', 'wrong') : ''}${_fileHeader()}');
        readBody = true;
        yield utf8.encode('large file\r\n--$_boundary--\r\n');
      }

      final original = ota.info;
      final response = await ota.handler(_request(body()));
      expect(response.statusCode, 403);
      expect(readBody, isFalse);
      expect(createdWriter, isFalse);
      expect(identical(ota.info, original), isTrue);
      expect(ota.busy, isFalse);
    });
  }

  test('large wrong-code HTTP upload returns a complete HTML error without resetting the connection', () async {
    var createdWriter = false;
    final ota = service(
      writerFactory: (file) async {
        createdWriter = true;
        return _Writer(await file.open(mode: FileMode.write));
      },
    );
    await ota.start();
    final client = HttpClient();
    addTearDown(() => client.close(force: true));
    final endpoint = Uri.parse('http://127.0.0.1:${ota.boundPort}/ota_upload');
    final request = await client.postUrl(endpoint);
    request.headers.set(HttpHeaders.acceptHeader, 'text/html');
    request.headers.set(HttpHeaders.acceptLanguageHeader, 'en');
    request.headers.set(HttpHeaders.contentTypeHeader, 'multipart/form-data; boundary=$_boundary');
    final prefix = utf8.encode('${_field('code', 'wrong-access-code')}${_fileHeader()}');
    final suffix = utf8.encode('\r\n--$_boundary--\r\n');
    const fileBytes = 32 * 1024 * 1024;
    final chunk = List<int>.filled(64 * 1024, 1);
    request.contentLength = prefix.length + fileBytes + suffix.length;
    Stream<List<int>> body() async* {
      yield prefix;
      for (var sent = 0; sent < fileBytes; sent += chunk.length) {
        yield chunk;
      }
      yield suffix;
    }

    // Exceed socket buffers so the wrong code is rejected during transmission,
    // rather than after a small body has already arrived at the server.
    await request.addStream(body()).timeout(const Duration(seconds: 10));
    final response = await request.close().timeout(const Duration(seconds: 10));
    final html = await utf8.decoder.bind(response).join().timeout(const Duration(seconds: 10));
    expect(response.statusCode, HttpStatus.forbidden);
    expect(response.headers.contentType?.mimeType, 'text/html');
    expect(html, contains('<html lang="en">'));
    expect(html, contains('The code does not match. Return to the form and enter it exactly as shown on the frame.'));
    expect(html, contains('</html>'));
    expect(createdWriter, isFalse);
    expect(directory.listSync(), isEmpty);
    expect(installer.files, isEmpty);
    expect(installer.restarts, 0);
    expect(ota.busy, isFalse);

    final next = await client.getUrl(endpoint.resolve('/ota_start'));
    final nextResponse = await next.close().timeout(const Duration(seconds: 10));
    expect(nextResponse.statusCode, HttpStatus.ok);
    expect(await utf8.decoder.bind(nextResponse).join(), contains('DSlideshow'));
  });

  test('extension, duplicate files and duplicate code never start installer', () async {
    final ota = service();
    final wrongType = await ota.handler(_request(Stream.value(_multipart(ota.code, filename: 'bad.zip'))));
    expect(wrongType.statusCode, 415);
    final duplicateFile = await ota.handler(
      _request(Stream.value(_multipart(ota.code, extra: '${_fileHeader('second.deb')}other\r\n'))),
    );
    expect(duplicateFile.statusCode, 413);
    final duplicateCode = await ota.handler(
      _request(
        Stream.value(
          utf8.encode(
            '${_field('code', ota.code)}${_field('code', ota.code)}'
            '${_fileHeader()}data\r\n--$_boundary--\r\n',
          ),
        ),
      ),
    );
    expect(duplicateCode.statusCode, 400);
    expect(installer.files, isEmpty);
    expect(directory.listSync(), isEmpty);
  });

  test('empty and missing package are rejected without installation', () async {
    final ota = service();
    expect((await upload(ota, data: '')).statusCode, 400);
    final missing = await ota.handler(
      _request(Stream.value(utf8.encode('${_field('code', ota.code)}--$_boundary--\r\n'))),
    );
    expect(missing.statusCode, 400);
    expect(installer.files, isEmpty);
    expect(directory.listSync(), isEmpty);
  });

  test('actual byte limit works without Content-Length and removes staging', () async {
    final ota = service(limits: const UploadLimits(maxBytes: 512, maxFiles: 1, maxParts: 2));
    final result = await upload(ota, data: 'x' * 1024);
    expect(result.statusCode, 413);
    expect(installer.files, isEmpty);
    expect(directory.listSync(), isEmpty);
    expect(ota.busy, isFalse);
  });

  test('bounded code and malformed multipart return errors', () async {
    final ota = service(limits: const UploadLimits(maxFieldBytes: 8, maxFiles: 1, maxParts: 2));
    final largeCode = await ota.handler(_request(Stream.value(_multipart('x' * 100))));
    expect(largeCode.statusCode, 413);
    final malformed = await ota.handler(_request(Stream.value(utf8.encode('bad body'))));
    expect(malformed.statusCode, 400);
    expect(installer.files, isEmpty);
    expect(directory.listSync(), isEmpty);
  });

  test('stream error and truncated body clean staging and allow retry', () async {
    final ota = service();
    Stream<List<int>> failedBody() async* {
      yield utf8.encode('${_field('code', ota.code)}${_fileHeader()}partial');
      throw StateError('connection lost');
    }

    expect((await ota.handler(_request(failedBody()))).statusCode, 400);
    expect(directory.listSync(), isEmpty);
    expect(ota.info.status, OTAStatus.issue);
    expect(ota.busy, isFalse);
    final truncated = await ota.handler(
      _request(Stream.value(utf8.encode('${_field('code', ota.code)}${_fileHeader()}partial'))),
    );
    expect(truncated.statusCode, 400);
    expect(directory.listSync(), isEmpty);
    expect((await upload(ota)).statusCode, 200);
    await _until(() => installer.data.isNotEmpty);
    expect(installer.data.length, 1);
  });

  for (final fault in [_Fault.write, _Fault.flush, _Fault.close]) {
    test('disk-full during ${fault.name} returns 507 without install', () async {
      final ota = service(
        writerFactory: (file) async {
          return _Writer(await file.open(mode: FileMode.write), fault: fault);
        },
      );
      expect((await upload(ota)).statusCode, 507);
      expect(installer.files, isEmpty);
      expect(directory.listSync(), isEmpty);
      expect(ota.busy, isFalse);
      expect(ota.info.status, OTAStatus.issue);
    });
  }

  test('close cancels stalled transfer and waits for temporary cleanup', () async {
    final firstWrite = Completer<void>();
    final ota = service(
      writerFactory: (file) async {
        return _Writer(await file.open(mode: FileMode.write), firstWrite: firstWrite);
      },
    );
    final body = StreamController<List<int>>();
    addTearDown(() async {
      await closeService(ota);
      await body.close();
    });
    final response = ota.handler(_request(body.stream));
    body.add(utf8.encode('${_field('code', ota.code)}${_fileHeader()}${'partial' * 100}'));
    // Wait for a completed write, rather than observing the directory between
    // OS creation and the receiver taking ownership of the temporary file.
    await firstWrite.future;
    await closeService(ota);
    expect((await response).statusCode, 408);
    expect(directory.listSync(), isEmpty);
    expect(installer.files, isEmpty);
    expect(ota.info.status, OTAStatus.disabled);
    await body.close();
  });

  test('parallel request is rejected without reading body or changing owner state', () async {
    final gate = Completer<void>();
    installer.pending = Completer<int>();
    addTearDown(() {
      if (!gate.isCompleted) gate.complete();
      if (!installer.pending!.isCompleted) installer.pending!.complete(1);
    });
    final created = Completer<_Writer>();
    final ota = service(
      writerFactory: (file) async {
        final writer = _Writer(await file.open(mode: FileMode.write), closeGate: gate);
        created.complete(writer);
        return writer;
      },
    );
    final first = upload(ota);
    final writer = await created.future;
    await writer.closeEntered.future;
    final ownerInfo = ota.info;
    var consumed = false;
    Stream<List<int>> rejectedBody() async* {
      consumed = true;
      yield _multipart(ota.code);
    }

    expect((await ota.handler(_request(rejectedBody()))).statusCode, 409);
    expect(consumed, isFalse);
    expect(identical(ota.info, ownerInfo), isTrue);
    gate.complete();
    expect((await first).statusCode, 200);
    await _until(() => installer.data.isNotEmpty);
    expect((await upload(ota)).statusCode, 409);
    installer.pending!.complete(1);
    await _until(() => !ota.busy);
  });

  test('release lookup owns the lock against manual and automatic requests', () async {
    final lookup = Completer<ReleaseInfo?>();
    var lookups = 0;
    final ota = service(
      latestRelease: () {
        lookups++;
        return lookup.future;
      },
    );
    final first = ota.checkLatestRelease();
    expect(ota.busy, isTrue);
    await ota.checkLatestRelease();
    expect(lookups, 1);
    expect((await upload(ota)).statusCode, 409);
    lookup.complete(null);
    await first;
    expect(ota.busy, isFalse);
    expect(installer.files, isEmpty);
  });

  for (final version in [Version.parse(ApplicationInfo.frontendVersion), Version(0, 0, 0)]) {
    test('release $version does not download or install an existing version', () async {
      var downloads = 0;
      final ota = service(
        latestRelease: () async =>
            ReleaseInfo(version: version, debUrl: 'https://example.invalid/should-not-download.deb'),
        downloadClientFactory: () {
          downloads++;
          throw StateError('An installed version must not be downloaded');
        },
      );
      await ota.checkLatestRelease();
      expect(downloads, 0);
      expect(ota.busy, isFalse);
      expect(installer.files, isEmpty);
      expect(remote.commands, isEmpty);
      expect(directory.listSync(), isEmpty);
      expect(ota.info.status, OTAStatus.disabled);
    });
  }

  test('close does not wait for an external release lookup', () async {
    final lookup = Completer<ReleaseInfo?>();
    final ota = service(latestRelease: () => lookup.future);
    final check = ota.checkLatestRelease();
    await closeService(ota);
    await check;
    lookup.complete(null);
    expect(ota.info.status, OTAStatus.disabled);
    expect(installer.files, isEmpty);
  });

  test('automatic chunked download decodes the package name before installation', () async {
    final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
    addTearDown(() => server.close(force: true));
    server.listen((request) async {
      request.response.bufferOutput = false;
      request.response.add(utf8.encode('downloaded '));
      await request.response.flush();
      request.response.add(utf8.encode('package'));
      await request.response.close();
    });
    final ota = service(
      latestRelease: () async =>
          ReleaseInfo(version: Version(999, 0, 0), debUrl: 'http://127.0.0.1:${server.port}/automatic%2B7.deb'),
    );
    await ota.checkLatestRelease();
    await _until(() => installer.data.isNotEmpty);
    expect(installer.data.single, utf8.encode('downloaded package'));
    expect(installer.files.single, path.join(directory.path, 'automatic+7.deb'));
    expect(directory.listSync().whereType<File>().length, 1);
    expect(remote.infos.every((info) => info.uploadingPercent.isFinite), isTrue);
  });

  test('automatic download HTTP failure is observable and releases lock', () async {
    final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
    addTearDown(() => server.close(force: true));
    server.listen((request) async {
      request.response.statusCode = 503;
      await request.response.close();
    });
    final ota = service(
      latestRelease: () async =>
          ReleaseInfo(version: Version(999, 0, 0), debUrl: 'http://127.0.0.1:${server.port}/automatic.deb'),
    );
    await ota.checkLatestRelease();
    expect(ota.info.status, OTAStatus.issue);
    expect(ota.info.errorText, contains('503'));
    expect(ota.busy, isFalse);
    expect(installer.files, isEmpty);
  });

  test('close cancels a blocked frontend screen request', () async {
    remote.blockedReady = Completer<RpcResult>();
    final ota = service(
      latestRelease: () async => ReleaseInfo(version: Version(999, 0, 0), debUrl: 'http://127.0.0.1/automatic.deb'),
    );
    final check = ota.checkLatestRelease();
    await _until(() => remote.readyRequested);
    await closeService(ota);
    await check;
    remote.blockedReady!.complete(const EmptyResult(id: 1));
    expect(installer.files, isEmpty);
    expect(ota.busy, isFalse);
  });

  test(
    'automatic OTA awaits frontend RPC without a deadline and handles its actual error',
    () => captureLogs((records) async {
      late FakeAsync clock;
      late OTAService ota;
      try {
        fakeAsync((time) {
          clock = time;
          remote.blockedReady = Completer<RpcResult>();
          ota = service(
            networkTimeout: const Duration(milliseconds: 20),
            latestRelease: () async =>
                ReleaseInfo(version: Version(999, 0, 0), debUrl: 'http://127.0.0.1/automatic.deb'),
          );
          var finished = false;
          ota.checkLatestRelease().then((_) => finished = true);
          time.flushMicrotasks();
          expect(remote.readyRequested, isTrue);
          time.elapse(const Duration(seconds: 30));
          expect(finished, isFalse);
          expect(ota.busy, isTrue);
          expect(installer.files, isEmpty);
          ota.checkLatestRelease();
          time.flushMicrotasks();
          expect(remote.commands.whereType<OTAReadyCommand>(), hasLength(1));
          remote.blockedReady!.completeError(StateError('private frontend endpoint'));
          time.flushMicrotasks();
          expect(finished, isTrue);
          expect(ota.info.status, OTAStatus.issue);
          expect(ota.info.errorText, contains('private frontend endpoint'));
          expect(ota.busy, isFalse);
        });
      } finally {
        var closed = false;
        final closing = closeService(ota).then((_) => closed = true);
        await _until(() {
          clock.flushMicrotasks();
          return closed;
        });
        await closing;
      }
      expect(records.any((record) => record.message == 'OTA frontend notification failed type=StateError'), isTrue);
      expect(records.where((record) => record.error != null), isNotEmpty);
      expect(
        records
            .where((record) => record.error != null)
            .every((record) => record.stackTrace != null && record.stackTrace.toString().isNotEmpty),
        isTrue,
      );
      expect(records.map((record) => record.message).join(), isNot(contains('private')));
    }),
  );

  test('automatic download response headers have an explicit deadline', () async {
    final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
    addTearDown(() => server.close(force: true));
    server.listen((request) {});
    final ota = service(
      networkTimeout: const Duration(milliseconds: 20),
      latestRelease: () async =>
          ReleaseInfo(version: Version(999, 0, 0), debUrl: 'http://127.0.0.1:${server.port}/automatic.deb'),
    );
    await ota.checkLatestRelease();
    expect(ota.info.status, OTAStatus.issue);
    expect(ota.info.errorText, contains('TimeoutException'));
    expect(ota.busy, isFalse);
    expect(installer.files, isEmpty);
  });

  test('automatic download enforces actual bytes without Content-Length', () async {
    final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
    addTearDown(() => server.close(force: true));
    server.listen((request) async {
      request.response.bufferOutput = false;
      request.response.add(List.filled(128, 1));
      await request.response.close();
    });
    final ota = service(
      limits: const UploadLimits(maxBytes: 64, maxFiles: 1, maxParts: 2),
      latestRelease: () async =>
          ReleaseInfo(version: Version(999, 0, 0), debUrl: 'http://127.0.0.1:${server.port}/automatic.deb'),
    );
    await ota.checkLatestRelease();
    expect(ota.info.status, OTAStatus.issue);
    expect(ota.busy, isFalse);
    expect(installer.files, isEmpty);
    expect(directory.listSync(), isEmpty);
  });

  test('installer output and progress stay bounded while a notification is in flight', () async {
    remote.blockedAll = Completer<RpcResult>();
    installer.pending = Completer<int>();
    addTearDown(() {
      if (!remote.blockedAll!.isCompleted) remote.blockedAll!.complete(const EmptyResult(id: 1));
      if (!installer.pending!.isCompleted) installer.pending!.complete(1);
    });
    final ota = service();
    expect((await upload(ota)).statusCode, 200);
    await _until(() => installer.emitOutput != null);
    installer.emitOutput!('x' * (128 * 1024));
    installer.emitOutput!('y' * (128 * 1024));
    installer.pending!.complete(1);
    await _until(() => !ota.busy);
    expect(remote.commands.length, 1);
    remote.blockedAll!.complete(const EmptyResult(id: 1));
    await _until(
      () => remote.infos.last.status == OTAStatus.issue && remote.commands.whereType<OTAOutputCommand>().isNotEmpty,
    );
    final output = remote.commands.whereType<OTAOutputCommand>().map((command) => command.output).join();
    expect(utf8.encode(output).length, lessThanOrEqualTo(64 * 1024));
    expect(remote.infos.last.status, OTAStatus.issue);
  });

  test('installer exceptions and frontend errors are caught', () async {
    installer.installError = StateError('could not start installer');
    remote.failSends = true;
    final ota = service();
    expect((await upload(ota)).statusCode, 200);
    await _until(() => !ota.busy);
    expect(ota.info.status, OTAStatus.issue);
    expect(ota.info.errorText, contains('could not start installer'));
    expect(installer.restarts, 0);
  });

  test('a nonzero installer result remains observable until a new attempt and does not close the screen', () async {
    installer.exitCode = 17;
    final ota = service(alwaysEnabled: true);
    expect((await upload(ota)).statusCode, 200);
    await _until(() => !ota.busy && remote.infos.any((info) => info.status == OTAStatus.issue));
    final failure = ota.info;
    expect(failure.status, OTAStatus.issue);
    expect(failure.exitCode, 17);
    expect(failure.errorText, contains('17'));
    expect(remote.infos.last, failure);
    final snapshot = await ota.executeCommand(OTAGetInfoCommand(id: 42));
    expect((snapshot as OTAGetInfoCommandResult).info, failure);
    expect(remote.commands.whereType<OTAReadyCommand>().where((c) => !c.ready), isEmpty);
    expect(installer.restarts, 0);

    installer.pending = Completer<int>();
    expect((await upload(ota)).statusCode, 200);
    await _until(() => installer.files.length == 2);
    expect(ota.info.status, OTAStatus.instaling);
    expect(ota.info.errorText, isNull);
    expect(ota.info.exitCode, isNull);
    installer.pending!.complete(23);
    await _until(() => !ota.busy);
    expect(ota.info.exitCode, 23);
  });

  test('successful installer holds lock through restart and reports restart failure', () async {
    installer.exitCode = 0;
    installer.restartError = StateError('restart failed');
    final ota = service(restartDelay: const Duration(milliseconds: 30));
    expect((await upload(ota)).statusCode, 200);
    await _until(() => ota.info.status == OTAStatus.finished);
    expect(ota.busy, isTrue);
    expect((await upload(ota)).statusCode, 409);
    await _until(() => installer.restarts == 1 && !ota.busy);
    expect(remote.infos.any((info) => info.status == OTAStatus.preReboot), isTrue);
    expect(ota.info.status, OTAStatus.issue);
    expect(ota.info.errorText, contains('restart failed'));
  });

  test('close leaves running installer alone and cancels future restart', () async {
    installer.pending = Completer<int>();
    final ota = service(restartDelay: Duration.zero);
    expect((await upload(ota)).statusCode, 200);
    await _until(() => installer.data.isNotEmpty);
    await closeService(ota);
    expect(installer.pending!.isCompleted, isFalse);
    installer.pending!.complete(0);
    await Future<void>.delayed(const Duration(milliseconds: 10));
    expect(installer.restarts, 0);
    expect(ota.info.status, OTAStatus.disabled);
  });

  test('start is awaitable and autostop waits for active installation', () async {
    installer.pending = Completer<int>();
    final ota = service(alwaysEnabled: false, autostopDelay: const Duration(milliseconds: 10));
    await ota.start();
    expect(ota.enabled, isTrue);
    expect((await upload(ota)).statusCode, 200);
    await _until(() => installer.data.isNotEmpty);
    await Future<void>.delayed(const Duration(milliseconds: 20));
    expect(ota.enabled, isTrue);
    expect(ota.info.status, OTAStatus.instaling);
    installer.pending!.complete(1);
    await _until(() => !ota.enabled && !ota.busy);
  });

  test('rapid start stop start finishes with a reachable listener', () async {
    final ota = service(alwaysEnabled: false);
    await Future.wait([ota.start(), ota.stop(), ota.start()]);
    expect(ota.enabled, isTrue);
    expect(ota.boundPort, isNotNull);
    final client = HttpClient();
    addTearDown(() => client.close(force: true));
    final request = await client.getUrl(Uri.parse('http://127.0.0.1:${ota.boundPort}/ota_start?format=json'));
    final response = await request.close();
    expect(response.statusCode, 200);
    expect(json.decode(await utf8.decoder.bind(response).join()), contains('version'));
  });

  test('progress remains finite and intermediate updates are at most 4 Hz', () async {
    final ota = service();
    final body = _multipart(ota.code, data: 'x' * 1000);
    Stream<List<int>> chunks() async* {
      for (var offset = 0; offset < body.length; offset += 64) {
        yield body.sublist(offset, (offset + 64).clamp(0, body.length));
        await Future<void>.delayed(const Duration(milliseconds: 30));
      }
    }

    expect((await ota.handler(_request(chunks(), contentLength: body.length))).statusCode, 200);
    expect(remote.progressTimes, isNotEmpty);
    for (var index = 1; index < remote.progressTimes.length; index++) {
      expect(remote.progressTimes[index] - remote.progressTimes[index - 1], greaterThanOrEqualTo(250000));
    }
    expect(
      remote.infos.every(
        (info) => info.uploadingPercent.isFinite && info.uploadingPercent >= 0 && info.uploadingPercent <= 100,
      ),
      isTrue,
    );
  });
}
