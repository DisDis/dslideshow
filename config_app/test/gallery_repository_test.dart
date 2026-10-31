import 'dart:async';
import 'dart:convert';

import 'package:config_app/src/gallery/gallery_repository.dart';
import 'package:config_app/src/gallery/media_image_loader.dart';
import 'package:dslideshow_common/gallery.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

Map<String, dynamic> catalog({String revision = 'r1', String renderRevision = ''}) => GalleryCatalog(
  section: GalleryMediaSection.published,
  catalogRevision: 'c1',
  capabilities: [GalleryCapability.thumbnails, GalleryCapability.revisionedOriginals, GalleryCapability.refresh],
  thumbnailPolicy: GalleryThumbnailPolicy(
    version: 3,
    revision: renderRevision,
    sizes: [GalleryThumbnailSize.small, GalleryThumbnailSize.medium, GalleryThumbnailSize.large],
  ),
  entries: [
    GalleryEntry(
      section: GalleryMediaSection.published,
      mediaId: 'photo',
      path: 'album/with #?%.jpg',
      name: 'with #?%.jpg',
      kind: GalleryEntryKind.image,
      sourceRevision: revision,
      thumbnailSupported: true,
    ),
  ],
).toJson();

GalleryRepository repository(http.Client client) =>
    GalleryRepository(baseUri: Uri.parse('http://localhost:8000'), code: 'secret', client: client);

