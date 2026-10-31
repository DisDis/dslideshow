import 'dart:async';

import 'package:dslideshow_backend/src/service/hardware/src/screen_service.dart';
import 'package:dslideshow_backend/src/service/hardware/src/gpio_service.dart';
import 'package:dslideshow_backend/src/service/storage/storage.dart';
import 'package:dslideshow_common/application_state.dart';
import 'package:logging/logging.dart';

export 'package:dslideshow_common/application_state.dart';

class ApplicationStateService {
  static final _log = Logger('ApplicationStateService');
  final StreamController<ApplicationState> _scApplicationState = new StreamController.broadcast();
  Stream<ApplicationState> get onChangedState => _scApplicationState.stream;
  ApplicationState _state;
  ApplicationState get state => _state;
  // Keep MQTT's existing initial isMotion value. Telemetry remains unknown until
  // GPIO has actually reported a sample, rather than inferring presence at boot.
  bool? get observedPresence => _observedPresence;
  bool? _observedPresence;
  DateTime? get presenceObservedAt => _presenceObservedAt;
  DateTime? _presenceObservedAt;
  // Timer to manage debounce duration
  Timer? _debounce;
  final _subscriptions = <StreamSubscription<dynamic>>[];
  bool _disposed = false;
  Future<void>? _disposeFuture;
  final ScreenService screenService;
  final GPIOService gpioService;
  final Storage storage;

  ApplicationStateService({required this.screenService, required this.gpioService, required this.storage})
    : _state = ApplicationState(storageStatus: storage.status) {
    _subscriptions.add(screenService.onStateChangePreparation.listen(_onScreenChanged));
    _subscriptions.add(gpioService.onMotion.listen(_onMotion));
    _subscriptions.add(storage.onStatusChanged.listen(_onStorageChanged));
  }

  void update(ApplicationState newState) {
    if (_disposed) return;
    _state = newState;

    // Cancel the previous timer
    if (_debounce?.isActive ?? false) {
      _debounce!.cancel();
    }

    // Setup a new timer
    _debounce = Timer(Duration(milliseconds: 500), () {
      _debounce = null;
      _scApplicationState.add(_state);
      _log.fine('Application state published storageStatus=${_state.storageStatus.name}');
    });
  }

  void _onStorageChanged(StorageStatusEnum status) {
    if (_disposed || status == _state.storageStatus) return;
    update(_state.copyWith(storageStatus: status));
  }

  void _onScreenChanged(bool value) {
    update(state.copyWith(isScreenOn: value));
  }

  void _onMotion(bool value) {
    if (_disposed) return;
    _observedPresence = value;
    _presenceObservedAt = DateTime.now().toUtc();
    update(state.copyWith(isMotion: value));
  }

  Future<void> dispose() => _disposeFuture ??= _dispose();

  Future<void> _dispose() async {
    _disposed = true;
    _debounce?.cancel();
    await Future.wait(_subscriptions.map((subscription) => subscription.cancel()));
    await _scApplicationState.close();
  }
}
