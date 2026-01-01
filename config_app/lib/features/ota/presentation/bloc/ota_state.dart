import 'package:freezed_annotation/freezed_annotation.dart';

part 'ota_state.freezed.dart';

@freezed
class OtaState with _$OtaState {
  const factory OtaState.uninitialized() = UninitializedOtaState;
  const factory OtaState.initialized({
    required String version,
  }) = InitializedOtaState;
  const factory OtaState.uploading({
    required double progress,
  }) = UploadingOtaState;
  const factory OtaState.uploadComplete() = UploadCompleteOtaState;
  const factory OtaState.error(String errorMessage) = ErrorOtaState;
}
