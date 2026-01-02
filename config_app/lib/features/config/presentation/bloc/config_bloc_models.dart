import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dslideshow_backend/config.dart'; // Ваш путь к AppConfig

part 'config_bloc_models.freezed.dart';

@freezed
class ConfigEvent with _$ConfigEvent {
  const factory ConfigEvent.load() = ConfigLoadEvent;
  const factory ConfigEvent.save(AppConfig config) = ConfigSaveEvent;
}

@freezed
class ConfigState with _$ConfigState {
  const factory ConfigState.initial() = ConfigInitialState;
  const factory ConfigState.loading() = ConfigLoadingState;
  const factory ConfigState.loaded(AppConfig config) = ConfigLoadedState;
  const factory ConfigState.error(String message) = ConfigErrorState;
  const factory ConfigState.saving() = ConfigSavingState;
  const factory ConfigState.saved() = ConfigSavedState; // Можно использовать для One-shot эффектов
}