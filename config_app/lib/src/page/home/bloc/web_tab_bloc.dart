import 'dart:async';
import 'dart:convert';
import 'dart:developer' as developer;

import 'package:bloc/bloc.dart';
import 'package:config_app/src/page/home/bloc/web_tab_event.dart';
import 'package:config_app/src/page/home/bloc/web_tab_state.dart';
import 'package:config_app/src/service/client_service.dart';
import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_backend/config.dart';
import 'package:logging/logging.dart';

class WebTabBloc extends Bloc<WebTabEvent, WebTabState> {
  static final Logger _log = Logger('WebTabBloc');
  final ClientService _client;
  static const prettyPrintJSONEncode = JsonEncoder.withIndent('  ');
  WebTabBloc({required WebTabState initialState, required ClientService client})
      : _client = client,
        super(initialState) {
    on<ReloadAppWebTabEvent>((event, emit) {
      _client.sendOneWay(WSRestartApplicationCommand());
    });
    on<LoadWebTabEvent>((event, emit) async {
      final result = await _client.send(WSConfigDownloadCommand()) as WSConfigDownloadResult;
      _log.info('Recived config:');
      var jsonMsg = json.decode(result.content);
      final _config = AppConfig.fromJson(jsonMsg);
      _log.info(prettyPrintJSONEncode.convert(jsonMsg));
      emit(InWebTabState(_config));
    });
  }
}
