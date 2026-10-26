import 'package:config_app/features/theme/presentation/extensions/build_context_ext.dart';
import 'package:flutter/material.dart';

class VideoUnavailable extends StatelessWidget {
  const VideoUnavailable({super.key, this.title});

  final String? title;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ColoredBox(
      color: theme.colorScheme.surfaceContainerHighest,
      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.videocam_off_outlined,
                color: theme.colorScheme.onSurfaceVariant,
              ),
              const SizedBox(height: 8),
              if (title != null) ...[
                Text(
                  title!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
              ],
              Text(
                context.localizations.video_platform_unavailable,
                style: theme.textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
