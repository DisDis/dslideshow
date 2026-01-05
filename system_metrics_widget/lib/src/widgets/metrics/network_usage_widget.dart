import 'package:dslideshow_backend/command.dart';
import 'package:flutter/material.dart';
import 'package:system_metrics_widget/src/environment/settings.dart';
import 'package:system_metrics_widget/src/widgets/metrics/common/metrics_container_widget.dart';

class NetworkUsageWidget extends StatelessWidget {
  final NetworkInfo model;

  const NetworkUsageWidget({required this.model, super.key});

  @override
  Widget build(BuildContext context) {
    // Фильтруем интерфейсы (убираем Loopback и пустые)
    final activeInterfaces = model.interfaces?.where((interface) {
      return interface.status == NetworkInterfaceStatus.running &&
          interface.name != 'lo' &&
          interface.name != 'lo0' &&
          interface.ip4.isNotEmpty;
    }).toList() ?? [];

    return MetricsContainerWidget(
      // Общая иконка статуса сети
      iconData: model.hasInternet 
          ? Icons.public : Icons.public_off,
      // Яркий цвет если есть интернет, красный/серый если нет
      iconColor: model.hasInternet ? Colors.greenAccent : Colors.redAccent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Если интерфейсов нет, пишем статус
          if (activeInterfaces.isEmpty)
             Text(
               "NO ACTIVE CONNECTION",
               style: Settings.networkNoConnectionTextStyle,
             ),

          // Список интерфейсов
          for (int i = 0; i < activeInterfaces.length; i++) ...[
            // Добавляем разделитель между интерфейсами, но не перед первым
            if (i > 0) 
              Divider(height: 12, color: Colors.white.withOpacity(0.1)),
              
            _buildInterfaceRow(activeInterfaces[i]),
          ]
        ],
      ),
    );
  }

  Widget _buildInterfaceRow(NetworkInterfaceInfo interface) {
    // Определяем иконку по имени интерфейса (wlan0 -> wifi, eth0 -> кабель)
    final bool isWifi = interface.name.toLowerCase().startsWith('w');
    final IconData typeIcon = isWifi 
        ? Icons.wifi 
        : Icons.settings_ethernet; // Или Icons.cable

    return Row(
      children: [
        // 1. Иконка типа подключения (маленькая и тусклая)
        Icon(typeIcon, color: Colors.white38, size: 14),
        
        const SizedBox(width: 8),
        
        // 2. Данные
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Имя интерфейса (мелко, как label)
              Text(
                interface.name.toUpperCase(),
                style: Settings.networkInterfaceNameTextStyle,
              ),
              // IP Адрес (Крупно, Моноширинно, Ярко)
              Text(
                interface.ip4,
                style: Settings.networkIpAddressTextStyle,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
