import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dslideshow_backend/src/service/ota/ota_config_transfer.dart';
import 'package:dslideshow_backend/src/service/upload/streaming_upload.dart';
import 'package:shelf/shelf.dart';
import 'package:test/test.dart';

const _boundary = 'ota-config-test';
const _code = '  code-Ж#any characters  ';
const _previous = '{"web":{"port":8081}}';

List<int> _field(String name, String value) => utf8.encode(
  '--$_boundary\r\n'
  'Content-Disposition: form-data; name="$name"\r\n\r\n'
  '$value\r\n',
);

List<int> _file(List<int> content) => [
  ...utf8.encode(
    '--$_boundary\r\n'
    'Content-Disposition: form-data; name="file"; filename="config.json"\r\n'
    'Content-Type: application/json\r\n\r\n',
  ),
  ...content,
  ...utf8.encode('\r\n'),
];

List<int> _multipart(List<List<int>> parts) => [
  for (final part in parts) ...part,
  ...utf8.encode('--$_boundary--\r\n'),
];

Request _request(List<List<int>> parts, {bool knownLength = false}) {
  final body = _multipart(parts);
  return Request(
    'POST',
    Uri.parse('http://localhost/ota_upload_config'),
    headers: {
      'content-type': 'multipart/form-data; boundary=$_boundary',
      if (knownLength) 'content-length': '${body.length}',
    },
    body: Stream<List<int>>.fromIterable([
      for (var offset = 0; offset < body.length; offset += 17)
        body.sublist(offset, (offset + 17).clamp(0, body.length)),
    ]),
  );
}

Matcher _failure(int status) => isA<UploadFailure>()
    .having((failure) => failure.statusCode, 'statusCode', status)
    .having((failure) => failure.message, 'message', isNot(contains('secret')));

class _FailingWriter implements UploadFileWriter {
  _FailingWriter(this._file, this._errorCode);

  final RandomAccessFile _file;
  final int _errorCode;

  @override
  Future<void> write(List<int> bytes) async {
    throw FileSystemException(
      'secret credentials',
      '/secret/config.json',
      OSError('secret details', _errorCode),
    );
  }

  @override
  Future<void> flush() => _file.flush();

  @override
  Future<void> close() => _file.close();
}

/// The receiver remains real; cancellation arrives at the ownership handoff.
class _CancellingReceiver extends StreamingUploadReceiver {
  @override
  Future<StagedUploadBatch> receiveMultipart(
    Request request, {
    required FutureOr<String> Function(String filename) destinationFor,
    FutureOr<void> Function(String name, String value)? onField,
    FutureOr<void> Function(String filename)? beforeFile,
    UploadProgress? onProgress,
    UploadCancellationToken? cancellation,
  }) async {
    final batch = await super.receiveMultipart(
      request,
      destinationFor: destinationFor,
      onField: onField,
      beforeFile: beforeFile,
      onProgress: onProgress,
      cancellation: cancellation,
    );
    cancellation!.cancel();
    return batch;
  }
}

