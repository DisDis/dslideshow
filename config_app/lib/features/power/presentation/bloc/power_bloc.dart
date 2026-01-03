import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:config_app/features/realtime/domain/services/realtime_service.dart';
import 'package:config_app/features/power/presentation/bloc/power_event.dart';
import 'package:config_app/features/power/presentation/bloc/power_state.dart';
import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_common/rpc.dart';
// import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:logging/logging.dart';

class PowerBloc extends Bloc<PowerEvent, PowerState> {
  static final Logger _log = Logger('WebTabBloc');
  final RealtimeService _client;
  static const prettyPrintJSONEncode = JsonEncoder.withIndent('  ');
  PowerBloc(
      {required PowerState initialState, required RealtimeService client})
      : _client = client,
        super(initialState) {
    on<RestartAppPowerEvent>(_restartApp);
    on<PowerOffPowerEvent>(_powerOff);
    on<LoadPowerEvent>(_loadData);
  }

  void _loadData(LoadPowerEvent event, emit) async {
    final result = await _client
            .send(WSConfigDownloadCommand(id: WebSocketCommand.generateId()))
        as WSConfigDownloadResult;
    _log.info('Recived config:');
    var jsonMsg = json.decode(result.content);
    final config = AppConfig.fromJson(jsonMsg);
    _log.info(prettyPrintJSONEncode.convert(jsonMsg));
    emit(InitializedPowerState(config));
  }

  void _restartApp(RestartAppPowerEvent event, emit) {
    _client.sendOneWay(WSSendRpcCommand.byCommand(RestartAppCommand(
      id: RpcCommand.generateId(),
    )));
  }

  void _powerOff(PowerOffPowerEvent event, emit) {
    _client.sendOneWay(WSSendRpcCommand.byCommand(PowerOffCommand(
      id: RpcCommand.generateId(),
    )));
  }
}
