import 'package:dslideshow_common/gallery.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/gallery_item.dart';
import '../../../theme/presentation/extensions/build_context_ext.dart';
import '../../../../src/gallery/gallery_date_time.dart';
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
          final rank = comparison?.rank(member.mediaId, resolution) ?? GalleryMetricRank.unknown;
          final dark = theme.brightness == Brightness.dark;
          Color color(GalleryMetricRank rank) => switch (rank) {
            GalleryMetricRank.best => galleryRecommendationColor(context),
            GalleryMetricRank.worst => theme.colorScheme.error,
            GalleryMetricRank.intermediate => dark ? Colors.amber.shade300 : const Color(0xff795800),
            GalleryMetricRank.unknown => theme.colorScheme.onSurface,
          };
          String rankText(GalleryMetricRank rank) => switch (rank) {
            GalleryMetricRank.best => l.gallery_metric_best,
            GalleryMetricRank.worst => l.gallery_metric_worst,
            GalleryMetricRank.intermediate => l.gallery_metric_intermediate,
            GalleryMetricRank.unknown => l.gallery_metric_unknown,
          };
          final bytes = data?.sizeBytes ?? member.sizeBytes;
          final taken = GalleryDateTime.parseDateTaken(data?.dateTaken);
          final quality = data?.jpeg?.comparableQuality;
          final qualityRank = comparison?.jpegQuality.rank(member.mediaId, quality) ?? GalleryMetricRank.unknown;
          final sizeRank =
              comparison?.jpegSize.rank(member.mediaId, data?.jpeg == null ? null : bytes) ?? GalleryMetricRank.unknown;
          Widget date(GalleryComparisonDateSource source, String label, DateTime? value) {
            final rank = comparison?.dateRank(member.mediaId, source, value) ?? GalleryMetricRank.unknown;
            return Tooltip(
              message: rankText(rank),
              child: Text(
                '$label: ${GalleryDateTime.format(value, l.localeName)}',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: color(rank),
                  fontWeight: rank == GalleryMetricRank.best ? FontWeight.w600 : null,
                ),
              ),
            );
          }

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
                      message: rankText(rank),
                      child: Text(
                        '${resolution?.width ?? '—'} × ${resolution?.height ?? '—'}',
                        style: theme.textTheme.titleMedium?.copyWith(color: color(rank), fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  _ComparisonMetric(
                    label: l.gallery_file_size,
                    child: DefaultTextStyle.merge(
                      style: theme.textTheme.titleMedium?.copyWith(color: color(sizeRank)),
                      child: Semantics(
                        label: rankText(sizeRank),
                        child: GalleryFileSize(bytes: bytes),
                      ),
                    ),
                  ),
                  if (data?.jpeg != null)
                    _ComparisonMetric(
                      label: l.gallery_jpeg_quality,
                      child: Tooltip(
                        message: '${rankText(qualityRank)}. ${l.gallery_jpeg_quality_hint}',
                        child: Text(
                          quality == null ? l.gallery_jpeg_quality_unknown : l.gallery_jpeg_quality_value(quality),
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: color(qualityRank),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              date(GalleryComparisonDateSource.dateTaken, l.gallery_date_taken, taken),
              date(GalleryComparisonDateSource.fileModified, l.gallery_file_modified, data?.fileModified),
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
