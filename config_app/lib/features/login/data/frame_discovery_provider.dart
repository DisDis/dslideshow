import 'package:dslideshow_common/frame_discovery.dart';

import 'frame_discovery_provider_stub.dart' if (dart.library.io) 'frame_discovery_provider_native.dart' as platform;

FrameDiscoveryProvider createFrameDiscoveryProvider() => platform.createProvider();
