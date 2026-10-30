import 'dart:io';

import 'package:dslideshow_backend/discovery.dart';
import 'package:dslideshow_common/frame_discovery.dart';

import 'frame_discovery_provider_stub.dart';
import 'frame_discovery_provider_android.dart';

FrameDiscoveryProvider createProvider() {
  if (Platform.isLinux) return const AvahiFrameDiscoveryProvider();
  if (Platform.isAndroid) return const AndroidFrameDiscoveryProvider();
  return const UnsupportedFrameDiscoveryProvider();
}
