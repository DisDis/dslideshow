import 'package:config_app/features/gallery/presentation/widgets/gallery_widget.dart';
import 'package:flutter/material.dart';

class FolderGridItem extends StatelessWidget {
  final GalleryItem item;
  const FolderGridItem({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.folder, size: 48, color: Colors.amber[700]),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: Text(
            item.title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 12),
            maxLines: 2,
            overflow: TextOverflow.ellipsis, // Обрезаем длинный текст
          ),
        ),
      ],
    );
  }
}
