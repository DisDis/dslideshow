import 'package:dslideshow_common/gallery.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/gallery_item.dart';
import '../../../theme/presentation/extensions/build_context_ext.dart';
import '../../../../src/gallery/gallery_management_repository.dart';
import '../bloc/gallery_comparison_metadata_bloc.dart';
import '../bloc/gallery_group_comparison_bloc.dart';
import 'gallery_actions.dart';
import 'gallery_file_size.dart';
import 'gallery_recommendation_badge.dart';

/// Only mounted cards create a metadata owner. Changing the keyed source closes
/// the old Bloc and cancels its read before the next visible source is accepted.
class GalleryComparisonDetails extends StatelessWidget {
  const GalleryComparisonDetails({
    super.key,
    required this.member,
    required this.item,
    required this.repository,
    required this.onRevisionMismatch,
    this.comparison,
    this.onMetadata,
  });
  final GalleryDuplicateMember member;
  final GalleryItem? item;
  final GalleryManagementRepository repository;
  final VoidCallback onRevisionMismatch;
  final GalleryGroupComparisonState? comparison;
  final ValueChanged<GalleryMetadata>? onMetadata;

  @override
  Widget build(BuildContext context) => BlocProvider(
    key: ValueKey((repository, item?.scope, item?.selectionIdentity)),
    create: (_) => GalleryComparisonMetadataBloc(repository: repository, item: item),
    child: BlocListener<GalleryComparisonMetadataBloc, GalleryComparisonMetadataState>(
      listenWhen: (previous, current) => previous.metadata != current.metadata,
      listener: (_, state) {
        if (state.metadata case final data?) onMetadata?.call(data);
      },
      child: BlocConsumer<GalleryComparisonMetadataBloc, GalleryComparisonMetadataState>(
        listenWhen: (previous, current) => previous.revisionMismatch != current.revisionMismatch,
        listener: (_, state) => onRevisionMismatch(),
        builder: (context, state) {
          final l = context.localizations, data = state.metadata;
          final theme = Theme.of(context);
          final resolution =
              GalleryImageResolution.read(data?.width, data?.height) ??
              GalleryImageResolution.read(member.width, member.height);
          final rank = comparison?.rank(member.mediaId, resolution) ?? GalleryResolutionRank.unknown;
          final dark = theme.brightness == Brightness.dark;
          final color = switch (rank) {
            GalleryResolutionRank.recommended => galleryRecommendationColor(context),
            GalleryResolutionRank.minimum => theme.colorScheme.error,
            GalleryResolutionRank.other => dark ? Colors.amber.shade300 : const Color(0xff795800),
            _ => theme.colorScheme.onSurface,
          };
          final reason = comparison == null ? null : galleryRecommendationReasonText(context, comparison!.reason);
          final rankLabel = switch (rank) {
            GalleryResolutionRank.recommended => '${l.gallery_recommend_keep}. $reason',
            GalleryResolutionRank.minimum => l.gallery_resolution_minimum,
            GalleryResolutionRank.other =>
              comparison?.exact == true || (resolution != null && resolution.pixels == comparison?.maxPixels)
                  ? l.gallery_resolution_same
                  : l.gallery_resolution_intermediate,
            GalleryResolutionRank.unknown => l.gallery_resolution_unknown,
          };
          final bytes = data?.sizeBytes ?? member.sizeBytes;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                spacing: 24,
                runSpacing: 12,
                children: [
                  _ComparisonMetric(
                    label: l.gallery_resolution,
                    child: Tooltip(
                      message: rankLabel,
                      child: Text(
                        '${resolution?.width ?? '—'} × ${resolution?.height ?? '—'}',
                        style: theme.textTheme.titleMedium?.copyWith(color: color, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  _ComparisonMetric(
                    label: l.gallery_file_size,
                    child: DefaultTextStyle.merge(
                      style: theme.textTheme.titleMedium,
                      child: GalleryFileSize(bytes: bytes),
                    ),
                  ),
                ],
              ),
              if (comparison?.smallestFile(bytes) ?? false)
                Text(l.gallery_file_smallest, style: theme.textTheme.bodySmall),
              if (data?.dateTaken != null)
                Text('${l.gallery_date_taken}: ${data!.dateTaken}')
              else if (data?.fileModified != null)
                Text('${l.gallery_file_modified}: ${data!.fileModified!.toLocal()}'),
              if (state.loading)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Row(
                    children: [
                      const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2)),
                      const SizedBox(width: 8),
                      Expanded(child: Text(l.gallery_details_loading)),
                    ],
                  ),
                ),
              if (state.failed && state.item != null) ...[
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    l.gallery_metadata_failed,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.error),
                  ),
                ),
                Text(switch (state.error) {
                  GalleryErrorCode.timeout => l.gallery_metadata_timeout,
                  GalleryErrorCode.processingFailed => l.gallery_metadata_read_failed,
                  _ => galleryErrorText(context, state.error),
                }),
                TextButton.icon(
                  onPressed: () =>
                      context.read<GalleryComparisonMetadataBloc>().add(const GalleryComparisonMetadataEvent.load()),
                  icon: const Icon(Icons.refresh),
                  label: Text(l.gallery_retry_details),
                ),
              ],
            ],
          );
        },
      ),
    ),
  );
}

class _ComparisonMetric extends StatelessWidget {
  const _ComparisonMetric({required this.label, required this.child});
  final String label;
  final Widget child;
  @override
  Widget build(BuildContext context) => Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
      ),
      const SizedBox(height: 4),
      child,
    ],
  );
}
