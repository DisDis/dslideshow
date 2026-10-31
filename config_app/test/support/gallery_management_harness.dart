import 'dart:async';
import 'dart:convert';

import 'package:config_app/features/gallery/domain/gallery_item.dart';
import 'package:config_app/features/realtime/domain/services/realtime_service.dart';
import 'package:config_app/src/gallery/gallery_repository.dart';
import 'package:config_app/src/gallery/gallery_management_repository.dart';
import 'package:config_app/src/gallery/gallery_session.dart';
import 'package:config_app/src/gallery/media_image_loader.dart';
import 'package:dslideshow_common/gallery.dart';
import 'package:http/http.dart' as http;

class GalleryTestClient implements RealtimeService {
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class ManagedCatalogRepository extends GalleryRepository {
  ManagedCatalogRepository(this.items) : super(baseUri: Uri.parse('http://frame.local'), code: 'code');
  List<GalleryItem> items;
  Completer<GalleryCatalogResult>? refreshGate;
  @override
  Set<GalleryCapability> get capabilities => const {
    GalleryCapability.metadata,
    GalleryCapability.mutations,
    GalleryCapability.rotation,
    GalleryCapability.trash,
    GalleryCapability.duplicates,
  };
  @override
  Future<GalleryCatalogResult> load({bool refresh = false}) async {
    if (refreshGate != null) return refreshGate!.future;
    return GalleryCatalogResult(List.of(items), GalleryProtocol.versioned, 'catalog');
  }
}

GalleryItem managedPhoto(String id, {String revision = '1'}) => GalleryItem(
  uri: Uri(
    pathSegments: ['cache', 'code', 'v2', 'published', 'original', id, revision],
    scheme: 'http',
    host: 'frame.local',
  ),
  title: '$id.jpg',
  mediaId: id,
  revision: revision,
  kind: GalleryEntryKind.image,
);

GalleryMetadata photoMetadata(String id, {String revision = '1'}) => GalleryMetadata(
  section: GalleryMediaSection.published,
  mediaId: id,
  sourceRevision: revision,
  name: '$id.jpg',
  path: '$id.jpg',
  kind: GalleryEntryKind.image,
  sizeBytes: 1024,
  width: 6000,
  height: 4000,
  camera: 'Test camera',
  iso: '100',
);

GallerySession managedSession(ManagedCatalogRepository catalog, http.Client managementClient, http.Client images) =>
    GallerySession(
      repository: catalog,
      management: GalleryManagementRepository(baseUri: catalog.baseUri, code: catalog.code, client: managementClient),
      loader: MediaImageLoader(client: images),
    );

http.Response duplicateResponse(http.Request request, GalleryDuplicateJob job) {
  final segments = request.url.pathSegments;
  if (segments.contains('groups')) {
    final index = int.parse(segments.last);
    return http.Response(
      jsonEncode(
        GalleryDuplicateGroupPage(
          jobId: job.jobId,
          index: index,
          group: index < job.groups.length ? job.groups[index] : null,
        ).toJson(),
      ),
      200,
    );
  }
  return http.Response(jsonEncode(job.toJson()), 200);
}
