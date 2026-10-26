import 'dart:math' as math;

import 'package:config_app/features/gallery/domain/gallery_item.dart';
import 'package:config_app/features/gallery/presentation/bloc/gallery_bloc.dart';
import 'package:config_app/features/gallery/presentation/pages/single_item_viewer_page.dart';
import 'package:config_app/features/gallery/presentation/widgets/folder_grid_item.dart';
import 'package:config_app/features/gallery/presentation/widgets/image_grid_item.dart';
import 'package:config_app/features/gallery/presentation/widgets/video_grid_item.dart';
import 'package:config_app/features/theme/presentation/extensions/build_context_ext.dart';
import 'package:config_app/features/uikit/presentation/widgets/config_app_scaffold.dart';
import 'package:config_app/src/gallery/gallery_session.dart';
import 'package:config_app/src/gallery/media_image_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart' show SliverGridRegularTileLayout;
import 'package:flutter_bloc/flutter_bloc.dart';

export '../../domain/gallery_item.dart';

class GalleryWidget extends StatefulWidget {
  const GalleryWidget({super.key});
  @override
  State<GalleryWidget> createState() => _GalleryWidgetState();
}

class _GalleryWidgetState extends State<GalleryWidget> {
  final _selectedIds = <String>{};

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<GalleryBloc>();
    final routeActive = ModalRoute.isCurrentOf(context) ?? true;
    return BlocBuilder<GalleryBloc, GalleryState>(
      builder: (context, state) {
        if (state is UninitializedGalleryState) {
          return ConfigAppScaffold(
            appBar: AppBar(title: Text(context.localizations.gallery_title)),
            body: const Center(child: CircularProgressIndicator()),
          );
        }
        if (state is ErrorGalleryState) {
          return ConfigAppScaffold(
            appBar: AppBar(title: Text(context.localizations.gallery_title)),
            body: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 48,
                    color: Theme.of(context).colorScheme.error,
                  ),
                  Text(context.localizations.gallery_load_failed),
                  TextButton(
                    onPressed: bloc.refresh,
                    child: Text(context.localizations.retry_button),
                  ),
                ],
              ),
            ),
          );
        }
        if (state is! LoadedGalleryState) return const SizedBox.shrink();
        final validIds = state.items
            .map((item) => item.selectionIdentity)
            .toSet();
        _selectedIds.retainWhere(validIds.contains);
        final selectionMode = _selectedIds.isNotEmpty;
        return ConfigAppScaffold(
          body: RefreshIndicator(
            onRefresh: bloc.refresh,
            child: CustomScrollView(
              key: const PageStorageKey('gallery-scroll'),
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                SliverAppBar(
                  title: Text(
                    selectionMode
                        ? context.localizations.gallery_selected(
                            _selectedIds.length,
                          )
                        : '${context.localizations.gallery_title} (${state.items.length})',
                  ),
                  floating: true,
                  pinned: true,
                  backgroundColor: selectionMode
                      ? Theme.of(context).colorScheme.secondaryContainer
                      : null,
                  leading: selectionMode
                      ? IconButton(
                          icon: const Icon(Icons.close),
                          tooltip: context.localizations.clear_selection,
                          onPressed: () => setState(_selectedIds.clear),
                        )
                      : null,
                  actions: [
                    if (!selectionMode)
                      IconButton(
                        icon: const Icon(Icons.refresh),
                        tooltip: context.localizations.refresh_button,
                        onPressed: state.refreshing ? null : bloc.refresh,
                      ),
                  ],
                ),
                if (state.refreshing)
                  const SliverToBoxAdapter(child: LinearProgressIndicator()),
                if (state.refreshFailed)
                  SliverToBoxAdapter(
                    child: MaterialBanner(
                      content: Text(
                        context.localizations.gallery_refresh_failed,
                      ),
                      actions: [
                        TextButton(
                          onPressed: bloc.refresh,
                          child: Text(context.localizations.retry_button),
                        ),
                      ],
                    ),
                  ),
                if (state.items.isEmpty)
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: Text(context.localizations.gallery_empty),
                    ),
                  ),
                SliverPadding(
                  padding: const EdgeInsets.all(8),
                  sliver: MediaGallerySliverGrid(
                    items: state.items,
                    selectedIds: _selectedIds,
                    onToggleSelect: _toggleSelection,
                    active: routeActive,
                    session: bloc.session,
                    onRevisionMismatch: bloc.resolveRevisionMismatch,
                    catalogUpdates: bloc.stream
                        .where((state) => state is LoadedGalleryState)
                        .map((state) => (state as LoadedGalleryState).items),
                    currentItem: (id) {
                      final current = bloc.state;
                      if (bloc.isClosed || current is! LoadedGalleryState) {
                        return null;
                      }
                      for (final candidate in current.items) {
                        if (candidate.mediaId == id) return candidate;
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _toggleSelection(String id) => setState(() {
    if (!_selectedIds.remove(id)) _selectedIds.add(id);
  });
}

/// SliverLayoutBuilder supplies offsets in the grid's own coordinate system,
/// after app bar and padding. Cache-extent children are not assumed visible.
class MediaGallerySliverGrid extends StatelessWidget {
  const MediaGallerySliverGrid({
    super.key,
    required this.items,
    required this.selectedIds,
    required this.onToggleSelect,
    required this.session,
    this.active = true,
    this.onRevisionMismatch,
    this.catalogUpdates,
    this.currentItem,
  });
  final List<GalleryItem> items;
  final Set<String> selectedIds;
  final ValueChanged<String> onToggleSelect;
  final GallerySession session;
  final bool active;
  final VoidCallback? onRevisionMismatch;
  final Stream<List<GalleryItem>>? catalogUpdates;
  final GalleryItem? Function(String)? currentItem;

  @override
  Widget build(BuildContext context) {
    const delegate = SliverGridDelegateWithMaxCrossAxisExtent(
      maxCrossAxisExtent: 200,
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      childAspectRatio: 1,
    );
    return SliverLayoutBuilder(
      builder: (context, constraints) {
        final layout = delegate.getLayout(constraints);
        final start =
            constraints.scrollOffset + math.max(0.0, constraints.overlap);
        final end = constraints.scrollOffset + constraints.remainingPaintExtent;
        final first = layout.getMinChildIndexForScrollOffset(start);
        final last = layout.getMaxChildIndexForScrollOffset(
          math.max(start, end),
        );
        final columns = layout is SliverGridRegularTileLayout
            ? layout.crossAxisCount
            : 1;
        final prefetchFirst = math.max(0, first - columns);
        final prefetchLast = math.min(items.length - 1, last + columns);
        return SliverGrid(
          gridDelegate: delegate,
          delegate: SliverChildBuilderDelegate((context, index) {
            final item = items[index];
            final visible = index >= first && index <= last;
            final demanded =
                active && index >= prefetchFirst && index <= prefetchLast;
            return _GalleryItemWidget(
              key: ValueKey(item.mediaId),
              item: item,
              isSelected: selectedIds.contains(item.selectionIdentity),
              session: session,
              active: demanded,
              priority: visible
                  ? GalleryImagePriority.visible
                  : GalleryImagePriority.prefetch,
              distance: visible
                  ? 0
                  : math.min((index - first).abs(), (index - last).abs()),
              videoActive: active && visible,
              onRevisionMismatch: onRevisionMismatch,
              onTap: () {
                if (selectedIds.isNotEmpty) {
                  onToggleSelect(item.selectionIdentity);
                } else if (!item.isFolder) {
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => SingleItemViewerPage(
                        item: item,
                        session: session,
                        onRevisionMismatch: onRevisionMismatch,
                        itemUpdates: catalogUpdates?.map((items) {
                          for (final candidate in items) {
                            if (candidate.mediaId == item.mediaId) {
                              return candidate;
                            }
                          }
                          return null;
                        }),
                        currentItem: currentItem == null
                            ? null
                            : () => currentItem!(item.mediaId),
                      ),
                    ),
                  );
                }
              },
              onLongPress: () => onToggleSelect(item.selectionIdentity),
            );
          }, childCount: items.length),
        );
      },
    );
  }
}

class _GalleryItemWidget extends StatelessWidget {
  const _GalleryItemWidget({
    super.key,
    required this.item,
    required this.isSelected,
    required this.onTap,
    required this.onLongPress,
    required this.session,
    required this.active,
    required this.videoActive,
    required this.priority,
    required this.distance,
    this.onRevisionMismatch,
  });
  final GalleryItem item;
  final bool isSelected;
  final VoidCallback onTap;
  final VoidCallback onLongPress;
  final GallerySession session;
  final bool active;
  final bool videoActive;
  final GalleryImagePriority priority;
  final int distance;
  final VoidCallback? onRevisionMismatch;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    Widget content;
    if (item.isFolder) {
      content = FolderGridItem(item: item);
    } else if (item.isVideo) {
      content = VideoGridItem(
        title: item.title,
        url: item.uri.toString(),
        active: videoActive,
      );
    } else if (item.isImage) {
      content = ImageGridItem(
        item: item,
        loader: session.loader,
        decodePool: session.decodePool,
        active: active,
        priority: priority,
        distance: distance,
        onRevisionMismatch: onRevisionMismatch,
      );
    } else {
      content = Icon(
        Icons.insert_drive_file_outlined,
        color: scheme.onSurfaceVariant,
      );
    }
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: scheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(12),
          border: isSelected
              ? Border.all(width: 3, color: scheme.primary)
              : null,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(9),
          child: Stack(
            fit: StackFit.expand,
            children: [
              content,
              if (isSelected)
                ColoredBox(
                  color: scheme.primary.withValues(alpha: .2),
                  child: Center(
                    child: Icon(
                      Icons.check_circle,
                      color: scheme.primary,
                      size: 36,
                    ),
                  ),
                ),
              if (item.isVideo)
                Positioned(
                  top: 6,
                  right: 6,
                  child: Icon(
                    Icons.play_circle_fill,
                    color: scheme.onPrimaryContainer,
                    size: 24,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
