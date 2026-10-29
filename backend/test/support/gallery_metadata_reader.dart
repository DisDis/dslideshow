import 'package:dslideshow_backend/src/service/gallery/gallery_catalog_service.dart';
import 'package:dslideshow_backend/src/service/gallery/gallery_metadata_reader.dart';
import 'package:dslideshow_common/gallery.dart';

typedef MetadataReadCallback = Future<GalleryMetadata> Function(
  GallerySource source, {
  String? input,
});

class CallbackGalleryMetadataReader extends GalleryMetadataReader {
  CallbackGalleryMetadataReader(this.callback);
  final MetadataReadCallback callback;
  int closeCount = 0;

  @override
  Future<GalleryMetadata> read(GallerySource source, {String? input}) =>
      callback(source, input: input);

  @override
  Future<void> close() {
    closeCount++;
    return super.close();
  }
}
