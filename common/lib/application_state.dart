// Freezed forwards factory annotations to the generated implementation.
// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

import 'storage_status.dart';

export 'storage_status.dart';

part 'application_state.freezed.dart';
part 'application_state.g.dart';

@freezed
sealed class ApplicationState with _$ApplicationState {
  @JsonSerializable()
  const factory ApplicationState({
    @Default(true) bool hasInternet,
    @Default(true) bool isScreenOn,
    @JsonKey(unknownEnumValue: StorageStatusEnum.off) @Default(StorageStatusEnum.done) StorageStatusEnum storageStatus,
    @Default(false) bool isMenu,
    @Default(false) bool isPaused,
    @Default(true) bool isMotion,
  }) = _ApplicationState;

  factory ApplicationState.fromJson(Map<String, dynamic> json) => _$ApplicationStateFromJson(json);
}
