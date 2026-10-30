import 'package:bloc/bloc.dart';
import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_flutter/features/ota/presentation/bloc/ota_bloc.dart';
import 'package:dslideshow_flutter/features/ota/presentation/bloc/ota_event.dart';
import 'package:dslideshow_flutter/features/ota/presentation/bloc/ota_state.dart';
import 'package:dslideshow_flutter/features/ota/presentation/bloc/terminal_backend.dart';
import 'package:dslideshow_flutter/features/ota/presentation/widgets/ota_view.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/pages/slideshow_page.dart';
import 'package:dslideshow_flutter/src/route_bloc.dart';
import 'package:dslideshow_flutter/src/service/frontend.dart' show ButtonEvent;
import 'package:flutter_test/flutter_test.dart';
import 'package:logging/logging.dart';
import 'package:xterm/xterm.dart';

import 'support/frame_app_harness.dart';
import 'support/ota_frontend.dart';

const _ready = OTAInfo(status: OTAStatus.ready, uploadingPercent: 0, code: 'review');
const _failed = OTAInfo(
  status: OTAStatus.issue,
  uploadingPercent: 100,
  code: 'review',
  exitCode: 17,
  errorText: 'synthetic terminal failure',
);
final _failureId = RegExp(r'failureId=([0-9]+)');

enum _CancellationAction { manual, route, exit, close }

class _BeforeReturnObserver extends BlocObserver {
  _BeforeReturnObserver(this.beforeReturn);

  final void Function() beforeReturn;

  @override
  void onEvent(Bloc<dynamic, dynamic> bloc, Object? event) {
    super.onEvent(bloc, event);
    if (event is OtaReturnAfterFailureEvent) beforeReturn();
  }
}

class _Fixture {
  _Fixture({bool pendingInfo = false}) {
    if (!pendingInfo) frontend.infoResult.complete(_ready);
    frontend.systemResult.complete(otaSystemInfo());
    bloc = OtaBloc(frontendService: frontend, backend: TerminalBackend(Terminal()), routeBloc: routes);
    routes.add(ChangePageEvent(RoutePage.ota));
  }

  final frontend = OtaTestFrontend();
  final routes = RouteBloc();
  late final OtaBloc bloc;
  bool _closed = false;

  Future<void> initialize(WidgetTester tester) async {
    await tester.pump();
    bloc.add(const OtaEvent.initialization());
    await tester.pump();
  }

  Future<void> update(WidgetTester tester, OTAInfo info) async {
    frontend.infoEvents.add(info);
    await tester.pump();
  }

  Future<void> close() async {
    if (_closed) return;
    _closed = true;
    await bloc.close();
    await routes.close();
    await frontend.close();
  }
}

