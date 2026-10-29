import 'package:dslideshow_common/gallery.dart';
import 'package:flutter/material.dart';

import '../../domain/gallery_item.dart';
import '../../../theme/presentation/extensions/build_context_ext.dart';

class MetadataPanel extends StatelessWidget {
  const MetadataPanel({
    super.key,
    required this.item,
    this.metadata,
    this.trashEntry,
    this.loading = false,
    this.failed = false,
    this.onRetry,
  });
  final GalleryItem item;
  final GalleryMetadata? metadata;
  final GalleryTrashEntry? trashEntry;
  final bool loading;
  final bool failed;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final l = context.localizations;
    final theme = Theme.of(context);
    final data = metadata;
    final trash = trashEntry;
    final fields = <(String, String?)>[
      (
        l.gallery_file_size,
        (data?.sizeBytes ?? trash?.sizeBytes) == null
            ? null
            : '${data?.sizeBytes ?? trash?.sizeBytes} B · ${((data?.sizeBytes ?? trash!.sizeBytes) / 1048576).toStringAsFixed(2)} MiB',
      ),
      (
        l.gallery_resolution,
        data?.width != null && data?.height != null
            ? '${data!.width} × ${data.height}'
            : null,
      ),
      (l.gallery_date_taken, data?.dateTaken),
      (l.gallery_file_modified, data?.fileModified?.toLocal().toString()),
      (l.gallery_format, data?.format),
      (l.gallery_camera, data?.camera),
      (l.gallery_lens, data?.lens),
      (l.gallery_iso, data?.iso?.toString()),
      (l.gallery_exposure, data?.exposure),
      (l.gallery_aperture, data?.aperture?.toString()),
      (l.gallery_focal_length, data?.focalLength?.toString()),
      (l.gallery_orientation, data?.orientation?.toString()),
      (l.gallery_duration, data?.durationSeconds?.toString()),
      (l.gallery_codec, data?.codec),
      (l.gallery_color_profile, data?.colorProfile),
      (l.gallery_bit_depth, data?.bitDepth?.toString()),
      (
        l.gallery_alpha,
        data?.hasAlpha == null
            ? null
            : data!.hasAlpha!
            ? l.gallery_yes
            : l.gallery_no,
      ),
      (l.gallery_trash_file_changed, trash?.trashedAt.toLocal().toString()),
    ];
    return Card(
      key: const ValueKey('viewer-metadata-card'),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
            child: Row(
              children: [
                Icon(Icons.info_outline, color: theme.colorScheme.primary),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(l.media_info, style: theme.textTheme.titleMedium),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          Flexible(
            fit: FlexFit.loose,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SelectableText(
                    data?.name ?? trash?.name ?? item.title,
                    style: theme.textTheme.titleSmall,
                  ),
                  if ((data?.path ?? trash?.originalPath)
                      case final String path)
                    if (path != (data?.name ?? trash?.name ?? item.title)) ...[
                      const SizedBox(height: 4),
                      SelectableText(
                        path,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  if (loading)
                    const Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: LinearProgressIndicator(),
                    ),
                  if (failed)
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.error_outline,
                            color: theme.colorScheme.error,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              l.gallery_metadata_failed,
                              style: theme.textTheme.bodyMedium,
                            ),
                          ),
                          TextButton(
                            onPressed: onRetry,
                            child: Text(l.retry_button),
                          ),
                        ],
                      ),
                    ),
                  for (final (label, value) in fields)
                    if (value != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                label,
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: theme.colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: SelectableText(
                                value,
                                style: theme.textTheme.bodyMedium,
                              ),
                            ),
                          ],
                        ),
                      ),
                  if (data?.latitude != null && data?.longitude != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: ExpansionTile(
                        tilePadding: EdgeInsets.zero,
                        title: Text(l.gallery_location),
                        children: [
                          SelectableText(
                            '${data!.latitude}, ${data.longitude}',
                          ),
                        ],
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
}
