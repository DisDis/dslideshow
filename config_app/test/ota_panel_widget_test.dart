import 'dart:async';

import 'package:config_app/features/ota/presentation/bloc/ota_bloc.dart';
import 'package:config_app/features/ota/presentation/bloc/ota_state.dart';
import 'package:config_app/features/ota/presentation/pages/ota_main_page.dart';
import 'package:dslideshow_i18n/i18n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import 'support/ota_panel_support.dart';

Widget _app(OtaBloc bloc) => MaterialApp(
  locale: const Locale('en'),
  localizationsDelegates: AppLocalizations.localizationsDelegates,
  supportedLocales: AppLocalizations.supportedLocales,
  home: Scaffold(
    body: BlocProvider<OtaBloc>.value(
      value: bloc,
      child: const OtaPageContent(),
    ),
  ),
);

void main() {
  testWidgets(
    'file selection needs explicit submit; rebuild preserves code and reset clears it',
    (tester) async {
      TestFirmwareFile? selection = TestFirmwareFile();
      final gateway = ControlledOtaClient()..upload = Completer<void>();
      final bloc = OtaBloc(
        initialState: const OtaState(phase: OtaPhase.ready, version: '1'),
        client: PanelRealtime(),
        picker: () async => selection,
        otaClientFactory: (_) => gateway,
      );
      addTearDown(bloc.close);
      await tester.pumpWidget(_app(bloc));
      final submit = find.byKey(const ValueKey('ota-upload'));
      expect(tester.widget<FilledButton>(submit).onPressed, isNull);
      await tester.enterText(find.byType(TextFormField), '00 text-code');
      await tester.tap(find.byKey(const ValueKey('ota-select-file')));
      await tester.pumpAndSettle();
      expect(find.text('Selected: firmware.deb'), findsOneWidget);
      expect(gateway.uploads, 0);
      expect(tester.widget<FilledButton>(submit).onPressed, isNotNull);
      await tester.pumpWidget(_app(bloc));
      expect(
        tester.widget<TextField>(find.byType(TextField)).controller!.text,
        '00 text-code',
      );

      selection = null;
      await tester.tap(find.byKey(const ValueKey('ota-select-file')));
      await tester.pumpAndSettle();
      expect(find.byKey(const ValueKey('ota-selected-file')), findsNothing);
      expect(tester.widget<FilledButton>(submit).onPressed, isNull);
      selection = TestFirmwareFile(name: 'selected-again.deb');
      await tester.tap(find.byKey(const ValueKey('ota-select-file')));
      await tester.pumpAndSettle();
      await tester.tap(submit);
      await tester.pump();
      expect(gateway.uploads, 1);
      expect(gateway.sentCode, '00 text-code');
      expect(tester.widget<TextField>(find.byType(TextField)).enabled, isFalse);
      expect(tester.widget<FilledButton>(submit).onPressed, isNull);

      await tester.tap(find.byKey(const ValueKey('ota-reset')));
      await tester.pumpAndSettle();
      expect(find.byType(TextFormField), findsNothing);
      expect(bloc.state.phase, OtaPhase.uninitialized);
      expect(gateway.closes, 1);
      gateway.upload!.complete();
      await tester.tap(find.widgetWithText(FilledButton, 'Initialize'));
      await tester.pumpAndSettle();
      expect(
        tester.widget<TextField>(find.byType(TextField)).controller!.text,
        isEmpty,
      );
      expect(find.byKey(const ValueKey('ota-selected-file')), findsNothing);
      expect(tester.widget<FilledButton>(submit).onPressed, isNull);
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets('unmount closes an in-flight upload and ignores late result', (
    tester,
  ) async {
    final gateway = ControlledOtaClient()..upload = Completer<void>();
    final bloc = OtaBloc(
      initialState: const OtaState(phase: OtaPhase.ready, version: '1'),
      client: PanelRealtime(),
      picker: () async => TestFirmwareFile(),
      otaClientFactory: (_) => gateway,
    );
    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('en'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: BlocProvider<OtaBloc>(
            create: (_) => bloc,
            child: const OtaPageContent(),
          ),
        ),
      ),
    );
    await tester.enterText(find.byType(TextFormField), 'code');
    await tester.tap(find.byKey(const ValueKey('ota-select-file')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('ota-upload')));
    await tester.pump();
    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump();
    expect(gateway.closes, 1);
    gateway.upload!.complete();
    await tester.pumpAndSettle();
    var closeDone = false;
    unawaited(bloc.close().then((_) => closeDone = true));
    await tester.pump();
    // Provider already owns disposal. Flush the real stream completion boundary
    // before checking its close future; no second teardown owns the same Bloc.
    await tester.runAsync(() => Future<void>(() {}));
    await tester.pump();
    expect(closeDone, isTrue);
    expect(bloc.isClosed, isTrue);
    expect(tester.takeException(), isNull);
  });
}
