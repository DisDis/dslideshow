import 'gallery_encoded_cache_memory.dart'
    if (dart.library.io) 'gallery_encoded_cache_io.dart'
    as platform;
import 'media_image_loader.dart';

/// One session handle. Native sessions share a bounded persistent backing store.
GalleryEncodedCache createGalleryEncodedCache() => platform.createCache();
