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
  static final Logger _log = Logger('PowerBloc');
  final RealtimeService _client;
  PowerBloc({required PowerState initialState, required this._client})
    : super(initialState) {
    on<RestartAppPowerEvent>(_restartApp);
    on<PowerOffPowerEvent>(_powerOff);
    on<LoadPowerEvent>(_loadData);
  }

  Future<void> _loadData(LoadPowerEvent event, Emitter<PowerState> emit) async {
    emit(const UninitializedPowerState());
    try {
      final result = await _client.send(
        WSConfigDownloadCommand(id: WebSocketCommand.generateId()),
      ) as WSConfigDownloadResult;
      if (emit.isDone) {
        return;
      }
      final jsonMsg = json.decode(result.content);
      final config = AppConfig.fromJson(jsonMsg);
      _log.info('Configuration received');
      emit(InitializedPowerState(config));
    } catch (error) {
      _log.warning('Loading power configuration failed (${error.runtimeType})');
      emit(ErrorPowerState(error.toString()));
    }
  }

  void _restartApp(RestartAppPowerEvent event, Emitter<PowerState> emit) {
    try {
      _client.sendOneWay(
        WSSendRpcCommand.byCommand(
          RestartAppCommand(id: RpcCommand.generateId()),
        ),
      );
    } catch (error) {
      _log.warning('Restart request failed (${error.runtimeType})');
      emit(ErrorPowerState(error.toString()));
    }
  }

  void _powerOff(PowerOffPowerEvent event, Emitter<PowerState> emit) {
    try {
      _client.sendOneWay(
        WSSendRpcCommand.byCommand(
          PowerOffCommand(id: RpcCommand.generateId()),
        ),
      );
    } catch (error) {
      _log.warning('Power-off request failed (${error.runtimeType})');
      emit(ErrorPowerState(error.toString()));
    }
  }
}
