import 'package:flutter/material.dart';

import '../../../theme/presentation/extensions/build_context_ext.dart';
import '../bloc/gallery_group_comparison_bloc.dart';

Color galleryRecommendationColor(BuildContext context) =>
    Theme.of(context).brightness == Brightness.dark ? Colors.green.shade300 : Colors.green.shade800;

String galleryRecommendationReasonText(BuildContext context, GalleryRecommendationReason reason) {
  final l = context.localizations;
  return switch (reason) {
    GalleryRecommendationReason.hasDateTaken => l.gallery_recommend_has_taken,
    GalleryRecommendationReason.firstTied => l.gallery_recommend_first_tied,
    GalleryRecommendationReason.firstUnknown => l.gallery_recommend_first_unknown,
    GalleryRecommendationReason.highestResolution => l.gallery_recommend_resolution,
    GalleryRecommendationReason.earliestDateTaken => l.gallery_recommend_earliest_taken,
    GalleryRecommendationReason.earliestFileModified => l.gallery_recommend_earliest_modified,
    GalleryRecommendationReason.highestJpegQuality => l.gallery_recommend_jpeg_quality,
    GalleryRecommendationReason.largestJpegFile => l.gallery_recommend_jpeg_size,
  };
}

class GalleryRecommendationBadge extends StatelessWidget {
  const GalleryRecommendationBadge({super.key, required this.reason, this.provisional = false});
  final GalleryRecommendationReason reason;
  final bool provisional;

  @override
  Widget build(BuildContext context) {
    final color = galleryRecommendationColor(context);
    return Tooltip(
      message: galleryRecommendationReasonText(context, reason),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(color: color.withValues(alpha: .12), borderRadius: BorderRadius.circular(8)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.star_rounded, size: 20, color: color),
            const SizedBox(width: 8),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    context.localizations.gallery_recommend_keep,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(color: color),
                  ),
                  if (provisional)
                    Text(
                      context.localizations.gallery_recommend_provisional,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(color: color),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
