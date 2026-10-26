import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dslideshow_backend/src/service/upload/streaming_upload.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:shelf/shelf.dart';
import 'package:test/test.dart';

const _boundary = 'upload-test-boundary';

class _Part {
  final String disposition;
  final List<int> bytes;

  _Part.file(String filename, String content)
    : disposition = 'form-data; name="file"; filename="$filename"',
      bytes = utf8.encode(content);

  _Part.field(String name, String content)
    : disposition = 'form-data; name="$name"',
      bytes = utf8.encode(content);

  _Part(this.disposition, this.bytes);
}

List<int> _multipart(List<_Part> parts) => [
  for (final part in parts) ...[
    ...utf8.encode('--$_boundary\r\n'),
    ...utf8.encode('Content-Disposition: ${part.disposition}\r\n\r\n'),
    ...part.bytes,
    ...utf8.encode('\r\n'),
  ],
  ...utf8.encode('--$_boundary--\r\n'),
];

Stream<List<int>> _chunks(List<int> bytes, [int size = 7]) async* {
  for (var i = 0; i < bytes.length; i += size) {
    yield bytes.sublist(i, (i + size).clamp(0, bytes.length));
  }
}

Request _request(
  List<int> bytes, {
  int? contentLength,
  int chunkSize = 7,
  Stream<List<int>>? stream,
  String contentType = 'multipart/form-data; boundary=$_boundary',
}) => Request(
  'POST',
  Uri.parse('http://localhost/upload'),
  headers: {
    'content-type': contentType,
    if (contentLength != null) 'content-length': '$contentLength',
  },
  body: stream ?? _chunks(bytes, chunkSize),
);

Matcher _status(int status) => isA<UploadFailure>().having(
  (error) => error.statusCode,
  'statusCode',
  status,
);

class _Writer implements UploadFileWriter {
  final RandomAccessFile file;
  final Completer<void> writing = Completer<void>();
  final Completer<void> closing = Completer<void>();
  Completer<void>? closeGate;
  Completer<void>? writeGate;
  Object? writeError;
  Object? flushError;
  Object? closeError;
  int closeCalls = 0;

  _Writer(this.file);

  @override
  Future<void> write(List<int> bytes) async {
    if (!writing.isCompleted) writing.complete();
    if (writeGate != null) await writeGate!.future;
    if (writeError != null) throw writeError!;
    await file.writeFrom(bytes);
  }

  @override
  Future<void> flush() async {
    if (flushError != null) throw flushError!;
    await file.flush();
  }

  @override
  Future<void> close() async {
    closeCalls++;
    if (!closing.isCompleted) closing.complete();
    if (closeGate != null) await closeGate!.future;
    await file.close();
    if (closeError != null) throw closeError!;
  }
}

