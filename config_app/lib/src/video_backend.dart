import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';

import 'video_backend_stub.dart' if (dart.library.io) 'video_backend_native.dart' as platform_backend;

final _videoBackend = ConfigAppVideoBackend();

bool get linuxVideoBackendAvailable => _videoBackend.linuxAvailable;

/// Call after the Flutter binding is initialized, before opening any players.
void initializeConfigAppVideoBackend() => _videoBackend.initialize();

/// Owns registration state independently from player widgets. Registration
/// failure leaves the rest of the settings interface usable.
class ConfigAppVideoBackend {
  ConfigAppVideoBackend({VoidCallback? registerLinuxBackend})
    : _registerLinuxBackend = registerLinuxBackend ?? platform_backend.registerLinuxVideoBackend;

  static final _log = Logger('ConfigAppVideoBackend');
  final VoidCallback _registerLinuxBackend;
  bool _linuxAvailable = false;

  bool get linuxAvailable => _linuxAvailable;

  void initialize({bool isWeb = kIsWeb, TargetPlatform? platform}) {
    if (isWeb || (platform ?? defaultTargetPlatform) != TargetPlatform.linux || _linuxAvailable) {
      return;
    }
    try {
      _registerLinuxBackend();
      _linuxAvailable = true;
    } catch (error, stack) {
      // Native loading failures can include paths and environment details.
      _log.warning('Linux video backend unavailable: ${error.runtimeType}', error, stack);
    }
  }
}
