import 'dart:async';

import 'package:dslideshow_backend/src/service/mqtt/mqtt_service.dart';
import 'package:dslideshow_backend/src/service/slideshow/slideshow_config.dart';
import 'package:logging/logging.dart';

import 'gpio_service.dart';
import 'screen_service.dart';
import 'night_mode_policy.dart';

/// Owns device-event subscriptions within the existing backend isolate.
///
/// The caller owns the services and frontend RPCs.
/// Disposing the bindings only detaches the subscriptions.
class DeviceEventBindings {
  DeviceEventBindings({
    required GPIOService gpioService,
    required MqttService mqttService,
    required ScreenService screenService,
    required void Function(ButtonEvent) onButtonEvent,
    required void Function(bool) onScreenPreparation,
    required void Function(SlideshowAction, bool) onAction,
    required Logger logger,
    required NightModePolicy nightMode,
  }) {
    _subscriptions.add(
      gpioService.onButtonEvent.listen((event) {
        logger.info('onButtonEvent button${event.button.index} = $event');
        onButtonEvent(event);
      }),
    );
    _subscriptions.add(screenService.onStateChangePreparation.listen(onScreenPreparation));
    _subscriptions.add(
      gpioService.onMotion.listen((event) {
        logger.info('Motion = $event');
        screenService.onPresence(event);
      }),
    );
    nightMode.updateAvailability(mqttService.isAmbientLightAvailable);
    _subscriptions.add(mqttService.onAmbientLight.listen(nightMode.updateLight));
    _subscriptions.add(mqttService.onAmbientLightAvailability.listen(nightMode.updateAvailability));
    _subscriptions.add(
      mqttService.onPause.listen((event) {
        logger.info('MQTT: onPause, $event');
        onAction(SlideshowAction.pause, event);
      }),
    );
    _subscriptions.add(
      mqttService.onScreen.listen((event) {
        logger.info('MQTT: screen enabled=$event');
        unawaited(event ? screenService.screenOn() : screenService.screenOff());
      }),
    );
    _subscriptions.add(
      mqttService.onAutoWake.listen((enabled) {
        logger.info('MQTT: auto wake enabled=$enabled');
        screenService.autoWakeEnabled = enabled;
      }),
    );
    _subscriptions.add(
      mqttService.onMenu.listen((event) {
        logger.info('MQTT: onMenu, $event');
        onAction(SlideshowAction.showMenu, event);
      }),
    );
  }

  final _subscriptions = <StreamSubscription<dynamic>>[];
  Future<void> dispose() async {
    await Future.wait(_subscriptions.map((subscription) => subscription.cancel()));
  }
}
