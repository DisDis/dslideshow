import 'package:config_app/features/uikit/presentation/widgets/photo_frame_config_logo.dart';
import 'package:flutter/material.dart';

// ignore: prefer-match-file-name
class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Startup navigation belongs to the router, which can also read a status
    // emitted before this fallback page was mounted.
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: PhotoFrameConfigLogo(
          size: 150,
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
    );
  }
}
