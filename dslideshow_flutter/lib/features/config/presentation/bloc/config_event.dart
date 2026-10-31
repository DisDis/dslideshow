import 'package:dslideshow_flutter/src/service/frontend.dart' show ButtonEvent;
import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_flutter/features/config/presentation/bloc/config_state.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'config_event.freezed.dart';

@freezed
sealed class ConfigEvent with _$ConfigEvent {
  const factory ConfigEvent.initialize() = ConfigInitialize;
  const factory ConfigEvent.retry() = ConfigRetry;
  const factory ConfigEvent.exit() = ConfigExit;
  const factory ConfigEvent.networkUpdated(SystemInfo info) = ConfigNetworkUpdated;
  const factory ConfigEvent.button(ButtonEvent button) = ConfigButton;
  const factory ConfigEvent.completed(
    ConfigOperation operation, {
    String? code,
    SystemInfo? info,
    ConfigFailureKind? failure,
  }) = ConfigCompleted;
}
