import 'dart:io';

import 'package:benchmarks/src/config.dart';
import 'package:benchmarks/src/media.dart';
import 'package:benchmarks/src/viewport.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
    'viewport starts automatically after layout without input controls',
    (tester) async {
      var starts = 0;
      tester.view.physicalSize = const Size(2560, 1600);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: MediaQuery.fromView(
            view: tester.view,
            child: BenchmarkViewport(
              config: BenchmarkConfig(),
              catalog: MediaCatalog(Directory.systemTemp, []),
              reportDirectory: Directory.systemTemp,
              onReady: (driver) async {
                starts++;
                expect(driver.display['physical_width'], 2560);
                expect(driver.display['physical_height'], 1600);
              },
            ),
          ),
        ),
      );
      await tester.pump();
      expect(starts, 1);
      expect(find.byType(TextButton), findsNothing);
      expect(find.byType(Slider), findsNothing);
      await tester.pumpWidget(const SizedBox());
      expect(tester.takeException(), isNull);
    },
  );
}