void main() {
  test('50001 media entries fit the normal catalog contract without truncation', () async {
    final payload = catalog();
    payload['entries'] = List.generate(
      50001,
      (index) => GalleryEntry(
        section: GalleryMediaSection.published,
        mediaId: 'media-$index',
        path: '2026/10/album/photo-$index.jpg',
        name: 'photo-$index.jpg',
        kind: GalleryEntryKind.image,
        sourceRevision: 'revision-$index',
        thumbnailSupported: true,
      ).toJson(),
    );
    final body = jsonEncode(payload);
    var requests = 0;
    final repo = repository(
      MockClient((_) async {
        requests++;
        return http.Response(body, 200);
      }),
    );
    addTearDown(repo.close);
    expect(utf8.encode(body).length, lessThan(repo.maxCatalogBytes));
    final result = await repo.load();
    expect(result.items, hasLength(50001));
    expect(result.items.first.mediaId, 'media-0');
    expect(result.items.last.mediaId, 'media-50000');
    expect(result.items.last.revision, 'revision-50000');
    expect(result.items.last.uri.pathSegments.skip(3), ['published', 'original', 'media-50000', 'revision-50000']);
    expect(result.items.last.thumbnailsEnabled, isTrue);
    expect(requests, 1, reason: 'Loading the catalog must not fetch media bodies');
  });

  test('typed catalog preserves original, safely encodes path and picks DPR bucket', () async {
    final repo = repository(MockClient((_) async => http.Response(jsonEncode(catalog()), 200)));
    final result = await repo.load();
    final item = result.items.single;
    expect(item.scope, repo.authScope);
    expect(item.uri.pathSegments, ['cache', 'secret', 'v2', 'published', 'original', 'photo', 'r1']);
    expect(item.uri.queryParameters, isEmpty);
    final thumbnail = item.imageRequest(physicalWidth: 400);
    expect(thumbnail.uri.pathSegments.last, '512');
    expect(thumbnail.uri.pathSegments[thumbnail.uri.pathSegments.length - 2], '3');
    expect(thumbnail.key.policy, 3);
    expect(thumbnail.key.variant, GalleryImageVariant.thumbnail);
    expect(item.imageRequest().key.variant, GalleryImageVariant.original);
    repo.close();
  });

  test('render settings change thumbnail URL and key, keeping original identity', () async {
    var revision = List.filled(64, 'a').join();
    final repo = repository(MockClient((_) async => http.Response(jsonEncode(catalog(renderRevision: revision)), 200)));
    final first = (await repo.load()).items.single;
    final thumbnail = first.imageRequest(physicalWidth: 256);
    expect(thumbnail.uri.pathSegments, contains('3-$revision'));
    expect(thumbnail.key.policyRevision, revision);
    revision = List.filled(64, 'b').join();
    final next = (await repo.load()).items.single;
    expect(next.imageRequest(physicalWidth: 256).uri, isNot(thumbnail.uri));
    expect(next.imageRequest(physicalWidth: 256).key, isNot(thumbnail.key));
    expect(next.imageRequest().key, first.imageRequest().key);
    expect(next.selectionIdentity, first.selectionIdentity);
    repo.close();
  });

  test('malformed policy revision cannot become a thumbnail path', () async {
    final repo = repository(
      MockClient((_) async => http.Response(jsonEncode(catalog(renderRevision: '../other')), 200)),
    );
    await expectLater(repo.load(), throwsFormatException);
    repo.close();
  });

  test('missing catalog and forbidden access fail without a legacy request', () async {
    for (final status in [404, 403]) {
      final urls = <Uri>[];
      final repo = repository(
        MockClient((request) async {
          urls.add(request.url);
          return http.Response('', status);
        }),
      );
      await expectLater(repo.load(), throwsA(isA<GalleryImageHttpException>()));
      expect(urls, hasLength(1));
      expect(urls.single.path, endsWith('/v2/published/catalog'));
      repo.close();
    }
  });

  test('normal v2 refresh POST uses scan and preserves unchanged source identities', () async {
    final requests = <http.Request>[];
    final repo = repository(
      MockClient((request) async {
        requests.add(request);
        return http.Response(jsonEncode(catalog()), 200);
      }),
    );
    final first = await repo.load();
    final second = await repo.load(refresh: true);
    expect(requests.last.method, 'POST');
    expect(requests.last.url.path, endsWith('/v2/published/catalog/refresh'));
    expect(jsonDecode(requests.last.body)['mode'], 'scan');
    expect(jsonDecode(requests.last.body)['operationId'], isNotEmpty);
    expect(first.items.single.selectionIdentity, second.items.single.selectionIdentity);
    repo.close();
  });

  test('invalid schema/data never silently downgrade to legacy strings', () async {
    var body = catalog()..['schemaVersion'] = 999;
    final repo = repository(MockClient((_) async => http.Response(jsonEncode(body), 200)));
    await expectLater(repo.load(), throwsFormatException);
    body = {
      'items': [42],
    };
    await expectLater(repo.load(), throwsA(anything));
    expect(repo.protocol, GalleryProtocol.undecided);
    repo.close();
  });

  test('replacement load cancels the old request and old data cannot publish', () async {
    final client = _AbortCatalogClient();
    final repo = repository(client);
    final old = repo.load();
    old.ignore();
    await Future<void>.delayed(Duration.zero);
    final current = repo.load();
    await Future<void>.delayed(Duration.zero);
    expect(client.aborted, 1);
    client.pending.last.complete(
      http.StreamedResponse(Stream.value(utf8.encode(jsonEncode(catalog(revision: 'new')))), 200),
    );
    expect((await current).items.single.revision, 'new');
    await expectLater(old, throwsA(anything));
    repo.close();
  });

  test('late missing-protocol response cannot downgrade the replacement request', () async {
    final client = _LateCatalogClient();
    final repo = repository(client);
    final old = repo.load();
    old.ignore();
    await Future<void>.delayed(Duration.zero);
    final current = repo.load();
    await Future<void>.delayed(Duration.zero);
    client.pending.first.complete(http.StreamedResponse(const Stream.empty(), 404));
    await expectLater(old, throwsA(isA<GalleryImageCancelled>()));
    expect(client.pending, hasLength(2));
    client.pending.last.complete(http.StreamedResponse(Stream.value(utf8.encode(jsonEncode(catalog()))), 200));
    await current;
    expect(repo.protocol, GalleryProtocol.versioned);
    repo.close();
  });
}

class _LateCatalogClient extends http.BaseClient {
  final pending = <Completer<http.StreamedResponse>>[];
  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    final result = Completer<http.StreamedResponse>();
    pending.add(result);
    return result.future;
  }
}

class _AbortCatalogClient extends http.BaseClient {
  final pending = <Completer<http.StreamedResponse>>[];
  int aborted = 0;
  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    final result = Completer<http.StreamedResponse>();
    pending.add(result);
    if (request case http.Abortable(:final abortTrigger?)) {
      unawaited(
        abortTrigger.then((_) {
          aborted++;
          if (!result.isCompleted) {
            result.completeError(http.RequestAbortedException(request.url));
          }
        }),
      );
    }
    return result.future;
  }
}
