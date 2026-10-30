import 'package:freezed_annotation/freezed_annotation.dart';

part 'ota_state.freezed.dart';

enum OtaPhase {
  uninitialized,
  initializing,
  ready,
  uploading,
  completed,
  failed,
}

enum OtaFailure {
  invalidFile,
  emptyFile,
  fileUnavailable,
  requestFailed,
  invalidResponse,
  uploadRejected,
  cancelled,
}

@freezed
abstract class OtaState with _$OtaState {
  const OtaState._();

  const factory OtaState({
    @Default(OtaPhase.uninitialized) OtaPhase phase,
    @Default('') String version,
    @Default('') String code,
    String? filename,
    int? fileSize,
    @Default(false) bool pickingFile,
    @Default(0.0) double progress,
    OtaFailure? failure,
    @Default(0) int formGeneration,
  }) = _OtaState;

  bool get canSubmit =>
      (phase == OtaPhase.ready || phase == OtaPhase.failed) &&
      !pickingFile &&
      filename != null &&
      (fileSize ?? 0) > 0 &&
      code.isNotEmpty;
}