void main() {
  late Directory directory;
  late File file;
  late OtaConfigTransfer transfer;

  setUp(() async {
    directory = await Directory.systemTemp.createTemp('ota-config-');
    file = File('${directory.path}/config.json');
    await file.writeAsString(_previous);
    transfer = OtaConfigTransfer(filename: file.path);
  });

  tearDown(() async => directory.delete(recursive: true));

  Future<void> upload(
    List<List<int>> parts, {
    OtaConfigTransfer? target,
    bool knownLength = false,
    UploadCancellationToken? cancellation,
  }) => (target ?? transfer).upload(
    _request(parts, knownLength: knownLength),
    code: _code,
    cancellation: cancellation ?? UploadCancellationToken(),
  );

  Future<void> expectPreviousAndClean() async {
    expect(await file.readAsString(), _previous);
    expect(directory.listSync().map((entry) => entry.path), [file.path]);
  }

  test('download preserves raw damaged bytes for recovery', () async {
    const content = [0xff, 0x00, 0x7b, 0x62, 0x61, 0x64];
    await file.writeAsBytes(content);
    expect(await transfer.download(), content);
  });

  test('download reports read failure without exposing the path', () async {
    await file.delete();
    await expectLater(transfer.download(), throwsA(_failure(500)));
  });

  for (final fileFirst in [false, true]) {
    test(
      'chunked import preserves original bytes, fileFirst=$fileFirst',
      () async {
        final content = utf8.encode(
          ' {\n  "web": { "port": 8090 }, "unknown": "сохранить"\n}\n',
        );
        final parts = [_field('code', _code), _file(content)];
        await upload(fileFirst ? parts.reversed.toList() : parts);
        expect(await file.readAsBytes(), content);
        expect(directory.listSync().length, 1);
      },
    );
  }

  test('normal Content-Length request imports successfully', () async {
    await upload([
      _field('code', _code),
      _file(utf8.encode('{}')),
    ], knownLength: true);
    expect(await file.readAsString(), '{}');
  });

  test(
    'incorrect code after a file leaves the previous config intact',
    () async {
      await expectLater(
        upload([_file(utf8.encode('{}')), _field('code', _code.trim())]),
        throwsA(_failure(403)),
      );
      await expectPreviousAndClean();
    },
  );

  for (final content in [
    '',
    '{secret',
    '[]',
    '{"slideshow":{"displayTimeMs":"secret"}}',
  ]) {
    test(
      'invalid config is rejected without replacing old data: $content',
      () async {
        await expectLater(
          upload([_field('code', _code), _file(utf8.encode(content))]),
          throwsA(_failure(400)),
        );
        await expectPreviousAndClean();
      },
    );
  }

  test('invalid UTF-8 leaves the previous config intact', () async {
    await expectLater(
      upload([
        _field('code', _code),
        _file([0xff, 0x00]),
      ]),
      throwsA(_failure(400)),
    );
    await expectPreviousAndClean();
  });

  test('rejected staged upload releases its destination for a retry', () async {
    await expectLater(
      upload([_file(utf8.encode('{broken')), _field('code', _code)]),
      throwsA(_failure(400)),
    );
    await upload([_file(utf8.encode('{}')), _field('code', _code)]);
    expect(await transfer.download(), utf8.encode('{}'));
    expect(directory.listSync().map((entry) => entry.path), [file.path]);
  });

  for (final entry in <String, List<List<int>>>{
    'missing code': [_file(utf8.encode('{}'))],
    'missing file': [_field('code', _code)],
    'duplicate code': [_field('code', _code), _field('code', _code)],
    'unexpected field': [_field('secret', _code), _file(utf8.encode('{}'))],
  }.entries) {
    test('${entry.key} leaves the previous config intact', () async {
      await expectLater(upload(entry.value), throwsA(_failure(400)));
      await expectPreviousAndClean();
    });
  }

  test(
    'additional file is rejected and all temporary data is cleaned',
    () async {
      await expectLater(
        upload([_file(utf8.encode('{}')), _file(utf8.encode('{}'))]),
        throwsA(_failure(413)),
      );
      await expectPreviousAndClean();
    },
  );

  test('chunked request enforces actual byte limit', () async {
    final limited = OtaConfigTransfer(
      filename: file.path,
      uploadReceiver: StreamingUploadReceiver(
        limits: const UploadLimits(maxBytes: 300, maxFiles: 1, maxParts: 2),
      ),
    );
    await expectLater(
      upload([
        _field('code', _code),
        _file(utf8.encode('{"data":"${'x' * 1000}"}')),
      ], target: limited),
      throwsA(_failure(413)),
    );
    await expectPreviousAndClean();
  });

  for (final (errorCode, status) in [(5, 500), (28, 507)]) {
    test(
      'write failure $errorCode preserves the previous configuration',
      () async {
        final failing = OtaConfigTransfer(
          filename: file.path,
          uploadReceiver: StreamingUploadReceiver(
            writerFactory: (temporary) async => _FailingWriter(
              await temporary.open(mode: FileMode.write),
              errorCode,
            ),
          ),
        );
        await expectLater(
          upload([
            _field('code', _code),
            _file(utf8.encode('{}')),
          ], target: failing),
          throwsA(_failure(status)),
        );
        await expectPreviousAndClean();
      },
    );
  }

  test('failed atomic publication leaves destination untouched', () async {
    await file.delete();
    final occupied = await Directory(file.path).create();
    final existing = File('${occupied.path}/previous.json');
    await existing.writeAsString(_previous);
    await expectLater(
      upload([_field('code', _code), _file(utf8.encode('{}'))]),
      throwsA(_failure(500)),
    );
    expect(await existing.readAsString(), _previous);
    expect(directory.listSync().map((entry) => entry.path), [occupied.path]);
  });

  test('cancellation before reception preserves old configuration', () async {
    final cancellation = UploadCancellationToken()..cancel();
    await expectLater(
      upload([
        _field('code', _code),
        _file(utf8.encode('{}')),
      ], cancellation: cancellation),
      throwsA(_failure(408)),
    );
    await expectPreviousAndClean();
  });

  test(
    'cancellation after reception cannot publish the staged configuration',
    () async {
      final cancelling = OtaConfigTransfer(
        filename: file.path,
        uploadReceiver: _CancellingReceiver(),
      );
      await expectLater(
        upload([
          _field('code', _code),
          _file(utf8.encode('{}')),
        ], target: cancelling),
        throwsA(_failure(408)),
      );
      await expectPreviousAndClean();
    },
  );
}
