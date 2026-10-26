import 'package:flutter/foundation.dart';

import 'video_backend.dart';

/// Backends registered by this application. Flutter-pi is registered only by
/// the photoframe executable, and is not a Linux desktop video backend.
bool get supportsConfigAppVideo => configAppVideoSupportedOn(
  isWeb: kIsWeb,
  platform: defaultTargetPlatform,
  linuxBackendAvailable: linuxVideoBackendAvailable,
);

@visibleForTesting
bool configAppVideoSupportedOn({
  required bool isWeb,
  required TargetPlatform platform,
  bool linuxBackendAvailable = false,
}) =>
    isWeb ||
    switch (platform) {
      TargetPlatform.android ||
      TargetPlatform.iOS ||
      TargetPlatform.macOS => true,
      TargetPlatform.linux => linuxBackendAvailable,
      TargetPlatform.windows || TargetPlatform.fuchsia => false,
    };
