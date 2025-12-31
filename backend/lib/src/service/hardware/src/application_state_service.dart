import 'dart:async';

import 'package:dslideshow_backend/src/service/hardware/hardware.dart';
import 'package:dslideshow_backend/src/service/hardware/src/gpio_service.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'application_state_service.freezed.dart';

class ApplicationStateService {
  final StreamController<ApplicationState> _scApplicationState =
      new StreamController.broadcast();
  Stream<ApplicationState> get onChangedState => _scApplicationState.stream;
  ApplicationState _state = ApplicationState();
  ApplicationState get state => _state;
  // Timer to manage debounce duration
  Timer? _debounce;
  final ScreenService screenService;
  final GPIOService gpioService;

  ApplicationStateService({
    required this.screenService,
    required this.gpioService,
  }) {
    screenService.onStateChangePreparation.listen(_onScreenChanged);
    gpioService.onMotion.listen(_onMotion);
  }

  update(ApplicationState newState) {
    _state = newState;

    // Cancel the previous timer
    if (_debounce?.isActive ?? false) {
      _debounce!.cancel();
    }

    // Setup a new timer
    _debounce = Timer(Duration(milliseconds: 500), () {
      // Add the current value to stream
      _scApplicationState.add(_state);
    });
  }

  void _onScreenChanged(bool value) {
    update(state.copyWith(isScreenOn: value));
  }

  void _onMotion(bool value) {
    update(state.copyWith(isMotion: value));
  }
}

@freezed
sealed class ApplicationState with _$ApplicationState {
  const factory ApplicationState({
    @Default(true) bool hasInternet,
    @Default(true) bool isScreenOn,
    // @Default(StorageStatusEnum.done) StorageStatusEnum storageStatus,
    @Default(false) bool isMenu,
    // @Default(false) bool isInfo,
    @Default(false) bool isPaused,
    @Default(true) bool isMotion,
  }) = _ApplicationState;
}
