import 'package:cached_network_image/cached_network_image.dart';
import 'package:config_app/features/theme/presentation/extensions/build_context_ext.dart';
import 'package:config_app/features/theme/presentation/theme.dart';
import 'package:config_app/features/gallery/presentation/widgets/gallery_widget.dart';
import 'package:flutter/material.dart';

class ImageGridItem extends StatelessWidget {
  final GalleryItem item;
  const ImageGridItem({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: item.title,
      child: CachedNetworkImage(
        imageUrl: item.uri.toString(),
        fit: BoxFit.cover, // ВАЖНО: Заполняет весь квадрат
        placeholder: (context, url) => const Center(
          child: SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        ),
        errorWidget: (context, url, error) => Container(
          color: AppColors.imageErrorBackground,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.broken_image, color: AppColors.imageErrorIcon),
              Text(context.localizations.error_text, style: const TextStyle(fontSize: 10)),
            ],
          ),
        ),
      ),
    );
  }
}
