import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_flutter/features/header/presentation/widgets/buttons_hint/buttons_hint.dart';
import 'package:dslideshow_flutter/features/header/presentation/widgets/buttons_hint/button_hint_action.dart';
import 'package:dslideshow_flutter/features/config/presentation/bloc/config_state.dart';
import 'package:dslideshow_flutter/features/shared/presentation/widgets/access_layout.dart';
import 'package:dslideshow_flutter/src/route_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'support/config_harness.dart';
import 'support/ota_frontend.dart';

void main() {
  configWidgetTest(
    'page prepares, paints connection details, refreshes and returns',
    (tester, h) async {
      await h.mount(tester);
      expect(find.text('Starting settings access…'), findsOneWidget);
      expect(find.byType(QrImageView), findsNothing);
      h.frontend.starts.single.complete('83472');
      await tester.pump();
      expect(find.text('83472'), findsOneWidget);
      expect(find.text('Finding the local network address…'), findsOneWidget);
      h.frontend.systems.single.complete(otaSystemInfo());
      await tester.pump();
      expect(
        tester.widget<AccessQrCode>(find.byType(AccessQrCode)).address,
        'http://192.168.50.143:8080',
      );
      await tester.tap(find.byKey(const Key('config-retry')));
      await tester.pump();
      expect(find.text('Checking the network…'), findsOneWidget);
      expect(find.byType(QrImageView), findsOneWidget);
      h.frontend.systems.last.complete(otaSystemInfo(interfaces: []));
      await tester.pump();
      expect(h.bloc.state.phase, ConfigPhase.addressUnavailable);
      expect(find.byIcon(Icons.wifi_off), findsOneWidget);
      expect(find.byIcon(Icons.lan_outlined), findsNothing);
      expect(find.byType(QrImageView), findsNothing);
      h.frontend.networkEvents.add(otaSystemInfo());
      await tester.pump();
      h.frontend.holdStop = true;
      await tester.tap(find.byKey(const Key('config-return')));
      await tester.pump();
      expect(find.text('Closing settings access…'), findsOneWidget);
      expect(find.byType(ButtonsHintWidget), findsNothing);
      expect(find.byType(QrImageView), findsNothing);
      expect(find.text('83472'), findsNothing);
      h.frontend.stops.single.complete();
      await tester.pump();
      expect(h.routes.state.current, RoutePage.slideshow);
      expect(h.frontend.starts, hasLength(1));
      expect(tester.takeException(), isNull);
    },
  );

  configWidgetTest(
    'unknown error and failed shutdown offer actionable recovery',
    (tester, h) async {
      await h.mount(tester);
      h.frontend.starts.single.completeError(StateError('internal secret'));
      h.frontend.systems.single.complete(otaSystemInfo());
      await tester.pump();
      expect(
        find.text('Unable to prepare settings access. Try again.'),
        findsOneWidget,
      );
      expect(find.text('internal secret'), findsNothing);
      h.frontend.holdStop = true;
      await tester.tap(find.byKey(const Key('config-return')));
      await tester.pump();
      h.frontend.stops.single.completeError(Exception('refused'));
      await tester.pump();
      expect(find.text('Return without confirmation'), findsOneWidget);
      expect(
        tester
            .widget<ButtonsHintWidget>(find.byType(ButtonsHintWidget))
            .bindings![ButtonType.button0]!
            .action,
        ButtonHintAction.returnUnconfirmed,
      );
      expect(
        find.descendant(
          of: find.byKey(const Key('config-return')),
          matching: find.byIcon(ButtonHintAction.returnUnconfirmed.icon),
        ),
        findsOneWidget,
      );
      await tester.tap(find.byKey(const Key('config-return')));
      await tester.pump();
      expect(h.routes.state.current, RoutePage.slideshow);
    },
  );

  for (final size in [
    const Size(2560, 1600),
    const Size(800, 600),
    const Size(400, 700),
  ]) {
    configWidgetTest(
      'responsive English layout at $size with large text and a long code',
      (tester, h) async {
        await h.mount(tester, size: size, textScale: 1.5);
        h.frontend.starts.single.complete('LONG-PERMANENT-ACCESS-CODE');
        h.frontend.systems.single.complete(otaSystemInfo());
        await tester.pump();
        expect(find.byType(QrImageView), findsOneWidget);
        await tester.ensureVisible(find.byKey(const Key('config-return')));
        await tester.pump();
        expect(
          find.byKey(const Key('config-return')).hitTestable(),
          findsOneWidget,
        );
        expect(tester.takeException(), isNull);
      },
    );
  }

  configWidgetTest('always enabled closing text describes persistent access', (
    tester,
    h,
  ) async {
    await h.mount(tester, alwaysEnabled: true);
    h.frontend.starts.single.complete('83472');
    h.frontend.systems.single.complete(otaSystemInfo());
    await tester.pump();
    h.frontend.holdStop = true;
    await tester.tap(find.byKey(const Key('config-return')));
    await tester.pump();
    expect(
      find.text(
        'Closing this screen. Settings access stays enabled by configuration.',
      ),
      findsOneWidget,
    );
    expect(tester.takeException(), isNull);
  });
}
