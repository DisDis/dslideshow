import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_common/version.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/bloc/status/slideshow_status_bloc.dart';
import 'package:dslideshow_flutter/src/route_bloc.dart';
import 'package:flutter/widgets.dart';

typedef FrameDisplayInfoReader = FrameDisplayInfo? Function();

/// Reads the running frame, rather than the browser that opened its settings.
class FrameFrontendController {
  final SlideshowStatusBloc statusBloc;
  final RouteBloc routeBloc;
  final FrameDisplayInfoReader displayInfo;

  FrameFrontendController({required this.statusBloc, required this.routeBloc, required this.displayInfo});

  void updateSystemInfo(SystemInfo info) {
    final status = statusBloc;
    if (!status.isClosed && status.state.hasInternet != info.networkInfo.hasInternet) {
      status.add(SlideshowInternetEvent(info.networkInfo.hasInternet));
    }
  }

  FrameFrontendState readState() {
    final status = statusBloc;
    final route = routeBloc;
    if (status.isClosed || route.isClosed) {
      throw StateError('Frontend is shutting down');
    }
    return FrameFrontendState(
      isPaused: status.state.isPaused,
      isMenu: status.state.isMenu,
      page: switch (route.state.current) {
        RoutePage.welcome => FramePage.welcome,
        RoutePage.slideshow => FramePage.slideshow,
        RoutePage.config => FramePage.config,
        RoutePage.ota => FramePage.ota,
      },
      frontendVersion: ApplicationInfo.frontendVersion,
      display: displayInfo(),
    );
  }

  Future<void> setControl(FrameControl control, bool enabled) async {
    final status = statusBloc;
    final route = routeBloc;
    if (status.isClosed || route.isClosed) {
      throw StateError('Frontend is shutting down');
    }
    if (control != FrameControl.screen && route.state.current != RoutePage.slideshow) {
      throw StateError('This control requires the slideshow page');
    }
    final action = switch (control) {
      FrameControl.pause => SlideshowAction.pause,
      FrameControl.menu => SlideshowAction.showMenu,
      FrameControl.screen => SlideshowAction.toggleScreen,
    };
    await status.executeActionAndWait(action, control == FrameControl.screen ? !enabled : enabled);
  }

  static FrameDisplayInfo? readDisplayInfo() {
    final dispatcher = WidgetsBinding.instance.platformDispatcher;
    final view = dispatcher.implicitView ?? dispatcher.views.firstOrNull;
    if (view == null || view.devicePixelRatio <= 0) return null;
    return FrameDisplayInfo(
      physicalWidth: view.physicalSize.width,
      physicalHeight: view.physicalSize.height,
      logicalWidth: view.physicalSize.width / view.devicePixelRatio,
      logicalHeight: view.physicalSize.height / view.devicePixelRatio,
      pixelRatio: view.devicePixelRatio,
    );
  }
}
