import 'dart:async';
import 'dart:convert';

import 'package:config_app/features/realtime/domain/services/realtime_service.dart';
import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_backend/config.dart';
import 'package:logging/logging.dart';

class PhotoframeRepository {
  final RealtimeService _client;
  static final Logger _log = Logger('PhotoframeRepository');

  PhotoframeRepository(this._client);

  static const prettyPrintJSONEncode = JsonEncoder.withIndent('  ');

  Future<AppConfig> getConfig() async {
    final result = await _client.send(WSConfigDownloadCommand(id: WebSocketCommand.generateId())) as WSConfigDownloadResult;
    _log.info('Recived config:');
    var jsonMsg = json.decode(result.content);
    final config = AppConfig.fromJson(jsonMsg);
    _log.info(prettyPrintJSONEncode.convert(jsonMsg));
    return config;
  }

  Future<WebSocketResult> saveConfig(AppConfig config) {
    return _client.send(WSConfigUploadCommand(id: WebSocketCommand.generateId(), content: prettyPrintJSONEncode.convert(config.toJson())));
  }

  void dispose() {
    // Clean up the controller when the widget is disposed.
  }
}
