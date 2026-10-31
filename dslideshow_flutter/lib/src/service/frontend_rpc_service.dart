import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_common/rpc.dart';
import 'package:logging/logging.dart';

import 'frame_frontend_controller.dart';
import 'frontend.dart';

class FrontendRpcService implements RpcService {
  FrontendRpcService({required this.frontendService, required this.frameController});

  static final _log = Logger('FrontendRpcService');
  final FrontendService frontendService;
  final FrameFrontendController frameController;

  @override
  Future<RpcResult> executeCommand(RpcCommand command) async {
    if (frontendService.isClosed || (command is! GetFrameFrontendStateCommand && command is! SetFrameControlCommand)) {
      return frontendService.executeCommand(command);
    }

    _log.fine('command start requestId=${command.id} type=${command.type}');
    try {
      if (command is GetFrameFrontendStateCommand) {
        return GetFrameFrontendStateResult(id: command.id, state: frameController.readState());
      }
      final control = command as SetFrameControlCommand;
      await frameController.setControl(control.control, control.enabled);
      return EmptyResult.respond(command);
    } catch (error, stack) {
      _log.warning(
        'command failed requestId=${command.id} type=${command.type} errorType=${error.runtimeType}',
        error,
        stack,
      );
      return ErrorResult(id: command.id, error: '$error');
    } finally {
      _log.fine('command result requestId=${command.id} type=${command.type}');
    }
  }
}
