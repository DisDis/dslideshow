import 'package:dslideshow_backend/src/service/system_info/os_type.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'os_info.g.dart';
part 'os_info.freezed.dart';

@freezed
sealed class OSInfo with _$OSInfo {
  //String kernelVersion = "Linux raspberrypi 4.19.97-v7l+ #1294 SMP Thu Jan 30 13:21:14 GMT 2020 armv7l GNU/Linux";

  const factory OSInfo({
    required String name,
    required OSType osType,
  }) = _OSInfo;

  factory OSInfo.fromJson(Map<String, dynamic> json) => _$OSInfoFromJson(json);
}
