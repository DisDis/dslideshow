import 'package:dslideshow_backend/src/command/frame_commands.dart';
import 'package:dslideshow_common/rpc.dart';
import 'package:dslideshow_common/version.dart';
import 'package:logging/logging.dart';

import 'application_state_service.dart';
import 'screen_service.dart';

/// Collects frame snapshots within the existing backend isolate.
///
/// Uses the reliable isolate RPC directly and owns no resources or cached state.
/// The caller owns the transport, supplied services and request lifetime.
class FrameStateReader {
  static final _log = Logger('FrameStateReader');

  FrameStateReader({
    required RemoteService frontendService,
    required ScreenService screenService,
    required ApplicationStateService applicationStateService,
  }) : _frontendService = frontendService,
       _screenService = screenService,
       _applicationStateService = applicationStateService;

  final RemoteService _frontendService;
  final ScreenService _screenService;
  final ApplicationStateService _applicationStateService;

  Future<FrameState> read() async {
    final frontend = await _readFrontendState();
    final presence = _applicationStateService.observedPresence;
    return FrameState(
      sampledAt: DateTime.now().toUtc(),
      presence: presence == null
          ? FramePresence.unknown
          : presence
          ? FramePresence.present
          : FramePresence.absent,
      presenceObservedAt: _applicationStateService.presenceObservedAt,
      isScreenLocked: _screenService.isScreenOffLock,
      isScreenOn: _screenService.confirmedPower,
      screenPhase: switch (_screenService.phase) {
        ScreenPhase.on => FrameScreenPhase.on,
        ScreenPhase.waitingOff => FrameScreenPhase.waitingOff,
        ScreenPhase.fadingOut => FrameScreenPhase.fadingOut,
        ScreenPhase.poweringOff => FrameScreenPhase.poweringOff,
        ScreenPhase.off => FrameScreenPhase.off,
        ScreenPhase.wakingUp => FrameScreenPhase.wakingUp,
        ScreenPhase.fadingIn => FrameScreenPhase.fadingIn,
        ScreenPhase.failed => FrameScreenPhase.failed,
        ScreenPhase.disposed => FrameScreenPhase.unknown,
      },
      backendVersion: ApplicationInfo.backendVersion,
      frontend: frontend,
    );
  }

  Future<FrameFrontendState?> _readFrontendState() async {
    try {
      final result = await _frontendService.send(GetFrameFrontendStateCommand(id: RpcCommand.generateId()));
      return result is GetFrameFrontendStateResult ? result.state : null;
    } catch (error, stack) {
      _log.fine('Frontend state unavailable type=${error.runtimeType}', error, stack);
      return null;
    }
  }
}
