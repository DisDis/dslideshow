import 'package:dslideshow_backend/command.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:system_metrics_widget/src/widgets/metrics/os_info_widget.dart';

void main() {
  for (final osType in OSType.values) {
    testWidgets('renders icons for ${osType.name}', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: OSInfoWidget(
              model: OSInfo(name: 'Test OS', osType: osType),
            ),
          ),
        ),
      );

      expect(find.text('Os info: Test OS'), findsOneWidget);
      expect(tester.takeException(), isNull);
      if ([
        OSType.linux,
        OSType.ios,
        OSType.macos,
        OSType.windows,
      ].contains(osType)) {
        expect(find.byType(FaIcon), findsNWidgets(2));
      }
    });
  }
}
