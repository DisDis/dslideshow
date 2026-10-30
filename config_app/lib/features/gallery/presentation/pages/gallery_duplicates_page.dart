import 'dart:async';

import 'package:dslideshow_common/gallery.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/gallery_item.dart';
import '../../../theme/presentation/extensions/build_context_ext.dart';
import '../../../../src/gallery/gallery_session.dart';
import '../../../../src/gallery/gallery_image_widget.dart';
import '../../../../src/gallery/gallery_log.dart';
import '../../../../src/gallery/media_image_loader.dart';
import '../bloc/gallery_duplicates_bloc.dart';
import '../bloc/gallery_group_comparison_bloc.dart';
import '../widgets/gallery_actions.dart';
import '../widgets/gallery_comparison_details.dart';
import '../widgets/gallery_duplicate_search_dialog.dart';
import '../widgets/gallery_file_path.dart';
import '../widgets/gallery_file_size.dart';
import '../widgets/gallery_recommendation_badge.dart';

export '../bloc/gallery_duplicates_bloc.dart' show GalleryDuplicateDecision;

class GalleryDuplicatesPage extends StatelessWidget {
  const GalleryDuplicatesPage({
    super.key,
    required this.session,
    required this.catalog,
    required this.onRefresh,
    this.catalogUpdates,
    this.currentCatalog,
  });
  final GallerySession session;

  /// Initial snapshot; subsequent confirmed snapshots arrive on catalogUpdates.
  final List<GalleryItem> catalog;
  final Stream<List<GalleryItem>>? catalogUpdates;
  final List<GalleryItem> Function()? currentCatalog;
  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) => BlocProvider(
    key: ObjectKey(session),
    create: (_) => GalleryDuplicatesBloc(
      repository: session.management,
      catalog: currentCatalog?.call() ?? catalog,
      catalogUpdates: catalogUpdates,
      onRefresh: onRefresh,
    ),
    child: Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1100),
        child: _DuplicatesView(session: session, onRefresh: onRefresh),
      ),
    ),
  );
}

class _DuplicatesView extends StatelessWidget {
  const _DuplicatesView({required this.session, required this.onRefresh});
  final GallerySession session;
  final Future<void> Function() onRefresh;

