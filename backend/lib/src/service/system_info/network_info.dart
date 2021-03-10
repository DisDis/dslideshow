import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:built_collection/built_collection.dart';

part 'network_info.g.dart';

abstract class NetworkInfo implements Built<NetworkInfo, NetworkInfoBuilder> {
  int get lastUpdate;
  bool get hasInternet;
  BuiltList<NetworkInterfaceInfo>? get interfaces;

  static Serializer<NetworkInfo> get serializer =>
      _$networkInfoSerializer;

  factory NetworkInfo([void updates(NetworkInfoBuilder b)?]) = _$NetworkInfo;
  NetworkInfo._();
}

abstract class NetworkInterfaceInfo implements Built<NetworkInterfaceInfo, NetworkInterfaceInfoBuilder> {
  String get name;
  NetworkInterfaceStatus get status;

  String? get ip4;
  String? get ip6;

  static Serializer<NetworkInterfaceInfo> get serializer =>
      _$networkInterfaceInfoSerializer;

  factory NetworkInterfaceInfo([void updates(NetworkInterfaceInfoBuilder b)]) = _$NetworkInterfaceInfo;
  NetworkInterfaceInfo._();
}

class NetworkInterfaceStatus extends EnumClass {
  static Serializer<NetworkInterfaceStatus> get serializer => _$networkInterfaceStatusSerializer;

  static const NetworkInterfaceStatus running = _$running;
  static const NetworkInterfaceStatus offline = _$offline;


  const NetworkInterfaceStatus._(String name) : super(name);

  static BuiltSet<NetworkInterfaceStatus> get values => _$valuesNetStatus;
  static NetworkInterfaceStatus valueOf(String name) => _$valueNetStatusOf(name);
}