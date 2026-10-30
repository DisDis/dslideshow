import 'package:config_app/features/auth/domain/repository/authentication_repository.dart';
import 'package:config_app/features/login/presentation/pages/login_page.dart';
import 'package:config_app/features/login/presentation/bloc/frame_discovery_bloc.dart';
import 'package:config_app/features/login/presentation/bloc/models/connectUri.dart';
import 'package:config_app/injection_container.dart';
import 'package:dslideshow_common/frame_discovery.dart';
import 'package:dslideshow_i18n/i18n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'support/frame_discovery.dart';

final _uri = find.byKey(const Key('loginForm_connectUriInput_textField'));

void main() {
  late ControlledFrameProvider provider;
  late LoginCapture authentication;
  setUp(() {
    provider = ControlledFrameProvider();
    authentication = LoginCapture();
    sl.registerSingleton<FrameDiscoveryProvider>(provider);
    sl.registerSingleton<AuthenticationRepository>(authentication);
  });
  tearDown(() => sl.reset());

  Future<void> mount(WidgetTester tester, {Size size = const Size(900, 1400), double textScale = 1}) async {
    tester.view.physicalSize = size;
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('en'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        builder: (context, child) => MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(textScale)),
          child: child!,
        ),
        home: const LoginPage(),
      ),
    );
    await tester.pump();
  }

  testWidgets('login starts once, selection updates edited field and submits discovered port only on explicit login', (
    tester,
  ) async {
    await mount(tester);
    expect(provider.sessions, hasLength(1));
    await tester.enterText(_uri, 'ws://manual.local:7777/ws');
    provider.sessions.single.controller.add(const FrameDiscoveryUpdate.resolved(firstFrame));
    await tester.pump();
    expect(find.text('ws://manual.local:7777/ws'), findsOneWidget);
    expect(authentication.requests, isEmpty);
    expect(find.byTooltip('Select frame'), findsOneWidget);
    final card = find.byKey(const ValueKey('frame-frame-a'));
    expect(tester.getSize(card).height, lessThan(100));
    final hostLeft = tester.getTopLeft(find.text(firstFrame.hostname)).dx;
    expect(tester.getTopLeft(find.text('192.0.2.8:9091')).dx, closeTo(hostLeft, 0.5));
    expect(tester.getCenter(find.byIcon(Icons.panorama_outlined)).dx, lessThan(hostLeft));
    expect(tester.getCenter(find.byTooltip('Select frame')).dx, greaterThan(hostLeft));
    await tester.tap(find.text('192.0.2.8:9091'));
    await tester.pump();
    expect(find.byTooltip('Selected'), findsOneWidget);
    expect(find.byTooltip('Select frame'), findsNothing);
    expect(find.text('ws://192.0.2.8:9091/ws'), findsOneWidget);
    expect(provider.sessions, hasLength(1));
    expect(authentication.requests, isEmpty);
    final submit = find.byKey(const Key('loginForm_continue_raisedButton'));
    await tester.ensureVisible(submit);
    await tester.tap(submit);
    await tester.pump();
    expect(authentication.requests.single.uri.toString(), 'ws://192.0.2.8:9091/ws');
    expect(authentication.requests.single.username, 'admin');
    expect(authentication.requests.single.password, '123');
    await tester.pumpWidget(const SizedBox.shrink());
    await tester.runAsync(() => provider.sessions.single.closed.future.timeout(const Duration(seconds: 2)));
    expect(provider.sessions.single.closes, 1);
  });

  testWidgets('selection can switch between cards and manual edits remove the selected state', (tester) async {
    await mount(tester);
    final session = provider.sessions.single;
    session.controller
      ..add(const FrameDiscoveryUpdate.resolved(firstFrame))
      ..add(const FrameDiscoveryUpdate.resolved(secondFrame));
    await tester.pump();
    final first = find.byKey(const ValueKey('frame-frame-a'));
    final second = find.byKey(const ValueKey('frame-frame-b'));
    await tester.ensureVisible(first);
    await tester.pump();
    await tester.tap(find.descendant(of: first, matching: find.byTooltip('Select frame')));
    await tester.pump();
    expect(find.descendant(of: first, matching: find.byTooltip('Selected')), findsOneWidget);
    await tester.ensureVisible(second);
    await tester.pump();
    await tester.tap(find.descendant(of: second, matching: find.byTooltip('Select frame')));
    await tester.pump();
    expect(find.descendant(of: second, matching: find.byTooltip('Selected')), findsOneWidget);
    expect(find.descendant(of: first, matching: find.byTooltip('Selected')), findsNothing);
    expect(find.text('ws://192.0.2.9:8080/ws'), findsOneWidget);
    await tester.enterText(_uri, 'ws://manual.local:7777/ws');
    await tester.pump();
    expect(find.byTooltip('Selected'), findsNothing);
    expect(authentication.requests, isEmpty);
    await tester.pumpWidget(const SizedBox.shrink());
    await tester.runAsync(() => session.closed.future.timeout(const Duration(seconds: 2)));
  });

  testWidgets('retry keeps known cards on resolve failure and shows one concise status', (tester) async {
    await mount(tester);
    expect(find.text('Login'), findsNothing);
    expect(find.textContaining('v17.'), findsNothing);
    provider.sessions.single.controller.add(const FrameDiscoveryUpdate.resolved(firstFrame));
    await tester.pump();
    await tester.pump(FrameDiscoveryBloc.defaultSearchDuration);
    await tester.tap(find.byKey(const Key('frame-discovery-retry')));
    await tester.pump();
    expect(find.text(firstFrame.hostname), findsOneWidget);
    provider.sessions.last.controller.add(const FrameDiscoveryUpdate.resolveFailed());
    await tester.pump();
    await tester.pump(FrameDiscoveryBloc.defaultSearchDuration);
    await tester.pump();
    expect(find.text(firstFrame.hostname), findsOneWidget);
    expect(find.text('The list may be incomplete.'), findsOneWidget);
    expect(find.textContaining('No frames found.'), findsNothing);
    await tester.tap(find.byTooltip('Select frame'));
    await tester.pump();
    expect(find.text('ws://192.0.2.8:9091/ws'), findsOneWidget);
    await tester.pumpWidget(const SizedBox.shrink());
    await tester.runAsync(
      () => Future.wait(provider.sessions.map((session) => session.closed.future)).timeout(const Duration(seconds: 2)),
    );
  });

  testWidgets('retry preserves manual credentials and empty search leaves manual login usable', (tester) async {
    await mount(tester);
    await tester.enterText(_uri, 'ws://manual.local:7777/ws');
    await tester.enterText(find.byKey(const Key('loginForm_passwordInput_textField')), 'user-code');
    await tester.pump(FrameDiscoveryBloc.defaultSearchDuration);
    await tester.pump();
    expect(find.textContaining('No frames found.'), findsOneWidget);
    final retry = find.byKey(const Key('frame-discovery-retry'));
    await tester.ensureVisible(retry);
    await tester.tap(retry);
    await tester.pump();
    expect(provider.sessions, hasLength(2));
    expect(find.text('ws://manual.local:7777/ws'), findsOneWidget);
    final submit = find.byKey(const Key('loginForm_continue_raisedButton'));
    await tester.ensureVisible(submit);
    await tester.tap(submit);
    await tester.pump();
    expect(authentication.requests.single.uri.port, 7777);
    expect(authentication.requests.single.password, 'user-code');
    await tester.pumpWidget(const SizedBox.shrink());
    await tester.runAsync(
      () => Future.wait(provider.sessions.map((session) => session.closed.future)).timeout(const Duration(seconds: 2)),
    );
    expect(provider.sessions.every((session) => session.closes == 1), isTrue);
  });

  testWidgets('EN narrow login layout keeps long frame names and address selection usable at text scale 1.5', (
    tester,
  ) async {
    await mount(tester, size: const Size(320, 720), textScale: 1.5);
    final frame = firstFrame.copyWith(hostname: 'a-very-long-living-room-photoframe-with-display.local');
    provider.sessions.single.controller.add(FrameDiscoveryUpdate.resolved(frame));
    await tester.pump();
    expect(find.text(frame.hostname), findsOneWidget);
    final tile = find.text('192.0.2.8:9091');
    await tester.ensureVisible(tile);
    await tester.pump();
    await tester.tap(tile);
    await tester.pump();
    expect(find.text('ws://192.0.2.8:9091/ws'), findsOneWidget);
    expect(tester.takeException(), isNull);
    await tester.pumpWidget(const SizedBox.shrink());
    await tester.runAsync(() => provider.sessions.single.closed.future.timeout(const Duration(seconds: 2)));
  });

  testWidgets('an unresolved announcement shows one failure message instead of empty and partial messages', (
    tester,
  ) async {
    await mount(tester);
    provider.sessions.single.controller.add(const FrameDiscoveryUpdate.resolveFailed());
    await tester.pump();
    await tester.pump(FrameDiscoveryBloc.defaultSearchDuration);
    await tester.pump();
    expect(find.text('Could not refresh the list. Try again.'), findsOneWidget);
    expect(find.textContaining('No frames found.'), findsNothing);
    expect(find.text('The list may be incomplete.'), findsNothing);
    expect(find.text('or enter the address manually'), findsOneWidget);
    await tester.pumpWidget(const SizedBox.shrink());
    await tester.runAsync(() => provider.sessions.single.closed.future.timeout(const Duration(seconds: 2)));
  });

  testWidgets('manual address starts as editable template and enables login after replacing xx', (tester) async {
    await mount(tester);
    final editable = find.descendant(of: _uri, matching: find.byType(EditableText));
    expect(tester.widget<EditableText>(editable).controller.text, ConnectUri.manualTemplate);
    final submit = find.byKey(const Key('loginForm_continue_raisedButton'));
    expect(tester.widget<FilledButton>(submit).onPressed, isNull);
    await tester.enterText(_uri, 'ws://192.168.1.xx:8080/ws');
    await tester.pump();
    expect(tester.widget<FilledButton>(submit).onPressed, isNull);
    await tester.enterText(_uri, 'ws://192.168.50.143:8080/ws');
    await tester.pump();
    expect(find.text('ws://192.168.50.143:8080/ws'), findsOneWidget);
    expect(tester.widget<FilledButton>(submit).onPressed, isNotNull);
    await tester.ensureVisible(submit);
    await tester.tap(submit);
    await tester.pump();
    expect(authentication.requests.single.uri.toString(), 'ws://192.168.50.143:8080/ws');
    await tester.pumpWidget(const SizedBox.shrink());
    await tester.runAsync(() => provider.sessions.single.closed.future.timeout(const Duration(seconds: 2)));
  });
}