void main() {
  late Directory root;

  setUp(() async {
    root = await Directory.systemTemp.createTemp('streaming-upload-test-');
  });

  tearDown(() async {
    await root.delete(recursive: true);
  });

  String destination(String filename) => path.join(root.path, filename);

  Future<List<FileSystemEntity>> leftovers() =>
      root.list(recursive: true).toList();

  for (final chunkSize in [1, 2, 7, 256]) {
    test('separate files and split boundaries with $chunkSize-byte chunks', () async {
      final bytes = _multipart([
        _Part.file(
          'one.jpg',
          'first\r\n--${_boundary}x is data\r\n--$_boundary--x\r\n--$_boundary \tx\r\nend',
        ),
        _Part.file('nested/two.jpg', 'second\u0000\u00ff'),
      ]);
      final batch = await StreamingUploadReceiver().receiveMultipart(
        _request(bytes, chunkSize: chunkSize),
        destinationFor: destination,
      );
      expect(batch.receivedBytes, bytes.length);
      expect(batch.files.map((file) => file.filename), [
        'one.jpg',
        'nested/two.jpg',
      ]);
      expect(File(destination('one.jpg')).existsSync(), isFalse);
      expect(
        await batch.files[0].temporary.readAsString(),
        'first\r\n--${_boundary}x is data\r\n--$_boundary--x\r\n--$_boundary \tx\r\nend',
      );
      expect(
        await batch.files[1].temporary.readAsString(),
        'second\u0000\u00ff',
      );
      for (final file in batch.files) {
        expect(file.temporary.path.endsWith('.part'), isTrue);
        expect(file.temporary.parent.path, File(file.destination).parent.path);
        await file.publish();
      }
      await batch.cleanup();
      expect(
        await File(destination('one.jpg')).readAsString(),
        'first\r\n--${_boundary}x is data\r\n--$_boundary--x\r\n--$_boundary \tx\r\nend',
      );
      expect(
        (await leftovers()).where((file) => file.path.endsWith('.part')),
        isEmpty,
      );
    });
  }

  test('accepts existing http.MultipartRequest encoding', () async {
    final request =
        http.MultipartRequest('POST', Uri.parse('http://localhost/upload'))
          ..fields['code'] = '12345'
          ..files.add(
            http.MultipartFile.fromString(
              'file',
              'firmware',
              filename: 'release.deb',
            ),
          );
    final stream = request.finalize();
    final receivedFields = <String, String>{};
    final batch = await StreamingUploadReceiver().receiveMultipart(
      Request('POST', request.url, headers: request.headers, body: stream),
      destinationFor: destination,
      onField: (name, value) {
        receivedFields[name] = value;
      },
    );
    expect(receivedFields, {'code': '12345'});
    expect(await batch.files.single.temporary.readAsString(), 'firmware');
    await batch.cleanup();
  });

  test(
    'real multipart client preserves Unicode filename and every binary byte',
    () async {
      final bytes = List<int>.generate(256, (index) => index);
      final request =
          http.MultipartRequest('POST', Uri.parse('http://localhost/upload'))
            ..files.add(
              http.MultipartFile.fromBytes(
                'file',
                bytes,
                filename: 'album/лето 01.jpg',
              ),
            );
      final stream = request.finalize();
      final batch = await StreamingUploadReceiver().receiveMultipart(
        Request('POST', request.url, headers: request.headers, body: stream),
        destinationFor: destination,
      );
      expect(batch.files.single.filename, 'album/лето 01.jpg');
      expect(await batch.files.single.temporary.readAsBytes(), bytes);
      await batch.files.single.publish();
      await batch.cleanup();
      expect(await File(destination('album/лето 01.jpg')).readAsBytes(), bytes);
    },
  );

  test(
    'accepts preamble, transport padding, epilogue and final boundary at EOF',
    () async {
      final canonical = utf8.decode(_multipart([_Part.file('x', 'payload')]));
      for (final body in [
        canonical.substring(0, canonical.length - 2),
        'Preamble ignored\r\n$canonical',
        canonical
            .replaceAll('--$_boundary\r\n', '--$_boundary \t\r\n')
            .replaceAll('--$_boundary--\r\n', '--$_boundary-- \t\r\n'),
        '${canonical}Epilogue ignored',
      ]) {
        final batch = await StreamingUploadReceiver().receiveMultipart(
          _request(utf8.encode(body), chunkSize: 1),
          destinationFor: destination,
        );
        expect(await batch.files.single.temporary.readAsString(), 'payload');
        await batch.cleanup();
      }
    },
  );

  test(
    'waits for close before returning; replacement waits for publish',
    () async {
      await File(destination('one.jpg')).writeAsString('old');
      final gate = Completer<void>();
      final opened = Completer<_Writer>();
      final receiver = StreamingUploadReceiver(
        writerFactory: (file) async {
          final writer = _Writer(await file.open(mode: FileMode.write))
            ..closeGate = gate;
          opened.complete(writer);
          return writer;
        },
      );
      var completed = false;
      final result = receiver
          .receiveMultipart(
            _request(_multipart([_Part.file('one.jpg', 'new')])),
            destinationFor: destination,
          )
          .then((batch) {
            completed = true;
            return batch;
          });
      final writer = await opened.future;
      await writer.closing.future;
      expect(completed, isFalse);
      expect(await File(destination('one.jpg')).readAsString(), 'old');
      gate.complete();
      final batch = await result;
      expect(writer.closeCalls, 1);
      await batch.files.single.publish();
      await batch.cleanup();
      expect(await File(destination('one.jpg')).readAsString(), 'new');
      expect(writer.closeCalls, 1);
    },
  );

  test(
    'legacy field callback runs before opening file; missing auth opens none',
    () async {
      var authorised = false;
      var opens = 0;
      final receiver = StreamingUploadReceiver(
        writerFactory: (file) async {
          opens++;
          return _Writer(await file.open(mode: FileMode.write));
        },
      );
      Future<StagedUploadBatch> receive(List<_Part> parts) =>
          receiver.receiveMultipart(
            _request(_multipart(parts)),
            destinationFor: destination,
            onField: (name, value) {
              expect(name, 'code');
              if (value != '12345')
                throw const UploadFailure(403, 'Incorrect code');
              authorised = true;
            },
            beforeFile: (_) {
              if (!authorised) throw const UploadFailure(403, 'Code required');
            },
          );
      await expectLater(
        receive([_Part.field('code', 'wrong'), _Part.file('x.deb', 'x')]),
        throwsA(_status(403)),
      );
      await expectLater(
        receive([_Part.file('x.deb', 'x')]),
        throwsA(_status(403)),
      );
      expect(opens, 0);
      expect(await leftovers(), isEmpty);
      final batch = await receive([
        _Part.field('code', '12345'),
        _Part.file('x.deb', 'x'),
      ]);
      expect(opens, 1);
      await batch.cleanup();
    },
  );

  test(
    'real bytes enforce limit without Content-Length, including epilogue',
    () async {
      final bytes = _multipart([_Part.file('one.jpg', 'abc')]);
      final receiver = StreamingUploadReceiver(
        limits: UploadLimits(maxBytes: bytes.length),
      );
      final batch = await receiver.receiveMultipart(
        _request(bytes),
        destinationFor: destination,
      );
      await batch.cleanup();
      await expectLater(
        receiver.receiveMultipart(
          _request([...bytes, 1]),
          destinationFor: destination,
        ),
        throwsA(_status(413)),
      );
      expect(await leftovers(), isEmpty);
    },
  );

  test(
    'known oversized length is rejected without subscribing to body',
    () async {
      var listened = false;
      final stream = StreamController<List<int>>(
        onListen: () {
          listened = true;
        },
      );
      final receiver = StreamingUploadReceiver(
        limits: const UploadLimits(maxBytes: 10),
      );
      await expectLater(
        receiver.receiveMultipart(
          _request([], stream: stream.stream, contentLength: 11),
          destinationFor: destination,
        ),
        throwsA(_status(413)),
      );
      expect(listened, isFalse);
      final subscription = stream.stream.listen((_) {});
      await stream.close();
      await subscription.cancel();
    },
  );

  test('false small length does not bypass actual byte limit', () async {
    final receiver = StreamingUploadReceiver(
      limits: const UploadLimits(maxBytes: 100),
    );
    await expectLater(
      receiver.receiveMultipart(
        _request(_multipart([_Part.file('x', 'abcdef')]), contentLength: 1),
        destinationFor: destination,
      ),
      throwsA(_status(413)),
    );
    expect(await leftovers(), isEmpty);
  });

  test(
    'raw stream and malformed multipart errors clean all staged files',
    () async {
      final bytes = _multipart([
        _Part.file('one.jpg', 'abc'),
        _Part.file('two.jpg', 'def'),
      ]);
      final receiver = StreamingUploadReceiver();
      await expectLater(
        receiver.receiveMultipart(
          _request(bytes.sublist(0, bytes.length - 8)),
          destinationFor: destination,
        ),
        throwsA(_status(400)),
      );
      expect(await leftovers(), isEmpty);
      Stream<List<int>> broken() async* {
        yield bytes.sublist(0, bytes.length - 8);
        throw const SocketException('connection lost');
      }

      await expectLater(
        receiver.receiveMultipart(
          _request([], stream: broken()),
          destinationFor: destination,
        ),
        throwsA(_status(400)),
      );
      expect(await leftovers(), isEmpty);
    },
  );

  test('limits fields, headers, file count, and total part count', () async {
    final cases = [
      (
        const UploadLimits(maxFieldBytes: 2),
        [_Part.field('code', 'abc'), _Part.file('x', 'x')],
      ),
      (
        const UploadLimits(maxHeaderBytes: 60),
        [_Part.file('long-filename-for-header-limit.jpg', 'x')],
      ),
      (
        const UploadLimits(maxFiles: 1),
        [_Part.file('x', 'x'), _Part.file('y', 'y')],
      ),
      (
        const UploadLimits(maxParts: 1),
        [_Part.field('code', 'a'), _Part.file('x', 'x')],
      ),
    ];
    for (final (limits, parts) in cases) {
      await expectLater(
        StreamingUploadReceiver(limits: limits).receiveMultipart(
          _request(_multipart(parts)),
          destinationFor: destination,
          onField: (_, _) {},
        ),
        throwsA(_status(413)),
      );
      expect(await leftovers(), isEmpty);
    }
  });

  test(
    'unknown or malformed parts fail explicitly instead of buffering',
    () async {
      for (final part in [
        _Part('form-data; filename="x"', [1]),
        _Part('form-data; name="other"; filename="x"', [1]),
        _Part('form-data; name="file"', [1]),
        _Part('form-data; name="file"; filename=""', [1]),
        _Part('form-data; name="file"; filename="unterminated', [1]),
      ]) {
        await expectLater(
          StreamingUploadReceiver().receiveMultipart(
            _request(_multipart([part])),
            destinationFor: destination,
          ),
          throwsA(_status(400)),
        );
        expect(await leftovers(), isEmpty);
      }
    },
  );

  for (final failure in ['write', 'flush', 'close', 'space']) {
    test('$failure failure is awaited and removes staging', () async {
      final opened = <_Writer>[];
      final receiver = StreamingUploadReceiver(
        writerFactory: (file) async {
          final writer = _Writer(await file.open(mode: FileMode.write));
          switch (failure) {
            case 'write':
              writer.writeError = StateError('failed');
            case 'flush':
              writer.flushError = StateError('failed');
            case 'close':
              writer.closeError = StateError('failed');
            case 'space':
              writer.writeError = const FileSystemException(
                'disk',
                '/private/path',
                OSError('no space', 28),
              );
          }
          opened.add(writer);
          return writer;
        },
      );
      await expectLater(
        receiver.receiveMultipart(
          _request(_multipart([_Part.file('one.jpg', 'abc')])),
          destinationFor: destination,
        ),
        throwsA(_status(failure == 'space' ? 507 : 500)),
      );
      expect(await leftovers(), isEmpty);
      expect(opened.single.closeCalls, 1);
      // Failure released the destination reservation.
      final staged = await StreamingUploadReceiver().receiveStream(
        Stream.value([1]),
        filename: 'one.jpg',
        destination: destination('one.jpg'),
      );
      await staged.cleanup();
    });
  }

  test(
    'duplicate and concurrent destinations conflict until cleanup',
    () async {
      final receiver = StreamingUploadReceiver();
      await expectLater(
        receiver.receiveMultipart(
          _request(
            _multipart([_Part.file('x', 'first'), _Part.file('x', 'second')]),
          ),
          destinationFor: destination,
        ),
        throwsA(_status(409)),
      );
      expect(await leftovers(), isEmpty);
      final first = await receiver.receiveStream(
        Stream.value([1]),
        filename: 'x',
        destination: destination('x'),
      );
      await first.publish();
      await expectLater(
        receiver.receiveStream(
          Stream.value([2]),
          filename: 'x',
          destination: destination('x'),
        ),
        throwsA(_status(409)),
      );
      await first.cleanup();
      await first.cleanup();
      final second = await receiver.receiveStream(
        Stream.value([2]),
        filename: 'x',
        destination: destination('x'),
      );
      await second.publish();
      await second.cleanup();
      expect(await File(destination('x')).readAsBytes(), [2]);
    },
  );

  test(
    'publish failure keeps finished earlier files and cleans remaining parts',
    () async {
      final batch = await StreamingUploadReceiver().receiveMultipart(
        _request(_multipart([_Part.file('one', '1'), _Part.file('two', '2')])),
        destinationFor: destination,
      );
      await batch.files.first.publish();
      await Directory(destination('two')).create();
      await expectLater(batch.files.last.publish(), throwsA(_status(500)));
      await batch.cleanup();
      expect(await File(destination('one')).readAsString(), '1');
      expect(
        (await leftovers()).where((file) => file.path.endsWith('.part')),
        isEmpty,
      );
    },
  );

  test(
    'cancel wakes stalled source, cancels subscription, and frees target',
    () async {
      final token = UploadCancellationToken();
      var cancelled = false;
      final source = StreamController<List<int>>(
        onCancel: () {
          cancelled = true;
        },
      );
      final receiver = StreamingUploadReceiver();
      final receiving = receiver.receiveStream(
        source.stream,
        filename: 'x',
        destination: destination('x'),
        cancellation: token,
      );
      final expectation = expectLater(receiving, throwsA(_status(408)));
      while (!(await leftovers()).any((file) => file.path.endsWith('.part'))) {
        await Future<void>.delayed(Duration.zero);
      }
      token.cancel();
      await expectation.timeout(const Duration(seconds: 1));
      expect(cancelled, isTrue);
      expect(await leftovers(), isEmpty);
      await source.close();
      final file = await receiver.receiveStream(
        Stream.value([1]),
        filename: 'x',
        destination: destination('x'),
      );
      await file.cleanup();
    },
  );

  test(
    'cancel does not wait for close and observes its late failure',
    () async {
      final token = UploadCancellationToken();
      final gate = Completer<void>();
      final opened = Completer<_Writer>();
      final receiver = StreamingUploadReceiver(
        writerFactory: (file) async {
          final writer = _Writer(await file.open(mode: FileMode.write))
            ..closeGate = gate
            ..closeError = StateError('late close failure');
          opened.complete(writer);
          return writer;
        },
      );
      final receiving = receiver.receiveStream(
        Stream.value([1]),
        filename: 'x',
        destination: destination('x'),
        cancellation: token,
      );
      final expectation = expectLater(receiving, throwsA(_status(408)));
      final writer = await opened.future;
      await writer.closing.future;
      token.cancel();
      await expectation.timeout(const Duration(seconds: 1));
      expect(await leftovers(), isEmpty);
      gate.complete();
      await Future<void>.delayed(const Duration(milliseconds: 10));
      expect(writer.closeCalls, 1);
    },
  );

  test('backpressure and cancellation bound a stalled write', () async {
    final token = UploadCancellationToken();
    final gate = Completer<void>();
    final opened = Completer<_Writer>();
    var chunksRead = 0;
    Stream<List<int>> source() async* {
      for (var i = 0; i < 10000; i++) {
        chunksRead++;
        yield [i % 256];
      }
    }

    final receiver = StreamingUploadReceiver(
      writerFactory: (file) async {
        final writer = _Writer(await file.open(mode: FileMode.write))
          ..writeGate = gate
          ..writeError = StateError('late failed write');
        opened.complete(writer);
        return writer;
      },
    );
    final receiving = receiver.receiveStream(
      source(),
      filename: 'x',
      destination: destination('x'),
      cancellation: token,
    );
    final expectation = expectLater(receiving, throwsA(_status(408)));
    final writer = await opened.future;
    await writer.writing.future;
    await Future<void>.delayed(Duration.zero);
    expect(chunksRead, 1);
    token.cancel();
    await expectation.timeout(const Duration(seconds: 1));
    expect(await leftovers(), isEmpty);
    gate.complete();
    await writer.closing.future;
    await Future<void>.delayed(const Duration(milliseconds: 10));
    expect(writer.closeCalls, 1);
  });

  test('cancelled late writer open cannot recreate an orphan part', () async {
    final token = UploadCancellationToken();
    final opening = Completer<void>();
    final gate = Completer<void>();
    final closed = Completer<void>();
    final receiver = StreamingUploadReceiver(
      writerFactory: (file) async {
        opening.complete();
        await gate.future;
        final writer = _Writer(await file.open(mode: FileMode.write));
        writer.closing.future.then((_) => closed.complete());
        return writer;
      },
    );
    final receiving = receiver.receiveStream(
      Stream.value([1]),
      filename: 'x',
      destination: destination('x'),
      cancellation: token,
    );
    final expectation = expectLater(receiving, throwsA(_status(408)));
    await opening.future;
    token.cancel();
    await expectation;
    expect(await leftovers(), isEmpty);
    gate.complete();
    await closed.future;
    // The close completion also performs cleanup of a recreated temporary file.
    while ((await leftovers()).isNotEmpty) {
      await Future<void>.delayed(Duration.zero);
    }
  });

  test('late failed writer factory cleans a recreated part', () async {
    final token = UploadCancellationToken();
    final gate = Completer<void>();
    final opening = Completer<void>();
    final failed = Completer<void>();
    final receiver = StreamingUploadReceiver(
      writerFactory: (file) async {
        opening.complete();
        await gate.future;
        await file.writeAsString('recreated');
        failed.complete();
        throw StateError('late open failure');
      },
    );
    final receiving = receiver.receiveStream(
      Stream.value([1]),
      filename: 'x',
      destination: destination('x'),
      cancellation: token,
    );
    final expectation = expectLater(receiving, throwsA(_status(408)));
    await opening.future;
    token.cancel();
    await expectation;
    expect(await leftovers(), isEmpty);
    gate.complete();
    await failed.future;
    while ((await leftovers()).isNotEmpty) {
      await Future<void>.delayed(Duration.zero);
    }
  });

  test('idle deadline and total deadline release unfinished staging', () async {
    for (final limits in [
      const UploadLimits(idleTimeout: Duration(milliseconds: 20)),
      const UploadLimits(totalTimeout: Duration(milliseconds: 20)),
    ]) {
      final source = StreamController<List<int>>();
      await expectLater(
        StreamingUploadReceiver(limits: limits).receiveStream(
          source.stream,
          filename: 'x',
          destination: destination('x'),
        ),
        throwsA(_status(408)),
      );
      expect(await leftovers(), isEmpty);
      await source.close();
    }
  });

  test('failure cleanup close is also bounded by total deadline', () async {
    final gate = Completer<void>();
    final receiver = StreamingUploadReceiver(
      limits: const UploadLimits(totalTimeout: Duration(milliseconds: 30)),
      writerFactory: (file) async =>
          _Writer(await file.open(mode: FileMode.write))
            ..writeError = StateError('write failed')
            ..closeGate = gate,
    );
    await expectLater(
      receiver.receiveStream(
        Stream.value([1]),
        filename: 'x',
        destination: destination('x'),
      ),
      throwsA(_status(500)),
    ).timeout(const Duration(seconds: 1));
    expect(await leftovers(), isEmpty);
    gate.complete();
    await Future<void>.delayed(const Duration(milliseconds: 10));
  });

  test(
    'progress is throttled and final actual byte count is delivered',
    () async {
      final updates = <(int, int?)>[];
      final bytes = _multipart([_Part.file('x', 'a' * 1000)]);
      final batch = await StreamingUploadReceiver().receiveMultipart(
        _request(bytes, chunkSize: 1),
        destinationFor: destination,
        onProgress: (received, total) => updates.add((received, total)),
      );
      expect(updates.length, lessThan(5));
      expect(updates.last, (bytes.length, null));
      await batch.cleanup();
    },
  );

  test('error mapping hides paths and distinguishes storage exhaustion', () {
    expect(
      uploadFailureFor(
        const FileSystemException('secret', '/secret', OSError('quota', 122)),
      ).statusCode,
      507,
    );
    final error = uploadFailureFor(
      const FileSystemException('secret', '/secret'),
    );
    expect(error.statusCode, 500);
    expect(error.message, isNot(contains('secret')));
    expect(uploadFailureFor(const FormatException('secret')).statusCode, 400);
  });
}
