import 'dart:async';

import 'package:dslideshow_backend/src/service/mqtt/mqtt_service.dart';
import 'package:dslideshow_backend/src/service/slideshow/slideshow_config.dart';
import 'package:logging/logging.dart';

import 'gpio_service.dart';
import 'screen_service.dart';

/// Owns device-event subscriptions within the existing backend isolate.
///
/// The caller owns the services, frontend RPCs and screen-notification queue.
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
  }) {
    _subscriptions.add(
      gpioService.onButtonEvent.listen((event) {
        logger.info('onButtonEvent button${event.button.index} = $event');
        onButtonEvent(event);
      }),
    );
    _subscriptions.add(
      screenService.onStateChangePreparation.listen(onScreenPreparation),
    );
    _subscriptions.add(
      gpioService.onMotion.listen((event) {
        logger.info('Motion = $event');
        if (event) {
          unawaited(screenService.screenOn());
        } else {
          screenService.scheduleScreenOff();
        }
      }),
    );
    _subscriptions.add(
      mqttService.onPause.listen((event) {
        logger.info('MQTT: onPause, $event');
        onAction(SlideshowAction.pause, event);
      }),
    );
    _subscriptions.add(
      mqttService.onScreen.listen((event) {
        logger.info('MQTT: onScreenToggle, $event');
        // Preserve the frontend toggleScreen action's inverted value.
        onAction(SlideshowAction.toggleScreen, !event);
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
  Future<void>? _disposeFuture;

  Future<void> dispose() => _disposeFuture ??= _dispose();

  Future<void> _dispose() async {
    await Future.wait(
      _subscriptions.map((subscription) => subscription.cancel()),
    );
  }
}
