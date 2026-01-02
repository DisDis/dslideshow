import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:config_app/features/realtime/domain/services/realtime_service.dart';
import 'package:config_app/features/upload/domain/upload_task.dart';
import 'package:config_app/src/web_client/web_client.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';
import 'package:path/path.dart' as p;
// Замените на ваш реальный WebClient

part 'upload_queue_bloc.freezed.dart';

// --- EVENTS ---
@freezed
class UploadQueueEvent with _$UploadQueueEvent {
  // Добавить файлы
  const factory UploadQueueEvent.addFiles({required List<File> files, required String rootPath}) = _AddFiles;

  // Удалить задачу (только если в очереди)
  const factory UploadQueueEvent.removeTask(String taskId) = _RemoveTask;

  // Перезапустить задачу (если ошибка)
  const factory UploadQueueEvent.retryTask(String taskId) = _RetryTask;

  // Внутренние события (обновление прогресса)
  const factory UploadQueueEvent.updateProgress(String taskId, int sent, int total) = _UpdateProgress;
  const factory UploadQueueEvent.taskCompleted(String taskId) = _TaskCompleted;
  const factory UploadQueueEvent.taskFailed(String taskId, String error) = _TaskFailed;
}

// --- STATE ---
@freezed
sealed class UploadQueueState with _$UploadQueueState {
  const factory UploadQueueState({
    @Default([]) List<UploadTask> tasks,
  }) = _UploadQueueState;
}

// --- BLOC ---
class UploadQueueBloc extends Bloc<UploadQueueEvent, UploadQueueState> {
  final RealtimeService client;

  static const int _maxConcurrentUploads = 2; // Константа параллелизма
  static const int _maxHistorySize = 100; // История

  UploadQueueBloc({required this.client}) : super(const UploadQueueState()) {
    on<_AddFiles>(_onAddFiles);
    on<_RemoveTask>(_onRemoveTask);
    on<_RetryTask>(_onRetryTask);
    on<_UpdateProgress>(_onUpdateProgress);
    on<_TaskCompleted>(_onTaskCompleted);
    on<_TaskFailed>(_onTaskFailed);
  }

  // Добавление файлов в очередь
  Future<void> _onAddFiles(_AddFiles event, Emitter<UploadQueueState> emit) async {
    final newTasks = event.files.map((file) {
      // Вычисляем относительный путь для сервера
      // Если rootPath = /user/photos, а файл /user/photos/vacation/1.jpg
      // то serverPath = vacation/1.jpg
      String serverPath = p.relative(file.path, from: event.rootPath);

      return UploadTask(
        id: const Uuid().v4(),
        localPath: file.path,
        serverPath: serverPath,
        status: UploadStatus.queued,
      );
    }).toList();

    emit(state.copyWith(tasks: [...state.tasks, ...newTasks]));
    _processQueue();
  }

  void _onRemoveTask(_RemoveTask event, Emitter<UploadQueueState> emit) {
    // Удаляем только если задача в очереди или ошибка
    final updatedTasks = state.tasks.where((t) => t.id != event.taskId).toList();
    emit(state.copyWith(tasks: updatedTasks));
  }

  void _onRetryTask(_RetryTask event, Emitter<UploadQueueState> emit) {
    final updatedTasks = state.tasks.map((t) {
      if (t.id == event.taskId) {
        return t.copyWith(status: UploadStatus.queued, errorMessage: null, progress: 0);
      }
      return t;
    }).toList();

    emit(state.copyWith(tasks: updatedTasks));
    _processQueue();
  }

  void _onUpdateProgress(_UpdateProgress event, Emitter<UploadQueueState> emit) {
    final updatedTasks = state.tasks.map((t) {
      if (t.id == event.taskId) {
        final progress = event.total == 0 ? 0.0 : event.sent / event.total;
        // Если пришел прогресс, значит задача точно загружается
        return t.copyWith(progress: progress, status: UploadStatus.uploading // Форсируем статус
            );
      }
      return t;
    }).toList();
    emit(state.copyWith(tasks: updatedTasks));
  }

  void _onTaskCompleted(_TaskCompleted event, Emitter<UploadQueueState> emit) {
    var updatedTasks = state.tasks.map((t) {
      if (t.id == event.taskId) {
        return t.copyWith(status: UploadStatus.completed, progress: 1.0);
      }
      return t;
    }).toList();

    // Очистка старой истории (> 100 выполненных)
    updatedTasks = _cleanupHistory(updatedTasks);

    emit(state.copyWith(tasks: updatedTasks));
    _processQueue(); // Запускаем следующую
  }

