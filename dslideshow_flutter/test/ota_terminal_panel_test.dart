import 'package:dslideshow_flutter/features/ota/presentation/bloc/ota_terminal_session.dart';
import 'package:dslideshow_flutter/features/ota/presentation/widgets/ota_terminal_panel.dart';
import 'package:dslideshow_i18n/i18n.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xterm/xterm.dart';

Widget _app(OtaTerminalSession session, {String? emptyMessage}) => MaterialApp(
  locale: const Locale('en'),
  supportedLocales: AppLocalizations.supportedLocales,
  localizationsDelegates: AppLocalizations.localizationsDelegates,
  home: Scaffold(
    body: OtaTerminalPanel(session: session, emptyMessage: emptyMessage),
  ),
);

void _write(OtaTerminalSession session, int start, int count) {
  session.backend.onWrite(
    [
      for (var i = start; i < start + count; i++)
        'Installer output $i: preparing package and keeping the original log.',
      '',
    ].join('\n'),
  );
}

void main() {
  testWidgets(
    'empty log hint yields to visible output and keeps the terminal',
    (tester) async {
      final session = OtaTerminalSession();
      addTearDown(session.dispose);
      await tester.pumpWidget(
        _app(session, emptyMessage: 'Waiting for output'),
      );
      final terminal = tester
          .widget<TerminalView>(find.byType(TerminalView))
          .terminal;
      expect(find.text('Waiting for output'), findsOneWidget);
      session.backend.onWrite('');
      session.backend.onWrite('\x1b[31m');
      await tester.pump();
      expect(find.text('Waiting for output'), findsOneWidget);
      session.backend.onWrite('Unpacking package\n');
      await tester.pump();
      expect(find.text('Waiting for output'), findsNothing);
      expect(
        tester.widget<TerminalView>(find.byType(TerminalView)).terminal,
        same(terminal),
      );
      expect(terminal.buffer.lines[0].getText(), 'Unpacking package');
      // A stage change must not put a hint over the retained installation log.
      await tester.pumpWidget(_app(session, emptyMessage: 'Another stage'));
      expect(find.text('Another stage'), findsNothing);
      await tester.pumpWidget(const SizedBox.shrink());
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets(
    'log follows bursts, pauses for history, and resumes at latest line',
    (tester) async {
      tester.view.devicePixelRatio = 1;
      tester.view.physicalSize = const Size(1280, 800);
      addTearDown(tester.view.resetDevicePixelRatio);
      addTearDown(tester.view.resetPhysicalSize);
      final session = OtaTerminalSession();
      addTearDown(session.dispose);
      _write(session, 0, 100);
      await tester.pumpWidget(_app(session));
      await tester.pump();
      final position = session.scrollController.position;
      expect(position.maxScrollExtent, greaterThan(0));
      expect(position.extentAfter, closeTo(0, 1));
      expect(find.text('Following new output'), findsOneWidget);
      expect(
        tester
            .widget<TerminalView>(find.byType(TerminalView))
            .textStyle
            .fontSize,
        32,
      );

      _write(session, 100, 200);
      await tester.pump();
      expect(position.extentAfter, closeTo(0, 1));

      await tester.sendEventToBinding(
        PointerScrollEvent(
          position: tester.getCenter(find.byType(TerminalView)),
          scrollDelta: const Offset(0, -400),
        ),
      );
      await tester.pump();
      await tester.pump();
      expect(session.isFollowing, isFalse);
      expect(find.text('Viewing history · auto-scroll paused'), findsOneWidget);
      expect(find.text('Go to latest line'), findsOneWidget);
      final historyOffset = position.pixels;
      _write(session, 300, 50);
      await tester.pump();
      expect(position.pixels, closeTo(historyOffset, 1));
      expect(position.extentAfter, greaterThan(400));

      await tester.tap(find.text('Go to latest line'));
      await tester.pump();
      await tester.pump();
      expect(position.extentAfter, closeTo(0, 1));
      expect(session.isFollowing, isTrue);
      expect(find.text('Following new output'), findsOneWidget);
      _write(session, 350, 25);
      await tester.pump();
      expect(position.extentAfter, closeTo(0, 1));

      // xterm pauses even for a fractional scroll above its last line. Keep the
      // label and the resume action consistent with the actual viewport policy.
      position.jumpTo(position.maxScrollExtent - .5);
      await tester.pump();
      await tester.pump();
      expect(session.isFollowing, isFalse);
      expect(find.text('Go to latest line'), findsOneWidget);
      final fractionalOffset = position.pixels;
      _write(session, 375, 1);
      await tester.pump();
      expect(position.pixels, fractionalOffset);
      expect(session.isFollowing, isFalse);
      expect(tester.takeException(), isNull);
      await tester.pumpWidget(const SizedBox.shrink());
    },
  );

  testWidgets('resize keeps follow mode and preserves history while paused', (
    tester,
  ) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(1280, 800);
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.view.resetPhysicalSize);
    final session = OtaTerminalSession();
    addTearDown(session.dispose);
    _write(session, 0, 100);
    await tester.pumpWidget(_app(session));
    await tester.pump();
    tester.view.physicalSize = const Size(1000, 700);
    await tester.pump();
    await tester.pump();
    expect(session.scrollController.position.extentAfter, closeTo(0, 1));
    expect(session.isFollowing, isTrue);

    await tester.sendEventToBinding(
      PointerScrollEvent(
        position: tester.getCenter(find.byType(TerminalView)),
        scrollDelta: const Offset(0, -500),
      ),
    );
    await tester.pump();
    await tester.pump();
    expect(session.isFollowing, isFalse);
    tester.view.physicalSize = const Size(1000, 600);
    await tester.pump();
    await tester.pump();
    expect(session.isFollowing, isFalse);
    expect(session.scrollController.position.extentAfter, greaterThan(100));
    expect(tester.takeException(), isNull);
    await tester.pumpWidget(const SizedBox.shrink());
  });

  testWidgets('a queued scroll update is harmless after page disposal', (
    tester,
  ) async {
    final session = OtaTerminalSession();
    await tester.pumpWidget(_app(session));
    await tester.pumpWidget(const SizedBox.shrink());
    session.scheduleScrollStateUpdate();
    session.dispose();
    // A late terminal notification must not reach disposed hint notifiers.
    session.terminal.write('Late output');
    await tester.pump();
    expect(tester.takeException(), isNull);
  });
}
