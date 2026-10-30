import 'package:flutter/material.dart';

import 'gallery_file_size.dart';

/// A distinct, readable file in a bounded trash/delete confirmation list.
class GalleryConfirmationFile extends StatelessWidget {
  const GalleryConfirmationFile({
    super.key,
    required this.number,
    required this.name,
    this.sizeBytes,
  });

  final int number;
  final String name;
  final int? sizeBytes;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerHighest,
          border: Border.all(color: theme.colorScheme.outlineVariant),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 28,
              child: Text(
                MaterialLocalizations.of(context).formatDecimal(number),
                style: theme.textTheme.labelLarge?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(name, style: theme.textTheme.titleSmall),
                  if (sizeBytes != null) ...[
                    const SizedBox(height: 4),
                    GalleryFileSize(bytes: sizeBytes!),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
