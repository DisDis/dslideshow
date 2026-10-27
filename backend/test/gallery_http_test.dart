import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_backend/src/service/gallery/gallery_publication.dart';
import 'package:dslideshow_backend/src/service/gallery/thumbnail_service.dart';
import 'package:dslideshow_backend/src/web_server/web_service.dart';
import 'package:dslideshow_backend/src/web_server/media_file_responder.dart';
import 'package:dslideshow_common/gallery.dart';
import 'package:dslideshow_common/rpc.dart';
import 'package:image/image.dart' as image;
import 'package:shelf/shelf.dart';
import 'package:test/test.dart';

import 'helpers/capture_logs.dart';

class _Remote implements RemoteService {
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  late Directory root;
  late Directory media;
  late WebService service;
  var missingEncoder = false;
  var galleryConfig = const GalleryConfig();
  setUp(() async {
    root = await Directory.systemTemp.createTemp('gallery-http-test-');
    media = await Directory('${root.path}/media').create();
    await Directory('${root.path}/web').create();
    final cwd = Directory.current;
    try {
      Directory.current = root;
      final config = AppConfig.fromJson({})..gallery = galleryConfig;
      service = WebService(
        config,
        config.webServer,
        _Remote(),
        cacheDirectory: media,
        galleryDirectory: Directory('${root.path}/gallery'),
        startServer: false,
        thumbnailWorker: FfmpegThumbnailWorker(
          ffmpegExecutable: missingEncoder ? '${root.path}/missing' : 'ffmpeg',
        ),
      );
    } finally {
      Directory.current = cwd;
    }
  });
  tearDown(() async {
    await service.close();
    await root.delete(recursive: true);
  });
  Future<Response> request(
    String tail, {
    String method = 'GET',
    Map<String, String> headers = const {},
    String? body,
  }) async => service.handler(
    Request(
      method,
      Uri.parse('http://localhost/cache/${service.code}/$tail'),
      headers: headers,
      body: body,
    ),
  );
  test('thumbnail bytes, HEAD, cache validator, stale revision and original remain distinct', () async {
    final picture = image.Image(width: 600, height: 400)
      ..clear(image.ColorRgb8(20, 100, 200));
    final original = image.encodeJpg(picture);
    await File('${media.path}/photo.jpg').writeAsBytes(original);
    final catalogResponse = await request('v2/catalog');
    expect(catalogResponse.statusCode, 200);
    final catalog = GalleryCatalog.fromJson(
      jsonDecode(await catalogResponse.readAsString()) as Map<String, dynamic>,
    );
    expect(catalog.thumbnailPolicy!.version, thumbnailPolicyVersion);
    final entry = catalog.entries.single;
    final tail =
        'v2/thumbnail/${entry.mediaId}/${entry.sourceRevision}/${catalog.thumbnailPolicy!.identity}/256';
    final outdated = await request(
      'v2/thumbnail/${entry.mediaId}/${entry.sourceRevision}/1/256',
    );
    expect(outdated.statusCode, 409);
    await outdated.read().drain<void>();
    final thumb = await request(tail);
    expect(thumb.statusCode, 200);
    final bytes = await thumb.read().expand((chunk) => chunk).toList();
    expect(thumb.headers['etag'], '"${md5.convert(bytes)}"');
    final decoded = image.decodeImage(Uint8List.fromList(bytes))!;
    expect(decoded.width, 256);
    expect(decoded.height, 256);
    final head = await request(tail, method: 'HEAD');
    expect(head.contentLength, bytes.length);
    expect(
      await head.read().fold<int>(0, (sum, chunk) => sum + chunk.length),
      0,
    );
    final cached = await request(
      tail,
      headers: {'if-none-match': thumb.headers['etag']!},
    );
    expect(cached.statusCode, 304);
    await cached.read().drain<void>();
    final full = await request('get/photo.jpg?rev=${entry.sourceRevision}');
    expect(await full.read().expand((chunk) => chunk).toList(), original);
    final refresh = await request(
      'v2/catalog/refresh',
      method: 'POST',
      headers: {'content-type': 'application/json'},
      body: jsonEncode(
        const GalleryRefreshRequest(
          operationId: 'force',
          mode: GalleryRefreshMode.forceInvalidate,
        ).toJson(),
      ),
    );
    expect(refresh.statusCode, 200);
    await refresh.read().drain<void>();
    final stale = await request(tail);
    expect(stale.statusCode, 409);
    await stale.read().drain<void>();
  });
  group('without FFmpeg', () {
    setUpAll(() => missingEncoder = true);
    tearDownAll(() => missingEncoder = false);
    test(
      'thumbnail is 503 while original remains available',
      () => captureLogs((records) async {
        final original = image.encodePng(image.Image(width: 8, height: 8));
        await File('${media.path}/photo.png').writeAsBytes(original);
        final response = await request('v2/catalog');
        final catalog = GalleryCatalog.fromJson(
          jsonDecode(await response.readAsString()) as Map<String, dynamic>,
        );
        final entry = catalog.entries.single;
        final thumbnail = await request(
          'v2/thumbnail/${entry.mediaId}/${entry.sourceRevision}/${catalog.thumbnailPolicy!.identity}/256',
        );
        expect(thumbnail.statusCode, 503);
        expect(await thumbnail.readAsString(), isNot(contains(root.path)));
        final full = await request('get/photo.png?rev=${entry.sourceRevision}');
        expect(await full.read().expand((chunk) => chunk).toList(), original);
        final diagnostic = records.singleWhere(
          (record) => record.message.startsWith('Gallery thumbnail rejected'),
        );
        expect(diagnostic.message, contains('status=503'));
        expect(diagnostic.message, contains('reason=unavailable'));
        expect(diagnostic.message, contains(entry.mediaId));
        expect(diagnostic.error, isA<ThumbnailFailure>());
        expect(
          records.any(
            (record) => record.message.contains('/cache/${service.code}/'),
          ),
          isFalse,
        );
      }),
    );
  });
  group('gallery configuration', () {
    setUpAll(
      () => galleryConfig = const GalleryConfig(
        maxConcurrentMediaStreams: 1,
        thumbnail: GalleryThumbnailConfig(
          sizes: [GalleryThumbnailSize.small],
          jpegQuality: 95,
          backgroundColor: 0xffffffff,
          frameSelectionFrames: 5,
        ),
      ),
    );
    tearDownAll(() => galleryConfig = const GalleryConfig());

    test('advertises configured buckets and renders JPEG on configured background', () async {
      final original = image.encodePng(
        image.Image(width: 20, height: 20, numChannels: 4),
      );
      await File('${media.path}/alpha.png').writeAsBytes(original);
      final response = await request('v2/catalog');
      final catalog = GalleryCatalog.fromJson(
        jsonDecode(await response.readAsString()) as Map<String, dynamic>,
      );
      final policy = catalog.thumbnailPolicy!;
      expect(policy.sizes, [GalleryThumbnailSize.small]);
      expect(
        policy.identity,
        ThumbnailPolicy.fromConfig(galleryConfig.thumbnail)
            .catalogPolicy
            .identity,
      );
      final entry = catalog.entries.single;
      final tail =
          'v2/thumbnail/${entry.mediaId}/${entry.sourceRevision}/${policy.identity}';
      final invalidSize = await request('$tail/512');
      expect(invalidSize.statusCode, 400);
      await invalidSize.read().drain<void>();
      // An open client with the previous size list must refresh its catalog.
      final previousPolicy = const ThumbnailPolicy().catalogPolicy.identity;
      final oldCatalog = await request(
        'v2/thumbnail/${entry.mediaId}/${entry.sourceRevision}/$previousPolicy/512',
      );
      expect(oldCatalog.statusCode, 409);
      await oldCatalog.read().drain<void>();
      final responseJpeg = await request('$tail/256');
      expect(responseJpeg.statusCode, 200);
      expect(responseJpeg.headers['content-type'], 'image/jpeg');
      final bytes = Uint8List.fromList(
        await responseJpeg.read().expand((chunk) => chunk).toList(),
      );
      final jpeg = image.decodeJpg(bytes)!;
      expect(jpeg.width, 20);
      expect(jpeg.getPixel(10, 10).r, greaterThan(245));
      expect(jpeg.getPixel(10, 10).g, greaterThan(245));
      expect(jpeg.getPixel(10, 10).b, greaterThan(245));
      final full = await request('get/alpha.png?rev=${entry.sourceRevision}');
      expect(await full.read().expand((chunk) => chunk).toList(), original);
    });

    test(
      'configured media stream cap lasts until the first body is consumed',
      () async {
        await File('${media.path}/photo.jpg')
            .writeAsBytes(List.filled(200000, 7));
        final first = await request('get/photo.jpg');
        expect(first.statusCode, 200);
        final blocked = await request('get/photo.jpg');
        expect(blocked.statusCode, 429);
        await blocked.read().drain<void>();
        await first.read().drain<void>();
        final next = await request('get/photo.jpg');
        expect(next.statusCode, 200);
        await next.read().drain<void>();
      },
    );
  });
  test(
    'original conditional, Range, HEAD and CORS preserve the HTTP contract',
    () async {
      await File('${media.path}/video.mp4').writeAsString('0123456789');
      final first = await request('get/video.mp4');
      final etag = first.headers['etag']!;
      expect(await first.readAsString(), '0123456789');
      final range = await request(
        'get/video.mp4',
        headers: {'range': 'bytes=2-4'},
      );
      expect(range.statusCode, 206);
      expect(await range.readAsString(), '234');
      final unsat = await request(
        'get/video.mp4',
        headers: {'range': 'bytes=99-'},
      );
      expect(unsat.statusCode, 416);
      expect(unsat.headers['content-range'], 'bytes */10');
      await unsat.read().drain<void>();
      final ifRange = await request(
        'get/video.mp4',
        headers: {
          'range': 'bytes=2-4',
          'if-range': 'Tue, 15 Nov 1994 12:45:26 GMT',
        },
      );
      expect(ifRange.statusCode, 200);
      expect(await ifRange.readAsString(), '0123456789');
      final unchanged = await request(
        'get/video.mp4',
        headers: {'if-none-match': etag},
      );
      expect(unchanged.statusCode, 304);
      await unchanged.read().drain<void>();
      final options = await request('get/video.mp4', method: 'OPTIONS');
      expect(options.statusCode, 204);
      expect(
        options.headers['access-control-allow-headers'],
        contains('If-None-Match'),
      );
      await options.read().drain<void>();
    },
  );
  test(
    'revisioned original returns a typed temporary publication failure',
    () async {
      await File('${media.path}/photo.jpg').writeAsString('original');
      Future<GalleryCatalog> catalog() async {
        final response = await request('v2/catalog');
        expect(response.statusCode, 200);
        return GalleryCatalog.fromJson(
          jsonDecode(await response.readAsString()) as Map<String, dynamic>,
        );
      }

      final initial = (await catalog()).entries.single;
      final publication = await GalleryPublication.begin(
        Directory('${root.path}/gallery'),
        'photo.jpg',
      );
      try {
        final unavailable = await request(
          'get/photo.jpg?rev=${initial.sourceRevision}',
        );
        expect(unavailable.statusCode, 503);
        expect(unavailable.headers['access-control-allow-origin'], '*');
        expect(unavailable.headers['cache-control'], 'no-store');
        expect(unavailable.headers['retry-after'], '1');
        expect(
          GalleryErrorResponse.fromJson(
            jsonDecode(await unavailable.readAsString())
                as Map<String, dynamic>,
          ).code,
          GalleryErrorCode.unavailable,
        );
      } finally {
        await publication.finish();
      }
      final stale = await request(
        'get/photo.jpg?rev=${initial.sourceRevision}',
      );
      expect(stale.statusCode, 409);
      expect(stale.headers['access-control-allow-origin'], '*');
      expect(
        GalleryErrorResponse.fromJson(
          jsonDecode(await stale.readAsString()) as Map<String, dynamic>,
        ).code,
        GalleryErrorCode.revisionMismatch,
      );
      final current = (await catalog()).entries.single;
      final recovered = await request(
        'get/photo.jpg?rev=${current.sourceRevision}',
      );
      expect(recovered.statusCode, 200);
      expect(await recovered.readAsString(), 'original');
    },
  );
  test('media cap lasts until body completion/cancel, including unconsumed responses', () async {
    final file = await File('${media.path}/large.bin')
        .writeAsBytes(List.filled(200000, 7));
    final responder = MediaFileResponder(maxStreams: 1);
    addTearDown(responder.close);
    final req = Request('GET', Uri.parse('http://localhost/x'));
    final first = await responder.serve(req, file);
    expect((await responder.serve(req, file)).statusCode, 429);
    final subscription = first.read().listen((_) {});
    subscription.pause();
    await subscription.cancel();
    final next = await responder.serve(
      Request('HEAD', Uri.parse('http://localhost/x')),
      file,
    );
    expect(next.statusCode, 200);
    await next.read().drain<void>();
    final unopened = await responder.serve(req, file);
    expect(unopened.statusCode, 200);
    await responder.close();
    expect((await responder.serve(req, file)).statusCode, 503);
  });

