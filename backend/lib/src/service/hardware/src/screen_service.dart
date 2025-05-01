import 'dart:async';
import 'dart:io' as io;
import 'package:dslideshow_backend/src/service/hardware/src/hardware_service_config.dart';
import 'package:logging/logging.dart';
import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart' as ffi;

class ScreenService {
  static final Logger _log = new Logger('ScreenService');
  static final KmsDrmService kmsDrmService = KmsDrmService();
  final HardwareConfig _config;

  // Property?
  bool isScreenOffLock = false;

  final _stateChangePreparation = new StreamController<bool>.broadcast();

  final Duration _preparationOffTime = const Duration(milliseconds: 2000);
  Stream<bool> get onStateChangePreparation => _stateChangePreparation.stream;

  ScreenService(this._config);
  Timer? _timerScreenOff;
  bool get isScreenOn => _screenOn;
  bool _screenOn = true;

  void screenOn() async {
    _log.info('screenOn');
    if (isScreenOffLock) {
      _log.info('"screenOn" is canceled because the screen is lock');
      return;
    }
    if (_timerScreenOff != null) {
      _timerScreenOff!.cancel();
      _timerScreenOff = null;
    }
    try {
      if (!_screenOn) {
        io.Process.run(_config.screenPowerOnScript, [], runInShell: true);
        if (kmsDrmService.isAvailable()) {
          // Turn on
          // kmsprint -p
          // DPMS (2) = 3 (Off) [On=0|Standby=1|Suspend=2|Off=3]
          kmsDrmService.setProperty(2, 0);
        }
        _screenOn = true;
        _stateChangePreparation.add(true);
      } else {
        _log.info('"screenOn" is skipped because the screen was turned on');
      }
    } catch (e, s) {
      _log.severe('screenOn', e, s);
    }
  }

  void scheduleScreenOff() {
    _log.info('scheduleScreenOff');
    if (_timerScreenOff != null) {
      _timerScreenOff!.cancel();
      _timerScreenOff = null;
    }
    _timerScreenOff = new Timer(new Duration(seconds: _config.screenPowerOnTimerSec), () {
      _timerScreenOff = null;
      screenOff();
    });
  }

  void screenOff() async {
    _log.info('screenOff');
    if (_timerScreenOff != null) {
      _timerScreenOff!.cancel();
      _timerScreenOff = null;
    }
    try {
      _stateChangePreparation.add(false);
      await Future<void>.delayed(_preparationOffTime);
      io.Process.run(_config.screenPowerOffScript, [], runInShell: true);
      if (kmsDrmService.isAvailable()) {
        // Turn off
        // kmsprint -p
        // DPMS (2) = 0 (On) [On=0|Standby=1|Suspend=2|Off=3]
        kmsDrmService.setProperty(2, 3);
      }
      _screenOn = false;
    } catch (e, s) {
      _log.severe('screenOff', e, s);
    }
  }
}

/*
uint32_t KMS_DRM_isAvailable();

void KMS_DRM_setProperty(uint32_t propId, uint64_t value) ;

uint64_t KMS_DRM_getProperty(uint32_t propId);
*/

typedef KMS_DRM_setPropertyFuncType = ffi.Void Function(ffi.Uint32 propId, ffi.Uint64 value);
typedef KMS_DRM_setPropertyType = void Function(int propId, int value);

typedef KMS_DRM_isAvailableFuncType = ffi.Uint32 Function();
typedef KMS_DRM_isAvailableType = int Function();

class KmsDrmService {
  final _KmsDrmService _service = _KmsDrmService.instance;
  bool isAvailable() {
    if (_service.KMS_DRM_isAvailable == null || _service.KMS_DRM_isAvailable!() == 0) {
      return false;
    }
    return true;
  }

  void setProperty(int propId, int value) {
    if (_service.KMS_DRM_setProperty == null) {
      return;
    }
    _service.KMS_DRM_setProperty!(propId, value);
  }
}

class _KmsDrmService {
  final KMS_DRM_setPropertyType? KMS_DRM_setProperty;
  final KMS_DRM_isAvailableType? KMS_DRM_isAvailable;
  _KmsDrmService._constructor({required this.KMS_DRM_setProperty, required this.KMS_DRM_isAvailable});

  factory _KmsDrmService._() {
    final lib = ffi.DynamicLibrary.process();

    try {
      final KMS_DRM_setPropertyLFunc = lib.lookupFunction<KMS_DRM_setPropertyFuncType, KMS_DRM_setPropertyType>("KMS_DRM_setProperty");
      final KMS_DRM_isAvailableLFunc = lib.lookupFunction<KMS_DRM_isAvailableFuncType, KMS_DRM_isAvailableType>("KMS_DRM_isAvailable");

      return _KmsDrmService._constructor(
        KMS_DRM_setProperty: KMS_DRM_setPropertyLFunc,
        KMS_DRM_isAvailable: KMS_DRM_isAvailableLFunc,
      );
    } on ArgumentError {
      return _KmsDrmService._constructor(
        KMS_DRM_setProperty: null,
        KMS_DRM_isAvailable: null,
      );
    }
  }

  static _KmsDrmService? _instance;

  static _KmsDrmService get instance {
    if (_instance == null) {
      _instance = _KmsDrmService._();
    }

    return _instance!;
  }
}
