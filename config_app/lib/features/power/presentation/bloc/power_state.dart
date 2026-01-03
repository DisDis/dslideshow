import 'package:dslideshow_backend/config.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'power_state.freezed.dart';

@freezed
class PowerState with _$PowerState {
  const factory PowerState.uninitialized() = UninitializedPowerState;
  const factory PowerState.error(String errorMessage) = ErrorPowerState;
  const factory PowerState.initialized(AppConfig config) = InitializedPowerState;
}