import 'dart:io';

import 'package:dslideshow_backend/discovery.dart';
import 'package:dslideshow_common/frame_discovery.dart';

import 'frame_discovery_provider_stub.dart';

FrameDiscoveryProvider createProvider() =>
    Platform.isLinux ? const AvahiFrameDiscoveryProvider() : const UnsupportedFrameDiscoveryProvider();
