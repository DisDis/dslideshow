import 'package:dslideshow_common/frame_discovery.dart';

FrameDiscoveryProvider createProvider() => const UnsupportedFrameDiscoveryProvider();

class UnsupportedFrameDiscoveryProvider implements FrameDiscoveryProvider {
  const UnsupportedFrameDiscoveryProvider();

  @override
  FrameDiscoverySession createSession() => throw UnsupportedError('Native discovery unavailable');
}
