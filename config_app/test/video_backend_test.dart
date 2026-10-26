import 'package:config_app/src/video_backend.dart';
import 'package:config_app/src/video_playback_support.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logging/logging.dart';

void main() {
  test(
    'Linux support becomes available only after successful registration',
    () {
      var registrations = 0;
      final backend = ConfigAppVideoBackend(
        registerLinuxBackend: () => registrations++,
      );
      expect(backend.linuxAvailable, isFalse);
      expect(
        configAppVideoSupportedOn(isWeb: false, platform: TargetPlatform.linux),
        isFalse,
      );
      backend.initialize(isWeb: false, platform: TargetPlatform.linux);
      expect(backend.linuxAvailable, isTrue);
      expect(
        configAppVideoSupportedOn(
          isWeb: false,
          platform: TargetPlatform.linux,
          linuxBackendAvailable: backend.linuxAvailable,
        ),
        isTrue,
      );
      backend.initialize(isWeb: false, platform: TargetPlatform.linux);
      expect(registrations, 1);
    },
  );

  test('native loading failure keeps panel usable and video unavailable', () {
    var registrations = 0;
    final records = <LogRecord>[];
    final subscription = Logger('ConfigAppVideoBackend').onRecord
        .listen(records.add);
    addTearDown(subscription.cancel);
    final backend = ConfigAppVideoBackend(
      registerLinuxBackend: () {
        registrations++;
        throw StateError('native library missing at /private/path');
      },
    );
    expect(
      () => backend.initialize(isWeb: false, platform: TargetPlatform.linux),
      returnsNormally,
    );
    expect(backend.linuxAvailable, isFalse);
    expect(registrations, 1);
    expect(
      records.single.message,
      'Linux video backend unavailable: StateError',
    );
    expect(records.single.error, isNull);
    expect(records.single.stackTrace, isNull);
  });

  test('registration preserves existing web and other platform backends', () {
    var registrations = 0;
    final backend = ConfigAppVideoBackend(
      registerLinuxBackend: () => registrations++,
    );
    backend.initialize(isWeb: true, platform: TargetPlatform.linux);
    for (final platform in TargetPlatform.values) {
      if (platform != TargetPlatform.linux) {
        backend.initialize(isWeb: false, platform: platform);
      }
    }
    expect(registrations, 0);
    expect(backend.linuxAvailable, isFalse);
    expect(
      configAppVideoSupportedOn(isWeb: true, platform: TargetPlatform.linux),
      isTrue,
    );
    expect(
      configAppVideoSupportedOn(
        isWeb: false,
        platform: TargetPlatform.windows,
        linuxBackendAvailable: true,
      ),
      isFalse,
    );
  });
}
