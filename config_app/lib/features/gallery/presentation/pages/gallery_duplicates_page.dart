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
import '../widgets/gallery_actions.dart';
import '../widgets/gallery_comparison_details.dart';

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
    child: _DuplicatesView(session: session, onRefresh: onRefresh),
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
                    if (effect.members.length > galleryDialogFileLimit)
                      Text(l.gallery_first_files(galleryDialogFileLimit)),
                    ...effect.members
                        .take(galleryDialogFileLimit)
                        .map(
                          (item) => ListTile(
                            title: Text(item.name),
                            subtitle: Text('${item.path}\n${item.sizeBytes}'),
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

  @override
  Widget build(
    BuildContext context,
  ) => BlocConsumer<GalleryDuplicatesBloc, GalleryDuplicatesState>(
    listenWhen: (previous, current) => previous.effect != current.effect,
    listener: (context, state) {
      if (state.effect != null) unawaited(_effect(context, state.effect!));
    },
    builder: (context, state) {
      final bloc = context.read<GalleryDuplicatesBloc>();
      final l = context.localizations;
      final job = state.job;
      final diagnosticCard = _diagnostics(state);
      if (state.loading) {
        return const Center(child: CircularProgressIndicator());
      }
      if (state.running) {
        final seconds = state.elapsedSeconds;
        return Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircularProgressIndicator(),
                const SizedBox(height: 16),
                Text(
                  job!.status == GalleryDuplicateStatus.stopping
                      ? l.gallery_search_stopping
                      : l.gallery_search_running,
                ),
                Text(
                  l.gallery_elapsed(
                    '${seconds ~/ 60}:${(seconds % 60).toString().padLeft(2, '0')}',
                  ),
                ),
                ?diagnosticCard,
                if (state.failed)
                  TextButton(
                    onPressed: state.busy || state.polling
                        ? null
                        : () => bloc.add(const GalleryDuplicatesEvent.load()),
                    child: Text(l.retry_button),
                  ),
                TextButton(
                  onPressed:
                      state.busy ||
                          job.status == GalleryDuplicateStatus.stopping
                      ? null
                      : () => bloc.add(const GalleryDuplicatesEvent.stop()),
                  child: Text(l.gallery_search_stop),
                ),
              ],
            ),
          ),
        );
      }
      if (state.setup ||
          job == null ||
          job.status == GalleryDuplicateStatus.idle) {
        return ListView(
          padding: const EdgeInsets.all(24),
          children: [
            ?diagnosticCard,
            Text(l.gallery_search_scope),
            for (final mode in GalleryDuplicateMode.values)
              CheckboxListTile(
                title: Text(
                  mode == GalleryDuplicateMode.exact
                      ? l.gallery_exact_copies
                      : l.gallery_similar_images,
                ),
                value: state.modes.contains(mode),
                onChanged: state.busy
                    ? null
                    : (value) => bloc.add(
                        GalleryDuplicatesEvent.mode(mode, value == true),
                      ),
              ),
            FilledButton(
              onPressed: state.busy || state.modes.isEmpty
                  ? null
                  : () => bloc.add(const GalleryDuplicatesEvent.start()),
              child: Text(l.gallery_search_start),
            ),
            if (state.busy) const LinearProgressIndicator(),
            if (job != null && job.groups.isNotEmpty)
              TextButton(
                onPressed: () =>
                    bloc.add(const GalleryDuplicatesEvent.setup(false)),
                child: Text(l.gallery_duplicates),
              ),
            if (state.failed)
              TextButton(
                onPressed: state.busy || state.polling
                    ? null
                    : () => bloc.add(const GalleryDuplicatesEvent.load()),
                child: Text(l.retry_button),
              ),
          ],
        );
      }
      final group = state.group;
      return ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ?diagnosticCard,
          if (job.status == GalleryDuplicateStatus.cancelled)
            Text(l.gallery_search_cancelled),
          if (job.status == GalleryDuplicateStatus.interrupted)
            Text(l.gallery_search_interrupted),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: state.busy
                  ? null
                  : () => bloc.add(const GalleryDuplicatesEvent.setup(true)),
              child: Text(l.gallery_search_new),
            ),
          ),
          if (job.skipped > 0 &&
              (job.diagnostics == null || job.groups.isNotEmpty))
            Text(l.gallery_skipped(job.skipped)),
          if (job.groups.isEmpty &&
              job.status == GalleryDuplicateStatus.completed)
            Text(l.gallery_search_none),
          if (state.groupLoading) const LinearProgressIndicator(),
          if (job.groups.isNotEmpty)
            Wrap(
              spacing: 12,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                if (group != null)
                  TextButton(
                    onPressed: state.busy || state.groupLoading
                        ? null
                        : () => bloc.add(const GalleryDuplicatesEvent.skip()),
                    child: Text(l.gallery_skip_group),
                  ),
                Text(
                  l.gallery_selected(
                    state.decisions.values
                        .where(
                          (decision) =>
                              decision == GalleryDuplicateDecision.trash,
                        )
                        .length,
                  ),
                ),
                FilledButton.icon(
                  onPressed:
                      state.busy ||
                          state.groupLoading ||
                          !state.decisions.values.contains(
                            GalleryDuplicateDecision.trash,
                          )
                      ? null
                      : () => bloc.add(const GalleryDuplicatesEvent.review()),
                  icon: const Icon(Icons.delete_outline),
                  label: Text(l.gallery_move_to_trash),
                ),
              ],
            ),
          if (group != null) ...[
            Text(
              l.gallery_group_position(state.groupIndex + 1, job.groups.length),
            ),
            Text(
              group.mode == GalleryDuplicateMode.exact
                  ? l.gallery_exact_copies
                  : l.gallery_similar_images,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(
              group.mode == GalleryDuplicateMode.exact
                  ? l.gallery_exact_hint
                  : l.gallery_similar_hint,
            ),
            Text(l.gallery_duplicate_select_hint),
            if (group.items.length > 10)
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  IconButton(
                    tooltip: MaterialLocalizations.of(context)
                        .previousPageTooltip,
                    onPressed:
                        state.busy ||
                            state.groupLoading ||
                            state.memberOffset == 0
                        ? null
                        : () => bloc.add(
                            GalleryDuplicatesEvent.members(
                              state.memberOffset - 10,
                            ),
                          ),
                    icon: const Icon(Icons.chevron_left),
                  ),
                  Text(
                    l.gallery_duplicate_members(
                      state.memberOffset + 1,
                      state.memberOffset + state.visibleMembers.length,
                      group.items.length,
                    ),
                  ),
                  IconButton(
                    tooltip: MaterialLocalizations.of(context).nextPageTooltip,
                    onPressed:
                        state.busy ||
                            state.groupLoading ||
                            state.memberOffset + 10 >= group.items.length
                        ? null
                        : () => bloc.add(
                            GalleryDuplicatesEvent.members(
                              state.memberOffset + 10,
                            ),
                          ),
                    icon: const Icon(Icons.chevron_right),
                  ),
                ],
              ),
            for (final member in state.visibleMembers)
              _CandidateCard(
                key: ValueKey((
                  group.groupId,
                  member.mediaId,
                  member.sourceRevision,
                )),
                session: session,
                state: state,
                group: group,
                member: member,
              ),
          ] else if (!state.groupLoading &&
              !state.failed &&
              job.groups.isNotEmpty) ...[
            Text(l.gallery_duplicate_review_done),
            TextButton(
              onPressed: state.busy
                  ? null
                  : () => bloc.add(const GalleryDuplicatesEvent.skip()),
              child: Text(l.gallery_duplicate_review_again),
            ),
          ],
          if (state.busy) const LinearProgressIndicator(),
          if (state.failed)
            TextButton(
              onPressed: state.busy || state.polling
                  ? null
                  : () => bloc.add(const GalleryDuplicatesEvent.load()),
              child: Text(l.retry_button),
            ),
        ],
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
    super.key,
    required this.session,
    required this.state,
    required this.group,
    required this.member,
  });
  final GallerySession session;
  final GalleryDuplicatesState state;
  final GalleryDuplicateGroup group;
  final GalleryDuplicateMember member;

  @override
  Widget build(BuildContext context) {
    final l = context.localizations;
    final bloc = context.read<GalleryDuplicatesBloc>();
    final item = state.item(member);
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
        CheckboxListTile(
          contentPadding: EdgeInsets.zero,
          controlAffinity: ListTileControlAffinity.leading,
          value: selected,
          onChanged: enabled ? choose : null,
          title: Text(member.name),
          subtitle: Text(member.path),
        ),
        GalleryComparisonDetails(
          key: ValueKey((member.mediaId, member.sourceRevision)),
          member: member,
          item: item,
          repository: session.management,
          onRevisionMismatch: () =>
              bloc.add(GalleryDuplicatesEvent.invalidate(member)),
        ),
      ],
    );
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final image = SizedBox(
              height: 220,
              width: constraints.maxWidth >= 600 ? 320 : constraints.maxWidth,
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
                        onRevisionMismatch: () =>
                            bloc.add(GalleryDuplicatesEvent.invalidate(member)),
                        errorBuilder: (context, retry) => Center(
                          child: TextButton(
                            onPressed: retry,
                            child: Text(l.gallery_retry_image),
                          ),
                        ),
                      ),
                    ),
            );
            return constraints.maxWidth >= 600
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
          },
        ),
      ),
    );
  }
}
