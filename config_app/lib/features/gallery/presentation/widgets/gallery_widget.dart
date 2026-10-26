import 'package:config_app/features/gallery/presentation/bloc/gallery_bloc.dart';
import 'package:config_app/features/gallery/presentation/pages/single_item_viewer_page.dart';
import 'package:config_app/features/gallery/presentation/widgets/folder_grid_item.dart';
import 'package:config_app/features/gallery/presentation/widgets/image_grid_item.dart';
import 'package:config_app/features/gallery/presentation/widgets/video_grid_item.dart';
import 'package:config_app/features/theme/presentation/extensions/build_context_ext.dart';
import 'package:config_app/features/uikit/presentation/widgets/config_app_scaffold.dart';
import 'package:dslideshow_common/file_settings.dart';
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
          return ConfigAppScaffold(
            appBar: AppBar(title: Text(context.localizations.gallery_title)),

            body: const Center(child: CircularProgressIndicator()),
          );
        }

        // 2. Состояние ошибки
        if (state is ErrorGalleryState) {
          return ConfigAppScaffold(
            appBar: AppBar(title: Text(context.localizations.gallery_title)),

            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 48,
                    color: Theme.of(context).colorScheme.error,
                  ),
                  const SizedBox(height: 16),
                  Text(state.errorMessage),
                  TextButton(
                    onPressed: () => context.read<GalleryBloc>().add(
                      const GalleryLoadEvent(),
                    ),
                    child: Text(context.localizations.retry_button),
                  ),
                ],
              ),
            ),
          );
        }

        // 3. Состояние данных (Основной экран)
        if (state is LoadedGalleryState) {
          return ConfigAppScaffold(
            // ВАЖНО: Добавляем Drawer сюда

            body: RefreshIndicator(
              onRefresh: () async {
                context.read<GalleryBloc>().add(const GalleryLoadEvent());
              },
              child: CustomScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                slivers: [
                  // The shell supplies a drawer on narrow screens.
                  SliverAppBar(
                    title: Text(
                      _isSelectionMode
                          ? context.localizations.gallery_selected(
                              _selectedIds.length,
                            )
                          : "${context.localizations.gallery_title} (${state.items.length})",
                    ),
                    floating: true,
                    pinned: true,
                    // Меняем цвет, если выбран режим выделения
                    backgroundColor: _isSelectionMode
                        ? Theme.of(context).colorScheme.secondaryContainer
                        : null,
                    // Если режим выбора - показываем кнопку "Назад" (закрыть выбор) вместо "Меню"
                    leading: _isSelectionMode
                        ? IconButton(
                            icon: const Icon(Icons.close),
                            tooltip: context.localizations.clear_selection,
                            onPressed: () =>
                                setState(() => _selectedIds.clear()),
                          )
                        : null, // Если null, Flutter сам поставит кнопку Drawer (бургер)
                    actions: [
                      if (!_isSelectionMode)
                        IconButton(
                          icon: const Icon(Icons.refresh),
                          tooltip: context.localizations.refresh_button,
                          onPressed: () => context.read<GalleryBloc>().add(
                            const GalleryLoadEvent(),
                          ),
                        ),
                    ],
                  ),

                  if (state.items.isEmpty)
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: Center(
                        child: Text(context.localizations.gallery_empty),
                      ),
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
      delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
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
            } else if (!galleryItem.isFolder) {
              // ОТКРЫТИЕ SINGLE VIEWER
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => SingleItemViewerPage(item: galleryItem),
                ),
              );
            }
          },
          onLongPress: () => onToggleSelect(galleryItem.uri.toString()),
        );
      }, childCount: items.length),
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
    final ext = path.extension(item.uri.path);
    final isVideo = FileSettings.isVideo(ext);

    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(12),
          border: isSelected
              ? Border.all(
                  width: 3,
                  color: Theme.of(context).colorScheme.primary,
                )
              : null,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(9),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Контент
              _buildContent(item.isFolder, isVideo),

              // Затемнение при выборе
              if (isSelected)
                Container(
                  color: Theme.of(context).colorScheme.primary
                      .withValues(alpha: 0.2),
                  child: Center(
                    child: Icon(
                      Icons.check_circle,
                      color: Theme.of(context).colorScheme.primary,
                      size: 36,
                    ),
                  ),
                ),

              // Индикаторы типа файла
              if (isVideo)
                Positioned(
                  top: 6,
                  right: 6,
                  child: Icon(
                    Icons.play_circle_fill,
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                    size: 24,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent(bool isFolder, bool isVideo) {
    if (isFolder) {
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
  final bool isFolder;

  GalleryItem({required this.uri, required this.title, this.selected = false})
    : isFolder = path.extension(uri.path) == '';
}
