import 'dart:async';
import 'dart:math' as math;

import 'package:config_app/features/gallery/domain/gallery_item.dart';
import 'package:config_app/features/gallery/presentation/bloc/gallery_bloc.dart';
import 'package:config_app/features/gallery/presentation/bloc/gallery_management_bloc.dart';
import 'package:config_app/features/gallery/presentation/pages/single_item_viewer_page.dart';
import 'package:config_app/features/gallery/presentation/pages/gallery_duplicates_page.dart';
import 'package:config_app/features/gallery/presentation/widgets/folder_grid_item.dart';
import 'package:config_app/features/gallery/presentation/widgets/image_grid_item.dart';
import 'package:config_app/features/gallery/presentation/widgets/video_grid_item.dart';
import 'package:config_app/features/gallery/presentation/widgets/gallery_actions.dart';
import 'package:config_app/features/theme/presentation/extensions/build_context_ext.dart';
import 'package:config_app/features/uikit/presentation/widgets/config_app_scaffold.dart';
import 'package:config_app/src/gallery/gallery_session.dart';
import 'package:config_app/src/gallery/media_image_loader.dart';
import 'package:dslideshow_common/gallery.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart' show SliverGridRegularTileLayout;
import 'package:flutter_bloc/flutter_bloc.dart';

export '../../domain/gallery_item.dart';
export '../bloc/gallery_management_bloc.dart' show GallerySection;

class GalleryWidget extends StatelessWidget {
  const GalleryWidget({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (context) => GalleryManagementBloc(catalogBloc: context.read<GalleryBloc>()),
    child: const _GalleryManagementView(),
  );
}

class _GalleryManagementView extends StatelessWidget {
  const _GalleryManagementView();

  void _notice(BuildContext context, GalleryManagementState state) {
    final bloc = context.read<GalleryManagementBloc>();
    final l = context.localizations;
    if (state.notice == GalleryManagementNotice.trashed || state.notice == GalleryManagementNotice.hidden) {
      showGalleryUndo(
        context,
        bloc.repository,
        state.undoMediaIds,
        bloc.refresh,
        section: state.notice == GalleryManagementNotice.hidden
            ? GalleryMediaSection.hidden
            : GalleryMediaSection.trash,
      );
      return;
    }
    final message = switch (state.notice) {
      GalleryManagementNotice.restored => l.gallery_restored,
      GalleryManagementNotice.unhidden => l.gallery_unhidden,
      GalleryManagementNotice.purged => l.gallery_purged,
      GalleryManagementNotice.partialFailure => l.gallery_failed_files,
      GalleryManagementNotice.failed => galleryErrorText(context, state.error),
      GalleryManagementNotice.unknownOutcome => l.gallery_mutation_unknown,
      GalleryManagementNotice.confirmationChanged => l.gallery_confirmation_changed,
      _ => null,
    };
    if (message != null) {
      ScaffoldMessenger.of(context).showSnackBar(galleryNotification(message));
    }
  }

  void _requestMutation(BuildContext context, GalleryMutation action) {
    final bloc = context.read<GalleryManagementBloc>();
    bloc.add(GalleryManagementEvent.mutationRequested(action));
  }

  Future<void> _confirm(BuildContext context, GalleryManagementState state) async {
    final bloc = context.read<GalleryManagementBloc>();
    final confirmation = state.confirmation!;
    final confirmed = await confirmGalleryMutation(context, confirmation);
    if (context.mounted && !bloc.isClosed) {
      bloc.add(GalleryManagementEvent.mutationDecision(confirmationId: confirmation.token, confirmed: confirmed));
    }
  }

