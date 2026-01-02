import 'package:config_app/features/config/data/repository/photoframe_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'config_bloc_models.dart';

class ConfigBloc extends Bloc<ConfigEvent, ConfigState> {
  final PhotoframeRepository _repository;

  ConfigBloc({
    required ConfigState initialState,
    required PhotoframeRepository client,
  })  : _repository = client,
        super(initialState) {
    on<ConfigLoadEvent>(_onLoad);
    on<ConfigSaveEvent>(_onSave);
  }

  Future<void> _onLoad(ConfigLoadEvent event, Emitter<ConfigState> emit) async {
    emit(const ConfigState.loading());
    try {
      final config = await _repository.getConfig();
      emit(ConfigState.loaded(config));
    } catch (e) {
      emit(ConfigState.error(e.toString()));
    }
  }

  Future<void> _onSave(ConfigSaveEvent event, Emitter<ConfigState> emit) async {
    emit(const ConfigState.saving());
    try {
      await _repository.saveConfig(event.config);
      // После сохранения возвращаем обновленный конфиг в состояние Loaded
      emit(ConfigState.loaded(event.config));
    } catch (e) {
      emit(ConfigState.error(e.toString()));
    }
  }
}