import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_flutter/features/ota/presentation/bloc/ota_event.dart';
import 'package:dslideshow_flutter/features/ota/presentation/bloc/ota_state.dart';
import 'package:dslideshow_flutter/features/ota/presentation/bloc/terminal_backend.dart';
import 'package:dslideshow_flutter/src/route_bloc.dart';
import 'package:dslideshow_flutter/src/service/frontend.dart';

class OtaBloc extends Bloc<OtaEvent, OtaState> {
  final FrontendService frontendService;
  final TerminalBackend backend;
  final RouteBloc routeBloc;
  StreamSubscription? _onPushSubscription;

  OtaBloc({required this.frontendService, required this.backend, required this.routeBloc})
      : super(const OtaState.initial(
            info: OTAInfo(
          uploadingPercent: 0,
          status: OTAStatus.disabled,
          code: '-',
          errorText: '',
          exitCode: 0,
        ))) {
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

    _onPushSubscription = frontendService.onPushButton.listen(_pushButton);
  }

  Future<void> _initialization(OtaEvent event, Emitter<OtaState> emit) async {
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

  void _pushButton(ButtonType event) {
    if (event == ButtonType.button0 && state is OtaReadyState) {
      routeBloc.add(ChangePageEvent(RoutePage.slideshow));
    }
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
    _onPushSubscription?.cancel();
    _onPushSubscription = null;
    return super.close();
  }
}
