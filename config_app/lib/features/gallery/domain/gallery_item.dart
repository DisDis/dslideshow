import 'package:dslideshow_common/file_settings.dart';
import 'package:dslideshow_common/gallery.dart';
import 'package:path/path.dart' as path;

import 'package:config_app/src/gallery/media_image_loader.dart';

/// Original identity is independent of its thumbnail representation.
class GalleryItem {
  GalleryItem({
    required this.uri,
    required this.title,
    String? mediaId,
    this.revision = 'legacy',
    this.scope = 'standalone',
    GalleryEntryKind? kind,
    this.thumbnailBaseUri,
    this.thumbnailPolicy,
    this.thumbnailsEnabled = false,
    this.selected = false,
  }) : mediaId = mediaId ?? uri.toString(),
       kind = kind ?? _legacyKind(uri.path);

  final Uri uri;
  final String title;
  final String mediaId;
  final String revision;
  final String scope;
  final GalleryEntryKind kind;
  final Uri? thumbnailBaseUri;
  final GalleryThumbnailPolicy? thumbnailPolicy;
  final bool thumbnailsEnabled;
  // Retained for source compatibility; selection is owned by the gallery page.
  final bool selected;

  bool get isFolder => kind == GalleryEntryKind.directory;
  bool get isVideo => kind == GalleryEntryKind.video;
  bool get isImage =>
      kind == GalleryEntryKind.image || kind == GalleryEntryKind.animatedImage;
  String get selectionIdentity => '$mediaId\u0000$revision';

  GalleryImageRequest imageRequest({double? physicalWidth}) {
    final policy = thumbnailPolicy;
    final base = thumbnailBaseUri;
    if (physicalWidth != null && base != null && policy != null) {
      final sizes = policy.sizes.where((size) => size.pixels > 0).toList()
        ..sort((a, b) => a.pixels.compareTo(b.pixels));
      if (sizes.isNotEmpty) {
        final size = sizes.firstWhere(
          (size) => size.pixels >= physicalWidth,
          orElse: () => sizes.last,
        );
        return GalleryImageRequest(
          key: GalleryImageKey(
            scope: scope,
            mediaId: mediaId,
            revision: revision,
            variant: GalleryImageVariant.thumbnail,
            policy: policy.version,
            bucket: size.pixels,
          ),
          uri: base.replace(
            pathSegments: [...base.pathSegments, '${size.pixels}'],
          ),
        );
      }
    }
    return GalleryImageRequest(
      key: GalleryImageKey(
        scope: scope,
        mediaId: mediaId,
        revision: revision,
        variant: GalleryImageVariant.original,
      ),
      uri: uri,
    );
  }

  static GalleryEntryKind _legacyKind(String name) {
    final extension = path.extension(name);
    if (extension.isEmpty) return GalleryEntryKind.directory;
    if (FileSettings.isVideo(extension)) return GalleryEntryKind.video;
    return extension.toLowerCase() == '.gif'
        ? GalleryEntryKind.animatedImage
        : GalleryEntryKind.image;
  }
}