  test(
    'file read failures are logged without exposing paths in HTTP',
    () => captureLogs((records) async {
      final file = await File('${media.path}/photo.jpg')
          .writeAsString('original');
      final responder = MediaFileResponder();
      addTearDown(responder.close);
      final response = await responder.serve(
        Request('GET', Uri.parse('http://localhost/hidden')),
        file,
        isCurrent: () async => throw FileSystemException(
          'Permission denied',
          file.path,
          const OSError('Permission denied', 13),
        ),
      );
      expect(response.statusCode, 404);
      expect(await response.readAsString(), isNot(contains(file.path)));
      final diagnostic = records.singleWhere(
        (record) => record.message.startsWith('Media file unavailable'),
      );
      expect(diagnostic.message, contains(file.path));
      expect(diagnostic.error, isA<FileSystemException>());
    }),
  );

  test(
    'truncated media body logs its read error and releases its handle',
    () => captureLogs((records) async {
      final file = await File('${media.path}/photo.jpg')
          .writeAsString('original');
      final responder = MediaFileResponder(maxStreams: 1);
      addTearDown(responder.close);
      final response = await responder.serve(
        Request('GET', Uri.parse('http://localhost/hidden')),
        file,
      );
      await file.writeAsBytes([]);
      await expectLater(
        response.read().drain<void>(),
        throwsA(isA<FileSystemException>()),
      );
      final diagnostic = records.singleWhere(
        (record) => record.message.startsWith('Media body failed'),
      );
      expect(diagnostic.message, contains(file.path));
      expect(diagnostic.error, isA<FileSystemException>());
      final next = await responder.serve(
        Request('HEAD', Uri.parse('http://localhost/hidden')),
        file,
      );
      expect(next.statusCode, 200);
    }),
  );

