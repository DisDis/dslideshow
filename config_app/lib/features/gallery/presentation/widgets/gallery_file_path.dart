import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../theme/presentation/extensions/build_context_ext.dart';
import '../bloc/gallery_file_path_bloc.dart';

export '../bloc/gallery_file_path_bloc.dart' show GalleryFilePathStyle;

class GalleryFilePath extends StatelessWidget {
  const GalleryFilePath({
    super.key,
    required this.relativePath,
    required this.name,
    required this.style,
    this.showName = true,
  });

  final String? relativePath;
  final String name;
  final GalleryFilePathStyle style;
  final bool showName;

  @override
  Widget build(BuildContext context) => BlocProvider(
    key: ValueKey((relativePath, name, style)),
    create: (_) => GalleryFilePathBloc(relativePath: relativePath, name: name),
    child: BlocBuilder<GalleryFilePathBloc, GalleryFilePathState>(
      builder: (context, state) {
        final l = context.localizations;
        final theme = Theme.of(context);
        final compact = style == GalleryFilePathStyle.nearestFolder;
        final folders = state.folders;
        void toggle() => context.read<GalleryFilePathBloc>().add(
          GalleryFilePathEvent.toggle,
        );
        final route = LayoutBuilder(
          builder: (context, constraints) => Wrap(
            spacing: 6,
            runSpacing: 6,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Tooltip(message: l.gallery_library_root, child: const Text('/')),
              for (final folder in folders) ...[
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: constraints.maxWidth),
                  child: Tooltip(
                    message: folder,
                    child: Container(
                      padding: compact
                          ? EdgeInsets.zero
                          : const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                      decoration: compact
                          ? null
                          : BoxDecoration(
                              color: theme.colorScheme.surfaceContainerHighest,
                              borderRadius: BorderRadius.circular(6),
                            ),
                      child: Text(
                        folder,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: compact
                            ? theme.textTheme.bodySmall
                            : theme.textTheme.bodyMedium,
                      ),
                    ),
                  ),
                ),
                const Text('/'),
              ],
            ],
          ),
        );
        final filename = SelectableText(
          state.name,
          style: theme.textTheme.titleMedium,
        );
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (compact && showName) filename,
            if (state.displayPath != null) ...[
              if (compact) ...[
                const SizedBox(height: 8),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.folder_open_outlined,
                      size: 18,
                      color: theme.colorScheme.primary,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        folders.lastOrNull ?? '/',
                        style: theme.textTheme.titleSmall,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
              ] else ...[
                Text(
                  l.gallery_file_location,
                  style: theme.textTheme.labelMedium,
                ),
                const SizedBox(height: 8),
              ],
              if (!compact || state.expanded) route,
            ],
            if (!compact && showName) ...[const SizedBox(height: 12), filename],
            if (state.displayPath != null) ...[
              TextButton.icon(
                onPressed: toggle,
                icon: Icon(
                  state.expanded ? Icons.expand_less : Icons.expand_more,
                ),
                label: Text(
                  state.expanded
                      ? l.gallery_hide_full_path
                      : l.gallery_show_full_path,
                ),
              ),
              if (state.expanded)
                SelectableText(
                  state.displayPath!,
                  style: theme.textTheme.bodyMedium,
                ),
            ],
          ],
        );
      },
    ),
  );
}