  Future<void> _effect(
    BuildContext context,
    GalleryDuplicatesEffect effect,
  ) async {
    final bloc = context.read<GalleryDuplicatesBloc>();
    final l = context.localizations;
    final messenger = ScaffoldMessenger.of(context);
    switch (effect.notice) {
      case GalleryDuplicatesNotice.review:
        final confirmed = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(l.gallery_result_review_title),
            content: SizedBox(
              width: 480,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(l.gallery_selected(effect.members.length)),
                    ...effect.members
                        .take(galleryDialogFileLimit)
                        .map(
                          (item) => ListTile(
                            title: Text(item.name),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(item.path),
                                GalleryFileSize(bytes: item.sizeBytes),
                              ],
                            ),
                          ),
                        ),
                    if (effect.members.length > galleryDialogFileLimit)
                      Text(
                        l.gallery_more_files_trash(
                          effect.members.length - galleryDialogFileLimit,
                        ),
                      ),
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: Text(
                  MaterialLocalizations.of(context).cancelButtonLabel,
                ),
              ),
              FilledButton(
                onPressed: () => Navigator.pop(context, true),
                child: Text(l.gallery_move_to_trash),
              ),
            ],
          ),
        );
        if (context.mounted && confirmed == true && !bloc.isClosed) {
          bloc.add(GalleryDuplicatesEvent.apply(effect.jobId!, effect.members));
        }
      case GalleryDuplicatesNotice.completed:
        final result = effect.result!;
        final succeeded = result.items
            .where((item) => item.state == GalleryItemOperationState.succeeded)
            .toList();
        if (succeeded.isNotEmpty) {
          showGalleryUndo(
            context,
            session.management,
            succeeded
                .where((item) => item.trashId != null)
                .map((item) => item.trashId!)
                .toList(),
            onRefresh,
          );
        }
        if (result.items.any(
          (item) => item.state == GalleryItemOperationState.failed,
        )) {
          messenger.showSnackBar(galleryNotification(l.gallery_failed_files));
        }
      case GalleryDuplicatesNotice.keepOne:
        messenger.showSnackBar(galleryNotification(l.gallery_keep_one));
      case GalleryDuplicatesNotice.stale:
        messenger.showSnackBar(galleryNotification(l.gallery_stale_result));
      case GalleryDuplicatesNotice.refreshFailed:
        messenger.showSnackBar(galleryNotification(l.gallery_refresh_failed));
      case GalleryDuplicatesNotice.actionFailed:
        messenger.showSnackBar(galleryNotification(l.gallery_action_failed));
    }
  }

  Future<void> _newSearch(BuildContext context) async {
    final bloc = context.read<GalleryDuplicatesBloc>();
    final choice = await showGalleryDuplicateSearchDialog(
      context,
      initialModes: bloc.state.modes,
    );
    if (choice != null && !bloc.isClosed) {
      bloc.add(GalleryDuplicatesEvent.start(modes: choice.modes));
    }
  }

  @override
  Widget build(
    BuildContext context,
  ) => BlocConsumer<GalleryDuplicatesBloc, GalleryDuplicatesState>(
    listenWhen: (previous, current) => previous.effect != current.effect,
    listener: (context, state) {
      if (state.effect != null) unawaited(_effect(context, state.effect!));
    },
    builder: (context, state) {
      if (state.loading) {
        return const Center(child: CircularProgressIndicator());
      }
      final bloc = context.read<GalleryDuplicatesBloc>();
      final l = context.localizations;
      final job = state.job;
      final group = state.group;
      final diagnosticCard = _diagnostics(state);
      final hasGroups = job?.groups.isNotEmpty ?? false;
      Widget content(GalleryGroupComparisonState? comparison) => Column(
        children: [
          _DuplicatesHeader(state: state, onSearch: () => _newSearch(context)),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              children: [
                if (state.running) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 36),
                    child: Column(
                      children: [
                        const CircularProgressIndicator(),
                        const SizedBox(height: 20),
                        Text(
                          job!.status == GalleryDuplicateStatus.stopping
                              ? l.gallery_search_stopping
                              : l.gallery_search_running,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          l.gallery_elapsed(
                            '${state.elapsedSeconds ~/ 60}:${(state.elapsedSeconds % 60).toString().padLeft(2, '0')}',
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(_searchModesText(context, job.modes.toSet())),
                        const SizedBox(height: 16),
                        Text(
                          l.gallery_search_background_hint,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        OutlinedButton(
                          onPressed:
                              state.busy ||
                                  job.status == GalleryDuplicateStatus.stopping
                              ? null
                              : () => bloc.add(
                                  const GalleryDuplicatesEvent.stop(),
                                ),
                          child: Text(l.gallery_search_stop),
                        ),
                      ],
                    ),
                  ),
                  ?diagnosticCard,
                ] else ...[
                  if (diagnosticCard != null &&
                      (state.failed ||
                          job?.status == GalleryDuplicateStatus.failed ||
                          !hasGroups))
                    diagnosticCard,
                  if (hasGroups) ...[
                    _DuplicateGroupBar(state: state),
                    if (group != null && comparison != null) ...[
                      ExpansionTile(
                        key: const PageStorageKey('gallery-candidate-help'),
                        tilePadding: EdgeInsets.zero,
                        title: Text(
                          l.gallery_candidate_help,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        childrenPadding: const EdgeInsets.only(bottom: 16),
                        expandedCrossAxisAlignment: CrossAxisAlignment.start,
                        shape: const Border(),
                        collapsedShape: const Border(),
                        children: [
                          Text(
                            group.mode == GalleryDuplicateMode.exact
                                ? l.gallery_exact_hint
                                : l.gallery_similar_hint,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            comparison.exact
                                ? l.gallery_equivalent_copies
                                : l.gallery_resolution_recommendation_hint,
                          ),
                          const SizedBox(height: 8),
                          Text(l.gallery_duplicate_select_hint),
                          if (!comparison.complete && !comparison.exact)
                            Text(l.gallery_comparison_partial),
                        ],
                      ),
                      if (group.items.length > 10)
                        _DuplicateMemberPages(state: state),
                      for (final member in state.visibleMembers)
                        Padding(
                          key: ValueKey((
                            group.groupId,
                            member.mediaId,
                            member.sourceRevision,
                          )),
                          padding: const EdgeInsets.only(bottom: 12),
                          child: _CandidateCard(
                            session: session,
                            state: state,
                            group: group,
                            member: member,
                            comparison: comparison,
                          ),
                        ),
                    ] else if (!state.groupLoading && !state.failed) ...[
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Text(l.gallery_duplicate_review_done),
                      ),
                      TextButton(
                        onPressed: state.busy
                            ? null
                            : () =>
                                  bloc.add(const GalleryDuplicatesEvent.skip()),
                        child: Text(l.gallery_duplicate_review_again),
                      ),
                    ],
                  ] else if (job?.status != GalleryDuplicateStatus.failed &&
                      !state.failed) ...[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 40),
                      child: Column(
                        children: [
                          Icon(
                            job?.status == GalleryDuplicateStatus.completed
                                ? Icons.done_all
                                : Icons.photo_library_outlined,
                            size: 40,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            job?.status == GalleryDuplicateStatus.completed
                                ? l.gallery_search_none
                                : l.gallery_search_ready,
                            style: Theme.of(context).textTheme.titleLarge,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            l.gallery_search_scope,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 20),
                          FilledButton.icon(
                            onPressed: state.busy
                                ? null
                                : () => _newSearch(context),
                            icon: const Icon(Icons.search),
                            label: Text(l.gallery_search_start),
                          ),
                        ],
                      ),
                    ),
                  ],
                  if (hasGroups)
                    ExpansionTile(
                      key: const PageStorageKey('gallery-search-details'),
                      tilePadding: EdgeInsets.zero,
                      title: Text(
                        l.gallery_search_details,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      expandedCrossAxisAlignment: CrossAxisAlignment.start,
                      shape: const Border(),
                      collapsedShape: const Border(),
                      children: [
                        if (job!.modes.isNotEmpty)
                          Text(_searchModesText(context, job.modes.toSet())),
                        if (job.skipped > 0)
                          Text(l.gallery_skipped(job.skipped)),
                        if (!state.failed &&
                            job.status != GalleryDuplicateStatus.failed)
                          ?diagnosticCard,
                      ],
                    ),
                ],
                if (state.busy || state.groupLoading)
                  const LinearProgressIndicator(),
                if (state.failed)
                  TextButton(
                    onPressed: state.busy || state.polling
                        ? null
                        : () => bloc.add(const GalleryDuplicatesEvent.load()),
                    child: Text(l.retry_button),
                  ),
              ],
            ),
          ),
          if (!state.running && hasGroups) _DuplicateSelectionBar(state: state),
        ],
      );
      if (group == null || state.running) return content(null);
      return BlocProvider(
        key: ObjectKey(group),
        create: (_) => GalleryGroupComparisonBloc(group: group),
        child:
            BlocBuilder<
              GalleryGroupComparisonBloc,
              GalleryGroupComparisonState
            >(builder: (_, comparison) => content(comparison)),
      );
    },
  );

  Widget? _diagnostics(GalleryDuplicatesState state) {
    final job = state.job;
    final diagnostics = job?.diagnostics;
    if (state.failed) {
      return _DuplicateDiagnosticsCard(
        kind: _DiagnosticsKind.requestFailure,
        job: job,
        error: state.requestError ?? GalleryErrorCode.unknown,
      );
    }
    if (job?.status == GalleryDuplicateStatus.failed) {
      return _DuplicateDiagnosticsCard(
        kind: _DiagnosticsKind.searchFailure,
        job: job,
        error: job!.error,
      );
    }
    if (job?.status == GalleryDuplicateStatus.completed &&
        diagnostics != null &&
        (job!.groups.isEmpty ||
            diagnostics.snapshotSkippedCount > 0 ||
            diagnostics.rejectedResultCount > 0)) {
      return _DuplicateDiagnosticsCard(
        kind: _DiagnosticsKind.summary,
        job: job,
      );
    }
    return null;
  }
}

