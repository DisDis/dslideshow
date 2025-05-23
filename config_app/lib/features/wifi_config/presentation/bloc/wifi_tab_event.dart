import 'package:freezed_annotation/freezed_annotation.dart';
part 'wifi_tab_event.freezed.dart';

@freezed
class WifiTabEvent with _$WifiTabEvent {
  const factory WifiTabEvent() = _WifiTabEvent;
  const factory WifiTabEvent.uninitialized() = UnWifiTabEvent;
  const factory WifiTabEvent.load() = LoadWifiTabEvent;
  // ignore: non_constant_identifier_names
  const factory WifiTabEvent.add(String name, String SSID, String psk) = AddWifiTabEvent;
  const factory WifiTabEvent.remove(String connectionId) = RemoveWifiTabEvent;
  const factory WifiTabEvent.enable(String connectionId, bool value) = EnableWifiTabEvent;
}
