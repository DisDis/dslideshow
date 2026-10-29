import 'package:config_app/features/gallery/domain/gallery_item.dart';
import 'package:config_app/features/gallery/presentation/bloc/gallery_viewer_bloc.dart';
import 'package:config_app/features/gallery/presentation/widgets/metadata_panel.dart';
import 'package:config_app/features/gallery/presentation/widgets/single_image_viewer.dart';
import 'package:config_app/features/gallery/presentation/widgets/single_video_player.dart';
import 'package:config_app/features/theme/presentation/extensions/build_context_ext.dart';
import 'package:config_app/src/gallery/gallery_management_repository.dart';
import 'package:config_app/src/gallery/gallery_session.dart';
import 'package:dslideshow_common/gallery.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/gallery_actions.dart';

class SingleItemViewerPage extends StatelessWidget {
  final GalleryItem item;
  final GallerySession? session;
  final VoidCallback? onRevisionMismatch;
  final Stream<GalleryItem?>? itemUpdates;
  final GalleryItem? Function()? currentItem;
  final Set<GalleryCapability> capabilities;
  final GalleryManagementRepository? management;
  final GalleryTrashEntry? trashEntry;
  final Future<void> Function()? onChanged;
  final void Function(List<String>)? onTrashed;

  const SingleItemViewerPage({
    super.key,
    required this.item,
    this.session,
    this.onRevisionMismatch,
    this.itemUpdates,
    this.currentItem,
    this.capabilities = const {},
    this.management,
    this.trashEntry,
    this.onChanged,
    this.onTrashed,
  });

  @override
  Widget build(BuildContext context) {
    final configuration = GalleryViewerConfiguration(
      item: item,
      management: management ?? session?.management,
      capabilities: capabilities,
      trashEntry: trashEntry,
      itemUpdates: itemUpdates,
      currentItem: currentItem,
    );
    return BlocProvider(
      create: (_) => GalleryViewerBloc(configuration: configuration),
      child: _ViewerControls(page: this, configuration: configuration),
    );
  }
}

/// Only the control fade needs a TickerProvider and a State lifecycle. All media,
/// metadata, subscription, request and revision state belongs to the viewer Bloc.
class _ViewerControls extends StatefulWidget {
  const _ViewerControls({required this.page, required this.configuration});
  final SingleItemViewerPage page;
  final GalleryViewerConfiguration configuration;
  @override
  State<_ViewerControls> createState() => _ViewerControlsState();
}