String _searchModesText(BuildContext context, Set<GalleryDuplicateMode> modes) {
  final l = context.localizations;
  return switch (GalleryDuplicateSearchChoice.fromModes(modes)) {
    GalleryDuplicateSearchChoice.exact => l.gallery_exact_copies,
    GalleryDuplicateSearchChoice.similar => l.gallery_similar_images,
    GalleryDuplicateSearchChoice.both => l.gallery_search_both,
  };
}

class _DuplicatesHeader extends StatelessWidget {
  const _DuplicatesHeader({required this.state, required this.onSearch});
  final GalleryDuplicatesState state;
  final VoidCallback onSearch;

  @override
  Widget build(BuildContext context) {
    final l = context.localizations;
    final job = state.job;
    final status = state.running
        ? l.gallery_search_running
        : job?.status == GalleryDuplicateStatus.completed
        ? l.gallery_search_completed
        : job?.status == GalleryDuplicateStatus.cancelled
        ? l.gallery_search_cancelled
        : job?.status == GalleryDuplicateStatus.interrupted
        ? l.gallery_search_interrupted
        : job?.status == GalleryDuplicateStatus.failed
        ? l.gallery_search_not_completed
        : state.failed
        ? l.gallery_search_not_completed
        : l.gallery_search_ready;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final title = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l.gallery_duplicates,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 4),
              Text(
                [
                  if (job?.groups.isNotEmpty ?? false)
                    l.gallery_search_groups(job!.groups.length),
                  status,
                ].join(' · '),
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          );
          final button = OutlinedButton.icon(
            onPressed: state.busy || state.running || state.groupLoading
                ? null
                : onSearch,
            icon: const Icon(Icons.search),
            label: Text(l.gallery_search_new),
          );
          if (constraints.maxWidth < 560) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [title, const SizedBox(height: 12), button],
            );
          }
          return Row(
            children: [
              Expanded(child: title),
              const SizedBox(width: 16),
              button,
            ],
          );
        },
      ),
    );
  }
}

