import 'package:freezed_annotation/freezed_annotation.dart';

part 'web_tab_event.freezed.dart';

@freezed
class WebTabEvent with _$WebTabEvent {
  const factory WebTabEvent.restartApp() = RestartAppWebTabEvent;
  const factory WebTabEvent.powerOff() = PowerOffWebTabEvent;
  const factory WebTabEvent.load() = LoadWebTabEvent;
}
