// Explicit local VM capture; not part of ordinary *_test.dart runs.
import 'dart:io';
import 'dart:ui' as ui;

import 'package:dslideshow_flutter/environment.dart' as environment;
import 'package:dslideshow_flutter/features/config/presentation/bloc/config_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import '../test/support/config_harness.dart';
import '../test/support/ota_frontend.dart';

void main() {
  final output = Directory(Platform.environment['CONFIG_SCREENSHOT_DIR'] ?? 'build/config-screenshots');
  setUpAll(() async {
    if (!environment.isLinuxEmbedded) throw StateError('Set DSLIDESHOW_EMBEDDED=true');
    await output.create(recursive: true);
    final sdk = Platform.environment['CONFIG_FLUTTER_ROOT'] ?? Platform.environment['FLUTTER_ROOT'];
    if (sdk == null) throw StateError('Set CONFIG_FLUTTER_ROOT');
    for (final entry in {
      'Roboto': ['Roboto-Regular.ttf', 'Roboto-Medium.ttf', 'Roboto-Bold.ttf'],
      'MaterialIcons': ['MaterialIcons-Regular.otf'],
    }.entries) {
      final loader = FontLoader(entry.key);
      for (final name in entry.value) {
        loader.addFont(File('$sdk/bin/cache/artifacts/material_fonts/$name').readAsBytes().then(ByteData.sublistView));
      }
      await loader.load();
    }
  });
  Future<void> capture(WidgetTester tester, ConfigHarness h, String name) async {
    await tester.pump(const Duration(milliseconds: 300));
    expect(tester.takeException(), isNull, reason: name);
    await tester.runAsync(() async {
      final boundary = h.boundaryKey.currentContext!.findRenderObject()! as RenderRepaintBoundary;
      final image = await boundary.toImage();
      try {
        expect(image.width, 2560);
        expect(image.height, 1600);
        final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
        await File('${output.path}/$name.png')
            .writeAsBytes(bytes!.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes));
      } finally {
        image.dispose();
      }
    });
  }

  configWidgetTest('capture real ConfigPage preparation, network and closing states', (tester, h) async {
    await h.mount(tester);
    await capture(tester, h, '01-preparing');
    h.frontend.starts.single.complete('83472');
    await tester.pump();
    await capture(tester, h, '02-preparing-address');
    h.frontend.systems.single.complete(otaSystemInfo());
    await tester.pump();
    await capture(tester, h, '03-ready');
    h.bloc.add(const ConfigEvent.retry());
    await tester.pump();
    await capture(tester, h, '04-checking');
    h.frontend.systems.last.complete(otaSystemInfo(interfaces: []));
    await tester.pump();
    await capture(tester, h, '05-no-network');
    h.bloc.add(const ConfigEvent.retry());
    await tester.pump();
    await capture(tester, h, '17-no-network-checking');
    h.frontend.systems.last.complete(otaSystemInfo(interfaces: []));
    await tester.pump();

    h.bloc.add(const ConfigEvent.retry());
    await tester.pump();
    h.frontend.systems.last.completeError(Exception('network read failed'));
    await tester.pump();
    await capture(tester, h, '06-network-error');
    h.frontend.holdStop = true;
    h.bloc.add(const ConfigEvent.exit());
    await tester.pump();
    await capture(tester, h, '11-closing');
    h.frontend.stops.single.completeError(Exception('stop failed'));
    await tester.pump();
    await capture(tester, h, '12-close-failure');
  });
  for (final unknown in [false, true]) {
    configWidgetTest('capture ${unknown ? 'unknown' : 'server'} failure', (tester, h) async {
      await h.mount(tester);
      h.frontend.starts.single.completeError(unknown ? StateError('unknown') : Exception('server start failed'));
      h.frontend.systems.single.complete(otaSystemInfo());
      await tester.pump();
      await capture(tester, h, unknown ? '08-unknown-error' : '07-server-error');
    });
  }
  configWidgetTest('capture permanently enabled server closing', (tester, h) async {
    await h.mount(tester, alwaysEnabled: true);
    h.frontend.starts.single.complete('83472');
    h.frontend.systems.single.complete(otaSystemInfo());
    await tester.pump();
    h.frontend.holdStop = true;
    h.bloc.add(const ConfigEvent.exit());
    await tester.pump();
    await capture(tester, h, '13-closing-always-enabled');
  });
}
