import 'package:config_app/features/device/presentation/rpc_rates.dart';
import 'package:config_app/features/device/presentation/widgets/rpc_telemetry_section.dart';
import 'package:dslideshow_common/rpc.dart';
import 'package:dslideshow_i18n/i18n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

RpcTelemetrySnapshot snapshot() => RpcTelemetrySnapshot(
  nodes: [
    RpcNodeSnapshot(
      node: RpcNode.backend,
      sessionId: 'backend-run',
      sampledAt: DateTime.utc(2026),
      elapsedMicros: 1000000,
      connections: [
        const RpcConnectionSnapshot(
          peer: RpcNode.frontend,
          outgoing: RpcQueueSnapshot(
            capacity: 25,
            inFlight: 25,
            queued: 7,
            maxInFlight: 25,
            maxQueued: 9,
            submitted: 100,
            sent: 100,
            responses: 75,
            oldestInFlight: RpcPendingSnapshot(
              commandType: 'get_system_info',
              ageMicros: 12340000,
            ),
          ),
          incoming: RpcHandlerSnapshot(),
        ),
      ],
    ),
    RpcNodeSnapshot(
      node: RpcNode.frontend,
      sessionId: 'frontend-run',
      sampledAt: DateTime.utc(2026),
      elapsedMicros: 1000000,
      stale: true,
      connections: [
        const RpcConnectionSnapshot(
          peer: RpcNode.backend,
          outgoing: RpcQueueSnapshot(capacity: 25),
          incoming: RpcHandlerSnapshot(active: 3, completed: 72, errors: 2),
        ),
      ],
    ),
  ],
);

void main() {
  const locale = 'en';
  for (final width in [360.0, 1200.0]) {
    testWidgets(
      'RPC occupancy, receiver metrics and stale data $locale $width',
      (tester) async {
        tester.view.physicalSize = Size(width, 1800);
        tester.view.devicePixelRatio = 1;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);
        await tester.pumpWidget(
          MaterialApp(
            locale: Locale(locale),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            theme: ThemeData(
              brightness: width == 360 ? Brightness.dark : Brightness.light,
            ),
            home: Scaffold(
              body: SingleChildScrollView(
                child: MediaQuery(
                  data: MediaQueryData(textScaler: TextScaler.linear(1.5)),
                  child: RpcTelemetrySection(
                    snapshot: snapshot(),
                    stale: false,
                    rates: RpcRates(),
                    webSocketTimeouts: 4,
                  ),
                ),
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();
        expect(find.textContaining('25/25'), findsOneWidget);
        final tile = find.byKey(const ValueKey('rpc-backend-frontend'));
        await tester.ensureVisible(tile);
        await tester.tap(tile);
        await tester.pumpAndSettle();
        expect(find.textContaining('get_system_info'), findsOneWidget);
        expect(find.text('72'), findsOneWidget);
        expect(tester.takeException(), isNull);
      },
    );
  }

  testWidgets('old software shows missing metrics without fabricated zeros', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: RpcTelemetrySection(
            snapshot: null,
            stale: true,
            rates: RpcRates(),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('No RPC data'), findsNWidgets(4));
    expect(find.textContaining('0/25'), findsNothing);
    expect(tester.takeException(), isNull);
  });
}
