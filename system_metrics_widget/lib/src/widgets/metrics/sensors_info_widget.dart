import 'package:dslideshow_backend/command.dart';
import 'package:flutter/material.dart';
import 'package:system_metrics_widget/src/environment/settings.dart';
import 'package:system_metrics_widget/src/widgets/metrics/common/metrics_container_widget.dart';

class SensorsInfoWidget extends StatelessWidget {
  const SensorsInfoWidget({required this.model, super.key});
  final UpdateInfo model;

  @override
  Widget build(BuildContext context) {
    return MetricsContainerWidget(
      iconData: Icons.sensors, // Или Icons.developer_board
      iconColor: Colors.tealAccent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Заголовок (опционально, если иконки недостаточно)
          /*
          const Text(
            "SENSORS",
            style: TextStyle(color: Colors.white38, fontSize: 10, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          */

          // Список датчиков
          for (int i = 0; i < model.sensors.length; i++) ...[
            if (i > 0) 
              Divider(height: 12, color: Colors.white.withOpacity(0.1)),
            _buildSensorRow(model.sensors[i]),
          ],
        ],
      ),
    );
  }

  Widget _buildSensorRow(SensorInfo sensor) {
    final name = sensor.name.toUpperCase();
    final valueStr = sensor.value;

    // 1. ОПРЕДЕЛЯЕМ ТИП ДАННЫХ

    // Проверка на бинарный датчик (true/false, on/off)
    final lowerVal = valueStr.toLowerCase();
    if (lowerVal == 'true' || lowerVal == 'false' || lowerVal == 'on' || lowerVal == 'off') {
      final bool isActive = lowerVal == 'true' || lowerVal == 'on';
      return _buildBinaryRow(name, isActive);
    }

    // Проверка на температуру (содержит 'C, C, F)
    // Обычно формат "61.3'C" или "61.3"
    if (valueStr.contains("'C") || valueStr.contains("°C") || valueStr.contains("C")) {
      return _buildNumericRow(name, valueStr, unit: "°C", valueColor: Colors.orangeAccent);
    }
    
    // Проверка на вентилятор (RPM)
    if (lowerVal.contains("rpm")) {
      return _buildNumericRow(name, valueStr.replaceAll(RegExp(r'[a-zA-Z]'), ''), unit: "RPM", valueColor: Colors.greenAccent);
    }

    // Проверка на Motion/Detect (Датчики движения часто шлют "detected" или "motion")
    if (lowerVal.contains("motion") || lowerVal.contains("detected")) {
      return _buildAlertRow(name, valueStr);
    }

    // Дефолтный вывод (просто текст)
    return _buildGenericRow(name, valueStr);
  }

  // --- ВАРИАНТЫ ОТОБРАЖЕНИЯ ---

  // 1. Для температур и оборотов: "CPU TEMP ...... 61.5 °C"
  Widget _buildNumericRow(String name, String rawValue, {required String unit, required Color valueColor}) {
    // Пытаемся вытащить чистое число для красивого форматирования
    // "61.3'C" -> "61.3"
    final cleanValue = rawValue.replaceAll(RegExp(r"[^0-9\.]"), "");
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Имя датчика
        Expanded(
          child: Text(
            name,
            style: Settings.sensorNameTextStyle,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        // Значение
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              cleanValue,
              style: Settings.sensorValueTextStyle(valueColor),
            ),
            const SizedBox(width: 2),
            Text(
              unit,
              style: Settings.sensorUnitTextStyle(valueColor),
            ),
          ],
        ),
      ],
    );
  }

  // 2. Для бинарных: "BUTTON ...... [ON]" (с "лампочкой")
  Widget _buildBinaryRow(String name, bool isActive) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            name,
            style: Settings.sensorNameTextStyle,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: isActive ? Colors.green.withOpacity(0.2) : Colors.white10,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              color: isActive ? Colors.green : Colors.white24,
              width: 1
            ),
          ),
          child: Row(
            children: [
              // "Лампочка"
              Container(
                width: 6, 
                height: 6, 
                decoration: BoxDecoration(
                  color: isActive ? Colors.greenAccent : Colors.grey,
                  shape: BoxShape.circle,
                  boxShadow: isActive ? [const BoxShadow(color: Colors.greenAccent, blurRadius: 4)] : null,
                ),
              ),
              const SizedBox(width: 6),
              Text(
                isActive ? "ON" : "OFF",
                style: Settings.sensorBinaryStatusTextStyle(isActive ? Colors.greenAccent : Colors.white38),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // 3. Для алертов (Motion): Красный текст
  Widget _buildAlertRow(String name, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(name, style: Settings.sensorNameTextStyle),
        Text(
          value.toUpperCase(),
          style: Settings.sensorAlertTextStyle,
        ),
      ],
    );
  }

  // 4. Обычный текст
  Widget _buildGenericRow(String name, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: Text(name, style: Settings.sensorNameTextStyle)),
        Text(
          value,
          style: Settings.sensorGenericValueTextStyle,
        ),
      ],
    );
  }
}