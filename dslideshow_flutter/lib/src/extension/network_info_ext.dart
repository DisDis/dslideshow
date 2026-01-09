import 'package:dslideshow_backend/command.dart';

extension NetworkInfoExt on NetworkInfo {
  NetworkInterfaceInfo getCurrentInterface() {
    final interface = interfaces!.firstWhere(
        (item) =>
            item.status == NetworkInterfaceStatus.running &&
            item.ip4.isNotEmpty &&
            !item.ip4.startsWith('127.'),
      );
      return interface;
  }
}

extension NetworkInterfaceInfoExt on NetworkInterfaceInfo {
  // Определяем иконку по имени интерфейса (wlan0 -> wifi, eth0 -> кабель)
 bool get isWifi => name.toLowerCase().startsWith('w');
}
