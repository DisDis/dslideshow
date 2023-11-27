import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_flutter/src/page/ota/ota_event.dart';
import 'package:dslideshow_flutter/src/page/ota/ota_page.dart';
import 'package:dslideshow_flutter/src/page/ota/ota_state.dart';
import 'package:dslideshow_flutter/src/service/frontend.dart';
/*
class OtaBloc extends Bloc<OtaEvent, OtaState> {
  final FrontendService frontendService;
  final ProcessTerminalBackend backend;
  OtaBloc({required this.frontendService, required this.backend})
      : super(OtaState.initial(info: OTAInfo((b) {
          b.uploadingPercent = 0;
          b.status = OTAStatus.disabled;
          b.code = '-';
          b.errorText = '';
          b.exitCode = 0;
        }))) {
    on<OtaInitializationEvent>(_initialization);
    on<OtaExitEvent>((event, emit) {
      emit(OtaState.exit(info: state.info));
    });
    on<OtaTerminalUpdateEvent>((event, emit) {
      emit(state);
    });
    on<OtaUpdateInfoEvent>((event, emit) {
      if (event.info.status != state.info.status) {
        switch (event.info.status) {
          case OTAStatus.uploading:
          case OTAStatus.instaling:
            emit(OtaState.progress(info: event.info));
            break;
          case OTAStatus.preReboot:
          case OTAStatus.finished:
            emit(OtaState.success(info: event.info));
            break;
          case OTAStatus.issue:
            emit(OtaState.failure(info: event.info));
            break;
          case OTAStatus.disabled:
          case OTAStatus.ready:
          default:
            emit(OtaState.ready(info: event.info));
        }
      } else {
        emit(state.copyWith(info: event.info));
      }
    });

    // on<OtaStartEvent>((event, emit) {
    //   return emit.forEach<OtaState>(
    //     event.applyAsync(currentState: state, bloc: this),
    //     onData: (state) => state,
    //     onError: (error, stackTrace) {
    //       developer.log('$error', name: 'OtaBloc', error: error, stackTrace: stackTrace);
    //       return ErrorOtaState(error.toString());
    //     },
    //   );
    // });
  }

  FutureOr<void> _initialization(OtaEvent event, Emitter<OtaState> emit) async {
    _onOTAInfoSubscription?.cancel();
    _onOTAInfoSubscription = frontendService.onOTAInfo.listen((info) {
      add(OtaEvent.updateInfo(info));
    });
    _onOTAOutputSubscription?.cancel();
    _onOTAOutputSubscription = frontendService.onOTAOutput.listen((event) {
      backend.onWrite(event);
      add(const OtaEvent.terminalUpdate());
    });
    _onOTAReadySubscription = frontendService.onOTAReady.listen((value) {
      if (!value) {
        add(const OtaEvent.exit());
      }
    });
    var info = await frontendService.getOTAInfo();
    await Future<void>.delayed(const Duration(microseconds: 1000));
    emit(OtaState.ready(info: info));
  }

  StreamSubscription? _onOTAInfoSubscription;
  StreamSubscription? _onOTAOutputSubscription;
  StreamSubscription? _onOTAReadySubscription;

  @override
  Future<void> close() {
    _onOTAReadySubscription?.cancel();
    _onOTAInfoSubscription?.cancel();
    _onOTAInfoSubscription = null;
    _onOTAOutputSubscription?.cancel();
    _onOTAOutputSubscription = null;
    return super.close();
  }
}

class OtaRepository {
  FrontendService _frontendService;
  OtaRepository({
    required FrontendService frontendService,
  }) : _frontendService = frontendService;

  Stream<OTAInfo> get onOTAInfo => _frontendService.onOTAInfo;
}
*/