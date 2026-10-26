import 'dart:async';
import 'dart:io';
import 'dart:math' as math;
import 'dart:typed_data';

import 'package:dslideshow_backend/src/service/gallery/gallery_catalog_service.dart';
import 'package:dslideshow_backend/src/web_server/media_file_responder.dart';
import 'package:dslideshow_common/gallery.dart';
import 'package:shelf/shelf.dart';
import 'package:test/test.dart';

class _Handle implements RandomAccessFile {
  final Uint8List bytes;
  int _position = 0;
  int closeCount = 0;
  int readCount = 0;
  _Handle(int size) : bytes = Uint8List(size);
  @override
  Future<int> length() async => bytes.length;
  @override
  Future<RandomAccessFile> setPosition(int value) async {
    _position = value;
    return this;
  }

  @override
  Future<Uint8List> read(int count) async {
    readCount++;
    final result = Uint8List.sublistView(
      bytes,
      _position,
      math.min(_position + count, bytes.length),
    );
    _position += result.length;
    return result;
  }

  @override
  Future<RandomAccessFile> close() async {
    closeCount++;
    return this;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _File implements File {
  final File delegate;
  final _Handle handle;
  final Future<void>? openGate;
  final Completer<void> openReached = Completer();
  _File(this.delegate, int size, {this.openGate}) : handle = _Handle(size);
  @override
  String get path => delegate.path;
  @override
  Future<FileStat> stat() async => delegate.statSync();
  @override
  Future<RandomAccessFile> open({FileMode mode = FileMode.read}) async {
    if (!openReached.isCompleted) openReached.complete();
    await openGate;
    return handle;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  late Directory directory;
  late File fixture;
  final responders = <MediaFileResponder>[];
  setUp(() async {
    directory = await Directory.systemTemp.createTemp('media-responder-test-');
    fixture = await File('${directory.path}/media.jpg')
        .writeAsBytes(List.filled(32, 1));
  });
  tearDown(() async {
    for (final responder in responders) {
      await responder.close();
    }
    responders.clear();
    await directory.delete(recursive: true);
  });
  MediaFileResponder create() {
    final responder = MediaFileResponder(maxStreams: 1);
    responders.add(responder);
    return responder;
  }

  Request request() => Request('GET', Uri.parse('http://localhost/media.jpg'));

  for (final range in ['bytes=2-4', 'bytes=999-']) {
    test(
      'HEAD ignores $range and retains full representation metadata',
      () async {
        final responder = create();
        final file = _File(fixture, 32);
        var releases = 0;
        final response = await responder.serve(
          Request(
            'HEAD',
            Uri.parse('http://localhost/media.jpg'),
            headers: {'range': range, 'if-range': '"strong"'},
          ),
          file,
          etag: '"strong"',
          onRelease: () async {
            releases++;
          },
        );
        expect(response.statusCode, 200);
        expect(response.contentLength, 32);
        expect(response.headers, isNot(contains('content-range')));
        expect(await response.read().toList(), isEmpty);
        expect(file.handle.readCount, 0);
        expect(file.handle.closeCount, 1);
        expect(releases, 1);
        final next = await responder.serve(request(), _File(fixture, 32));
        expect(next.statusCode, 200);
        await next.read().drain<void>();
      },
    );
  }

  test('same-second Last-Modified cannot validate If-Range after replacement', () async {
    final responder = create();
    await fixture.setLastModified(DateTime.utc(2025, 1, 1, 0, 0, 0, 200));
    final initial = await responder.serve(
      Request('HEAD', Uri.parse('http://localhost/media.jpg')),
      fixture,
    );
    await initial.read().drain<void>();
    final modified = initial.headers['last-modified']!;
    expect(initial.headers['etag'], startsWith('W/'));
    // Both versions have the same HTTP-date, despite different bytes and
    // subsecond source metadata. Returning 206 would splice different versions.
    await fixture.writeAsBytes(List.filled(32, 2));
    await fixture.setLastModified(DateTime.utc(2025, 1, 1, 0, 0, 0, 800));
    final response = await responder.serve(
      Request(
        'GET',
        Uri.parse('http://localhost/media.jpg'),
        headers: {'range': 'bytes=0-1', 'if-range': modified},
      ),
      fixture,
    );
    expect(response.headers['last-modified'], modified);
    expect(response.statusCode, 200);
    expect(response.contentLength, 32);
    expect(response.headers, isNot(contains('content-range')));
    expect(
      await response.read().expand((chunk) => chunk).toList(),
      List.filled(32, 2),
    );
  });

  test(
    'If-Range accepts an exact strong ETag and rejects its weak form',
    () async {
      final responder = create();
      for (final ifRange in ['"strong"', 'W/"strong"']) {
        final strong = ifRange == '"strong"';
        final response = await responder.serve(
          Request(
            'GET',
            Uri.parse('http://localhost/media.jpg'),
            headers: {'range': 'bytes=2-4', 'if-range': ifRange},
          ),
          _File(fixture, 32),
          etag: '"strong"',
        );
        expect(response.statusCode, strong ? 206 : 200);
        expect(response.contentLength, strong ? 3 : 32);
        expect(
          response.headers['content-range'],
          strong ? 'bytes 2-4/32' : isNull,
        );
        expect(
          await response.read().fold<int>(
            0,
            (total, chunk) => total + chunk.length,
          ),
          strong ? 3 : 32,
        );
      }
    },
  );

  test('pausing the last chunk holds admission and artifact until done', () async {
    final responder = create();
    final file = _File(fixture, 32);
    var releases = 0;
    final first = await responder.serve(
      request(),
      file,
      onRelease: () async {
        releases++;
      },
    );
    final received = Completer<void>();
    final done = Completer<void>();
    late StreamSubscription<List<int>> subscription;
    subscription = first.read().listen((bytes) {
      expect(bytes.length, 32);
      subscription.pause();
      received.complete();
    }, onDone: done.complete);
    await received.future;
    // A turn drains immediate fake handle.close Futures. This is not a timing
    // threshold: it catches release at source EOF before paused consumer done.
    await Future<void>.delayed(Duration.zero);
    final whilePaused = await responder.serve(request(), file);
    expect(whilePaused.statusCode, 429);
    await whilePaused.read().drain<void>();
    expect(done.isCompleted, isFalse);
    expect(releases, 0);
    subscription.resume();
    await done.future;
    expect(releases, 1);
    expect(file.handle.closeCount, 1);
    final afterDone = await responder.serve(request(), _File(fixture, 32));
    expect(afterDone.statusCode, 200);
    await afterDone.read().drain<void>();
  });

  test('consumer cancellation releases the slot and descriptor once', () async {
    final responder = create();
    final file = _File(fixture, 32);
    var releases = 0;
    final response = await responder.serve(
      request(),
      file,
      onRelease: () async {
        releases++;
      },
    );
    final received = Completer<void>();
    late StreamSubscription<List<int>> subscription;
    subscription = response.read().listen((_) {
      subscription.pause();
      received.complete();
    });
    await received.future;
    await subscription.cancel();
    expect(file.handle.closeCount, 1);
    expect(releases, 1);
    final next = await responder.serve(request(), _File(fixture, 32));
    expect(next.statusCode, 200);
    await next.read().drain<void>();
    await responder.close();
    expect(file.handle.closeCount, 1);
  });

  for (final code in [GalleryErrorCode.busy, GalleryErrorCode.unavailable]) {
    test(
      'late ${code.name} validation releases the handle and admission',
      () async {
        final responder = create();
        final file = _File(fixture, 32);
        final validationReached = Completer<void>();
        final validation = Completer<bool>();
        final failure = GalleryCatalogFailure(code);
        var releases = 0;
        final response = responder.serve(
          request(),
          file,
          isCurrent: () {
            validationReached.complete();
            return validation.future;
          },
          onRelease: () async {
            releases++;
          },
        );
        final failed = expectLater(response, throwsA(same(failure)));
        await validationReached.future;
        try {
          expect(file.handle.closeCount, 0);
          final waiting = await responder.serve(request(), _File(fixture, 32));
          expect(waiting.statusCode, 429);
          await waiting.read().drain<void>();
        } finally {
          validation.completeError(failure);
        }
        await failed;
        expect(file.handle.closeCount, 1);
        expect(file.handle.readCount, 0);
        expect(releases, 1);
        final next = await responder.serve(request(), _File(fixture, 32));
        expect(next.statusCode, 200);
        await next.read().drain<void>();
        await responder.close();
        expect(file.handle.closeCount, 1);
        expect(releases, 1);
      },
    );
  }

  test(
    'close releases an unlistened response without awaiting a consumer',
    () async {
      final responder = create();
      final file = _File(fixture, 32);
      var releases = 0;
      final response = await responder.serve(
        request(),
        file,
        onRelease: () async {
          releases++;
        },
      );
      await responder.close().timeout(const Duration(seconds: 5));
      expect(file.handle.closeCount, 1);
      expect(file.handle.readCount, 0);
      expect(releases, 1);
      expect(await response.read().toList(), isEmpty);
      await responder.close();
      expect(releases, 1);
    },
  );

  test(
    'close waits for an admitted pending open and prevents late body',
    () async {
      final responder = create();
      final gate = Completer<void>();
      final file = _File(fixture, 32, openGate: gate.future);
      var releases = 0;
      final response = responder.serve(
        request(),
        file,
        onRelease: () async {
          releases++;
        },
      );
      await file.openReached.future;
      var closed = false;
      final closing = responder.close().then((_) {
        closed = true;
      });
      await Future<void>.delayed(Duration.zero);
      expect(closed, isFalse);
      gate.complete();
      final result = await response;
      expect(result.statusCode, 503);
      await result.read().drain<void>();
      await closing;
      expect(file.handle.closeCount, 1);
      expect(file.handle.readCount, 0);
      expect(releases, 1);
    },
  );
}
