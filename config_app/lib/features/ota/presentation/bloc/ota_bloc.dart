import 'dart:io';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:config_app/features/ota/presentation/bloc/ota_client.dart';
import 'package:config_app/features/realtime/domain/services/realtime_service.dart';
import 'package:config_app/features/ota/presentation/bloc/ota_event.dart';
import 'package:config_app/features/ota/presentation/bloc/ota_state.dart';
import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_common/rpc.dart';
import 'package:logging/logging.dart';

class OtaBloc extends Bloc<OtaEvent, OtaState> {
  static final Logger _log = Logger('OtaBloc');
  final RealtimeService client;

  OtaBloc({required OtaState initialState, required this.client})
      : super(initialState) {
    on<InitOtaEvent>(_onInit);
    on<UploadFileOtaEvent>(_onUploadFile);
    on<UploadProgressOtaEvent>(_onUploadProgress);
    on<UploadCompleteOtaEvent>(_onUploadComplete);
    on<ResetOtaEvent>(_onReset);
  }

  void _onInit(InitOtaEvent event, Emitter<OtaState> emit) async {
    try {
      final ota = OTAClient(host: client.connectUri.host);
      final result = await ota.start();

      _log.info(
          'Received OTA info: v_frontend=${result["version"]["frontend"]}, v_backend=${result["version"]["backend"]}');

      // Пока используем тестовые данные
      emit(InitializedOtaState(
        version: "${result["version"]["frontend"]}",
      ));
    } catch (e) {
      _log.severe('Error initializing OTA: $e');
      emit(ErrorOtaState('Failed to initialize OTA: $e'));
    }
  }

  void _onUploadFile(UploadFileOtaEvent event, Emitter<OtaState> emit) async {
    try {
      // Начинаем загрузку файла
      final file = File(event.filePath);
      if (!await file.exists()) {
        emit(const ErrorOtaState('File does not exist'));
        return;
      }
      final ota = OTAClient(host: client.connectUri.host);
      emit(UploadingOtaState(progress: 0.0));
      await ota.uploadFile(event.code, event.filePath);
      emit(UploadCompleteOtaState());

      //   // Обновляем состояние на процесс загрузки
      //   emit(UploadingOtaState(
      //     version: state.maybeWhen(
      //       initialized: (version, updateCode) => version,
      //       uploading: (version, updateCode, progress) => version,
      //       uploadComplete: (version, updateCode) => version,
      //       orElse: () => 'Unknown',
      //     ),
      //     updateCode: state.maybeWhen(
      //       initialized: (version, updateCode) => updateCode,
      //       uploading: (version, updateCode, progress) => updateCode,
      //       uploadComplete: (version, updateCode) => updateCode,
      //       orElse: () => 'Unknown',
      //     ),
      //     progress: 0.0,
      //   ));

      //   // Отправляем файл на сервер
      //   final bytes = await file.readAsBytes();
      //   final base64Data = base64Encode(bytes);

      //   // TODO: Заменить на реальную команду загрузки OTA
      //   // final uploadResult = await _client
      //   //         .send(WSOtaUploadCommand(
      //   //           id: WebSocketCommand.generateId(),
      //   //           data: base64Data,
      //   //           filename: file.path.split('/').last,
      //   //         ))
      //   //     as WSOtaUploadResult;

      //   // _log.info('Upload complete: ${uploadResult.success}');

      //   // Пока используем тестовую логику
      //   // Имитируем процесс загрузки
      //   for (int i = 10; i <= 100; i += 10) {
      //     await Future.delayed(const Duration(milliseconds: 200));
      //     add(UploadProgressOtaEvent(i / 100.0));
      //   }

      //   emit(UploadCompleteOtaState(
      //     version: state.maybeWhen(
      //       initialized: (version, updateCode) => version,
      //       uploading: (version, updateCode, progress) => version,
      //       uploadComplete: (version, updateCode) => version,
      //       orElse: () => 'Unknown',
      //     ),
      //     updateCode: state.maybeWhen(
      //       initialized: (version, updateCode) => updateCode,
      //       uploading: (version, updateCode, progress) => updateCode,
      //       uploadComplete: (version, updateCode) => updateCode,
      //       orElse: () => 'Unknown',
      //     ),
      //   ));
    } catch (e) {
      _log.severe('Error uploading file: $e');
      emit(ErrorOtaState('Upload failed: $e'));
    }
  }

  void _onUploadProgress(UploadProgressOtaEvent event, Emitter<OtaState> emit) {
    if (state is UploadingOtaState) {
      final currentState = state as UploadingOtaState;
      emit(UploadingOtaState(
        progress: event.progress,
      ));
    }
  }

  void _onUploadComplete(UploadCompleteOtaEvent event, Emitter<OtaState> emit) {
    // Обработка завершения загрузки
    if (state is UploadingOtaState) {
      final currentState = state as UploadingOtaState;
      emit(UploadCompleteOtaState(
          //version: currentState.version,
          // updateCode: currentState.updateCode,
          ));
    }
  }

  void _onReset(ResetOtaEvent event, Emitter<OtaState> emit) {
    emit(const UninitializedOtaState());
  }
}
