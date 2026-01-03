import 'package:freezed_annotation/freezed_annotation.dart';

part 'power_event.freezed.dart';

@freezed
class PowerEvent with _$PowerEvent {
  const factory PowerEvent.restartApp() = RestartAppPowerEvent;
  const factory PowerEvent.powerOff() = PowerOffPowerEvent;
  const factory PowerEvent.load() = LoadPowerEvent;
}
