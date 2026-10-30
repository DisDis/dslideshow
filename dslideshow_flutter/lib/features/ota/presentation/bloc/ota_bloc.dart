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

enum _FailureReturnCancellation { exit, newStatus, screenClosed, routeChanged, manualReturn, close }

class OtaBloc extends Bloc<OtaEvent, OtaState> {
  static final _log = Logger('OtaBloc');
  static const failureReturnDelay = Duration(seconds: 30);
  // Retained until the return event is handled or cancelled, even after firing.
  Timer? _failureReturnTimer;
  // Invalidates timer events already queued before cancellation or a new attempt.
  int _failureReturnGeneration = 0;
  String? _otaStartUrl;
  bool _isPreparingAddress = false;
  bool _exitRequested = false;
  bool _isClosing = false;
  Future<void>? _closeFuture;
  int _initializationVersion = 0;
  int _infoVersion = 0;
  final FrontendService frontendService;
  final TerminalBackend backend;
  final RouteBloc routeBloc;
  late final StreamSubscription<ButtonEvent> _onButtonSubscription;
  StreamSubscription<OTAInfo>? _onOTAInfoSubscription;
  StreamSubscription<String>? _onOTAOutputSubscription;
  StreamSubscription<bool>? _onOTAReadySubscription;
  StreamSubscription<RouteState>? _onRouteSubscription;

  OtaBloc({required this.frontendService, required this.backend, required this.routeBloc})
    : super(
        const OtaState.initial(
          info: OTAInfo(uploadingPercent: 0, status: OTAStatus.disabled, code: '-', errorText: '', exitCode: 0),
        ),
      ) {
    on<OtaInitializationEvent>(_initialization);
    on<OtaExitEvent>((event, emit) {
      if (_isClosing) return;
      _cancelFailureReturn(_FailureReturnCancellation.exit);
      _exitRequested = true;
      emit(OtaState.exit(info: state.info));
    });
    on<OtaUpdateInfoEvent>((event, emit) {
      if (_exitRequested || _isClosing) return;
      _infoVersion++;
      _observeConfirmedInfo(event.info);
      emit(_stateForInfo(event.info));
    });
    on<OtaReturnAfterFailureEvent>((event, emit) {
      if (_isClosing ||
          _exitRequested ||
          event.generation != _failureReturnGeneration ||
          state is! OtaFailureState ||
          routeBloc.isClosed ||
          routeBloc.state.current != RoutePage.ota) {
        return;
      }
      _failureReturnTimer?.cancel();
      _failureReturnTimer = null;
      _exitRequested = true;
      _log.info('event=failureReturnCompleted failureId=${event.generation}');
      routeBloc.add(ChangePageEvent(RoutePage.slideshow));
    });
    on<OtaAddTextToTerminalEvent>((event, emit) {
      if (_isClosing) return;
      backend.onWrite(event.message);
    });

    _onButtonSubscription = frontendService.onButtonEvent.listen(_pushButton);
    _onRouteSubscription = routeBloc.stream.listen((route) {
      if (route.current != RoutePage.ota) {
        _cancelFailureReturn(_FailureReturnCancellation.routeChanged);
      }
    });
  }

  Future<void> _initialization(OtaInitializationEvent event, Emitter<OtaState> emit) async {
    if (_exitRequested || _isClosing) return;
    final version = ++_initializationVersion;
    _isPreparingAddress = true;
    _otaStartUrl = null;
    _onOTAInfoSubscription ??= frontendService.onOTAInfo.listen((info) {
      if (_isClosing || _exitRequested) return;
      // Invalidate the snapshot before this queued event is handled.
      _infoVersion++;
      if (info.status != OTAStatus.issue) {
        _cancelFailureReturn(_FailureReturnCancellation.newStatus);
      }
      add(OtaEvent.updateInfo(info));
    });
    _onOTAOutputSubscription ??= frontendService.onOTAOutput.listen((output) {
      if (_isClosing) return;
      backend.onWrite(output);
    });
    _onOTAReadySubscription ??= frontendService.onOTAReady.listen((ready) {
      if (!ready && !_isClosing) {
        _cancelFailureReturn(_FailureReturnCancellation.screenClosed);
        _exitRequested = true;
        add(const OtaEvent.exit());
      }
    });
    if (state case final OtaReadyState ready) {
      emit(ready.copyWith(otaStartUrl: null, isPreparingAddress: true));
    }
    await Future.wait([_loadInfo(version, _infoVersion, emit), _loadAddress(version, emit)]);
  }

