import 'package:dslideshow_backend/command.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ota_state.freezed.dart';

@freezed
class OtaState with _$OtaState {
  const factory OtaState.initial({required OTAInfo info}) = _OtaInitialState;
  const factory OtaState.ready({required OTAInfo info}) = _OtaReadyState;
  const factory OtaState.progress({required OTAInfo info}) = _OtaProgressState;
  const factory OtaState.success({required OTAInfo info}) = _OtaSuccessState;
  const factory OtaState.failure({required OTAInfo info}) = _OtaFailureState;
  const factory OtaState.exit({required OTAInfo info}) = _OtaExitState;
}
