import 'package:dslideshow_backend/command.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:system_metrics_widget/src/widgets/metrics/sensors_info_widget.dart';

void main() {
  testWidgets('renders measured fan speed with the RPM unit', (tester) async {
    await tester.pumpWidget(
      _sensorsWidget(const [SensorInfo(name: 'fan1', value: '4611rpm')]),
    );

    expect(find.text('FAN1'), findsOneWidget);
    expect(find.text('4611'), findsOneWidget);
    expect(find.text('RPM'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  for (final value in ['0RPM', '0rPm']) {
    testWidgets('renders a stopped fan for $value', (tester) async {
      await tester.pumpWidget(
        _sensorsWidget([SensorInfo(name: 'fan1', value: value)]),
      );

      expect(find.text('FAN1'), findsOneWidget);
      expect(find.text('0'), findsOneWidget);
      expect(find.text('RPM'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('removes an unavailable fan while retaining temperature', (
    tester,
  ) async {
    const temperature = SensorInfo(name: 'temp', value: "57.1'C");
    await tester.pumpWidget(
      _sensorsWidget(const [
        temperature,
        SensorInfo(name: 'fan1', value: '4611rpm'),
      ]),
    );
    expect(find.text('FAN1'), findsOneWidget);
    expect(find.text('RPM'), findsOneWidget);

    await tester.pumpWidget(_sensorsWidget(const [temperature]));

    expect(find.text('FAN1'), findsNothing);
    expect(find.text('4611'), findsNothing);
    expect(find.text('RPM'), findsNothing);
    expect(find.text('TEMP'), findsOneWidget);
    expect(find.text('57.1'), findsOneWidget);
    expect(find.text('°C'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}

Widget _sensorsWidget(List<SensorInfo> sensors) => MaterialApp(
  home: Scaffold(
    body: SensorsInfoWidget(
      model: UpdateInfo(
        cpuLoad1: 0,
        cpuLoad15: 0,
        cpuLoad5: 0,
        diskAvailable: 0,
        diskUsed: 0,
        diskUsedPercent: 0,
        lastUpdate: 0,
        memTotal: 0,
        memUsed: 0,
        sensors: sensors,
        swapTotal: 0,
        swapUsed: 0,
        uptime: '',
      ),
    ),
  ),
);