  Future<void> _loadInfo(int version, int infoVersion, Emitter<OtaState> emit) async {
    try {
      final info = await frontendService.getOTAInfo();
      if (_canInitialize(version, emit) && infoVersion == _infoVersion) {
        _observeConfirmedInfo(info);
        emit(_stateForInfo(info));
      }
    } catch (error) {
      _log.warning('event=infoFailed type=${error.runtimeType}');
      if (_canInitialize(version, emit) && infoVersion == _infoVersion) {
        emit(OtaState.failure(info: state.info.copyWith(status: OTAStatus.issue, errorText: null, exitCode: null)));
      }
    }
  }

  Future<void> _loadAddress(int version, Emitter<OtaState> emit) async {
    String? address;
    try {
      final systemInfo = await frontendService.getSystemInfo();
      final interface = systemInfo.networkInfo.getCurrentInterface();
      address = 'http://${interface.ip4}:8282/ota_start';
    } catch (error) {
      _log.info('event=addressFailed type=${error.runtimeType}');
    }
    if (!_canInitialize(version, emit)) return;
    _isPreparingAddress = false;
    _otaStartUrl = address;
    if (state case final OtaReadyState ready) {
      emit(ready.copyWith(otaStartUrl: address, isPreparingAddress: false));
    }
  }

  bool _canInitialize(int version, Emitter<OtaState> emit) =>
      !_isClosing && !isClosed && !_exitRequested && !emit.isDone && version == _initializationVersion;

  OtaState _stateForInfo(OTAInfo info) => switch (info.status) {
    OTAStatus.uploading || OTAStatus.instaling => OtaState.progress(info: info),
    OTAStatus.preReboot || OTAStatus.finished => OtaState.success(info: info),
    OTAStatus.issue => OtaState.failure(info: info),
    OTAStatus.disabled ||
    OTAStatus.ready => OtaState.ready(info: info, otaStartUrl: _otaStartUrl, isPreparingAddress: _isPreparingAddress),
  };

  void _observeConfirmedInfo(OTAInfo info) {
    if (info.status != OTAStatus.issue) {
      _cancelFailureReturn(_FailureReturnCancellation.newStatus);
      return;
    }
    if (_failureReturnTimer != null || routeBloc.isClosed || routeBloc.state.current != RoutePage.ota) {
      return;
    }
    final generation = ++_failureReturnGeneration;
    _log.info('event=failureReturnScheduled failureId=$generation delayMs=${failureReturnDelay.inMilliseconds}');
    _failureReturnTimer = Timer(failureReturnDelay, () {
      if (_isClosing || _exitRequested || isClosed) return;
      add(OtaEvent.returnAfterFailure(generation));
    });
  }

  void _cancelFailureReturn(_FailureReturnCancellation reason) {
    if (_failureReturnTimer == null) return;
    final generation = _failureReturnGeneration;
    _failureReturnTimer?.cancel();
    _failureReturnTimer = null;
    _failureReturnGeneration++;
    _log.info('event=failureReturnCancelled failureId=$generation reason=${reason.name}');
  }

  void _pushButton(ButtonEvent event) {
    if (_isClosing || event.event != ButtonEventType.released || event.button != ButtonType.button0) {
      return;
    }
    if (!state.canReturnToSlideshow) {
      _log.fine('Back ignored while OTA status=${state.info.status.name}');
      return;
    }
    _cancelFailureReturn(_FailureReturnCancellation.manualReturn);
    _exitRequested = true;
    _log.info('Returning from OTA status=${state.info.status.name}');
    routeBloc.add(ChangePageEvent(RoutePage.slideshow));
  }

  @override
  Future<void> close() => _closeFuture ??= _close().whenComplete(() => super.close());

  Future<void> _close() async {
    _isClosing = true;
    _cancelFailureReturn(_FailureReturnCancellation.close);
    _initializationVersion++;
    await Future.wait([
      if (_onOTAReadySubscription case final subscription?) subscription.cancel(),
      if (_onOTAInfoSubscription case final subscription?) subscription.cancel(),
      if (_onOTAOutputSubscription case final subscription?) subscription.cancel(),
      _onButtonSubscription.cancel(),
      if (_onRouteSubscription case final subscription?) subscription.cancel(),
    ]);
  }
}
