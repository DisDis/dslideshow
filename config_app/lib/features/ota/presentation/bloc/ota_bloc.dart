import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:config_app/features/ota/presentation/bloc/ota_client.dart';
import 'package:config_app/features/realtime/domain/services/realtime_service.dart';
import 'package:config_app/features/ota/presentation/bloc/ota_event.dart';
import 'package:config_app/features/ota/presentation/bloc/ota_state.dart';
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
    } catch (e) {
      _log.severe('Error uploading file: $e');
      emit(ErrorOtaState('Upload failed: $e'));
    }
  }

  void _onUploadProgress(UploadProgressOtaEvent event, Emitter<OtaState> emit) {
    if (state is UploadingOtaState) {
      emit(UploadingOtaState(
        progress: event.progress,
      ));
    }
  }

  void _onUploadComplete(UploadCompleteOtaEvent event, Emitter<OtaState> emit) {
    // Обработка завершения загрузки
    if (state is UploadingOtaState) {
      emit(UploadCompleteOtaState());
    }
  }

  void _onReset(ResetOtaEvent event, Emitter<OtaState> emit) {
    emit(const UninitializedOtaState());
  }
}
