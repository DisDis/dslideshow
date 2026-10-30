import 'package:flutter/material.dart';

import '../../../theme/presentation/extensions/build_context_ext.dart';
import '../bloc/gallery_group_comparison_bloc.dart';

Color galleryRecommendationColor(BuildContext context) =>
    Theme.of(context).brightness == Brightness.dark
    ? Colors.green.shade300
    : Colors.green.shade800;

String galleryRecommendationReasonText(
  BuildContext context,
  GalleryRecommendationReason reason,
) {
  final l = context.localizations;
  return switch (reason) {
    GalleryRecommendationReason.firstExactCopy =>
      l.gallery_recommend_first_copy,
    GalleryRecommendationReason.firstTied => l.gallery_recommend_first_tied,
    GalleryRecommendationReason.highestKnownResolution =>
      l.gallery_recommend_known_resolution,
    GalleryRecommendationReason.firstUnknown =>
      l.gallery_recommend_first_unknown,
    GalleryRecommendationReason.highestResolution =>
      l.gallery_recommend_resolution,
  };
}

class GalleryRecommendationBadge extends StatelessWidget {
  const GalleryRecommendationBadge({super.key, required this.reason});
  final GalleryRecommendationReason reason;

  @override
  Widget build(BuildContext context) {
    final color = galleryRecommendationColor(context);
    return Tooltip(
      message: galleryRecommendationReasonText(context, reason),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: color.withValues(alpha: .12),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.star_rounded, size: 20, color: color),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                context.localizations.gallery_recommend_keep,
                style: Theme.of(context).textTheme.titleSmall
                    ?.copyWith(color: color),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
