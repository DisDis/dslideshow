import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_backend/src/web_server/web_server_config.dart';
import 'package:dslideshow_backend/src/web_server/web_service.dart';
import 'package:dslideshow_common/rpc.dart';
import 'package:logging/logging.dart';

class WebServer implements RpcService {
  static final Logger _log = new Logger('WebServer');
  // ignore: unused_field
  final WebServerConfig _config;
  // ignore: unused_field
  final RemoteService _remoteBackendService;
  final WebService _webService;

  WebServer(this._config, this._remoteBackendService, this._webService) {}

  @override
  Future<RpcResult> executeCommand(RpcCommand command) {
    return _executeCommand(command).whenComplete(() {
      _log.info("Command: [${command.hashCode}]${command.id}:${command.type}");
    });
  }

  Future<RpcResult> _executeCommand(RpcCommand command) {
    switch (command.type) {
      case WebServerControlCommand.TYPE:
        return _executeWebServerControlCommand(command as WebServerControlCommand);
      case EchoCommand.TYPE:
        return _executeEchoCommand(command as EchoCommand);
      default:
        return _generateErrorResult(new Exception("Unknown command: ${command.type}"), command);
    }
  }

  Future<RpcErrorResult> _generateErrorResult(Object e, RpcCommand command) async {
    return ErrorResult(id: command.id, error: '$e');
  }

  Future<RpcResult> _executeEchoCommand(EchoCommand command) async {
    if (command.text == 'error') {
      return _generateErrorResult(new Exception("Echo error"), command);
    }
    return EchoCommandResult(id: command.id, resultText: "${command.text} Service ${new DateTime.now()}");
  }

  Future<RpcResult> _executeWebServerControlCommand(WebServerControlCommand command) async {
    try {
      await _webService.setEnabled(command.enable);
    } catch (_) {
      return ErrorResult(id: command.id, error: 'Web server control failed');
    }
    return WebServerControlCommandResult.respond(command, _webService.code, command.enable);
  }
}
