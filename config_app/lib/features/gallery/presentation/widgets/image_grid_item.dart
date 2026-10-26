import 'package:config_app/features/gallery/domain/gallery_item.dart';
import 'package:config_app/features/theme/presentation/extensions/build_context_ext.dart';
import 'package:config_app/src/gallery/gallery_image_widget.dart';
import 'package:config_app/src/gallery/media_image_loader.dart';
import 'package:flutter/material.dart';

class ImageGridItem extends StatelessWidget {
  const ImageGridItem({
    super.key,
    required this.item,
    required this.loader,
    required this.decodePool,
    this.active = true,
    this.priority = GalleryImagePriority.visible,
    this.distance = 0,
    this.onRevisionMismatch,
  });
  final GalleryItem item;
  final MediaImageLoader loader;
  final GalleryDecodePool decodePool;
  final bool active;
  final GalleryImagePriority priority;
  final int distance;
  final VoidCallback? onRevisionMismatch;

  @override
  Widget build(BuildContext context) => Tooltip(
    message: item.title,
    child: LayoutBuilder(
      builder: (context, constraints) {
        if (item.thumbnailsEnabled && item.thumbnailBaseUri == null) {
          return const Center(child: Icon(Icons.image_not_supported_outlined));
        }
        final pixels =
            (constraints.maxWidth * MediaQuery.devicePixelRatioOf(context))
                .ceil();
        return GalleryImage(
          loader: loader,
          decodePool: decodePool,
          request: item.imageRequest(physicalWidth: pixels.toDouble()),
          active: active,
          priority: priority,
          distance: distance,
          // Server derivatives are square cover crops. A legacy/original may
          // be landscape: reducing only its width would blur the square cover.
          decodeWidth: item.thumbnailBaseUri != null ? pixels : null,
          onRevisionMismatch: onRevisionMismatch,
          errorBuilder: (context, retry) => Center(
            child: IconButton(
              icon: const Icon(Icons.broken_image_outlined),
              tooltip: context.localizations.retry_button,
              onPressed: retry,
            ),
          ),
        );
      },
    ),
  );
}
