import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_backend/src/service/ota/ota_installer.dart';
import 'package:dslideshow_backend/src/service/ota/ota_service.dart';
import 'package:dslideshow_backend/src/service/ota/release_info.dart';
import 'package:dslideshow_backend/src/service/upload/streaming_upload.dart';
import 'package:dslideshow_common/rpc.dart';
import 'package:dslideshow_common/version.dart';
import 'package:path/path.dart' as path;
import 'package:pub_semver/pub_semver.dart';
import 'package:shelf/shelf.dart';
import 'package:test/test.dart';

const _boundary = 'ota-test-boundary';

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

Request _request(Stream<List<int>> body, {int? contentLength}) => Request(
  'POST',
  Uri.parse('http://localhost/ota_upload'),
  headers: {
    'content-type': 'multipart/form-data; boundary=$_boundary',
    if (contentLength != null) 'content-length': '$contentLength',
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
  Future<int> install(
    File package, {
    required void Function(String) onOutput,
  }) async {
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

  _Writer(
    this.file, {
    this.fault = _Fault.none,
    this.closeGate,
    this.firstWrite,
  });

  FileSystemException get _noSpace =>
      const FileSystemException('full', '', OSError('No space left', 28));

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
    Future<ReleaseInfo?> Function()? latestRelease,
    HttpClient Function()? downloadClientFactory,
    Duration restartDelay = const Duration(seconds: 5),
    Duration autostopDelay = const Duration(minutes: 5),
    Duration networkTimeout = const Duration(seconds: 60),
    bool alwaysEnabled = true,
  }) {
    final config = AppConfig.fromJson({
      'ota': {'alwaysEnabled': alwaysEnabled, 'autoUpdateEnabled': false},
    });
    final result = OTAService(
      config: config,
      frontendService: remote,
      startServer: false,
      firmwareDirectory: directory,
      installer: installer,
      uploadReceiver: StreamingUploadReceiver(
        limits: limits,
        writerFactory: writerFactory,
      ),
      latestRelease: latestRelease,
      downloadClientFactory: downloadClientFactory,
      restartDelay: restartDelay,
      autostopDelay: autostopDelay,
      networkTimeout: networkTimeout,
      port: 0,
    );
    services.add(result);
    return result;
  }

  Future<Response> upload(
    OTAService ota, {
    String data = 'package contents',
  }) async {
    return ota.handler(
      _request(Stream.value(_multipart(ota.code, data: data))),
    );
  }

  setUp(() async {
    directory = await Directory.systemTemp.createTemp('ota-upload-test-');
    remote = _Remote();
    installer = _Installer();
  });

  tearDown(() async {
    for (final ota in services) {
      await ota.close();
    }
    services.clear();
    await directory.delete(recursive: true);
  });

  test(
    'unknown Content-Length saves one package before HTTP 200 and install',
    () async {
      final ota = service();
      final response = await upload(ota);
      expect(response.statusCode, 200);
      await _until(() => installer.data.isNotEmpty);
      expect(installer.data.single, utf8.encode('package contents'));
      expect(installer.files.single, path.join(directory.path, 'update.deb'));
      expect(directory.listSync().whereType<File>().length, 1);
      expect(
        remote.infos.every((info) => info.uploadingPercent.isFinite),
        isTrue,
      );
      await _until(
        () => remote.infos.any((info) => info.uploadingPercent == 100),
      );
    },
  );

  test('success and installer both wait for writer close and rename', () async {
    final gate = Completer<void>();
    addTearDown(() {
      if (!gate.isCompleted) gate.complete();
    });
    final created = Completer<_Writer>();
    final ota = service(
      writerFactory: (file) async {
        final writer = _Writer(
          await file.open(mode: FileMode.write),
          closeGate: gate,
        );
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
    test(
      'rejects ${codeFirst ? 'wrong code' : 'file before code'} before reading file body',
      () async {
        var readBody = false;
        var createdWriter = false;
        final ota = service(
          writerFactory: (file) async {
            createdWriter = true;
            return _Writer(await file.open(mode: FileMode.write));
          },
        );
        Stream<List<int>> body() async* {
          yield utf8.encode(
            '${codeFirst ? _field('code', 'wrong') : ''}${_fileHeader()}',
          );
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
      },
    );
  }

  test(
    'extension, duplicate files and duplicate code never start installer',
    () async {
      final ota = service();
      final wrongType = await ota.handler(
        _request(Stream.value(_multipart(ota.code, filename: 'bad.zip'))),
      );
      expect(wrongType.statusCode, 415);
      final duplicateFile = await ota.handler(
        _request(
          Stream.value(
            _multipart(
              ota.code,
              extra: '${_fileHeader('second.deb')}other\r\n',
            ),
          ),
        ),
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
    },
  );

  test('empty and missing package are rejected without installation', () async {
    final ota = service();
    expect((await upload(ota, data: '')).statusCode, 400);
    final missing = await ota.handler(
      _request(
        Stream.value(
          utf8.encode('${_field('code', ota.code)}--$_boundary--\r\n'),
        ),
      ),
    );
    expect(missing.statusCode, 400);
    expect(installer.files, isEmpty);
    expect(directory.listSync(), isEmpty);
  });

  test(
    'actual byte limit works without Content-Length and removes staging',
    () async {
      final ota = service(
        limits: const UploadLimits(maxBytes: 512, maxFiles: 1, maxParts: 2),
      );
      final result = await upload(ota, data: 'x' * 1024);
      expect(result.statusCode, 413);
      expect(installer.files, isEmpty);
      expect(directory.listSync(), isEmpty);
      expect(ota.busy, isFalse);
    },
  );

  test('bounded code and malformed multipart return errors', () async {
    final ota = service(
      limits: const UploadLimits(maxFieldBytes: 8, maxFiles: 1, maxParts: 2),
    );
    final largeCode = await ota.handler(
      _request(Stream.value(_multipart('x' * 100))),
    );
    expect(largeCode.statusCode, 413);
    final malformed = await ota.handler(
      _request(Stream.value(utf8.encode('bad body'))),
    );
    expect(malformed.statusCode, 400);
    expect(installer.files, isEmpty);
    expect(directory.listSync(), isEmpty);
  });

  test(
    'stream error and truncated body clean staging and allow retry',
    () async {
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
        _request(
          Stream.value(
            utf8.encode('${_field('code', ota.code)}${_fileHeader()}partial'),
          ),
        ),
      );
      expect(truncated.statusCode, 400);
      expect(directory.listSync(), isEmpty);
      expect((await upload(ota)).statusCode, 200);
      await _until(() => installer.data.isNotEmpty);
      expect(installer.data.length, 1);
    },
  );

  for (final fault in [_Fault.write, _Fault.flush, _Fault.close]) {
    test(
      'disk-full during ${fault.name} returns 507 without install',
      () async {
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
      },
    );
  }

  test(
    'close cancels stalled transfer and waits for temporary cleanup',
    () async {
      final firstWrite = Completer<void>();
      final ota = service(
        writerFactory: (file) async {
          return _Writer(
            await file.open(mode: FileMode.write),
            firstWrite: firstWrite,
          );
        },
      );
      final body = StreamController<List<int>>();
      addTearDown(() async {
        await ota.close();
        await body.close();
      });
      final response = ota.handler(_request(body.stream));
      body.add(
        utf8.encode(
          '${_field('code', ota.code)}${_fileHeader()}${'partial' * 100}',
        ),
      );
      // Wait for a completed write, rather than observing the directory between
      // OS creation and the receiver taking ownership of the temporary file.
      await firstWrite.future;
      await ota.close();
      expect((await response).statusCode, 408);
      expect(directory.listSync(), isEmpty);
      expect(installer.files, isEmpty);
      expect(ota.info.status, OTAStatus.disabled);
      await body.close();
    },
  );

  test(
    'parallel request is rejected without reading body or changing owner state',
    () async {
      final gate = Completer<void>();
      installer.pending = Completer<int>();
      addTearDown(() {
        if (!gate.isCompleted) gate.complete();
        if (!installer.pending!.isCompleted) installer.pending!.complete(1);
      });
      final created = Completer<_Writer>();
      final ota = service(
        writerFactory: (file) async {
          final writer = _Writer(
            await file.open(mode: FileMode.write),
            closeGate: gate,
          );
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
    },
  );

  test(
    'release lookup owns the lock against manual and automatic requests',
    () async {
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
    },
  );

  for (final version in [
    Version.parse(ApplicationInfo.frontendVersion),
    Version(0, 0, 0),
  ]) {
    test(
      'release $version does not download or install an existing version',
      () async {
        var downloads = 0;
        final ota = service(
          latestRelease: () async => ReleaseInfo(
            version: version,
            debUrl: 'https://example.invalid/should-not-download.deb',
          ),
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
      },
    );
  }

  test('close does not wait for an external release lookup', () async {
    final lookup = Completer<ReleaseInfo?>();
    final ota = service(latestRelease: () => lookup.future);
    final check = ota.checkLatestRelease();
    await ota.close();
    await check;
    lookup.complete(null);
    expect(ota.info.status, OTAStatus.disabled);
    expect(installer.files, isEmpty);
  });

  test(
    'automatic chunked download decodes the package name before installation',
    () async {
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
        latestRelease: () async => ReleaseInfo(
          version: Version(999, 0, 0),
          debUrl: 'http://127.0.0.1:${server.port}/automatic%2B7.deb',
        ),
      );
      await ota.checkLatestRelease();
      await _until(() => installer.data.isNotEmpty);
      expect(installer.data.single, utf8.encode('downloaded package'));
      expect(
        installer.files.single,
        path.join(directory.path, 'automatic+7.deb'),
      );
      expect(directory.listSync().whereType<File>().length, 1);
      expect(
        remote.infos.every((info) => info.uploadingPercent.isFinite),
        isTrue,
      );
    },
  );

  test(
    'automatic download HTTP failure is observable and releases lock',
    () async {
      final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
      addTearDown(() => server.close(force: true));
      server.listen((request) async {
        request.response.statusCode = 503;
        await request.response.close();
      });
      final ota = service(
        latestRelease: () async => ReleaseInfo(
          version: Version(999, 0, 0),
          debUrl: 'http://127.0.0.1:${server.port}/automatic.deb',
        ),
      );
      await ota.checkLatestRelease();
      expect(ota.info.status, OTAStatus.issue);
      expect(ota.info.errorText, contains('503'));
      expect(ota.busy, isFalse);
      expect(installer.files, isEmpty);
    },
  );

  test('close cancels a blocked frontend screen request', () async {
    remote.blockedReady = Completer<RpcResult>();
    final ota = service(
      latestRelease: () async => ReleaseInfo(
        version: Version(999, 0, 0),
        debUrl: 'http://127.0.0.1/automatic.deb',
      ),
    );
    final check = ota.checkLatestRelease();
    await _until(() => remote.readyRequested);
    await ota.close();
    await check;
    remote.blockedReady!.complete(const EmptyResult(id: 1));
    expect(installer.files, isEmpty);
    expect(ota.busy, isFalse);
  });

  test(
    'blocked frontend has a deadline and releases automatic OTA lock',
    () async {
      remote.blockedReady = Completer<RpcResult>();
      final ota = service(
        networkTimeout: const Duration(milliseconds: 20),
        latestRelease: () async => ReleaseInfo(
          version: Version(999, 0, 0),
          debUrl: 'http://127.0.0.1/automatic.deb',
        ),
      );
      await ota.checkLatestRelease();
      expect(ota.info.status, OTAStatus.issue);
      expect(ota.busy, isFalse);
      expect(installer.files, isEmpty);
      remote.blockedReady!.complete(const EmptyResult(id: 1));
    },
  );

  test(
    'automatic download response headers have an explicit deadline',
    () async {
      final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
      addTearDown(() => server.close(force: true));
      server.listen((request) {});
      final ota = service(
        networkTimeout: const Duration(milliseconds: 20),
        latestRelease: () async => ReleaseInfo(
          version: Version(999, 0, 0),
          debUrl: 'http://127.0.0.1:${server.port}/automatic.deb',
        ),
      );
      await ota.checkLatestRelease();
      expect(ota.info.status, OTAStatus.issue);
      expect(ota.info.errorText, contains('TimeoutException'));
      expect(ota.busy, isFalse);
      expect(installer.files, isEmpty);
    },
  );

  test(
    'automatic download enforces actual bytes without Content-Length',
    () async {
      final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
      addTearDown(() => server.close(force: true));
      server.listen((request) async {
        request.response.bufferOutput = false;
        request.response.add(List.filled(128, 1));
        await request.response.close();
      });
      final ota = service(
        limits: const UploadLimits(maxBytes: 64, maxFiles: 1, maxParts: 2),
        latestRelease: () async => ReleaseInfo(
          version: Version(999, 0, 0),
          debUrl: 'http://127.0.0.1:${server.port}/automatic.deb',
        ),
      );
      await ota.checkLatestRelease();
      expect(ota.info.status, OTAStatus.issue);
      expect(ota.busy, isFalse);
      expect(installer.files, isEmpty);
      expect(directory.listSync(), isEmpty);
    },
  );

  test('stalled frontend keeps one RPC and bounded output, then delivers latest state', () async {
    remote.blockedAll = Completer<RpcResult>();
    installer.pending = Completer<int>();
    addTearDown(() {
      if (!remote.blockedAll!.isCompleted)
        remote.blockedAll!.complete(const EmptyResult(id: 1));
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
      () =>
          remote.infos.last.status == OTAStatus.issue &&
          remote.commands.whereType<OTAOutputCommand>().isNotEmpty,
    );
    final output = remote.commands
        .whereType<OTAOutputCommand>()
        .map((command) => command.output)
        .join();
    expect(utf8.encode(output).length, lessThanOrEqualTo(64 * 1024));
    expect(remote.infos.last.status, OTAStatus.issue);
  });

  test(
    'repeated screen timeouts share the same unresolved RPC and recover',
    () async {
      remote.blockedAll = Completer<RpcResult>();
      addTearDown(() {
        if (!remote.blockedAll!.isCompleted)
          remote.blockedAll!.complete(const EmptyResult(id: 1));
      });
      final ota = service(
        networkTimeout: const Duration(milliseconds: 10),
        latestRelease: () async => ReleaseInfo(
          version: Version(999, 0, 0),
          debUrl: 'http://127.0.0.1/automatic.deb',
        ),
      );
      for (var index = 0; index < 3; index++) {
        await ota.checkLatestRelease();
        expect(ota.busy, isFalse);
      }
      expect(remote.commands.length, 1);
      remote.blockedAll!.complete(const EmptyResult(id: 1));
      await _until(
        () =>
            remote.infos.isNotEmpty &&
            remote.infos.last.status == OTAStatus.issue,
      );
      expect(installer.files, isEmpty);
    },
  );

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

  test('successful installer holds lock through restart and reports restart failure', () async {
    installer.exitCode = 0;
    installer.restartError = StateError('restart failed');
    final ota = service(restartDelay: const Duration(milliseconds: 30));
    expect((await upload(ota)).statusCode, 200);
    await _until(() => ota.info.status == OTAStatus.finished);
    expect(ota.busy, isTrue);
    expect((await upload(ota)).statusCode, 409);
    await _until(() => installer.restarts == 1 && !ota.busy);
    expect(
      remote.infos.any((info) => info.status == OTAStatus.preReboot),
      isTrue,
    );
    expect(ota.info.status, OTAStatus.issue);
    expect(ota.info.errorText, contains('restart failed'));
  });

  test(
    'close leaves running installer alone and cancels future restart',
    () async {
      installer.pending = Completer<int>();
      final ota = service(restartDelay: Duration.zero);
      expect((await upload(ota)).statusCode, 200);
      await _until(() => installer.data.isNotEmpty);
      await ota.close();
      expect(installer.pending!.isCompleted, isFalse);
      installer.pending!.complete(0);
      await Future<void>.delayed(const Duration(milliseconds: 10));
      expect(installer.restarts, 0);
      expect(ota.info.status, OTAStatus.disabled);
    },
  );

  test(
    'start is awaitable and autostop waits for active installation',
    () async {
      installer.pending = Completer<int>();
      final ota = service(
        alwaysEnabled: false,
        autostopDelay: const Duration(milliseconds: 10),
      );
      await ota.start();
      expect(ota.enabled, isTrue);
      expect((await upload(ota)).statusCode, 200);
      await _until(() => installer.data.isNotEmpty);
      await Future<void>.delayed(const Duration(milliseconds: 20));
      expect(ota.enabled, isTrue);
      expect(ota.info.status, OTAStatus.instaling);
      installer.pending!.complete(1);
      await _until(() => !ota.enabled && !ota.busy);
    },
  );

  test('rapid start stop start finishes with a reachable listener', () async {
    final ota = service(alwaysEnabled: false);
    await Future.wait([ota.start(), ota.stop(), ota.start()]);
    expect(ota.enabled, isTrue);
    expect(ota.boundPort, isNotNull);
    final client = HttpClient();
    addTearDown(() => client.close(force: true));
    final request = await client.getUrl(
      Uri.parse('http://127.0.0.1:${ota.boundPort}/ota_start?format=json'),
    );
    final response = await request.close();
    expect(response.statusCode, 200);
    expect(
      json.decode(await utf8.decoder.bind(response).join()),
      contains('version'),
    );
  });

  test(
    'progress remains finite and intermediate updates are at most 4 Hz',
    () async {
      final ota = service();
      final body = _multipart(ota.code, data: 'x' * 1000);
      Stream<List<int>> chunks() async* {
        for (var offset = 0; offset < body.length; offset += 64) {
          yield body.sublist(offset, (offset + 64).clamp(0, body.length));
          await Future<void>.delayed(const Duration(milliseconds: 30));
        }
      }

      expect(
        (await ota.handler(_request(chunks(), contentLength: body.length)))
            .statusCode,
        200,
      );
      expect(remote.progressTimes, isNotEmpty);
      for (var index = 1; index < remote.progressTimes.length; index++) {
        expect(
          remote.progressTimes[index] - remote.progressTimes[index - 1],
          greaterThanOrEqualTo(250000),
        );
      }
      expect(
        remote.infos.every(
          (info) =>
              info.uploadingPercent.isFinite &&
              info.uploadingPercent >= 0 &&
              info.uploadingPercent <= 100,
        ),
        isTrue,
      );
    },
  );
}
