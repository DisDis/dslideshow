import 'package:freezed_annotation/freezed_annotation.dart';

part 'ota_event.freezed.dart';

@freezed
sealed class OtaEvent with _$OtaEvent {
  const factory OtaEvent.init() = InitOtaEvent;
  const factory OtaEvent.pickFile() = PickFileOtaEvent;
  const factory OtaEvent.codeChanged(String value) = CodeChangedOtaEvent;
  const factory OtaEvent.upload() = UploadFileOtaEvent;
  const factory OtaEvent.reset() = ResetOtaEvent;
}