  void _open(BuildContext context, GalleryItem item) {
    final bloc = context.read<GalleryManagementBloc>();
    final state = bloc.state;
    final entry = state.isStored ? state.snapshot.entriesById[item.mediaId] : null;
    final mediaSection = state.isTrash
        ? GalleryMediaSection.trash
        : state.isHidden
        ? GalleryMediaSection.hidden
        : GalleryMediaSection.published;
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => SingleItemViewerPage(
          item: item,
          session: bloc.catalogBloc.session,
          capabilities: state.capabilities,
          entry: entry,
          onRevisionMismatch: state.isHidden
              ? () => unawaited(bloc.refresh())
              : bloc.catalogBloc.resolveRevisionMismatch,
          onChanged: bloc.refresh,
          onTrashed: (ids) {
            if (context.mounted) {
              showGalleryUndo(context, bloc.repository, ids, bloc.refresh);
            }
          },
          onHidden: (ids) {
            if (context.mounted) {
              showGalleryUndo(context, bloc.repository, ids, bloc.refresh, section: GalleryMediaSection.hidden);
            }
          },
          itemUpdates: state.isTrash ? null : bloc.itemUpdates(item.mediaId, mediaSection: mediaSection),
          currentItem: state.isTrash ? null : () => bloc.currentItem(item.mediaId, mediaSection: mediaSection),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => BlocListener<GalleryManagementBloc, GalleryManagementState>(
    listenWhen: (previous, current) =>
        current.confirmation != null && previous.confirmation?.token != current.confirmation?.token,
    listener: _confirm,
    child: BlocConsumer<GalleryManagementBloc, GalleryManagementState>(
      listenWhen: (previous, current) => previous.noticeSerial != current.noticeSerial,
      listener: _notice,
      builder: (context, state) {
        final bloc = context.read<GalleryManagementBloc>();
        final l = context.localizations;
        Widget body;
        if (state.section == GallerySection.duplicates) {
          body = GalleryDuplicatesPage(
            session: bloc.catalogBloc.session,
            catalog: bloc.currentDuplicateItems,
            catalogUpdates: bloc.confirmedCatalogUpdates,
            currentCatalog: () => bloc.currentDuplicateItems,
            onRefresh: bloc.refresh,
          );
        } else if (state.initialLoading) {
          body = const Center(child: CircularProgressIndicator());
        } else if (state.initialFailed) {
          body = Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(l.gallery_load_failed),
                TextButton(onPressed: bloc.refresh, child: Text(l.retry_button)),
              ],
            ),
          );
        } else {
          body = Card(
            margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                SizedBox(
                  height: 4,
                  child: state.refreshing && state.operationPlan == null ? const LinearProgressIndicator() : null,
                ),
                if (state.refreshFailed)
                  MaterialBanner(
                    content: Text(l.gallery_refresh_failed),
                    actions: [TextButton(onPressed: bloc.refresh, child: Text(l.retry_button))],
                  ),
                if (state.isTrash) Padding(padding: const EdgeInsets.all(12), child: Text(l.gallery_trash_hint)),
                if (state.failures.isNotEmpty)
                  MaterialBanner(
                    content: Text(l.gallery_failed_files),
                    actions: [
                      TextButton(onPressed: () => _details(context, state), child: Text(l.gallery_operation_details)),
                    ],
                  ),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: bloc.refresh,
                    child: CustomScrollView(
                      key: PageStorageKey('gallery-${state.section.name}'),
                      physics: const AlwaysScrollableScrollPhysics(),
                      slivers: [
                        if (state.isHidden)
                          SliverToBoxAdapter(
                            child: Padding(padding: const EdgeInsets.all(12), child: Text(l.gallery_hidden_hint)),
                          ),
                        if (state.items.isEmpty)
                          SliverFillRemaining(hasScrollBody: false, child: Center(child: Text(l.gallery_empty))),
                        SliverPadding(
                          padding: const EdgeInsets.all(12),
                          sliver: MediaGallerySliverGrid(
                            items: state.items,
                            selectedIds: state.selectedIds,
                            onToggleSelect: (id) => bloc.add(GalleryManagementEvent.selectionToggled(id)),
                            session: bloc.catalogBloc.session,
                            // Overlay keeps visible routes ticking below a popup
                            // and disables them only behind an opaque page.
                            // isCurrent would also release every image on dialog.
                            active: TickerMode.valuesOf(context).enabled,
                            playbackActive: ModalRoute.isCurrentOf(context) ?? true,
                            onRevisionMismatch: state.isStored
                                ? () => bloc.add(const GalleryManagementEvent.trashRequested())
                                : bloc.catalogBloc.resolveRevisionMismatch,
                            onOpen: (item) => _open(context, item),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        return ConfigAppScaffold(
          appBar: AppBar(
            title: Text(l.gallery_title),
            actions: [
              IconButton(
                tooltip: l.refresh_button,
                icon: const Icon(Icons.refresh),
                onPressed: state.busy ? null : bloc.refresh,
              ),
            ],
          ),
          body: SettingsContent(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (state.capabilities.contains(GalleryCapability.duplicates) ||
                    state.capabilities.contains(GalleryCapability.hidden) ||
                    state.capabilities.contains(GalleryCapability.trash))
                  Card(
                    margin: const EdgeInsets.fromLTRB(16, 8, 16, 12),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Wrap(
                        spacing: 8,
                        runSpacing: 4,
                        children: [
                          for (final section in [
                            GallerySection.published,
                            if (state.capabilities.contains(GalleryCapability.hidden)) GallerySection.hidden,
                            if (state.capabilities.contains(GalleryCapability.duplicates)) GallerySection.duplicates,
                            if (state.capabilities.contains(GalleryCapability.trash)) GallerySection.trash,
                          ])
                            ChoiceChip(
                              label: Text(switch (section) {
                                GallerySection.published => l.gallery_library,
                                GallerySection.hidden => l.gallery_hidden,
                                GallerySection.duplicates => l.gallery_duplicates,
                                GallerySection.trash => l.gallery_trash,
                              }),
                              selected: state.section == section,
                              onSelected: state.busy || state.confirmation != null
                                  ? null
                                  : (selected) {
                                      if (selected) {
                                        bloc.add(GalleryManagementEvent.sectionChanged(section));
                                      }
                                    },
                            ),
                        ],
                      ),
                    ),
                  ),
                if (state.section != GallerySection.duplicates)
                  Card(
                    margin: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                    clipBehavior: Clip.antiAlias,
                    child: _GallerySelectionBar(
                      key: const ValueKey('gallery-selection-bar'),
                      state: state,
                      onMutation: (action) => _requestMutation(context, action),
                    ),
                  ),
                Expanded(child: body),
              ],
            ),
          ),
        );
      },
    ),
  );

  void _details(BuildContext context, GalleryManagementState state) {
    showDialog<void>(
      context: context,
      builder: (_) => GalleryFailureDetailsDialog(state: state),
    );
  }
}

class GalleryFailureDetailsDialog extends StatelessWidget {
  const GalleryFailureDetailsDialog({super.key, required this.state});
  final GalleryManagementState state;

  @override
  Widget build(BuildContext context) {
    final l = context.localizations;
    final shown = math.min(galleryDialogFileLimit, state.failures.length);
    return AlertDialog(
      title: Text(l.gallery_operation_details),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l.gallery_failed_count(state.failures.length), style: Theme.of(context).textTheme.titleSmall),
            if (shown < state.failures.length)
              Padding(padding: const EdgeInsets.only(top: 8), child: Text(l.gallery_first_files(shown))),
            for (final failure in state.failures.take(galleryDialogFileLimit))
              ListTile(
                title: Text(
                  state.failureSnapshot?.byMediaId[failure.mediaId]?.title ??
                      state.snapshot.byMediaId[failure.mediaId]?.title ??
                      failure.mediaId,
                ),
                subtitle: Text(galleryErrorText(context, failure.error)),
              ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(MaterialLocalizations.of(context).closeButtonLabel),
        ),
      ],
    );
  }
}

class _GallerySelectionBar extends StatelessWidget {
  const _GallerySelectionBar({super.key, required this.state, required this.onMutation});
  final GalleryManagementState state;
  final ValueChanged<GalleryMutation> onMutation;

