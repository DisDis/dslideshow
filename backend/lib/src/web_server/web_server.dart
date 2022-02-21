import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_backend/src/web_server/web_server_config.dart';
import 'package:dslideshow_backend/src/web_server/web_service.dart';
import 'package:dslideshow_common/rpc.dart';
import 'package:logging/logging.dart';

class WebServer implements RpcService {
  static final Logger _log = new Logger('WebServer');
  final WebServerConfig _config;
  final RemoteService _remoteBackendService;
  final WebService _webService;

  WebServer(this._config, this._remoteBackendService, this._webService) {}

  @override
  Future<RpcResult> executeCommand(RpcCommand command) {
    Stopwatch work = new Stopwatch()
      ..reset()
      ..start();
    return _executeCommand(command).whenComplete(() {
      work.stop();
      _log.info(
          "Command: [${command.hashCode}]${command.id}:${command.type} duration: ${work.elapsed.inMilliseconds.toString()}ms");
    });
  }

  Future<RpcResult> _executeCommand(RpcCommand command) {
    switch (command.type) {
      case WebServerControlCommand.TYPE:
        return _executeWebServerControlCommand(command as WebServerControlCommand);
      case EchoCommand.TYPE:
        return new Future.value(_executeEchoCommand(command as EchoCommand));
      default:
        return new Future.value(_generateErrorResult(new Exception("Unknown command: ${command.type}"), command));
    }
  }

  RpcErrorResult _generateErrorResult(Object e, RpcCommand command) {
    return new ErrorResult((b) => b
      ..id = command.id
      ..error = '$e');
  }

  RpcResult _executeEchoCommand(EchoCommand command) {
    if (command.text == 'error') {
      return _generateErrorResult(new Exception("Echo error"), command);
    }
    return new EchoCommandResult((b) {
      b.id = command.id;
      b.resultText = "${command.text} Service ${new DateTime.now()}";
    });
  }

  Future<RpcResult> _executeWebServerControlCommand(WebServerControlCommand command) async {
    _webService.enabled = command.enable;
    return new WebServerControlCommandResult.respond(command, _webService.code, command.enable);
  }
}
