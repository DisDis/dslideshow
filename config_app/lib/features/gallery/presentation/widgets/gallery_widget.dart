import 'package:cached_network_image/cached_network_image.dart';
import 'package:config_app/features/gallery/presentation/bloc/gallery_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart' as path;

class GalleryWidget extends StatelessWidget {
  const GalleryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GalleryBloc, GalleryState>(builder: (
      BuildContext context,
      GalleryState currentState,
    ) {
      if (currentState is UninitializedGalleryState) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      if (currentState is ErrorGalleryState) {
        return Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(currentState.errorMessage),
            Padding(
              padding: const EdgeInsets.only(top: 32.0),
              child: ElevatedButton(
                onPressed: () => _load(context),
                child: const Text('reload'),
              ),
            ),
          ],
        ));
      }
      if (currentState is LoadedGalleryState) {
        return Column(
          children: [
            Row(
              children: [
                Text("Total ${currentState.items.length} items"),
                ElevatedButton(
                  child: const Text('Reload'),
                  onPressed: () {
                    _load(context);
                  },
                ),
              ],
            ),
            Expanded(
              child: MediaGalleryWidget(
                items: currentState.items,
              ),
            ),
          ],
        );
      }
      return const Center(
        child: CircularProgressIndicator(),
      );
    });
  }

  void _load(BuildContext context) {
    context.read<GalleryBloc>().add(const GalleryLoadEvent());
  }
}

class MediaGalleryWidget extends StatefulWidget {
  final List<String> items;
  const MediaGalleryWidget({super.key, required this.items});

  @override
  State<MediaGalleryWidget> createState() => _MediaGalleryWidgetState();
}

class _MediaGalleryWidgetState extends State<MediaGalleryWidget> {
  late List<GalleryItem> items;
  final _selected = <GalleryItem>[];
  @override
  void initState() {
    final wclient = context.read<GalleryBloc>().getWebClient();
    items = widget.items
        .map((item) => GalleryItem(
              uri: wclient.getMediaItemUri(item),
              title: path.basename(item),
            ))
        .toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
            height: MediaQuery.of(context).size.height -
                200, // Устанавливаем высоту, чтобы избежать проблем с shrinkWrap
            child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  //maxCrossAxisExtent: 200,
                  childAspectRatio: 3 / 2,
                  crossAxisSpacing: 10,
                  crossAxisCount: 3,
                  mainAxisSpacing: 10,
                ),
                itemCount: items.length,
                itemBuilder: _buildItem)));
  }

  Widget _buildItem(BuildContext ctx, int index) {
    final item = items[index];
    final ext = path.extension(item.uri.path);

    // Определяем типы для удобства чтения
    final isFolder = ext == '';
    final isVideo = ext == '.mp4' || ext == '.avi'; // Можно расширить список: || ext == '.mov'
    final isSelected = item.selected;

    return Tooltip(
      message: item.title,
      child: GestureDetector(
        onTap: () {
          setState(() {
            item.selected = !item.selected;
            if (item.selected) {
              _selected.add(item);
            } else {
              _selected.remove(item);
            }
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200), // Плавная анимация рамки
          decoration: BoxDecoration(
            color: Colors.grey[200], // Цвет фона (пока грузится картинка)
            borderRadius: BorderRadius.circular(12),
            border: isSelected
                ? Border.all(
                    width: 3, color: Colors.blue) // Жирная рамка при выборе
                : Border.all(
                    width: 1,
                    color: Colors.grey.withOpacity(0.3)), // Тонкая рамка обычно
          ),
          child: ClipRRect(
            borderRadius:
                BorderRadius.circular(9), // Радиус чуть меньше внешнего
            child: Stack(
              fit: StackFit.expand, // Растягиваем детей на всю ячейку
              children: [
                // 1. СЛОЙ КОНТЕНТА (Фото/Видео/Папка)
                _buildContent(item, isFolder, isVideo),

                // 2. СЛОЙ ВЫДЕЛЕНИЯ (Затемнение + Галочка)
                if (isSelected)
                  Container(
                    color: Colors.black45, // Полупрозрачный черный
                    child: const Center(
                      child: Icon(
                        Icons.check_circle,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                  ),

                // 3. ИКОНКА ТИПА ФАЙЛА (Например, значок Play для видео)
                if (isVideo)
                  const Positioned(
                    top: 8,
                    right: 8,
                    child: Icon(Icons.videocam, color: Colors.white, size: 20),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

// Вспомогательный метод для чистоты кода
  Widget _buildContent(GalleryItem item, bool isFolder, bool isVideo) {
    if (isFolder) {
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
    } else if (isVideo) {
      // Заглушка для видео
      return Container(
        color: Colors.black87, // Темный фон для видео
        alignment: Alignment.center,
        padding: const EdgeInsets.all(4),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.play_circle_outline,
                color: Colors.white54, size: 32),
            const SizedBox(height: 4),
            Text(
              item.title,
              style: const TextStyle(color: Colors.white70, fontSize: 10),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      );
    }

    // Обычное изображение
    return CachedNetworkImage(
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
        color: Colors.grey[300],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.broken_image, color: Colors.grey),
            Text('Error', style: TextStyle(fontSize: 10)),
          ],
        ),
      ),
    );
  }
}

class GalleryItem {
  final Uri uri;
  final String title;
  bool selected;

  GalleryItem({
    required this.uri,
    required this.title,
    this.selected = false,
  });
}
