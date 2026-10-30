import 'package:freezed_annotation/freezed_annotation.dart';

part 'upload_task.freezed.dart';

enum UploadStatus { queued, uploading, completed, error }

enum UploadFailure { sourceUnavailable, lengthUnknown, transferFailed }

enum UploadSelectionIssue { emptyFolder, folderReadFailed, pickerFailed }

enum UploadSelectionKind { files, folder }

enum UploadPickedPathMode { parentFolder, fileName }

@freezed
sealed class UploadTask with _$UploadTask {
  const factory UploadTask({
    required String id, // Уникальный ID (uuid)
    required String localPath, // Абсолютный путь на устройстве
    required String serverPath, // Путь на сервере (например subfolder/img.jpg)
    @Default('') String batchId,
    @Default(UploadStatus.queued) UploadStatus status,
    @Default(0.0) double progress, // 0.0 to 1.0
    UploadFailure? failure,
  }) = _UploadTask;
}
