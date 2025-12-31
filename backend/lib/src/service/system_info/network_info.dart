import 'package:freezed_annotation/freezed_annotation.dart';

part 'network_info.g.dart';
part 'network_info.freezed.dart';

@freezed
sealed class NetworkInfo with _$NetworkInfo {
  const factory NetworkInfo({
    required int lastUpdate,
    required bool hasInternet,
    required List<NetworkInterfaceInfo>? interfaces,
  }) = _NetworkInfo;

  factory NetworkInfo.fromJson(Map<String, dynamic> json) =>
      _$NetworkInfoFromJson(json);
}

@freezed
sealed class NetworkInterfaceInfo with _$NetworkInterfaceInfo {
  const factory NetworkInterfaceInfo({
    required String name,
    required NetworkInterfaceStatus status,
    required String ip4,
    required String ip6,
  }) = _NetworkInterfaceInfo;

  factory NetworkInterfaceInfo.fromJson(Map<String, dynamic> json) =>
      _$NetworkInterfaceInfoFromJson(json);
}

enum NetworkInterfaceStatus { running, offline }
