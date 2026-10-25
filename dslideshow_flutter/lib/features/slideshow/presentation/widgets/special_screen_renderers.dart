import 'package:dslideshow_backend/config.dart';
import 'package:flutter/widgets.dart';

import '../sessions/cameras_screen_session.dart';
import '../sessions/clock_screen_session.dart';
import '../sessions/special_screen_session.dart';
import 'cameras_screen_widget.dart';
import 'clock_screen_widget.dart';

typedef SpecialSessionFactory = SpecialScreenSession Function(
  SpecialScreenConfig config,
  int cameraIndex,
);
typedef SpecialScreenBuilder = Widget Function(SpecialScreenSession session);

class SpecialScreenRenderer {
  final SpecialSessionFactory createSession;
  final SpecialScreenBuilder build;
  const SpecialScreenRenderer(this.createSession, this.build);
}

/// Renderer registration is independent of scheduling and media storage.
class SpecialScreenRenderers {
  static final definitions = <SpecialScreenType, SpecialScreenRenderer>{
    SpecialScreenType.clock: SpecialScreenRenderer(
      (c, _) => ClockScreenSession(c),
      (s) => ClockScreenWidget(session: s as ClockScreenSession),
    ),
    SpecialScreenType.cameras: SpecialScreenRenderer(
      (c, i) => CamerasScreenSession(c, cameraIndex: i),
      (s) => CamerasScreenWidget(session: s as CamerasScreenSession),
    ),
  };
}
