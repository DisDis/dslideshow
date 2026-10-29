// Explicit capture command; not part of the ordinary *_test.dart suite.
import 'dart:io';
import 'dart:ui' as ui;

import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_flutter/environment.dart' as environment;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import '../test/support/frame_app_harness.dart';
import '../test/support/ota_frontend.dart';

const _ready = OTAInfo(
  status: OTAStatus.ready,
  uploadingPercent: 0,
  code: '83472',
);

void main() {
  final output = Directory(
    Platform.environment['OTA_SCREENSHOT_DIR'] ?? 'build/ota-screenshots',
  );

  setUpAll(() async {
    if (!environment.isLinuxEmbedded) {
      throw StateError('Run with DSLIDESHOW_EMBEDDED=true.');
    }
    await output.create(recursive: true);
    // Widget tests normally substitute Ahem. Load real SDK fonts so that text
    // and icon glyphs can be assessed in the actual application layout.
    final sdk = Directory(
      Platform.environment['OTA_FLUTTER_ROOT'] ??
          Platform.environment['FLUTTER_ROOT'] ??
          (throw StateError('Set OTA_FLUTTER_ROOT to the Flutter SDK path.')),
    );
    final fonts = Directory('${sdk.path}/bin/cache/artifacts/material_fonts');
    for (final entry in {
      'Roboto': ['Roboto-Regular.ttf', 'Roboto-Medium.ttf', 'Roboto-Bold.ttf'],
      'MaterialIcons': ['MaterialIcons-Regular.otf'],
    }.entries) {
      final loader = FontLoader(entry.key);
      for (final filename in entry.value) {
        loader.addFont(
          File('${fonts.path}/$filename')
              .readAsBytes()
              .then(ByteData.sublistView),
        );
      }
      await loader.load();
    }
    final terminalFont = Platform.environment['OTA_TERMINAL_FONT'];
    if (terminalFont == null) {
      throw StateError('Set OTA_TERMINAL_FONT to a local monospace TTF path.');
    }
    // The test engine can fall back to Ahem before trying a missing family's
    // alternatives. Register the chosen local mono font under the requested
    // primary family as well, keeping terminal output readable in captures.
    for (final family in ['Cascadia Mono', 'Courier New', 'monospace']) {
      final loader = FontLoader(family)
        ..addFont(File(terminalFont).readAsBytes().then(ByteData.sublistView));
      await loader.load();
    }
  });

  Future<void> capture(
    WidgetTester tester,
    GlobalKey key,
    String filename,
  ) async {
    // Choose a visible animation phase for the activity indicator, then flush
    // terminal follow/resize work. This is virtual time, not an I/O wait.
    await tester.pump(const Duration(milliseconds: 300));
    await tester.pump();
    expect(tester.takeException(), isNull, reason: filename);
    await tester.runAsync(() async {
      final boundary =
          key.currentContext!.findRenderObject()! as RenderRepaintBoundary;
      final image = await boundary.toImage();
      try {
        expect(image.width, 2560);
        expect(image.height, 1600);
        final bytes = (await image.toByteData(format: ui.ImageByteFormat.png))!;
        await File('${output.path}/$filename.png').writeAsBytes(
          bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes),
        );
      } finally {
        image.dispose();
      }
    });
  }

  testWidgets('capture the real OTA application through its normal lifecycle', (
    tester,
  ) async {
    final frontend = OtaTestFrontend();
    final key = GlobalKey();
    await mountFrameOtaApp(tester, boundaryKey: key, otaFrontend: frontend);
    expect(find.text('Preparing the update page…'), findsOneWidget);
    await capture(tester, key, '01-preparing');

    frontend.infoResult.complete(_ready);
    await tester.pump();
    expect(find.text('83472'), findsOneWidget);
    await capture(tester, key, '02-preparing-address');

    frontend.systemResult.complete(otaSystemInfo());
    await tester.pump();
    expect(find.text('http://192.168.50.143:8282/ota_start'), findsOneWidget);
    await capture(tester, key, '03-ready');

    Rect? receivingHeading;
    Rect? receivingBar;
    for (final (percent, filename) in [
      (0.0, '05-upload-0'),
      (67.0, '06-upload-67'),
      (100.0, '07-upload-100'),
    ]) {
      frontend.infoEvents.add(
        _ready.copyWith(status: OTAStatus.uploading, uploadingPercent: percent),
      );
      await tester.pump();
      // The built-in progress interpolation needs virtual time to reach the
      // requested percentage before taking a still image.
      await tester.pump(const Duration(milliseconds: 250));
      final label = '${percent.toInt()}%';
      expect(find.text(label), findsOneWidget);
      final paragraph = tester.renderObject<RenderParagraph>(find.text(label));
      final boxes = paragraph.getBoxesForSelection(
        TextSelection(baseOffset: 0, extentOffset: label.length),
      );
      expect(
        boxes,
        hasLength(1),
        reason: '$label must fit on one line with the real UI font',
      );
      expect(
        boxes.single.toRect().width,
        lessThanOrEqualTo(paragraph.size.width),
      );
      expect(paragraph.didExceedMaxLines, isFalse);
      final headingRect = tester.getRect(find.text('Receiving firmware'));
      final barRect = tester.getRect(find.byType(LinearProgressIndicator));
      final panelRect = tester.getRect(
        find
            .ancestor(
              of: find.byType(LinearProgressIndicator),
              matching: find.byType(Container),
            )
            .first,
      );
      expect(
        panelRect.bottom - barRect.bottom,
        inInclusiveRange(24, 40),
        reason: 'The space under the bar should contain only the card padding',
      );
      final panelViewport = tester.getRect(
        find
            .ancestor(
              of: find.byType(LinearProgressIndicator),
              matching: find.byType(SingleChildScrollView),
            )
            .first,
      );
      expect(
        panelRect.height,
        lessThanOrEqualTo(panelViewport.height),
        reason: 'The compact status card must keep its bottom border visible',
      );
      receivingHeading ??= headingRect;
      receivingBar ??= barRect;
      expect(
        headingRect,
        receivingHeading,
        reason: '$label shifts the heading',
      );
      expect(barRect, receivingBar, reason: '$label shifts the progress bar');
      await capture(tester, key, filename);
    }

    frontend.infoEvents.add(
      _ready.copyWith(status: OTAStatus.instaling, uploadingPercent: 100),
    );
    frontend.outputEvents.add(
      'Reading package lists... Done\n'
      'Building dependency tree... Done\n'
      'Reading state information... Done\n'
      'Preparing to unpack firmware.deb ...\n'
      'Unpacking dslideshow ...\n'
      'Setting up dslideshow ...\n',
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));
    expect(find.text('Installing firmware'), findsOneWidget);
    expect(find.text('100%'), findsNothing);
    await capture(tester, key, '08-installing');

    frontend.infoEvents.add(_ready.copyWith(status: OTAStatus.finished));
    frontend.outputEvents.add('Processing triggers ...\n');
    await tester.pump();
    expect(find.text('Firmware installed'), findsOneWidget);
    await capture(tester, key, '09-finished');

    frontend.infoEvents.add(_ready.copyWith(status: OTAStatus.preReboot));
    await tester.pump();
    expect(find.text('Restarting the application'), findsOneWidget);
    await capture(tester, key, '10-restarting');

    frontend.readyEvents.add(false);
    await tester.pump();
    expect(find.text('Closing the update screen…'), findsOneWidget);
    await capture(tester, key, '13-exit');
  });

  testWidgets('capture missing network address', (tester) async {
    final frontend = OtaTestFrontend()..infoResult.complete(_ready);
    final key = GlobalKey();
    await mountFrameOtaApp(tester, boundaryKey: key, otaFrontend: frontend);
    frontend.systemResult.completeError(StateError('No network address'));
    await tester.pump();
    expect(
      find.textContaining('No network address is available.'),
      findsOneWidget,
    );
    await capture(tester, key, '04-no-network');
  });

  testWidgets('capture installer error and fallback error message', (
    tester,
  ) async {
    final frontend = OtaTestFrontend()
      ..infoResult.complete(
        _ready.copyWith(
          status: OTAStatus.issue,
          exitCode: 1,
          errorText: 'Installer exited with code 1',
        ),
      )
      ..systemResult.complete(otaSystemInfo());
    final key = GlobalKey();
    await mountFrameOtaApp(tester, boundaryKey: key, otaFrontend: frontend);
    frontend.outputEvents.add(
      'Setting up dslideshow ...\n'
      '\x1b[31mdpkg: error processing package dslideshow (--configure):\x1b[0m\n'
      ' installed package post-installation script returned error exit status 1\n'
      'Errors were encountered while processing:\n'
      ' dslideshow\n',
    );
    await tester.pump();
    expect(find.text('Installer exited with code 1'), findsOneWidget);
    await capture(tester, key, '11-failed');

    frontend.infoEvents.add(
      _ready.copyWith(status: OTAStatus.issue, errorText: ''),
    );
    await tester.pump();
    expect(find.text('An unknown error occurred.'), findsOneWidget);
    await capture(tester, key, '12-unknown-error');
  });
}
