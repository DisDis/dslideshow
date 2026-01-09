import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:system_metrics_widget/src/widgets/metrics/common/metrics_container_widget.dart';
import 'package:system_metrics_widget/src/widgets/metrics/details/metrics_details_widget.dart';

class DisplayInfoWidget extends StatelessWidget {
  const DisplayInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {


// Получаем информацию о дисплее
    final window = View.of(context);
    final devicePixelRatio = window.devicePixelRatio;
    final physicalSize = window.physicalSize;
    final size = MediaQuery.of(context).size;
    
    // Рассчитываем DPI по горизонтали и вертикали
    double dpiX = physicalSize.width / size.width;
    double dpiY = physicalSize.height / size.height;

    return MetricsContainerWidget(
      iconData: Icons.monitor,
      iconColor: Colors.yellowAccent,
      child: Column(
        crossAxisAlignment : CrossAxisAlignment.start,
        children: <Widget>[
          MetricsDetails('Device Pixel Ratio, DPI X/Y', value: "$devicePixelRatio, ${dpiX.toStringAsFixed(1)}/${dpiY.toStringAsFixed(1)}"),
          MetricsDetails('Physical Size', value: "${physicalSize.width} x ${physicalSize.height} px"),
          MetricsDetails('Logical Size', value: "${size.width} x ${size.height}"),
        ],
      ),
    );
  }
}
