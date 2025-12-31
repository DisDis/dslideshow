import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:config_app/features/realtime/domain/services/realtime_service.dart';
import 'package:config_app/features/web_server_config/presentation/bloc/web_tab_event.dart';
import 'package:config_app/features/web_server_config/presentation/bloc/web_tab_state.dart';
import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_backend/config.dart';
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
    on<ReloadAppWebTabEvent>(_reloadApp);
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

  void _reloadApp(ReloadAppWebTabEvent event, emit) {
    _client.sendOneWay(
        WSRestartApplicationCommand(id: WebSocketCommand.generateId()));
  }
}
/*
class LoadingFormBloc extends FormBloc<String, String> {
  final text = TextFieldBloc();

  final select = SelectFieldBloc<String, dynamic>();

  LoadingFormBloc() : super(isLoading: true) {
    addFieldBlocs(
      fieldBlocs: [text, select],
    );
  }

  var _throwException = true;

  @override
  void onLoading() async {
    try {
      await Future<void>.delayed(const Duration(milliseconds: 1500));

      if (_throwException) {
        // Simulate network error
        throw Exception('Network request failed. Please try again later.');
      }

      text.updateInitialValue('I am prefilled');

      select
        ..updateItems(['Option A', 'Option B', 'Option C'])
        ..updateInitialValue('Option B');

      emitLoaded();
    } catch (e) {
      _throwException = false;

      emitLoadFailed();
    }
  }

  @override
  void onSubmitting() async {
    print(text.value);
    print(select.value);

    try {
      await Future<void>.delayed(const Duration(milliseconds: 500));

      emitSuccess();
    } catch (e) {
      emitFailure();
    }
  }
}*/
