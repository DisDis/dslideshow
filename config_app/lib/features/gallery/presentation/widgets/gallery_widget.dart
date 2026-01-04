import 'package:config_app/features/gallery/presentation/bloc/gallery_bloc.dart';
import 'package:config_app/features/gallery/presentation/widgets/folder_grid_item.dart';
import 'package:config_app/features/gallery/presentation/widgets/image_grid_item.dart';
import 'package:config_app/features/gallery/presentation/widgets/video_grid_item.dart';
import 'package:config_app/features/uikit/presentation/widgets/navigation_bar/configapp_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart' as path;

class GalleryWidget extends StatefulWidget {
  const GalleryWidget({super.key});

  @override
  State<GalleryWidget> createState() => _GalleryWidgetState();
}

class _GalleryWidgetState extends State<GalleryWidget> {
  final Set<String> _selectedIds = {}; 
  bool get _isSelectionMode => _selectedIds.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GalleryBloc, GalleryState>(
      builder: (context, state) {
        // 1. Состояние загрузки (Показываем пустой экран с Drawer, чтобы меню работало всегда)
        if (state is UninitializedGalleryState) {
          return Scaffold(
            appBar: AppBar(title: const Text("Gallery")),
            drawer: const ConfigAppNavigationBar(), // <-- Drawer здесь
            body: const Center(child: CircularProgressIndicator()),
          );
        }

        // 2. Состояние ошибки
        if (state is ErrorGalleryState) {
          return Scaffold(
            appBar: AppBar(title: const Text("Gallery")),
            drawer: const ConfigAppNavigationBar(), // <-- Drawer здесь
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 48, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(state.errorMessage),
                  TextButton(
                    onPressed: () => context.read<GalleryBloc>().add(const GalleryLoadEvent()),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
          );
        }

        // 3. Состояние данных (Основной экран)
        if (state is LoadedGalleryState) {
          return Scaffold(
            // ВАЖНО: Добавляем Drawer сюда
            drawer: const ConfigAppNavigationBar(),
            
            body: RefreshIndicator(
              onRefresh: () async {
                 context.read<GalleryBloc>().add(const GalleryLoadEvent());
              },
              child: CustomScrollView(
                slivers: [
                  // SliverAppBar автоматически покажет кнопку меню (Drawer),
                  // потому что мы добавили drawer в Scaffold выше.
                  SliverAppBar(
                    title: Text(_isSelectionMode 
                        ? "${_selectedIds.length} selected" 
                        : "Gallery (${state.items.length})"),
                    floating: true,
                    pinned: true,
                    // Меняем цвет, если выбран режим выделения
                    backgroundColor: _isSelectionMode ? Colors.blueGrey.shade900 : null,
                    // Если режим выбора - показываем кнопку "Назад" (закрыть выбор) вместо "Меню"
                    leading: _isSelectionMode 
                        ? IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () => setState(() => _selectedIds.clear()),
                          )
                        : null, // Если null, Flutter сам поставит кнопку Drawer (бургер)
                    actions: [
                      if (_isSelectionMode) ...[
                        IconButton(icon: const Icon(Icons.share), onPressed: () {}),
                        IconButton(icon: const Icon(Icons.delete), onPressed: () {}),
                      ] else 
                        IconButton(
                           icon: const Icon(Icons.refresh),
                           onPressed: () => context.read<GalleryBloc>().add(const GalleryLoadEvent()),
                        )
                    ],
                  ),

                  SliverPadding(
                    padding: const EdgeInsets.all(8.0),
                    sliver: MediaGallerySliverGrid(
                      items: state.items,
                      selectedIds: _selectedIds,
                      onToggleSelect: _toggleSelection,
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  void _toggleSelection(String uri) {
    setState(() {
      if (_selectedIds.contains(uri)) {
        _selectedIds.remove(uri);
      } else {
        _selectedIds.add(uri);
      }
    });
  }
}

class MediaGallerySliverGrid extends StatelessWidget {
  final List<String> items;
  final Set<String> selectedIds;
  final Function(String) onToggleSelect;

  const MediaGallerySliverGrid({
    super.key,
    required this.items,
    required this.selectedIds,
    required this.onToggleSelect,
  });

  @override
  Widget build(BuildContext context) {
    final wclient = context.read<GalleryBloc>().getWebClient();

    // SliverGridDelegateWithMaxCrossAxisExtent делает сетку адаптивной
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200, // Максимальная ширина ячейки
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
        childAspectRatio: 1.0, // Квадратные ячейки выглядят современнее
      ),
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          final itemString = items[index];
          // Создаем модель на лету (или лучше делать это в BLoC)
          final galleryItem = GalleryItem(
            uri: wclient.getMediaItemUri(itemString),
            title: path.basename(itemString),
          );

          final isSelected = selectedIds.contains(galleryItem.uri.toString());

          return _GalleryItemWidget(
            item: galleryItem,
            isSelected: isSelected,
            onTap: () {
              if (selectedIds.isNotEmpty) {
                // Если режим выбора активен, обычный клик тоже выбирает
                onToggleSelect(galleryItem.uri.toString());
              } 
              // else {
              //   // Иначе открываем фуллскрин
              //   print("Open Fullscreen: ${galleryItem.title}");
              //   // Navigator.push(...)
              // }
            },
            onLongPress: () => onToggleSelect(galleryItem.uri.toString()),
          );
        },
        childCount: items.length,
      ),
    );
  }
}

class _GalleryItemWidget extends StatelessWidget {
  final GalleryItem item;
  final bool isSelected;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  const _GalleryItemWidget({
    required this.item,
    required this.isSelected,
    required this.onTap,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    final ext = path.extension(item.uri.path).toLowerCase();
    final isFolder = ext == '';
    final isVideo = ['.mp4', '.avi', '.mov'].contains(ext);

    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
          border: isSelected
              ? Border.all(width: 3, color: Colors.blueAccent)
              : Border.all(width: 0, color: Colors.transparent),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(9),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Контент
              _buildContent(isFolder, isVideo),

              // Затемнение при выборе
              if (isSelected)
                Container(
                  color: Colors.blue.withAlpha((255.0 * 0.2).round()),
                  child: const Center(
                    child:
                        Icon(Icons.check_circle, color: Colors.blue, size: 36),
                  ),
                ),

              // Индикаторы типа файла
              if (isVideo)
                const Positioned(
                  top: 6,
                  right: 6,
                  child: Icon(Icons.play_circle_fill,
                      color: Colors.white, size: 24),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent(bool isFolder, bool isVideo) {
    if (isFolder){
      return FolderGridItem(item: item);
    }
    if (isVideo) {
      // Ваша заглушка
      return VideoGridItem(title: item.title, url: item.uri.toString());
    }

    // CachedNetworkImage (предположительно внутри ImageGridItem)
    // Добавьте fit: BoxFit.cover внутрь ImageGridItem для красивого квадрата
    return ImageGridItem(item: item);
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
