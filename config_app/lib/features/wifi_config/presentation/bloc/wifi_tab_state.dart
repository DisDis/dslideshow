import 'package:dslideshow_backend/command.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'wifi_tab_state.freezed.dart';

@freezed
class WifiTabState with _$WifiTabState {
  const factory WifiTabState.uninitialized() = UnWifiTabState;
  const factory WifiTabState.initialized({
    required Iterable<WiFiNetworkInfo> availableNetworks,
    required Iterable<WiFiStoredNetworkInfo> storedNetworks,
  }) = InWifiTabState;
  const factory WifiTabState.error(String errorMessage) = ErrorWifiTabState;
}