class _ViewerControlsState extends State<_ViewerControls>
    with SingleTickerProviderStateMixin {
  bool _showControls = true;
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 300),
    value: 1,
  );
  late final CurvedAnimation _opacity = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeInOut,
  );

  @override
  void didUpdateWidget(_ViewerControls oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.configuration != widget.configuration) {
      context.read<GalleryViewerBloc>().configure(widget.configuration);
    }
  }

  @override
  void dispose() {
    _opacity.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _toggleControls() => setState(() {
    _showControls = !_showControls;
    if (_showControls) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  });

  Future<void> _listen(BuildContext context, GalleryViewerState state) async {
    final effect = state.effect;
    switch (effect) {
      case ViewerConfirmMutation(:final confirmation):
        final bloc = context.read<GalleryViewerBloc>();
        final confirmed = await confirmGalleryMutation(context, confirmation);
        if (mounted && !bloc.isClosed) {
          bloc.add(
            GalleryViewerEvent.mutationDecision(
              confirmationId: confirmation.token,
              confirmed: confirmed,
            ),
          );
        }
      case ViewerConfirmationChanged():
        ScaffoldMessenger.of(context).showSnackBar(
          galleryNotification(
            context.localizations.gallery_confirmation_changed,
          ),
        );
      case ViewerOperationFailed(:final code, :final refreshCatalog):
        if (refreshCatalog) {
          try {
            await widget.page.onChanged?.call();
          } catch (_) {}
        }
        if (!context.mounted) return;
        ScaffoldMessenger.of(context)
            .showSnackBar(galleryNotification(galleryErrorText(context, code)));
      case ViewerRotationApplied():
        // Optional refresh errors cannot revoke a confirmed rotation.
        try {
          await widget.page.onChanged?.call();
        } catch (_) {}
      case ViewerMutationApplied(:final action, :final trashIds):
        if (action == GalleryMutation.trash) {
          widget.page.onTrashed?.call(trashIds);
        }
        try {
          await widget.page.onChanged?.call();
        } catch (_) {}
        if (context.mounted) Navigator.of(context).pop();
      case null:
        break;
    }
  }

  @override
  Widget build(
    BuildContext context,
  ) => BlocConsumer<GalleryViewerBloc, GalleryViewerState>(
    listenWhen: (previous, current) => previous.effectId != current.effectId,
    listener: _listen,
    builder: (context, state) {
      final bloc = context.read<GalleryViewerBloc>();
      final theme = Theme.of(context);
      return Scaffold(
        body: LayoutBuilder(
          builder: (context, constraints) {
            final wideInfo = constraints.maxWidth >= 1000;
            final top = kToolbarHeight + MediaQuery.paddingOf(context).top;
            return Stack(
              fit: StackFit.expand,
              children: [
                GestureDetector(
                  onTap: _toggleControls,
                  behavior: HitTestBehavior.translucent,
                  child: ColoredBox(
                    key: const ValueKey('viewer-media-canvas'),
                    color: theme.colorScheme.surfaceContainerLowest,
                    child: Padding(
                      padding: EdgeInsets.only(
                        right: wideInfo && state.showInfo && _showControls
                            ? 392
                            : 0,
                      ),
                      child: Center(
                        child: state.missing
                            ? Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.hide_image_outlined,
                                    size: 48,
                                    color: theme.colorScheme.onSurfaceVariant,
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    context
                                        .localizations
                                        .gallery_file_unavailable,
                                    textAlign: TextAlign.center,
                                    style: theme.textTheme.titleMedium,
                                  ),
                                ],
                              )
                            : state.item.isVideo
                            ? SingleVideoPlayer(
                                uri: state.item.uri,
                                onContentTap: _toggleControls,
                              )
                            : SingleImageViewer(
                                uri: state.item.uri,
                                item: state.item,
                                session: widget.page.session,
                                onRevisionMismatch:
                                    widget.page.onRevisionMismatch,
                              ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: ExcludeFocus(
                    excluding: !_showControls,
                    child: IgnorePointer(
                      ignoring: !_showControls,
                      child: FadeTransition(
                        opacity: _opacity,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _ViewerToolbar(
                              state: state,
                              onBack: () => Navigator.of(context).pop(),
                            ),
                            const Divider(height: 1),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                if (state.showInfo)
                  Positioned(
                    bottom: 0,
                    top: wideInfo ? top : null,
                    left: wideInfo ? null : 0,
                    width: wideInfo ? 392 : null,
                    right: 0,
                    child: ExcludeFocus(
                      excluding: !_showControls,
                      child: IgnorePointer(
                        ignoring: !_showControls,
                        child: FadeTransition(
                          opacity: _opacity,
                          child: SafeArea(
                            top: false,
                            minimum: const EdgeInsets.all(16),
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                maxHeight: wideInfo
                                    ? double.infinity
                                    : (constraints.maxHeight * .5).clamp(
                                        0,
                                        320,
                                      ),
                              ),
                              child: MetadataPanel(
                                item: state.item,
                                metadata: state.metadata,
                                trashEntry: state.trashEntry,
                                loading: state.metadataLoading,
                                failed: state.metadataFailed,
                                onRetry: () => bloc.add(
                                  const GalleryViewerEvent.metadataRequested(),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      );
    },
  );
}

class _ViewerToolbar extends StatelessWidget {
  const _ViewerToolbar({required this.state, required this.onBack});
  final GalleryViewerState state;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<GalleryViewerBloc>();
    final l = context.localizations;
    final blocked = state.busy || state.missing || state.confirmation != null;
    return AppBar(
      key: const ValueKey('viewer-toolbar'),
      title: Text(
        state.item.title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      leading: IconButton(
        tooltip: MaterialLocalizations.of(context).backButtonTooltip,
        icon: const Icon(Icons.arrow_back),
        onPressed: state.busy || state.confirmation != null ? null : onBack,
      ),
      actions: [
        if (state.canRotate) ...[
          IconButton(
            tooltip: l.gallery_rotate_left,
            icon: const Icon(Icons.rotate_left),
            onPressed: blocked
                ? null
                : () => bloc.add(
                    const GalleryViewerEvent.rotationRequested(
                      GalleryRotation.left,
                    ),
                  ),
          ),
          IconButton(
            tooltip: l.gallery_rotate_right,
            icon: const Icon(Icons.rotate_right),
            onPressed: blocked
                ? null
                : () => bloc.add(
                    const GalleryViewerEvent.rotationRequested(
                      GalleryRotation.right,
                    ),
                  ),
          ),
        ],
        if (state.trash) ...[
          IconButton(
            tooltip: l.gallery_restore,
            icon: const Icon(Icons.restore_from_trash),
            onPressed: blocked || !state.canMutate(GalleryMutation.restore)
                ? null
                : () => bloc.add(
                    const GalleryViewerEvent.mutationRequested(
                      GalleryMutation.restore,
                    ),
                  ),
          ),
          IconButton(
            tooltip: l.gallery_purge,
            icon: const Icon(Icons.delete_forever),
            onPressed: blocked || !state.canMutate(GalleryMutation.purge)
                ? null
                : () => bloc.add(
                    const GalleryViewerEvent.mutationRequested(
                      GalleryMutation.purge,
                    ),
                  ),
          ),
        ] else if (state.capabilities.contains(GalleryCapability.mutations))
          IconButton(
            tooltip: l.gallery_move_to_trash,
            icon: const Icon(Icons.delete_outline),
            onPressed: blocked || !state.canMutate(GalleryMutation.trash)
                ? null
                : () => bloc.add(
                    const GalleryViewerEvent.mutationRequested(
                      GalleryMutation.trash,
                    ),
                  ),
          ),
        if (state.busy)
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          ),
        IconButton(
          tooltip: l.media_info,
          isSelected: state.showInfo,
          selectedIcon: const Icon(Icons.info),
          icon: const Icon(Icons.info_outline),
          onPressed: () => bloc.add(const GalleryViewerEvent.infoToggled()),
        ),
      ],
    );
  }
}
