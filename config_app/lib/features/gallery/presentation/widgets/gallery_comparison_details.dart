import 'package:dslideshow_common/gallery.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/gallery_item.dart';
import '../../../theme/presentation/extensions/build_context_ext.dart';
import '../../../../src/gallery/gallery_management_repository.dart';
import '../bloc/gallery_comparison_metadata_bloc.dart';
import 'gallery_actions.dart';

/// Only mounted cards create a metadata owner. Changing the keyed source closes
/// the old Bloc and cancels its read before the next visible source is accepted.
class GalleryComparisonDetails extends StatelessWidget {
  const GalleryComparisonDetails({
    super.key,
    required this.member,
    required this.item,
    required this.repository,
    required this.onRevisionMismatch,
  });
  final GalleryDuplicateMember member;
  final GalleryItem? item;
  final GalleryManagementRepository repository;
  final VoidCallback onRevisionMismatch;

  @override
  Widget build(BuildContext context) => BlocProvider(
    key: ValueKey((repository, item?.scope, item?.selectionIdentity)),
    create: (_) =>
        GalleryComparisonMetadataBloc(repository: repository, item: item),
    child: BlocConsumer<GalleryComparisonMetadataBloc, GalleryComparisonMetadataState>(
      listenWhen: (previous, current) =>
          previous.revisionMismatch != current.revisionMismatch,
      listener: (_, state) => onRevisionMismatch(),
      builder: (context, state) {
        final l = context.localizations, data = state.metadata;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${data?.width ?? member.width ?? '—'} × ${data?.height ?? member.height ?? '—'} · ${data?.sizeBytes ?? member.sizeBytes} B',
            ),
            if (data?.dateTaken != null)
              Text('${l.gallery_date_taken}: ${data!.dateTaken}')
            else if (data?.fileModified != null)
              Text(
                '${l.gallery_file_modified}: ${data!.fileModified!.toLocal()}',
              ),
            if (state.loading)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
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
                  style: Theme.of(context).textTheme.bodyMedium
                      ?.copyWith(color: Theme.of(context).colorScheme.error),
                ),
              ),
              Text(switch (state.error) {
                GalleryErrorCode.timeout => l.gallery_metadata_timeout,
                GalleryErrorCode.processingFailed =>
                  l.gallery_metadata_read_failed,
                _ => galleryErrorText(context, state.error),
              }),
              TextButton.icon(
                onPressed: () => context
                    .read<GalleryComparisonMetadataBloc>()
                    .add(const GalleryComparisonMetadataEvent.load()),
                icon: const Icon(Icons.refresh),
                label: Text(l.gallery_retry_details),
              ),
            ],
          ],
        );
      },
    ),
  );
}
