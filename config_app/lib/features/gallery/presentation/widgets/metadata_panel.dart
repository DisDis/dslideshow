import 'package:config_app/features/gallery/presentation/widgets/gallery_widget.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;

class MetadataPanel extends StatelessWidget {
  final GalleryItem item;

  const MetadataPanel({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    // 1. Декодируем полный путь
    final decodedPath = Uri.decodeComponent(item.uri.path);

    // 2. Отрезаем техническую часть '/cache/xxxx/get/'
    // RegExp(r'^/cache/[^/]+/get/') означает:
    // ^        -> начало строки
    // /cache/  -> буквально "/cache/"
    // [^/]+    -> один или более символов, которые НЕ являются слешем (то самое xxxx)
    // /get/    -> буквально "/get/"
    final cleanPath = decodedPath.replaceFirst(RegExp(r'^/cache/[^/]+/get/'), '');

    // 3. Теперь получаем имя и папку из чистого пути
    final fileName = path.basename(cleanPath);
    
    // Получаем папку. Если файл в корне, dirname вернет '.', заменяем на '/' для красоты
    String rawFolderPath = path.dirname(cleanPath);
    final folderPath = rawFolderPath == '.' ? '/' : rawFolderPath;
    
    final extension = path.extension(fileName).replaceAll('.', '').toUpperCase();
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 40), // Отступ снизу побольше
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            Colors.black.withAlpha((255.0 * 0.9).round()),
            Colors.transparent,
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Заголовок (Имя файла)
          Text(
            fileName,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 8),
          
          // Путь (Папка)
          Row(
            children: [
              const Icon(Icons.folder_open_outlined, color: Colors.cyanAccent, size: 16),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  folderPath,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 13,
                    fontFamily: 'Courier', // Моноширинный шрифт для пути
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 12),
          
          // Теги (Расширение, Тип)
          Row(
            children: [
              _buildTag(extension, Colors.cyanAccent),
              // const SizedBox(width: 8),
              // _buildTag('MEDIA', Colors.white54),
              // Если бы были размеры файла, добавили бы здесь: _buildTag('4.2 MB', Colors.white54),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTag(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: color.withAlpha((255.0 * 0.5).round())),
        borderRadius: BorderRadius.circular(4),
        color: color.withAlpha((255.0 * 0.1).round()),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.0,
        ),
      ),
    );
  }
}