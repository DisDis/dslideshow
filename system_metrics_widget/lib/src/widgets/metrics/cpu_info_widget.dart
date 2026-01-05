import 'package:feather_icons/feather_icons.dart';
import 'package:dslideshow_backend/command.dart';
import 'package:flutter/material.dart';
import 'package:system_metrics_widget/src/widgets/metrics/circular_indicator/circular_indicator_widget.dart';
import 'package:system_metrics_widget/src/widgets/metrics/common/metrics_container_widget.dart';

class CpuInfoWidget extends StatelessWidget {
  final CpuInfo cpu;
  final double cpuLoad1;
  final double cpuLoad5;
  final double cpuLoad15;

  // Оптимальный размер для кружков внутри плитки
  final double gaugeSize = 50.0; 

  const CpuInfoWidget({
    required this.cpu,
    required this.cpuLoad1,
    required this.cpuLoad5,
    required this.cpuLoad15,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Нормализуем нагрузку относительно ядер
    // Если ядер 4, а LoadAverage 2.0, значит загрузка 50% (0.5)
    final cores = cpu.cores > 0 ? cpu.cores : 1;
    
    return MetricsContainerWidget(
      iconData: FeatherIcons.cpu,
      iconColor: Colors.purpleAccent, // Яркий акцент
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // 1. Информация о модели (Hardware)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  cpu.hardware.isEmpty ? 'Unknown CPU' : cpu.hardware.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 12, 
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 0.5,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              // Кол-во ядер как бейдж
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  '${cpu.cores} CORES',
                  style: const TextStyle(fontSize: 9, color: Colors.white70),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 12),
          
          // 2. Индикаторы Load Average (1m, 5m, 15m)
          // Используем Row + MainAxisAlignment.spaceAround для красивого распределения
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildGauge('1 min', cpuLoad1, cores),
              _buildGauge('5 min', cpuLoad5, cores),
              _buildGauge('15 min', cpuLoad15, cores),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGauge(String label, double load, int cores) {
    // Вычисляем процент заполнения (0.0 - 1.0)
    final percent = load / cores;
    
    return Column(
      children: [
        SizedBox(
          width: gaugeSize,
          height: gaugeSize,
          child: CircularIndicatorWidget(
            percent: percent,
            // Передаем load просто как число для отображения в центре, если виджет поддерживает
            // Но наш виджет отображает percent. 
            // Если хотим видеть само число LA (например "0.54"), нужно поправить CircularIndicatorWidget
            // В текущей реализации он покажет процент от нагрузки на все ядра.
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white54,
            fontSize: 9,
          ),
        ),
      ],
    );
  }
}