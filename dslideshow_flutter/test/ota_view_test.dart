import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_common/version.dart';
import 'package:dslideshow_flutter/features/ota/presentation/bloc/ota_state.dart';
import 'package:dslideshow_flutter/features/ota/presentation/widgets/ota_ready_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:xterm/xterm.dart';

import 'support/ota_harness.dart';

const _info = OTAInfo(
  status: OTAStatus.ready,
  uploadingPercent: 0,
  code: '83472',
);

void main() {
  testWidgets('initial page shows the current version before RPCs finish', (
    tester,
  ) async {
    final harness = OtaHarness();
    await harness.mount(tester);

    final version = tester.widget<Text>(
      find.text('v${ApplicationInfo.frontendVersion}'),
    );
    expect(version.style?.fontSize, 40);
    expect(version.style?.color, Colors.redAccent);
    expect(find.text('Preparing the update page…'), findsOneWidget);
    expect(find.byType(QrImageView), findsNothing);
    expect(tester.takeException(), isNull);
  });

  testWidgets('ready page preserves the large QR, code and version', (
    tester,
  ) async {
    final harness = OtaHarness();
    await harness.mount(tester);
    await harness.initialize(tester);
    await harness.completeInfo(tester, _info);

    expect(find.text(_info.code), findsOneWidget);
    expect(find.byType(QrImageView), findsNothing);
    expect(find.text('Preparing the update page…'), findsOneWidget);

    await harness.completeNetwork(tester);
    final qr = find.byType(QrImageView);
    expect(qr, findsOneWidget);
    expect(tester.getSize(qr).width, greaterThan(1300));
    expect(tester.getSize(qr).height, greaterThan(1300));
    final code = tester.widget<Text>(find.text(_info.code));
    expect(code.style?.fontSize, 136);
    expect(code.style?.fontWeight, FontWeight.w900);
    final version = tester.widget<Text>(
      find.text('v${ApplicationInfo.frontendVersion}'),
    );
    expect(version.style?.fontSize, 40);
    expect(version.style?.color, Colors.redAccent);
    expect(find.text('http://192.168.50.143:8282/ota_start'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('network failure keeps the code and explains the missing QR', (
    tester,
  ) async {
    final harness = OtaHarness();
    await harness.mount(tester);
    await harness.initialize(tester);
    await harness.completeInfo(tester, _info);
    harness.frontend.systemResult.completeError(StateError('No network'));
    await tester.pump();

    expect(find.text(_info.code), findsOneWidget);
    expect(find.byType(QrImageView), findsNothing);
    expect(
      find.text(
        'No network address is available. Connect the frame to a network to open the update page.',
      ),
      findsOneWidget,
    );
    expect(find.textContaining('127.0.0.1'), findsNothing);
    expect(tester.takeException(), isNull);
  });

  testWidgets(
    'stages retain a wide log and distinguish upload from installation',
    (tester) async {
      final harness = OtaHarness();
      await harness.mount(tester);
      await harness.initialize(tester);
      await harness.completeInfo(
        tester,
        _info.copyWith(status: OTAStatus.uploading, uploadingPercent: 67),
      );
      await harness.completeNetwork(tester);

      expect(find.text('Uploading firmware'), findsOneWidget);
      expect(find.text('67%'), findsOneWidget);
      expect(
        tester
            .widget<LinearProgressIndicator>(
              find.byType(LinearProgressIndicator),
            )
            .value,
        .67,
      );
      expect(
        tester.getSize(find.byType(TerminalView)).width,
        greaterThanOrEqualTo(2560 * .95),
      );
      expect(
        tester
            .widget<TerminalView>(find.byType(TerminalView))
            .textStyle
            .fontSize,
        32,
      );
      harness.frontend.outputEvents.add('Retained installer output\n');
      await tester.pump();
      final originalTerminal = tester
          .widget<TerminalView>(find.byType(TerminalView))
          .terminal;

      void expectRetainedLog() {
        final visibleTerminal = tester
            .widget<TerminalView>(find.byType(TerminalView))
            .terminal;
        expect(visibleTerminal, same(originalTerminal));
        expect(
          visibleTerminal.buffer.lines[0].getText(),
          'Retained installer output',
        );
      }

      expectRetainedLog();

      await harness.update(
        tester,
        _info.copyWith(status: OTAStatus.instaling, uploadingPercent: 100),
      );
      expect(find.text('Installing firmware'), findsOneWidget);
      expect(find.text('100%'), findsNothing);
      expect(
        tester
            .widget<LinearProgressIndicator>(
              find.byType(LinearProgressIndicator),
            )
            .value,
        isNull,
      );
      expectRetainedLog();

      await harness.update(
        tester,
        _info.copyWith(
          status: OTAStatus.issue,
          errorText: 'Installer exited with code 1',
          exitCode: 1,
        ),
      );
      expect(find.text('Update failed'), findsOneWidget);
      expect(find.text('Installer exited with code 1'), findsOneWidget);
      expect(find.text('See the system log for details.'), findsOneWidget);
      expectRetainedLog();

      await harness.update(tester, _info.copyWith(status: OTAStatus.finished));
      expect(find.text('Firmware updated'), findsOneWidget);
      expect(
        find.text('Waiting for the application to restart…'),
        findsOneWidget,
      );
      expect(find.text('Restarting the application…'), findsNothing);
      expectRetainedLog();
      await harness.update(tester, _info.copyWith(status: OTAStatus.preReboot));
      expect(find.text('Restarting the application…'), findsOneWidget);
      expect(
        find.text('Waiting for the application to restart…'),
        findsNothing,
      );
      expectRetainedLog();

      harness.frontend.readyEvents.add(false);
      await tester.pump();
      expect(find.text('Closing the update screen…'), findsOneWidget);
      expectRetainedLog();
      expect(find.byType(LinearProgressIndicator), findsNothing);
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets('compact installation smoke/layout keeps the log width', (
    tester,
  ) async {
    final harness = OtaHarness();
    await harness.mount(tester, size: const Size(1280, 800));
    await harness.initialize(tester);
    await harness.completeInfo(
      tester,
      _info.copyWith(status: OTAStatus.instaling, uploadingPercent: 100),
    );
    await harness.completeNetwork(tester);

    expect(find.text('Installing firmware'), findsOneWidget);
    expect(find.text('100%'), findsNothing);
    expect(
      tester.getSize(find.byType(TerminalView)).width,
      greaterThanOrEqualTo(1280 * .95),
    );
    expect(tester.getSize(find.byType(TerminalView)).height, greaterThan(100));
    expect(tester.takeException(), isNull);
  });

  testWidgets(
    'narrow ready layout scrolls long code and URL at full text size',
    (tester) async {
      const code = 'ABCD-1234-Long-Access-Code';
      const address =
          'http://frame-with-a-long-local-network-name.example:8282/ota_start';
      final harness = OtaHarness();
      await harness.mount(
        tester,
        size: const Size(800, 1000),
        child: OtaReadyWidget(
          state: OtaState.ready(
            info: _info.copyWith(code: code),
            otaStartUrl: address,
          ) as OtaReadyState,
        ),
      );

      expect(find.byType(QrImageView), findsOneWidget);
      await tester.ensureVisible(find.text(code));
      expect(tester.widget<Text>(find.text(code)).style?.fontSize, 136);
      await tester.ensureVisible(find.text(address));
      final addressLabel = find.byWidgetPredicate(
        (widget) => widget is SelectableText && widget.data == address,
      );
      expect(tester.widget<SelectableText>(addressLabel).style?.fontSize, 36);
      expect(tester.takeException(), isNull);
    },
  );
}
