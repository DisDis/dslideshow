import 'dart:async';

import 'package:config_app/features/device/data/device_repository.dart';
import 'package:config_app/features/device/config/router.dart';
import 'package:config_app/features/app/presentation/pages/home_page.dart';
import 'package:config_app/features/device/presentation/device_monitor.dart';
import 'package:config_app/features/device/presentation/pages/device_page.dart';
import 'package:config_app/features/realtime/domain/services/realtime_service.dart';
import 'package:config_app/features/theme/presentation/theme.dart';
import 'package:config_app/features/permission/domain/entities/permission.dart';
import 'package:config_app/features/permission/domain/services/permission_service.dart';
import 'package:config_app/features/uikit/presentation/widgets/navigation_bar/configapp_navigation_bar.dart';
import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_backend/serializers.dart';
import 'package:dslideshow_common/rpc.dart';
import 'package:dslideshow_i18n/i18n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

FrameState _frame({
  bool paused = false,
  bool menu = false,
  bool locked = false,
  FramePage page = FramePage.slideshow,
  bool frontendAvailable = true,
  FramePresence presence = FramePresence.present,
}) => FrameState(
  sampledAt: DateTime.utc(2040, 1, 2, 3, 4, 5),
  presence: presence,
  presenceObservedAt: DateTime.utc(2040, 1, 2, 3),
  isScreenLocked: locked,
  isScreenOn: !locked,
  screenPhase: locked ? FrameScreenPhase.off : FrameScreenPhase.on,
  backendVersion: 'remote-backend-42',
  frontend: frontendAvailable
      ? FrameFrontendState(
          isPaused: paused,
          isMenu: menu,
          page: page,
          frontendVersion: 'remote-frontend-24',
          display: const FrameDisplayInfo(
            physicalWidth: 2560,
            physicalHeight: 1600,
            logicalWidth: 1280,
            logicalHeight: 800,
            pixelRatio: 2,
          ),
        )
      : null,
);

const _metrics = SystemInfo(
  cpuInfo: CpuInfo(
    cores: 4,
    hardware: 'BCM2712',
    model: 'Remote Pi',
    revision: 'remote-revision',
  ),
  networkInfo: NetworkInfo(
    lastUpdate: 1700000000000,
    hasInternet: true,
    interfaces: [
      NetworkInterfaceInfo(
        name: 'wlan0',
        status: NetworkInterfaceStatus.running,
        ip4: '192.0.2.42',
        ip6: '2001:db8::42',
      ),
    ],
  ),
  osInfo: OSInfo(name: 'Remote Linux', osType: OSType.linux),
  updateInfo: UpdateInfo(
    cpuLoad1: 0.25,
    cpuLoad5: 0.5,
    cpuLoad15: 0.75,
    diskAvailable: 2048,
    diskUsed: 1024,
    diskUsedPercent: 33,
    lastUpdate: 1700000000000,
    memTotal: 4096,
    memUsed: 1024,
    sensors: [SensorInfo(name: 'Remote fan', value: '0 RPM')],
    swapTotal: 2048,
    swapUsed: 0,
    uptime: 'up 3 days',
  ),
);

class _UnusedClient implements RealtimeService {
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _ConnectedClient extends _UnusedClient {
  final disconnectEvents = StreamController<void>.broadcast();
  int metricsReads = 0;
  @override
  Uri get connectUri => Uri.parse('ws://frame.example/ws');
  @override
  Stream<void> get onDisconnect => disconnectEvents.stream;
  @override
  Future<WebSocketResult> send(
    WebSocketCommand command, {
    Duration? timeout,
  }) async {
    final request = serializers.deserialize(
      (command as WSSendRpcCommand).commandData,
    );
    final RpcResult result;
    if (request is GetSystemInfoCommand) {
      metricsReads++;
      result = GetSystemInfoCommandResult(id: request.id, systemInfo: _metrics);
    } else {
      result = GetFrameStateResult(
        id: (request as GetFrameStateCommand).id,
        state: _frame(),
      );
    }
    return WSRpcResult.byCommand(result, command);
  }
}

class _Repository extends DeviceRepository {
  _Repository(this.state) : super(_UnusedClient());
  FrameState state;
  final disconnect = StreamController<void>.broadcast();
  final commands = <(FrameControl, bool)>[];
  Completer<FrameState>? pending;
  bool fail = false;
  @override
  Stream<void> get onDisconnect => disconnect.stream;
  @override
  Future<FrameState> getState() async => state;
  @override
  Future<SystemInfo> getSystemInfo() async => _metrics;
  @override
  Future<FrameState> setControl(FrameControl control, bool enabled) async {
    commands.add((control, enabled));
    if (fail) throw const DeviceFailure(DeviceFailureKind.command);
    if (pending != null) return pending!.future;
    state = _frame(
      paused: control == FrameControl.pause
          ? enabled
          : state.frontend!.isPaused,
      menu: control == FrameControl.menu ? enabled : state.frontend!.isMenu,
      locked: control == FrameControl.screen ? !enabled : state.isScreenLocked,
    );
    return state;
  }
}

Widget _app(
  DeviceMonitor monitor,
  DeviceSection section, {
  Locale locale = const Locale('ru'),
  bool dark = false,
  double scale = 1,
}) => MaterialApp(
  locale: locale,
  localizationsDelegates: AppLocalizations.localizationsDelegates,
  supportedLocales: AppLocalizations.supportedLocales,
  theme: dark ? createDarkTheme() : createLightTheme(),
  builder: (context, child) => MediaQuery(
    data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(scale)),
    child: child!,
  ),
  home: DevicePage(section: section, monitor: monitor),
);