class _DuplicateGroupBar extends StatelessWidget {
  const _DuplicateGroupBar({required this.state});
  final GalleryDuplicatesState state;
  @override
  Widget build(BuildContext context) {
    final l = context.localizations;
    final bloc = context.read<GalleryDuplicatesBloc>();
    final group = state.group;
    final enabled = !state.busy && !state.groupLoading;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(height: 1),
        const SizedBox(height: 12),
        Wrap(
          spacing: 16,
          runSpacing: 8,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            if (group != null) ...[
              Text(
                l.gallery_group_position(
                  state.groupIndex + 1,
                  state.job!.groups.length,
                ),
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Chip(
                label: Text(
                  group.mode == GalleryDuplicateMode.exact
                      ? l.gallery_exact_copies
                      : l.gallery_similar_images,
                ),
                side: BorderSide.none,
              ),
              Text(
                l.gallery_group_files(group.items.length),
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  tooltip: l.gallery_previous_group,
                  onPressed: !enabled || state.groupIndex == 0
                      ? null
                      : () => bloc.add(
                          GalleryDuplicatesEvent.group(state.groupIndex - 1),
                        ),
                  icon: const Icon(Icons.chevron_left),
                ),
                Flexible(
                  child: TextButton.icon(
                    onPressed: !enabled || group == null
                        ? null
                        : () => bloc.add(const GalleryDuplicatesEvent.skip()),
                    iconAlignment: IconAlignment.end,
                    icon: const Icon(Icons.chevron_right),
                    label: Text(l.gallery_next_group),
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}

class _DuplicateMemberPages extends StatelessWidget {
  const _DuplicateMemberPages({required this.state});
  final GalleryDuplicatesState state;
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<GalleryDuplicatesBloc>();
    final enabled = !state.busy && !state.groupLoading;
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        IconButton(
          tooltip: MaterialLocalizations.of(context).previousPageTooltip,
          onPressed: !enabled || state.memberOffset == 0
              ? null
              : () => bloc.add(
                  GalleryDuplicatesEvent.members(state.memberOffset - 10),
                ),
          icon: const Icon(Icons.chevron_left),
        ),
        Text(
          context.localizations.gallery_duplicate_members(
            state.memberOffset + 1,
            state.memberOffset + state.visibleMembers.length,
            state.group!.items.length,
          ),
        ),
        IconButton(
          tooltip: MaterialLocalizations.of(context).nextPageTooltip,
          onPressed:
              !enabled || state.memberOffset + 10 >= state.group!.items.length
              ? null
              : () => bloc.add(
                  GalleryDuplicatesEvent.members(state.memberOffset + 10),
                ),
          icon: const Icon(Icons.chevron_right),
        ),
      ],
    );
  }
}

class _DuplicateSelectionBar extends StatelessWidget {
  const _DuplicateSelectionBar({required this.state});
  final GalleryDuplicatesState state;
  @override
  Widget build(BuildContext context) {
    final l = context.localizations;
    final bloc = context.read<GalleryDuplicatesBloc>();
    final enabled =
        !state.busy && !state.groupLoading && state.selectedCount > 0;
    return Material(
      color: Theme.of(context).colorScheme.surfaceContainerLow,
      child: SafeArea(
        top: false,
        child: Padding(
          key: const ValueKey('gallery-duplicate-selection'),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final children = <Widget>[
                Semantics(
                  liveRegion: true,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(l.gallery_selected(state.selectedCount)),
                      Tooltip(
                        message: l.gallery_size_bytes(state.selectedBytes),
                        child: Text(
                          l.gallery_selection_volume(
                            GalleryFileSize.formatMegabytes(
                              context,
                              state.selectedBytes,
                            ),
                          ),
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: enabled
                      ? () => bloc.add(
                          const GalleryDuplicatesEvent.clearSelection(),
                        )
                      : null,
                  child: Text(l.gallery_clear_selection),
                ),
                FilledButton.icon(
                  onPressed: enabled
                      ? () => bloc.add(const GalleryDuplicatesEvent.review())
                      : null,
                  icon: const Icon(Icons.delete_outline),
                  label: Wrap(
                    spacing: 4,
                    children: [
                      Text(l.gallery_move_to_trash),
                      if (state.selectedCount > 0)
                        Text('(${state.selectedCount})'),
                    ],
                  ),
                ),
              ];
              if (constraints.maxWidth >= 640) {
                return Row(
                  children: [
                    Expanded(child: children.first),
                    ...children.skip(1),
                  ],
                );
              }
              return Wrap(
                spacing: 16,
                runSpacing: 8,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: children,
              );
            },
          ),
        ),
      ),
    );
  }
}

enum _DiagnosticsKind { requestFailure, searchFailure, summary }

class _DuplicateDiagnosticsCard extends StatelessWidget {
  const _DuplicateDiagnosticsCard({
    required this.kind,
    required this.job,
    this.error,
  });
  static final _toolVersion = RegExp(r'^\d+\.\d+\.\d+$');
  final _DiagnosticsKind kind;
  final GalleryDuplicateJob? job;
  final GalleryErrorCode? error;

  static bool _validVersion(String value) {
    if (value.length > 32) return false;
    final match = _toolVersion.firstMatch(value);
    return match != null && match.end == value.length;
  }

  String _cause(
    BuildContext context,
    GalleryDuplicateDiagnostics? diagnostics,
  ) {
    final l = context.localizations;
    final reason = diagnostics?.failureReason;
    if (reason == null || reason == GalleryDuplicateFailureReason.unknown) {
      return switch (error) {
        GalleryErrorCode.timeout => l.gallery_search_cause_timeout,
        GalleryErrorCode.outputLimitExceeded =>
          l.gallery_search_cause_output_limit,
        _ => l.gallery_search_cause_unexpected,
      };
    }
    return switch (reason) {
      GalleryDuplicateFailureReason.toolUnavailable =>
        l.gallery_search_cause_tool_unavailable,
      GalleryDuplicateFailureReason.unsupportedVersion =>
        l.gallery_search_cause_unsupported_version,
      GalleryDuplicateFailureReason.versionProbeFailed =>
        l.gallery_search_cause_version_probe_failed,
      GalleryDuplicateFailureReason.processFailed =>
        l.gallery_search_cause_process_failed,
      GalleryDuplicateFailureReason.timeout => l.gallery_search_cause_timeout,
      GalleryDuplicateFailureReason.outputLimitExceeded =>
        l.gallery_search_cause_output_limit,
      GalleryDuplicateFailureReason.invalidResult =>
        l.gallery_search_cause_invalid_result,
      GalleryDuplicateFailureReason.storageUnavailable =>
        l.gallery_search_cause_storage_unavailable,
      GalleryDuplicateFailureReason.unknown ||
      GalleryDuplicateFailureReason.unexpected =>
        l.gallery_search_cause_unexpected,
    };
  }

  String _stage(BuildContext context, GalleryDuplicateStage stage) {
    final l = context.localizations;
    return switch (stage) {
      GalleryDuplicateStage.unknown => l.gallery_search_stage_unknown,
      GalleryDuplicateStage.snapshot => l.gallery_search_stage_snapshot,
      GalleryDuplicateStage.versionProbe =>
        l.gallery_search_stage_version_probe,
      GalleryDuplicateStage.scanning => l.gallery_search_stage_scanning,
      GalleryDuplicateStage.validation => l.gallery_search_stage_validation,
      GalleryDuplicateStage.persistence => l.gallery_search_stage_persistence,
    };
  }

  Widget _detail(BuildContext context, String label, String value) => Padding(
    padding: const EdgeInsets.only(top: 8),
    child: Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: '$label: ',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          TextSpan(text: value),
        ],
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final l = context.localizations;
    final theme = Theme.of(context);
    final diagnostics = kind == _DiagnosticsKind.requestFailure
        ? null
        : job?.diagnostics;
    final version = diagnostics?.toolVersion;
    return Card(
      key: const ValueKey('gallery-duplicate-diagnostics'),
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (kind != _DiagnosticsKind.summary) ...[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.error_outline, color: theme.colorScheme.error),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      kind == _DiagnosticsKind.requestFailure
                          ? l.gallery_search_transport_failed
                          : l.gallery_search_failed,
                      style: theme.textTheme.titleMedium,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                kind == _DiagnosticsKind.requestFailure
                    ? galleryErrorText(context, error)
                    : _cause(context, diagnostics),
              ),
            ],
            if (diagnostics != null) ...[
              if (kind == _DiagnosticsKind.searchFailure)
                _detail(
                  context,
                  l.gallery_search_stage,
                  _stage(context, diagnostics.stage),
                ),
              if (version != null && _validVersion(version))
                _detail(context, l.gallery_search_tool_version, version),
              if (diagnostics.exitCode != null)
                _detail(
                  context,
                  l.gallery_search_exit_code,
                  '${diagnostics.exitCode}',
                ),
              if (diagnostics.mode != null &&
                  kind == _DiagnosticsKind.searchFailure)
                _detail(
                  context,
                  l.gallery_search_mode,
                  diagnostics.mode == GalleryDuplicateMode.exact
                      ? l.gallery_exact_copies
                      : l.gallery_similar_images,
                ),
              _detail(
                context,
                l.gallery_search_candidates,
                '${diagnostics.candidateCount}',
              ),
              _detail(
                context,
                l.gallery_search_matched,
                '${diagnostics.matchedFileCount}',
              ),
              _detail(
                context,
                l.gallery_search_rejected,
                '${diagnostics.rejectedResultCount}',
              ),
              _detail(
                context,
                l.gallery_search_snapshot_skipped,
                '${diagnostics.snapshotSkippedCount}',
              ),
            ],
            if (error != null)
              _detail(context, l.gallery_search_error_code, error!.name),
            if (job != null && job!.jobId.isNotEmpty)
              _detail(
                context,
                l.gallery_search_job_id,
                GalleryLog.id(job!.jobId),
              ),
          ],
        ),
      ),
    );
  }
}

