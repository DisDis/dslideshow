import 'package:config_app/features/config/data/repository/photoframe_repository.dart';
import 'package:config_app/features/config/domain/config_draft.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'config_bloc_models.dart';

class ConfigBloc extends Bloc<ConfigEvent, ConfigState> {
  final PhotoframeRepository _repository;
  // Load and Save are separate event types but share one configuration.
  bool _busy = false;

  ConfigBloc({
    required ConfigState initialState,
    required PhotoframeRepository client,
  }) : _repository = client,
       super(initialState) {
    on<ConfigLoadEvent>(_onLoad);
    on<ConfigSaveEvent>(_onSave);
  }

  Future<void> _onLoad(ConfigLoadEvent event, Emitter<ConfigState> emit) async {
    if (_busy || isClosed) return;
    _busy = true;
    emit(const ConfigState.loading());
    try {
      final config = await _repository.getConfig();
      if (!emit.isDone && !isClosed) {
        emit(ConfigState.loaded(config));
      }
    } catch (e) {
      if (!emit.isDone && !isClosed) {
        emit(ConfigState.error(e.toString()));
      }
    } finally {
      _busy = false;
    }
  }

  Future<void> _onSave(ConfigSaveEvent event, Emitter<ConfigState> emit) async {
    if (_busy || isClosed) return;
    _busy = true;
    try {
      // The form is mutable. Keep the sent and acknowledged values independent
      // from edits made while the repository is waiting for its response.
      final snapshot = cloneConfig(event.config);
      emit(const ConfigState.saving());
      await _repository.saveConfig(snapshot);
      if (!emit.isDone && !isClosed) {
        emit(const ConfigState.saved());
        emit(ConfigState.loaded(snapshot));
      }
    } catch (e) {
      if (!emit.isDone && !isClosed) {
        emit(ConfigState.error(e.toString()));
      }
    } finally {
      _busy = false;
    }
  }
}
