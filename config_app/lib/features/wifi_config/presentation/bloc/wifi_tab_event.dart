abstract class WifiTabEvent {
  // Stream<WifiTabState> applyAsync({WifiTabState currentState, WifiTabBloc bloc});
}

class UnWifiTabEvent extends WifiTabEvent {
  // @override
  // Stream<WifiTabState> applyAsync({WifiTabState? currentState, WifiTabBloc? bloc}) async* {
  //   yield UnWifiTabState();
  // }
}

class LoadWifiTabEvent extends WifiTabEvent {
  // @override
  // Stream<WifiTabState> applyAsync({WifiTabState? currentState, WifiTabBloc? bloc}) async* {
  //   try {
  //     yield UnWifiTabState();
  //     await Future.delayed(const Duration(seconds: 10));
  //     yield InWifiTabState('Hello world');
  //   } catch (_, stackTrace) {
  //     developer.log('$_', name: 'LoadWifiTabEvent', error: _, stackTrace: stackTrace);
  //     yield ErrorWifiTabState(_.toString());
  //   }
  // }
}

class AddWifiTabEvent extends WifiTabEvent {
  final String SSID;
  final String psk;
  AddWifiTabEvent(this.SSID, this.psk);
}

class RemoveWifiTabEvent extends WifiTabEvent {
  final int wifiId;
  RemoveWifiTabEvent(this.wifiId);
}

class EnableWifiTabEvent extends WifiTabEvent {
  final int wifiId;
  final bool value;
  EnableWifiTabEvent(this.wifiId, this.value);
}
