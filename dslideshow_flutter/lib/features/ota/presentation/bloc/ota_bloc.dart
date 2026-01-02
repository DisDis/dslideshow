import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_flutter/features/ota/presentation/bloc/ota_event.dart';
import 'package:dslideshow_flutter/features/ota/presentation/bloc/ota_state.dart';
import 'package:dslideshow_flutter/features/ota/presentation/bloc/terminal_backend.dart';
import 'package:dslideshow_flutter/src/extension/network_info_ext.dart';
import 'package:dslideshow_flutter/src/route_bloc.dart';
import 'package:dslideshow_flutter/src/service/frontend.dart';
import 'package:logging/logging.dart';

class OtaBloc extends Bloc<OtaEvent, OtaState> {
  static final _log = Logger('OtaBloc');
  String otaStartUrl = 'http://127.0.0.1:8282/ota_start';
  final FrontendService frontendService;
  final TerminalBackend backend;
  final RouteBloc routeBloc;
  late StreamSubscription<ButtonEvent> _onButtonSubscription;

  OtaBloc({
    required this.frontendService,
    required this.backend,
    required this.routeBloc,
  }) : super(
         const OtaState.initial(
           info: OTAInfo(
             uploadingPercent: 0,
             status: OTAStatus.disabled,
             code: '-',
             errorText: '',
             exitCode: 0,
           ),
         ),
       ) {
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
            emit(OtaState.ready(info: event.info, otaStartUrl: otaStartUrl));
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

    _onButtonSubscription = frontendService.onButtonEvent.listen(_pushButton);
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
    _onOTAReadySubscription?.cancel();
    _onOTAReadySubscription = frontendService.onOTAReady.listen((value) {
      if (!value) {
        add(const OtaEvent.exit());
      }
    });
    final info = await frontendService.getOTAInfo();
    final fTmp = Future<void>.delayed(const Duration(microseconds: 1000));
    try {
      final systemInfo = await frontendService.getSystemInfo();
      final interface = systemInfo.networkInfo.getCurrentInterface();
      otaStartUrl = "http://${interface.ip4}:8282/ota_start";
    } catch (_) {
      _log.info("Error getting network info");
    }
    await fTmp;
    emit(OtaState.ready(info: info, otaStartUrl: otaStartUrl));
  }

  void _pushButton(ButtonEvent event) {
    if (event.event == ButtonEventType.released &&
        event.button == ButtonType.button0 &&
        state is OtaReadyState) {
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
    _onButtonSubscription.cancel();
    return super.close();
  }
}
