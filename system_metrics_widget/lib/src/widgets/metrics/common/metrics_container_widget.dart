import 'package:flutter/material.dart';
import 'package:system_metrics_widget/src/environment/settings.dart';

class MetricsContainerWidget extends StatelessWidget {
  final IconData iconData;
  final Widget child;
  final Color iconColor;

  const MetricsContainerWidget({
    required this.iconData,
    required this.child,
    super.key,
    this.iconColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xDD000000), 
        borderRadius: BorderRadius.circular(8), 
        border: Border.all(
          color: Colors.white24, 
          width: 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center, 
        children: <Widget>[
          // Левая часть с иконкой
          Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              // Легкий разделитель справа
              border: Border(
                right: BorderSide(color: Colors.white10),
              ),
            ),
            child: Icon(
              iconData,
              color: iconColor, 
              size: 20.0,
            ),
          ),
          Expanded( // Expanded теперь безопасен, так как Row знает свою ширину от Grid
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              // Принудительный стиль текста
              child: DefaultTextStyle.merge(
                style: Settings.metricsContainerDefaultTextStyle,
                child: child,
              ),
            ),
          ),
        ],
      ),
    );
  }
}