void main() {
  testWidgets('a confirmed failure returns exactly once at 30s without extending on repeats', (tester) async {
    final fixture = _Fixture();
    addTearDown(fixture.close);
    final records = <LogRecord>[];
    final previous = Logger.root.level;
    Logger.root.level = Level.ALL;
    final logs = Logger.root.onRecord.listen(records.add);
    addTearDown(() async {
      await logs.cancel();
      Logger.root.level = previous;
    });
    final transitions = <RoutePage>[];
    final routeSubscription = fixture.routes.stream.listen((s) => transitions.add(s.current));
    addTearDown(routeSubscription.cancel);
    await fixture.initialize(tester);
    await fixture.update(tester, _failed);
    await tester.pump(const Duration(seconds: 10));
    await fixture.update(tester, _failed);
    await tester.pump(const Duration(milliseconds: 19999));
    expect(fixture.routes.state.current, RoutePage.ota);
    expect(fixture.bloc.state, isA<OtaFailureState>());
    await tester.pump(const Duration(milliseconds: 1));
    expect(fixture.routes.state.current, RoutePage.slideshow);
    expect(transitions.where((page) => page == RoutePage.slideshow), hasLength(1));
    expect(fixture.bloc.state.info, _failed);
    final scheduled = records.singleWhere((r) => r.message.contains('event=failureReturnScheduled'));
    final completed = records.singleWhere((r) => r.message.contains('event=failureReturnCompleted'));
    expect(_failureId.firstMatch(completed.message)?.group(1), _failureId.firstMatch(scheduled.message)?.group(1));
  });

  for (final status in OTAStatus.values.where((s) => s != OTAStatus.issue)) {
    testWidgets('$status cancels an older failure return', (tester) async {
      final fixture = _Fixture();
      addTearDown(fixture.close);
      await fixture.initialize(tester);
      await fixture.update(tester, _failed);
      await tester.pump(const Duration(seconds: 10));
      await fixture.update(tester, _ready.copyWith(status: status));
      await tester.pump(const Duration(seconds: 31));
      expect(fixture.routes.state.current, RoutePage.ota);
    });
  }

  testWidgets('a subsequent attempt owns a fresh 30s deadline', (tester) async {
    final fixture = _Fixture();
    addTearDown(fixture.close);
    final records = <LogRecord>[];
    final previous = Logger.root.level;
    Logger.root.level = Level.ALL;
    final logs = Logger.root.onRecord.listen(records.add);
    addTearDown(() async {
      await logs.cancel();
      Logger.root.level = previous;
    });
    await fixture.initialize(tester);
    await fixture.update(tester, _failed);
    final scheduled = records.firstWhere((record) => record.message.contains('event=failureReturnScheduled '));
    final oldGeneration = int.parse(_failureId.firstMatch(scheduled.message)!.group(1)!);
    await tester.pump(const Duration(seconds: 10));
    await fixture.update(tester, _ready.copyWith(status: OTAStatus.uploading));
    await tester.pump(const Duration(seconds: 5));
    await fixture.update(tester, _failed.copyWith(exitCode: 23));
    // Simulate a timer event queued before cancellation, delivered to a new failure.
    fixture.bloc.add(OtaEvent.returnAfterFailure(oldGeneration));
    await tester.pump();
    expect(fixture.routes.state.current, RoutePage.ota);
    await tester.pump(const Duration(seconds: 15));
    expect(fixture.routes.state.current, RoutePage.ota);
    await tester.pump(const Duration(seconds: 15));
    expect(fixture.routes.state.current, RoutePage.slideshow);
  });

  testWidgets('a new status cancels a fired timer before its return event is handled', (tester) async {
    late final _Fixture fixture;
    var returnEvents = 0;
    final previousObserver = Bloc.observer;
    Bloc.observer = _BeforeReturnObserver(() {
      if (++returnEvents == 1) {
        fixture.frontend.infoEvents.add(_ready.copyWith(status: OTAStatus.uploading));
      }
    });
    addTearDown(() => Bloc.observer = previousObserver);
    fixture = _Fixture();
    addTearDown(fixture.close);
    await fixture.initialize(tester);
    await fixture.update(tester, _failed);

    await tester.pump(const Duration(seconds: 30));
    expect(returnEvents, 1);
    expect(fixture.routes.state.current, RoutePage.ota);
    expect(fixture.bloc.state, isA<OtaProgressState>());

    await fixture.update(tester, _failed.copyWith(exitCode: 23));
    await tester.pump(const Duration(milliseconds: 29999));
    expect(fixture.routes.state.current, RoutePage.ota);
    await tester.pump(const Duration(milliseconds: 1));
    expect(fixture.routes.state.current, RoutePage.slideshow);
    expect(returnEvents, 2);
  });

  testWidgets('a local info RPC failure does not invent a terminal update failure', (tester) async {
    final fixture = _Fixture(pendingInfo: true);
    addTearDown(fixture.close);
    await fixture.initialize(tester);
    fixture.frontend.infoResult.completeError(StateError('transport failed'));
    await tester.pump();
    expect(fixture.bloc.state, isA<OtaFailureState>());
    await tester.pump(const Duration(seconds: 31));
    expect(fixture.routes.state.current, RoutePage.ota);
  });

  for (final action in _CancellationAction.values) {
    testWidgets('$action cancels the old deadline and cannot steal a later page', (tester) async {
      final fixture = _Fixture();
      addTearDown(fixture.close);
      await fixture.initialize(tester);
      await fixture.update(tester, _failed);
      await tester.pump(const Duration(seconds: 5));
      switch (action) {
        case _CancellationAction.manual:
          fixture.frontend.buttons.add(
            ButtonEvent(button: ButtonType.button0, event: ButtonEventType.released, durationMs: 1000),
          );
          break;
        case _CancellationAction.route:
          fixture.routes.add(ChangePageEvent(RoutePage.config));
          break;
        case _CancellationAction.exit:
          fixture.bloc.add(const OtaEvent.exit());
          break;
        case _CancellationAction.close:
          await tester.runAsync(fixture.bloc.close);
          break;
      }
      await tester.pump();
      fixture.routes.add(ChangePageEvent(RoutePage.config));
      await tester.pump();
      await tester.pump(const Duration(seconds: 31));
      expect(fixture.routes.state.current, RoutePage.config);
    });
  }

  testWidgets('MainApp actually replaces a failed OTA page with the working slideshow at 30s', (tester) async {
    final frontend = OtaTestFrontend()
      ..infoResult.complete(_failed)
      ..systemResult.complete(otaSystemInfo());
    final routes = await mountFrameOtaApp(
      tester,
      otaFrontend: frontend,
      config: AppConfig.fromJson({
        'ota': {'alwaysEnabled': true},
      }),
    );
    expect(find.byType(OTAView), findsOneWidget);
    await tester.pump(const Duration(milliseconds: 29999));
    expect(find.byType(OTAView), findsOneWidget);
    expect(find.byType(SlideShowPage), findsNothing);
    await tester.pump(const Duration(milliseconds: 1));
    await tester.pump();
    expect(routes.state.current, RoutePage.slideshow);
    expect(find.byType(OTAView), findsNothing);
    expect(find.byType(SlideShowPage), findsOneWidget);
    expect(frontend.loads, greaterThan(0));
    expect(tester.takeException(), isNull);
  });
}
