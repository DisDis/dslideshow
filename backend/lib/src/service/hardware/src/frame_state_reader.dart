import 'dart:async';

import 'package:dslideshow_backend/src/command/frame_commands.dart';
import 'package:dslideshow_common/rpc.dart';
import 'package:dslideshow_common/version.dart';
import 'package:logging/logging.dart';

import 'application_state_service.dart';
import 'screen_service.dart';

/// Applies the owner's wait policy to an existing frontend-state request.
typedef FrontendStateWait = Future<FrameFrontendState?> Function(
  Future<FrameFrontendState?> request,
);

/// Collects frame snapshots within the existing backend isolate.
///
/// The owner supplies the frontend wait and lifetime checks shared with control
/// commands. The reader owns only coalescing of frontend-state requests; it does
/// not own the transport, services or their disposal.
class FrameStateReader {
  FrameStateReader({
    required RemoteService frontendService,
    required ScreenService screenService,
    required ApplicationStateService applicationStateService,
    required FrontendStateWait waitForFrontend,
    required void Function() ensureActive,
    required Logger logger,
  }) : _frontendService = frontendService,
       _screenService = screenService,
       _applicationStateService = applicationStateService,
       _waitForFrontend = waitForFrontend,
       _ensureActive = ensureActive,
       _log = logger;

  final RemoteService _frontendService;
  final ScreenService _screenService;
  final ApplicationStateService _applicationStateService;
  final FrontendStateWait _waitForFrontend;
  final void Function() _ensureActive;
  final Logger _log;
  Future<FrameFrontendState?>? _frontendStateRequest;

  Future<FrameState> read() async {
    final frontend = await _readFrontendState();
    _ensureActive();
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

  /// Read again after a control acknowledgement instead of reusing an older poll.
  /// Existing consumers still settle against their original request.
  void invalidateFrontendRequest() {
    _frontendStateRequest = null;
  }

  Future<FrameFrontendState?> _readFrontendState() async {
    _ensureActive();
    // A timeout cannot cancel an isolate RPC. Reuse the outstanding request so
    // polling a hung frontend never exhausts its transport's result-port pool.
    var request = _frontendStateRequest;
    if (request == null) {
      late final Future<FrameFrontendState?> bounded;
      final pending = _frontendService
          .send(GetFrameFrontendStateCommand(id: RpcCommand.generateId()))
          .then<FrameFrontendState?>((result) {
            return result is GetFrameFrontendStateResult ? result.state : null;
          })
          .catchError((Object error, StackTrace stack) {
            _log.fine('Frontend state unavailable', error, stack);
            return null;
          })
          .whenComplete(() {
            if (identical(_frontendStateRequest, bounded)) {
              _frontendStateRequest = null;
            }
          });
      bounded = _waitForFrontend(pending)
          .onError<TimeoutException>((_, _) => null);
      request = bounded;
      _frontendStateRequest = bounded;
    }
    return await request;
  }
}
