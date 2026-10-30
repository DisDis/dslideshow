import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_common/rpc.dart';
import 'package:dslideshow_flutter/features/menu/presentation/bloc/main_menu_bloc.dart';
import 'package:dslideshow_flutter/features/menu/presentation/widgets/mainmenu_model.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/bloc/status/slideshow_status_bloc.dart';
import 'package:dslideshow_flutter/src/route_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logging/logging.dart';

import 'support/frontend_remote.dart';

void main() {
  late FrontendHarness h;
  late MainMenuBloc menu;

  void menuTest(String name, Future<void> Function(WidgetTester) body) {
    testWidgets(name, (tester) async {
      h = FrontendHarness();
      menu = MainMenuBloc(
        routeBloc: h.route,
        frontendService: h.frontend,
        slideshowStatusBloc: h.status,
        config: SlideShowMenuConfig(minPressingMs: 200),
      );
      try {
        await body(tester);
      } finally {
        await tester.runAsync(menu.close);
        await tester.runAsync(h.close);
      }
    });
  }

  Future<void> showMenu(WidgetTester tester) async {
    h.status.add(SlideshowMenuEvent(true));
    await tester.pump();
  }

  Future<void> button(
    WidgetTester tester,
    ButtonType button, {
    ButtonEventType event = ButtonEventType.released,
    int duration = 201,
  }) async {
    await h.rpc.executeCommand(ButtonChangeStateCommand(id: 100, button: button, event: event, durationMs: duration));
    await tester.pump();
  }

  menuTest('released long presses navigate both list boundaries and execute the visible selection', (tester) async {
    await button(tester, ButtonType.button1);
    expect(menu.state.selectedIndex, -1, reason: 'closed menu ignores hardware input');
    await showMenu(tester);
    await button(tester, ButtonType.button1, event: ButtonEventType.pressed, duration: 1000);
    await button(tester, ButtonType.button1, duration: 200);
    expect(menu.state.selectedIndex, -1);
    await button(tester, ButtonType.button1);
    expect(menu.state.selectedIndex, 0);
    await button(tester, ButtonType.button2);
    expect(menu.state.selectedIndex, 4);
    await button(tester, ButtonType.button1);
    expect(menu.state.selectedIndex, 0);
    await button(tester, ButtonType.button1);
    await button(tester, ButtonType.button1);
    expect(menu.state.selectedIndex, 2);
    await button(tester, ButtonType.button3);
    expect(h.route.state.current, RoutePage.config);
    expect(h.status.state.isMenu, isFalse);
    expect(h.backend.requests.whereType<PowerOffCommand>(), isEmpty);
  });

  menuTest('unselected execute is idle and back returns to slideshow without a backend mutation', (tester) async {
    await showMenu(tester);
    menu.add(const MainMenuEvent.execute());
    await tester.pump();
    expect(h.status.state.isMenu, isTrue);
    await button(tester, ButtonType.button0);
    expect(h.status.state.isMenu, isFalse);
    expect(h.backend.requests.whereType<RestartAppCommand>(), isEmpty);
    expect(h.backend.requests.whereType<PowerOffCommand>(), isEmpty);
  });

  menuTest('OTA command changes the running route and closes the menu', (tester) async {
    await showMenu(tester);
    menu.add(const MainMenuEvent.execute(MenuCommand.update));
    await tester.pump();
    expect(h.route.state.current, RoutePage.ota);
    expect(h.status.state.isMenu, isFalse);
  });

  menuTest('power-off waits for acceptance, rejects overlapping mutations and allows explicit retry after failure', (
    tester,
  ) async {
    final previous = Logger.root.level;
    Logger.root.level = Level.ALL;
    final records = <LogRecord>[];
    final subscription = Logger.root.onRecord
        .where((record) => record.loggerName == 'MainMenuBloc')
        .listen(records.add);
    addTearDown(() async {
      await subscription.cancel();
      Logger.root.level = previous;
    });
    await showMenu(tester);
    menu.add(const MainMenuEvent.execute(MenuCommand.powerOff));
    await tester.pump();
    final first = h.backend.requests.whereType<PowerOffCommand>().single;
    expect(h.status.state.isMenu, isTrue);
    menu.add(const MainMenuEvent.execute(MenuCommand.restartApp));
    await tester.pump();
    expect(h.backend.requests.whereType<RestartAppCommand>(), isEmpty);
    h.backend.respond(first, ErrorResult(id: first.id, error: 'https://private-code/private-path'));
    await tester.pump();
    expect(h.status.state.isMenu, isTrue);
    expect(h.backend.requests.whereType<PowerOffCommand>(), hasLength(1));
    menu.add(const MainMenuEvent.execute(MenuCommand.powerOff));
    await tester.pump();
    final retry = h.backend.requests.whereType<PowerOffCommand>().last;
    expect(retry.id, isNot(first.id));
    h.backend.respond(retry, EmptyResult.respond(retry));
    await tester.pump();
    expect(h.status.state.isMenu, isFalse);
    expect(records.any((record) => record.message.startsWith('command failed action=powerOff')), isTrue);
    expect(records.any((record) => record.message.startsWith('command completed action=powerOff')), isTrue);
    expect(records.every((record) => record.error == null && !record.message.contains('private-code')), isTrue);
  });

  menuTest('restart awaits its own RPC and closes the menu only after acceptance', (tester) async {
    await showMenu(tester);
    menu.add(const MainMenuEvent.execute(MenuCommand.restartApp));
    await tester.pump();
    final restart = h.backend.requests.whereType<RestartAppCommand>().single;
    expect(h.status.state.isMenu, isTrue);
    h.backend.respond(restart, EmptyResult.respond(restart));
    await tester.pump();
    expect(h.status.state.isMenu, isFalse);
  });

  menuTest('close releases input subscription and ignores a pending command failure and later hardware input', (
    tester,
  ) async {
    await showMenu(tester);
    menu.add(const MainMenuEvent.execute(MenuCommand.powerOff));
    await tester.pump();
    final command = h.backend.requests.whereType<PowerOffCommand>().single;
    await tester.runAsync(menu.close);
    h.backend.fail(command, StateError('late external response'));
    await button(tester, ButtonType.button3);
    await button(tester, ButtonType.button0);
    expect(menu.isClosed, isTrue);
    expect(h.status.state.isMenu, isTrue);
    expect(h.backend.requests.whereType<PowerOffCommand>(), hasLength(1));
    expect(h.route.state.current, RoutePage.welcome);
  });
}
