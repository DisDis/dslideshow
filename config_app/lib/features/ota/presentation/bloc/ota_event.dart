import 'package:freezed_annotation/freezed_annotation.dart';

part 'ota_event.freezed.dart';

@freezed
class OtaEvent with _$OtaEvent {
  const factory OtaEvent.init() = InitOtaEvent;
  const factory OtaEvent.uploadFile(String filePath, String code) = UploadFileOtaEvent;
  const factory OtaEvent.uploadProgress(double progress) = UploadProgressOtaEvent;
  const factory OtaEvent.uploadComplete() = UploadCompleteOtaEvent;
  const factory OtaEvent.reset() = ResetOtaEvent;
}