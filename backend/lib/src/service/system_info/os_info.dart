import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'os_info.g.dart';

abstract class OSInfo implements Built<OSInfo, OSInfoBuilder> {
  //String kernelVersion = "Linux raspberrypi 4.19.97-v7l+ #1294 SMP Thu Jan 30 13:21:14 GMT 2020 armv7l GNU/Linux";
  String get name;

  static Serializer<OSInfo> get serializer =>
      _$oSInfoSerializer;

  factory OSInfo([void updates(OSInfoBuilder b)]) = _$OSInfo;
  OSInfo._();
}