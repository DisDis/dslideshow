import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_flutter/features/header/presentation/widgets/buttons_hint/button_hint_action.dart';
import 'package:dslideshow_flutter/features/header/presentation/widgets/buttons_hint/buttons_hint.dart';
import 'package:dslideshow_flutter/features/header/presentation/widgets/buttons_hint/buttons_hint_bloc.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/bloc/status/slideshow_status_bloc.dart';
import 'package:dslideshow_flutter/src/service/frontend.dart' show ButtonEvent;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logging/logging.dart';

import 'support/config_harness.dart';
import 'support/ota_frontend.dart';
import 'support/slideshow_frontend.dart';

void main() {
  testWidgets(
    'contextual hints remain visible and track press/release without leaked timers',
    (tester) async {
      final frontend = TestFrontend();
      final bloc = ButtonsHintBloc.contextual(frontendService: frontend);
      try {
        await tester.pump(const Duration(seconds: 6));
        expect(bloc.state.isShow, isTrue);
        frontend.buttons.add(
          ButtonEvent(
            button: ButtonType.button3,
            event: ButtonEventType.pressed,
            durationMs: 0,
          ),
        );
        await tester.pump();
        expect(bloc.state.button3isPush, isTrue);
        await tester.pump(const Duration(seconds: 1));
        expect(bloc.state.button3isPush, isTrue);
        frontend.buttons.add(
          ButtonEvent(
            button: ButtonType.button3,
            event: ButtonEventType.released,
            durationMs: 1000,
          ),
        );
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 199));
        expect(bloc.state.button3isPush, isTrue);
        await tester.pump(const Duration(milliseconds: 1));
        expect(bloc.state.button3isPush, isFalse);
        frontend.buttons.add(
          ButtonEvent(
            button: ButtonType.button0,
            event: ButtonEventType.released,
            durationMs: 1,
          ),
        );
        await tester.pump();
      } finally {
        await tester.runAsync(bloc.close);
        expect(frontend.buttons.hasListener, isFalse);
        await tester.pump(const Duration(seconds: 6));
        await frontend.close();
      }
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets(
    'slideshow retains configured actions, five-second hiding and permanent menu hints',
    (tester) async {
      final frontend = TestFrontend();
      final config = AppConfig.fromJson({});
      config.slideshow.buttons.button0.action = SlideshowAction.pause;
      final status = SlideshowStatusBloc(
        frontendService: frontend,
        config: config.slideshow,
      );
      final bloc = ButtonsHintBloc(
        frontendService: frontend,
        statusBloc: status,
        appConfig: config,
      );
      try {
        await tester.pumpWidget(
          BlocProvider<ButtonsHintBloc>.value(
            value: bloc,
            child: const MaterialApp(home: Scaffold(body: ButtonsHintWidget())),
          ),
        );
        await tester.pump();
        expect(
          find.descendant(
            of: find.byKey(const ValueKey(ButtonType.button0)),
            matching: find.byIcon(Icons.pause),
          ),
          findsOneWidget,
        );
        await tester.pump(const Duration(seconds: 5));
        expect(bloc.state.isShow, isFalse);
        await tester.pump();
        expect(find.byKey(const ValueKey(ButtonType.button0)), findsNothing);
        status.add(const SlideshowMenuEvent(true));
        await tester.pump();
        expect(bloc.state.isShow, isTrue);
        // Status -> hint event has completed; render its new snapshot.
        await tester.pump();
        expect(
          find.descendant(
            of: find.byKey(const ValueKey(ButtonType.button0)),
            matching: find.byIcon(Icons.arrow_back),
          ),
          findsOneWidget,
        );
        expect(
          find.descendant(
            of: find.byKey(const ValueKey(ButtonType.button3)),
            matching: find.byIcon(Icons.check_circle_outline_outlined),
          ),
          findsOneWidget,
        );
        await tester.pump(const Duration(seconds: 6));
        expect(bloc.state.isShow, isTrue);
        status.add(const SlideshowMenuEvent(false));
        await tester.pump();
        await tester.pump();
        expect(
          find.descendant(
            of: find.byKey(const ValueKey(ButtonType.button0)),
            matching: find.byIcon(Icons.pause),
          ),
          findsOneWidget,
        );
      } finally {
        await tester.runAsync(() async {
          await bloc.close();
          await status.close();
        });
        await frontend.close();
      }
    },
  );

  configWidgetTest(
    'config hints preserve physical coordinates, empty slots and matching menu icons',
    (tester, h) async {
      final config = AppConfig.fromJson({});
      config.slideshow.buttons.hintOffsetX = 1400;
      config.slideshow.buttons.hintOffsetY = 24;
      await h.mount(tester, configuration: config);
      h.frontend.starts.single.complete('83472');
      h.frontend.systems.single.complete(otaSystemInfo());
      await tester.pump();
      expect(find.textContaining('Frame buttons:'), findsNothing);
      final hint = find.byType(ButtonsHintWidget);
      expect(tester.getTopLeft(hint), const Offset(1400, 24));
      final widget = tester.widget<ButtonsHintWidget>(hint);
      expect(
        widget.bindings![ButtonType.button0]!.action,
        ButtonHintAction.back,
      );
      expect(
        widget.bindings![ButtonType.button3]!.action,
        ButtonHintAction.checkConnection,
      );
      for (final button in [ButtonType.button1, ButtonType.button2]) {
        expect(
          find.descendant(
            of: find.byKey(ValueKey(button)),
            matching: find.byType(Icon),
          ),
          findsNothing,
        );
      }
      final retry = tester.widget<FilledButton>(
        find.byKey(const Key('config-retry')),
      );
      final retryIcon = find.descendant(
        of: find.byKey(const Key('config-retry')),
        matching: find.byIcon(ButtonHintAction.checkConnection.icon),
      );
      expect(retry.onPressed, isNotNull);
      expect(retryIcon, findsOneWidget);
      final positions = [
        for (final button in ButtonType.values)
          tester.getCenter(find.byKey(ValueKey(button))).dx,
      ];
      expect(positions[1] - positions[0], positions[2] - positions[1]);
      expect(positions[2] - positions[1], positions[3] - positions[2]);
      await tester.tap(find.byKey(const Key('config-retry')));
      await tester.pump();
      expect(
        tester
            .widget<ButtonsHintWidget>(hint)
            .bindings![ButtonType.button3]!
            .enabled,
        isFalse,
      );
      h.frontend.systems.last.completeError(Exception('network unavailable'));
      await tester.pump();
      expect(
        tester
            .widget<ButtonsHintWidget>(hint)
            .bindings![ButtonType.button3]!
            .action,
        ButtonHintAction.retry,
      );
      expect(
        find.descendant(
          of: find.byKey(const Key('config-retry')),
          matching: find.byIcon(ButtonHintAction.retry.icon),
        ),
        findsOneWidget,
      );
    },
  );

  test('closing cancels queued hint changes and logs cleanup without raw transport details', () async {
    final frontend = TestFrontend();
    final records = <LogRecord>[];
    final level = Logger.root.level;
    Logger.root.level = Level.ALL;
    final sub = Logger.root.onRecord.listen(records.add);
    final bloc = ButtonsHintBloc.contextual(frontendService: frontend);
    try {
      bloc.add(
        const ButtonsHintEvent.buttonChanged(
          button: ButtonType.button0,
          type: ButtonEventType.released,
        ),
      );
      await bloc.close();
      expect(frontend.buttons.hasListener, isFalse);
      final logs = records
          .where((r) => r.loggerName == 'ButtonsHintBloc')
          .map((r) => r.message)
          .join('\n');
      expect(logs, contains('started mode=contextual'));
      expect(logs, contains('timers cancelled'));
      expect(logs, contains('closed mode=contextual'));
    } finally {
      await sub.cancel();
      Logger.root.level = level;
      await frontend.close();
    }
  });
}