  @override
  Widget build(BuildContext context) {
    final l = context.localizations;
    final bloc = context.read<GalleryManagementBloc>();
    final disabled =
        state.busy || state.needsMutationRefresh || state.selectedIds.isEmpty || state.confirmation != null;
    final allDisabled =
        state.busy ||
        state.needsMutationRefresh ||
        state.trashLoading ||
        state.confirmation != null ||
        state.items.isEmpty;
    final controls = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: Wrap(
        spacing: 8,
        runSpacing: 4,
        alignment: WrapAlignment.spaceBetween,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Text(l.gallery_selected(state.selectedIds.length), style: Theme.of(context).textTheme.titleSmall),
          if (state.isTrash) ...[
            TextButton.icon(
              key: const ValueKey('gallery-select-all-trash'),
              onPressed: allDisabled || state.selectedIds.length == state.items.length
                  ? null
                  : () => bloc.add(const GalleryManagementEvent.trashSelectionAllRequested()),
              icon: const Icon(Icons.select_all),
              label: Text(l.gallery_select_all),
            ),
            IconButton(
              tooltip: l.gallery_restore,
              icon: const Icon(Icons.restore_from_trash),
              onPressed: disabled ? null : () => onMutation(GalleryMutation.restore),
            ),
            IconButton(
              tooltip: l.gallery_purge,
              icon: const Icon(Icons.delete_forever),
              onPressed: disabled ? null : () => onMutation(GalleryMutation.purge),
            ),
            TextButton.icon(
              key: const ValueKey('gallery-clear-trash'),
              onPressed: allDisabled || !state.capabilities.contains(GalleryCapability.mutations)
                  ? null
                  : () => bloc.add(const GalleryManagementEvent.clearTrashRequested()),
              icon: const Icon(Icons.delete_sweep_outlined),
              label: Text(l.gallery_clear_trash),
            ),
          ] else if (state.capabilities.contains(GalleryCapability.mutations)) ...[
            if (state.capabilities.contains(GalleryCapability.hidden))
              TextButton.icon(
                key: const ValueKey('gallery-hide-selection'),
                onPressed: disabled
                    ? null
                    : () => onMutation(state.isHidden ? GalleryMutation.unhide : GalleryMutation.hide),
                icon: Icon(state.isHidden ? Icons.visibility_outlined : Icons.visibility_off_outlined),
                label: Text(state.isHidden ? l.gallery_unhide : l.gallery_hide),
              ),
            TextButton.icon(
              onPressed: disabled ? null : () => onMutation(GalleryMutation.trash),
              icon: const Icon(Icons.delete_outline),
              label: Text(l.gallery_move_to_trash),
            ),
          ],
          IconButton(
            tooltip: l.clear_selection,
            icon: const Icon(Icons.close),
            onPressed: disabled ? null : () => bloc.add(const GalleryManagementEvent.selectionCleared()),
          ),
        ],
      ),
    );
    return Material(
      color: Theme.of(context).colorScheme.surfaceContainer,
      child: state.isTrash
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                controls,
                // Reserved even when idle, so selection and batch progress do
                // not move the grid beneath the permanent trash controls.
                SizedBox(
                  height: 40,
                  child: state.operationPlan != null
                      ? Column(
                          children: [
                            LinearProgressIndicator(
                              value: state.operationTotal == 0 ? 0 : state.processedItems / state.operationTotal,
                            ),
                            Expanded(
                              child: Center(
                                child: Text(
                                  l.gallery_mutation_progress(state.processedItems, state.operationTotal),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ],
                        )
                      : null,
                ),
              ],
            )
          : controls,
    );
  }
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
    this.playbackActive = true,
    this.onRevisionMismatch,
    this.catalogUpdates,
    this.currentItem,
    this.onOpen,
  });
  final List<GalleryItem> items;
  final Set<String> selectedIds;
  final ValueChanged<String> onToggleSelect;
  final GallerySession session;
  final bool active;
  final bool playbackActive;
  final VoidCallback? onRevisionMismatch;
  final Stream<List<GalleryItem>>? catalogUpdates;
  final GalleryItem? Function(String)? currentItem;
  final ValueChanged<GalleryItem>? onOpen;

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
        final start = constraints.scrollOffset + math.max(0.0, constraints.overlap);
        final end = constraints.scrollOffset + constraints.remainingPaintExtent;
        final first = layout.getMinChildIndexForScrollOffset(start);
        final last = layout.getMaxChildIndexForScrollOffset(math.max(start, end));
        final columns = layout is SliverGridRegularTileLayout ? layout.crossAxisCount : 1;
        final prefetchFirst = math.max(0, first - columns);
        final prefetchLast = math.min(items.length - 1, last + columns);
        return SliverGrid(
          gridDelegate: delegate,
          delegate: SliverChildBuilderDelegate((context, index) {
            final item = items[index];
            final visible = index >= first && index <= last;
            final demanded = active && index >= prefetchFirst && index <= prefetchLast;
            return _GalleryItemWidget(
              key: ValueKey(item.mediaId),
              item: item,
              isSelected: selectedIds.contains(item.selectionIdentity),
              session: session,
              active: demanded,
              priority: visible ? GalleryImagePriority.visible : GalleryImagePriority.prefetch,
              distance: visible ? 0 : math.min((index - first).abs(), (index - last).abs()),
              videoActive: active && visible && playbackActive,
              onRevisionMismatch: onRevisionMismatch,
              onTap: () {
                if (item.isFolder) return;
                if (selectedIds.isNotEmpty) {
                  onToggleSelect(item.selectionIdentity);
                } else if (onOpen != null) {
                  onOpen!(item);
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
                        currentItem: currentItem == null ? null : () => currentItem!(item.mediaId),
                      ),
                    ),
                  );
                }
              },
              onLongPress: () {
                if (!item.isFolder) onToggleSelect(item.selectionIdentity);
              },
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
    final cardShape = Theme.of(context).cardTheme.shape;
    final selectedShape = cardShape is OutlinedBorder
        ? cardShape.copyWith(side: BorderSide(width: 3, color: scheme.primary))
        : RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(width: 3, color: scheme.primary),
          );
    Widget content;
    if (item.isFolder) {
      content = FolderGridItem(item: item);
    } else if (item.isVideo) {
      content = VideoGridItem(
        title: item.title,
        url: item.uri.toString(),
        active: videoActive,
        poster: item.thumbnailBaseUri == null
            ? null
            : ImageGridItem(
                item: item,
                loader: session.loader,
                decodePool: session.decodePool,
                active: active,
                priority: priority,
                distance: distance,
                onRevisionMismatch: onRevisionMismatch,
              ),
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
      content = Icon(Icons.insert_drive_file_outlined, color: scheme.onSurfaceVariant);
    }
    return Semantics(
      selected: isSelected,
      child: GestureDetector(
        onTap: onTap,
        onLongPress: onLongPress,
        child: Card(
          margin: EdgeInsets.zero,
          clipBehavior: Clip.antiAlias,
          child: Stack(
            fit: StackFit.expand,
            children: [
              content,
              if (isSelected)
                ColoredBox(
                  key: const ValueKey('gallery-selection-tint'),
                  color: scheme.primary.withValues(alpha: .12),
                  child: Center(child: Icon(Icons.check_circle, color: scheme.primary, size: 36)),
                ),
              if (!item.isFolder)
                Positioned(
                  key: const ValueKey('gallery-selection-checkbox'),
                  top: 0,
                  left: 0,
                  child: Semantics(
                    label: item.title,
                    child: Checkbox(value: isSelected, onChanged: (_) => onLongPress()),
                  ),
                ),
              if (item.isVideo)
                Positioned(
                  top: 6,
                  right: 6,
                  child: Icon(Icons.play_circle_fill, color: scheme.onPrimaryContainer, size: 24),
                ),
              // Paint the selection above the media. A decoration border on
              // the layout container adds padding; animating that padding
              // would change decodeWidth and restart the thumbnail each frame.
              if (isSelected)
                Positioned.fill(
                  key: const ValueKey('gallery-selection-border'),
                  child: IgnorePointer(
                    child: DecoratedBox(decoration: ShapeDecoration(shape: selectedShape)),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