  test('responder close drains admitted validation before reporting all handles released', () async {
    final file = await File('${media.path}/pending-validation.bin')
        .writeAsString('body');
    final responder = MediaFileResponder(maxStreams: 1);
    final validationEntered = Completer<void>();
    final validation = Completer<bool>();
    var released = 0;
    var consumed = false;
    final pending = responder.serve(
      Request('GET', Uri.parse('http://localhost/pending')),
      file,
      isCurrent: () {
        validationEntered.complete();
        return validation.future;
      },
      onRelease: () async {
        released++;
      },
    );
    addTearDown(() async {
      if (!validation.isCompleted) validation.complete(true);
      final response = await pending;
      if (!consumed) await response.read().drain<void>();
      await responder.close();
    });
    await validationEntered.future.timeout(const Duration(seconds: 5));
    var closed = false;
    final closing = responder.close().then((_) {
      closed = true;
    });
    await Future<void>.delayed(Duration.zero);
    await Future<void>.delayed(Duration.zero);
    expect(
      closed,
      isFalse,
      reason: 'close must wait for an already opened validating handle',
    );
    validation.complete(true);
    final response = await pending;
    expect(response.statusCode, 503);
    await closing.timeout(const Duration(seconds: 5));
    expect(released, 1);
    consumed = true;
    final bytes = await response
        .read()
        .timeout(const Duration(seconds: 5))
        .fold<int>(0, (total, chunk) => total + chunk.length);
    expect(
      bytes,
      0,
      reason: 'late response after close must finish without reading the file',
    );
    final open = Directory('/proc/self/fd').listSync().where((entry) {
      try {
        return Link(entry.path).targetSync() == file.path;
      } on FileSystemException {
        return false;
      }
    });
    expect(open, isEmpty);
  });
}
