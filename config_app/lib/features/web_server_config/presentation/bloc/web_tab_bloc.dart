import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:config_app/features/realtime/domain/services/realtime_service.dart';
import 'package:config_app/features/web_server_config/presentation/bloc/web_tab_event.dart';
import 'package:config_app/features/web_server_config/presentation/bloc/web_tab_state.dart';
import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_common/rpc.dart';
// import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:logging/logging.dart';

class WebTabBloc extends Bloc<WebTabEvent, WebTabState> {
  static final Logger _log = Logger('WebTabBloc');
  final RealtimeService _client;
  static const prettyPrintJSONEncode = JsonEncoder.withIndent('  ');
  WebTabBloc(
      {required WebTabState initialState, required RealtimeService client})
      : _client = client,
        super(initialState) {
    on<RestartAppWebTabEvent>(_restartApp);
    on<PowerOffWebTabEvent>(_powerOff);
    on<LoadWebTabEvent>(_loadConfig);
  }

  void _loadConfig(LoadWebTabEvent event, emit) async {
    final result = await _client
            .send(WSConfigDownloadCommand(id: WebSocketCommand.generateId()))
        as WSConfigDownloadResult;
    _log.info('Recived config:');
    var jsonMsg = json.decode(result.content);
    final config = AppConfig.fromJson(jsonMsg);
    _log.info(prettyPrintJSONEncode.convert(jsonMsg));
    emit(InWebTabState(config));
  }

  void _restartApp(RestartAppWebTabEvent event, emit) {
    _client.sendOneWay(WSSendRpcCommand.byCommand(RestartAppCommand(
      id: RpcCommand.generateId(),
    )));
  }

  void _powerOff(PowerOffWebTabEvent event, emit) {
    _client.sendOneWay(WSSendRpcCommand.byCommand(PowerOffCommand(
      id: RpcCommand.generateId(),
    )));
  }
}