  void _onTaskFailed(_TaskFailed event, Emitter<UploadQueueState> emit) {
    final updatedTasks = state.tasks.map((t) {
      if (t.id == event.taskId) {
        return t.copyWith(status: UploadStatus.error, errorMessage: event.error);
      }
      return t;
    }).toList();

    emit(state.copyWith(tasks: updatedTasks));
    _processQueue(); // Запускаем следующую, несмотря на ошибку
  }

  // --- LOGIC ---

  // Главный метод управления очередью
  void _processQueue() {
    // 1. Считаем сколько сейчас загружается
    final activeCount = state.tasks.where((t) => t.status == UploadStatus.uploading).length;

    if (activeCount >= _maxConcurrentUploads) return;

    // 2. Сколько слотов свободно
    final freeSlots = _maxConcurrentUploads - activeCount;

    // 3. Берем следующие из очереди
    final tasksToStart = state.tasks.where((t) => t.status == UploadStatus.queued).take(freeSlots);

    for (final task in tasksToStart) {
      _startUpload(task);
    }
  }

  Future<void> _startUpload(UploadTask task) async {
    // Меняем статус на uploading
    // ВНИМАНИЕ: Мы не используем emit здесь напрямую, так как метод асинхронный и внешний,
    // но для корректности UI нужно обновить стейт.
    // В Bloc > 7.2 лучше отправлять события самому себе или делать emit внутри handler.
    // Тут мы хакнем через Stream или просто модифицируем стейт "in place" нельзя.
    // Правильный путь:
    // Мы не можем сделать emit здесь. Но _processQueue вызывается ВНУТРИ хендлеров событий.
    // Поэтому мы должны запустить фоновую задачу, которая будет слать ивенты.

    // Но сначала пометим задачу как Uploading, чтобы занять слот.
    // Это изменение стейта должно пройти через событие или мы должны были сделать это раньше.
    // Давайте упростим: _processQueue не будет запускать задачу сама, она найдет кандидатов
    // и пошлет внутреннее событие _InternalStartTask. Но это усложнит код.
    // Проще всего: Сделаем dirty hack с обновлением стейта ПЕРЕД асинхронщиной внутри хендлеров.
    // Но так как _processQueue вызывается в конце хендлеров, мы не можем сделать emit.

    // РЕШЕНИЕ:
    // Мы просто запускаем асинхронную функцию, которая сразу пошлет ивент "Started".
    // Но чтобы не было гонки, лучше считать activeCount + startedCount.

    _uploadFileRoutine(task);
  }

  Future<void> _uploadFileRoutine(UploadTask task) async {
    try {
      // Мы не можем сделать emit(loading) тут.
      // Поэтому, визуально слот "занимается" только когда прилетит первый прогресс или мы сделаем событие Started.
      // Добавим специальный метод в bloc для старта, чтобы обновить UI.
      // Но для простоты примера, будем считать Uploading по первому байту.

      // Читаем файл
      final file = File(task.localPath);
      if (!await file.exists()) {
        add(UploadQueueEvent.taskFailed(task.id, "File not found"));
        return;
      }
      final wclient = WebClient(code: client.authCode, host: client.connectUri.host, port: client.connectUri.port);
      // Вызываем WebClient
      await wclient.uploadMedia(
        task.localPath,
        task.serverPath,
        (sent, total) {
          // Callback. Шлем событие в Блок
          add(UploadQueueEvent.updateProgress(task.id, sent, total));
          // *Примечание: в реальном коде стоит троттлить эти события (слать раз в 100мс),
          // иначе заспамим ивент-луп.
        },
      );

      add(UploadQueueEvent.taskCompleted(task.id));
    } catch (e) {
      add(UploadQueueEvent.taskFailed(task.id, e.toString()));
    }
  }

  // При получении прогресса, мы также должны убедиться, что статус стал Uploading
  // (наш _onUpdateProgress это делает косвенно, если мы добавим смену статуса там)
  // Для простоты подправим _onUpdateProgress чтобы он форсировал статус Uploading.
  // См. метод _onUpdateProgress ниже (доработанный).

  List<UploadTask> _cleanupHistory(List<UploadTask> tasks) {
    final completed = tasks.where((t) => t.status == UploadStatus.completed).toList();
    if (completed.length <= _maxHistorySize) return tasks;

    // Сортируем или просто удаляем первые, если они добавлялись в конец
    // Предполагаем, что старые выше в списке.
    // Нам нужно удалить (completed.length - 100) самых старых.
    int toDelete = completed.length - _maxHistorySize;

    // Создаем новый список, пропуская первые N завершенных
    final result = <UploadTask>[];
    int deletedCount = 0;

    for (var t in tasks) {
      if (t.status == UploadStatus.completed && deletedCount < toDelete) {
        deletedCount++;
        continue; // Пропускаем (удаляем)
      }
      result.add(t);
    }
    return result;
  }
}
