part of 'upload_queue_bloc.dart';

@freezed
sealed class UploadQueueEvent with _$UploadQueueEvent {
  const factory UploadQueueEvent.addFiles({
    required List<File> files,
    required String rootPath,
  }) = _AddFiles;
  const factory UploadQueueEvent.addPlatformFiles({
    required List<PlatformFile> files,
    required String rootPath,
  }) = _AddPlatformFiles;
  const factory UploadQueueEvent.addFolder(String path) = _AddFolder;
  const factory UploadQueueEvent.removeTask(String taskId) = _RemoveTask;
  const factory UploadQueueEvent.retryTask(String taskId) = _RetryTask;
  const factory UploadQueueEvent.updateProgress(
    String taskId,
    int attemptId,
    int sent,
    int total,
  ) = _UpdateProgress;
  const factory UploadQueueEvent.taskFinished(
    String taskId,
    int attemptId,
    UploadFailure? failure,
    bool cancelled,
  ) = _TaskFinished;
  const factory UploadQueueEvent.folderChunk({
    required int scanId,
    required List<File> files,
    required String rootPath,
    @Default(false) bool finished,
    UploadSelectionIssue? issue,
  }) = _FolderChunk;
}
