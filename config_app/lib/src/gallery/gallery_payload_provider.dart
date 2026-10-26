import 'package:flutter/painting.dart';

import 'media_image_loader.dart';
import 'gallery_payload_provider_stub.dart'
    if (dart.library.io) 'gallery_payload_provider_io.dart'
    as platform;

ImageProvider galleryPayloadProvider(GalleryEncodedImage image) {
  final bytes = image.bytes;
  return bytes != null
      ? MemoryImage(bytes)
      : platform.fileProvider(image.filePath!);
}
