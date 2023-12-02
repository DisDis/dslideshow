import 'package:dslideshow_backend/command.dart';
import 'package:equatable/equatable.dart';

abstract class WifiTabState extends Equatable {
  const WifiTabState();

  @override
  List<Object> get props => [];
}

/// UnInitialized
class UnWifiTabState extends WifiTabState {
  const UnWifiTabState();

  @override
  String toString() => 'UnWifiTabState';
}

/// Initialized
class InWifiTabState extends WifiTabState {
  const InWifiTabState({required this.availableNetworks, required this.storedNetworks});

  final Iterable<WiFiNetworkInfo> availableNetworks;
  final Iterable<WiFiStoredNetworkInfo> storedNetworks;

  @override
  String toString() => 'InWifiTabState $availableNetworks, $storedNetworks';

  @override
  List<Object> get props => [availableNetworks, storedNetworks];
}

class ErrorWifiTabState extends WifiTabState {
  const ErrorWifiTabState(this.errorMessage);

  final String errorMessage;

  @override
  String toString() => 'ErrorWifiTabState';

  @override
  List<Object> get props => [errorMessage];
}