class _CandidateCard extends StatelessWidget {
  const _CandidateCard({
    required this.session,
    required this.state,
    required this.group,
    required this.member,
    required this.comparison,
  });
  final GallerySession session;
  final GalleryDuplicatesState state;
  final GalleryDuplicateGroup group;
  final GalleryDuplicateMember member;
  final GalleryGroupComparisonState comparison;

  @override
  Widget build(BuildContext context) {
    final l = context.localizations;
    final bloc = context.read<GalleryDuplicatesBloc>();
    final item = state.item(member);
    final recommended =
        !state.groupLoading && comparison.recommended(member.mediaId);
    final theme = Theme.of(context);
    final recommendationColor = galleryRecommendationColor(context);
    final cardShape = theme.cardTheme.shape;
    final selected =
        state.decisions[member.mediaId] == GalleryDuplicateDecision.trash;
    final enabled = item != null && !state.busy && !state.groupLoading;
    void choose(bool? value) => bloc.add(
      GalleryDuplicatesEvent.decide(
        group.groupId,
        member.mediaId,
        value == true
            ? GalleryDuplicateDecision.trash
            : GalleryDuplicateDecision.keep,
      ),
    );
    final details = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GalleryComparisonDetails(
          key: ValueKey((member.mediaId, member.sourceRevision)),
          member: member,
          item: item,
          repository: session.management,
          comparison: state.groupLoading ? null : comparison,
          onMetadata: (metadata) {
            final comparisonBloc = context.read<GalleryGroupComparisonBloc>();
            if (!comparisonBloc.isClosed) comparisonBloc.add(metadata);
          },
          onRevisionMismatch: () =>
              bloc.add(GalleryDuplicatesEvent.invalidate(member)),
        ),
        const SizedBox(height: 8),
        GalleryFilePath(
          relativePath: member.path,
          name: member.name,
          style: GalleryFilePathStyle.nearestFolder,
          showName: false,
        ),
      ],
    );
    return Card(
      shape: recommended
          ? (cardShape is OutlinedBorder
                    ? cardShape
                    : RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ))
                .copyWith(
                  side: BorderSide(width: 3, color: recommendationColor),
                )
          : null,
      color: recommended
          ? Color.alphaBlend(
              recommendationColor.withValues(alpha: .05),
              theme.cardTheme.color ?? theme.colorScheme.surfaceContainerLow,
            )
          : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (recommended)
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: GalleryRecommendationBadge(reason: comparison.reason),
              ),
            ),
          Padding(
            key: const ValueKey('duplicate-card-content'),
            padding: const EdgeInsets.all(12),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final wide = constraints.maxWidth >= 600;
                final image = SizedBox(
                  width: wide ? 180 : constraints.maxWidth,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: wide ? 120 : 180,
                        width: double.infinity,
                        child: item == null
                            ? Center(child: Text(l.gallery_stale_result))
                            : InteractiveViewer(
                                minScale: 1,
                                maxScale: 5,
                                child: GalleryImage(
                                  loader: session.loader,
                                  decodePool: session.decodePool,
                                  request: item.imageRequest(),
                                  active: TickerMode.valuesOf(context).enabled,
                                  priority: GalleryImagePriority.fullscreen,
                                  fit: BoxFit.contain,
                                  onRevisionMismatch: () {
                                    if (!bloc.isClosed) {
                                      bloc.add(
                                        GalleryDuplicatesEvent.invalidate(
                                          member,
                                        ),
                                      );
                                    }
                                  },
                                  errorBuilder: (context, retry) => Center(
                                    child: TextButton(
                                      onPressed: retry,
                                      child: Text(l.gallery_retry_image),
                                    ),
                                  ),
                                ),
                              ),
                      ),
                      TextButton.icon(
                        onPressed: item == null
                            ? null
                            : () => showDialog<void>(
                                context: context,
                                builder: (_) => _DuplicatePhotoDialog(
                                  session: session,
                                  item: item,
                                  onRevisionMismatch: () {
                                    if (!bloc.isClosed) {
                                      bloc.add(
                                        GalleryDuplicatesEvent.invalidate(
                                          member,
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ),
                        icon: const Icon(Icons.open_in_full, size: 16),
                        label: Text(l.gallery_open_photo),
                      ),
                    ],
                  ),
                );
                final body = wide
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          image,
                          const SizedBox(width: 16),
                          Expanded(child: details),
                        ],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [image, details],
                      );
                final name = Tooltip(
                  message: member.name,
                  child: Text(
                    member.name,
                    style: theme.textTheme.titleMedium,
                    softWrap: true,
                  ),
                );
                final checkbox = SizedBox(
                  width: wide ? 200 : constraints.maxWidth,
                  child: CheckboxListTile(
                    contentPadding: EdgeInsets.zero,
                    controlAffinity: ListTileControlAffinity.leading,
                    title: Text(l.gallery_move_to_trash),
                    value: selected,
                    onChanged: enabled ? choose : null,
                  ),
                );
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (wide)
                      Row(
                        children: [
                          Expanded(child: name),
                          const SizedBox(width: 12),
                          checkbox,
                        ],
                      )
                    else ...[
                      name,
                      checkbox,
                    ],
                    const SizedBox(height: 8),
                    body,
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _DuplicatePhotoDialog extends StatelessWidget {
  const _DuplicatePhotoDialog({
    required this.session,
    required this.item,
    required this.onRevisionMismatch,
  });
  final GallerySession session;
  final GalleryItem item;
  final VoidCallback onRevisionMismatch;
  @override
  Widget build(BuildContext context) => Dialog(
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 960, maxHeight: 800),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    item.title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                IconButton(
                  tooltip: MaterialLocalizations.of(context).closeButtonTooltip,
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Flexible(
              child: InteractiveViewer(
                minScale: 1,
                maxScale: 5,
                child: GalleryImage(
                  loader: session.loader,
                  decodePool: session.decodePool,
                  request: item.imageRequest(),
                  active: TickerMode.valuesOf(context).enabled,
                  priority: GalleryImagePriority.fullscreen,
                  fit: BoxFit.contain,
                  onRevisionMismatch: onRevisionMismatch,
                  errorBuilder: (context, retry) => Center(
                    child: TextButton(
                      onPressed: retry,
                      child: Text(context.localizations.gallery_retry_image),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
