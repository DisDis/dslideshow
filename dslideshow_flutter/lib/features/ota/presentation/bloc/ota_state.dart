import 'package:dslideshow_backend/command.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ota_state.freezed.dart';

@freezed
sealed class OtaState with _$OtaState {
  const OtaState._();
  bool get canReturnToSlideshow => switch (this) {
    OtaReadyState() || OtaFailureState() => true,
    _ => false,
  };
  const factory OtaState.initial({required OTAInfo info}) = OtaInitialState;
  const factory OtaState.ready({
    required OTAInfo info,
    required String? otaStartUrl,
    @Default(false) bool isPreparingAddress,
  }) = OtaReadyState;
  const factory OtaState.progress({required OTAInfo info}) = OtaProgressState;
  const factory OtaState.success({required OTAInfo info}) = OtaSuccessState;
  const factory OtaState.failure({required OTAInfo info}) = OtaFailureState;
  const factory OtaState.exit({required OTAInfo info}) = OtaExitState;
}