void main() {
  Future<void> close(WidgetTester tester, _Repository repository) async {
    await tester.pumpWidget(const SizedBox.shrink());
    await repository.disconnect.close();
  }

  testWidgets('both destinations route from the shared navigation using RPC', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1280, 960);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await GetIt.instance.reset();
    final client = _ConnectedClient();
    GetIt.instance.registerSingleton<RealtimeService>(client);
    GetIt.instance.registerSingleton<PermissionService>(
      PermissionService()..loadData([Permission.NONE.id]),
    );
    final router = GoRouter(
      routes: [
        GoRoute(path: '/', builder: (context, state) => const HomePage()),
        createDeviceRoute(DeviceSection.telemetry),
        createDeviceRoute(DeviceSection.controls),
      ],
    );
    addTearDown(() async {
      router.dispose();
      await client.disconnectEvents.close();
      await GetIt.instance.reset();
    });
    await tester.pumpWidget(
      MaterialApp.router(
        routerConfig: router,
        locale: const Locale('ru'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        theme: createLightTheme(),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey(AppDestination.telemetry)));
    await tester.pumpAndSettle();
    expect(router.routeInformationProvider.value.uri.path, '/telemetry');
    expect(client.metricsReads, 1);
    expect(
      tester
          .widget<ListTile>(
            find.byKey(const ValueKey(AppDestination.telemetry)),
          )
          .selected,
      isTrue,
    );
    await tester.tap(find.byKey(const ValueKey(AppDestination.control)));
    await tester.pumpAndSettle();
    expect(router.routeInformationProvider.value.uri.path, '/device_control');
    expect(find.byKey(const ValueKey('device-pause')), findsOneWidget);
    await tester.pump(const Duration(seconds: 11));
    expect(client.metricsReads, 1);
    expect(tester.takeException(), isNull);
    await tester.pumpWidget(const SizedBox.shrink());
  });

  testWidgets('three controls send absolute intents and update labels', (
    tester,
  ) async {
    final repository = _Repository(_frame());
    final monitor = DeviceMonitor(repository, telemetry: false);
    await tester.pumpWidget(_app(monitor, DeviceSection.controls));
    await tester.pumpAndSettle();
    for (final key in ['device-pause', 'device-menu', 'device-screen']) {
      final button = find.byKey(ValueKey(key));
      await tester.ensureVisible(button);
      await tester.tap(button);
      await tester.pumpAndSettle();
    }
    expect(repository.commands, [
      (FrameControl.pause, true),
      (FrameControl.menu, true),
      (FrameControl.screen, false),
    ]);
    expect(find.text('Продолжить'), findsOneWidget);
    expect(find.text('Закрыть меню'), findsOneWidget);
    expect(find.text('Включить экран'), findsOneWidget);
    expect(tester.takeException(), isNull);
    await close(tester, repository);
  });

  testWidgets('in-flight command disables actions and errors preserve state', (
    tester,
  ) async {
    final repository = _Repository(_frame())..pending = Completer<FrameState>();
    final monitor = DeviceMonitor(repository, telemetry: false);
    await tester.pumpWidget(_app(monitor, DeviceSection.controls));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.byKey(const ValueKey('device-pause')));
    await tester.tap(find.byKey(const ValueKey('device-pause')));
    await tester.pump();
    final menu = tester.widget<FilledButton>(
      find.byKey(const ValueKey('device-menu')),
    );
    expect(menu.onPressed, isNull);
    repository.pending!.completeError(
      const DeviceFailure(DeviceFailureKind.command),
    );
    await tester.pumpAndSettle();
    expect(
      find.text(
        'Не удалось подтвердить команду. Обновите состояние перед повтором.',
      ),
      findsOneWidget,
    );
    expect(monitor.frame!.frontend!.isPaused, isFalse);
    expect(monitor.canControl, isFalse);
    await close(tester, repository);
  });

  testWidgets('unknown screen power offers an explicit wake command', (
    tester,
  ) async {
    final known = _frame();
    final repository = _Repository(
      FrameState(
        sampledAt: known.sampledAt,
        presence: known.presence,
        isScreenLocked: false,
        isScreenOn: null,
        screenPhase: FrameScreenPhase.failed,
        backendVersion: known.backendVersion,
        frontend: known.frontend,
      ),
    );
    final monitor = DeviceMonitor(repository, telemetry: false);
    await tester.pumpWidget(_app(monitor, DeviceSection.controls));
    await tester.pumpAndSettle();
    expect(find.text('Включить экран'), findsOneWidget);
    await tester.tap(find.byKey(const ValueKey('device-screen')));
    await tester.pumpAndSettle();
    expect(repository.commands, [(FrameControl.screen, true)]);
    await close(tester, repository);
  });

  for (final page in [FramePage.config, FramePage.ota, FramePage.unknown]) {
    testWidgets('pause and menu disabled on $page', (tester) async {
      final repository = _Repository(_frame(page: page));
      final monitor = DeviceMonitor(repository, telemetry: false);
      await tester.pumpWidget(_app(monitor, DeviceSection.controls));
      await tester.pumpAndSettle();
      expect(
        tester
            .widget<FilledButton>(find.byKey(const ValueKey('device-pause')))
            .onPressed,
        isNull,
      );
      expect(
        tester
            .widget<FilledButton>(find.byKey(const ValueKey('device-menu')))
            .onPressed,
        isNull,
      );
      expect(
        tester
            .widget<FilledButton>(find.byKey(const ValueKey('device-screen')))
            .onPressed,
        isNotNull,
      );
      await close(tester, repository);
    });
  }

  testWidgets(
    'unavailable frontend disables all actions and presence can be unknown',
    (tester) async {
      final repository = _Repository(
        _frame(frontendAvailable: false, presence: FramePresence.unknown),
      );
      final monitor = DeviceMonitor(repository, telemetry: false);
      await tester.pumpWidget(_app(monitor, DeviceSection.controls));
      await tester.pumpAndSettle();
      expect(find.text('Неизвестно'), findsOneWidget);
      for (final key in ['device-pause', 'device-menu', 'device-screen']) {
        expect(
          tester.widget<FilledButton>(find.byKey(ValueKey(key))).onPressed,
          isNull,
        );
      }
      await close(tester, repository);
    },
  );

  const locale = Locale('en');
  for (final dark in [false, true]) {
    testWidgets('remote telemetry, narrow layout, $locale dark=$dark', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(390, 900);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      final repository = _Repository(_frame());
      final monitor = DeviceMonitor(repository, telemetry: true);
      await tester.pumpWidget(
        _app(
          monitor,
          DeviceSection.telemetry,
          locale: locale,
          dark: dark,
          scale: 1.5,
        ),
      );
      await tester.pumpAndSettle();
      expect(find.textContaining('2040'), findsWidgets);
      final scrollable = find
          .descendant(
            of: find.byKey(const ValueKey('device-content')),
            matching: find.byType(Scrollable),
          )
          .first;
      await tester.scrollUntilVisible(
        find.text('remote-frontend-24'),
        500,
        scrollable: scrollable,
      );
      expect(find.text('remote-backend-42'), findsOneWidget);
      expect(find.textContaining('2\u00a0560'), findsNothing);
      final expectedSize = '2,560 × 1,600 px';
      expect(find.text(expectedSize), findsOneWidget);
      await tester.scrollUntilVisible(
        find.text('0 RPM'),
        500,
        scrollable: scrollable,
      );
      expect(find.text('0 RPM'), findsOneWidget);
      expect(tester.takeException(), isNull);
      await close(tester, repository);
    });
  }

  testWidgets('disconnect keeps last data and disables commands', (
    tester,
  ) async {
    final repository = _Repository(_frame());
    final monitor = DeviceMonitor(repository, telemetry: false);
    await tester.pumpWidget(_app(monitor, DeviceSection.controls));
    await tester.pumpAndSettle();
    repository.disconnect.add(null);
    await tester.pumpAndSettle();
    expect(find.text('Последние полученные данные устарели.'), findsOneWidget);
    expect(find.text('Человек рядом'), findsOneWidget);
    expect(
      tester
          .widget<FilledButton>(find.byKey(const ValueKey('device-pause')))
          .onPressed,
      isNull,
    );
    await close(tester, repository);
  });
}
