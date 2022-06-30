import 'dart:async';
import 'dart:convert';

import 'package:config_app/src/service/client_service.dart';
import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_backend/config.dart';
import 'package:logging/logging.dart';

class PhotoframeRepository {
  final ClientService _client;
  static final Logger _log = Logger('PhotoframeRepository');

  PhotoframeRepository(this._client);

  static const prettyPrintJSONEncode = JsonEncoder.withIndent('  ');

  Future<AppConfig> getConfig() async {
    final result = await _client.send(WSConfigDownloadCommand()) as WSConfigDownloadResult;
    _log.info('Recived config:');
    var jsonMsg = json.decode(result.content);
    final _config = AppConfig.fromJson(jsonMsg);
    _log.info(prettyPrintJSONEncode.convert(jsonMsg));
    return _config;
  }

  Future<WebSocketResult> saveConfig(AppConfig config) {
    return _client.send(WSConfigUploadCommand((b) => b.content = prettyPrintJSONEncode.convert(config.toJson())));
  }

  void dispose() {
    // Clean up the controller when the widget is disposed.
  }
}