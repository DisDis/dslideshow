part of 'upload_queue_bloc.dart';

@freezed
class UploadQueueEvent with _$UploadQueueEvent {
  // Добавить файлы
  const factory UploadQueueEvent.addFiles({required List<File> files, required String rootPath}) = _AddFiles;
  // Добавить bytes
  const factory UploadQueueEvent.addPlatformFiles({required List<PlatformFile> files, required String rootPath}) = _AddPlatformFiles;
  

  // Удалить задачу (только если в очереди)
  const factory UploadQueueEvent.removeTask(String taskId) = _RemoveTask;

  // Перезапустить задачу (если ошибка)
  const factory UploadQueueEvent.retryTask(String taskId) = _RetryTask;

  // Внутренние события (обновление прогресса)
  const factory UploadQueueEvent.updateProgress(String taskId, int sent, int total) = _UpdateProgress;
  const factory UploadQueueEvent.taskCompleted(String taskId) = _TaskCompleted;
  const factory UploadQueueEvent.taskFailed(String taskId, String error) = _TaskFailed;
}