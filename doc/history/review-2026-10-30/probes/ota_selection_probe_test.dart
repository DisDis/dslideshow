// Review evidence: reproduces the current missing-selection failure in VM.
import 'package:config_app/features/ota/presentation/bloc/ota_bloc.dart';
import 'package:config_app/features/ota/presentation/bloc/ota_state.dart';
import 'package:config_app/features/ota/presentation/pages/ota_main_page.dart';
import 'package:dslideshow_i18n/i18n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../config_app/test/support/gallery_management_harness.dart'
    show GalleryTestClient;

void main() {
  testWidgets('Update without a selected file throws before Bloc validation', (
    tester,
  ) async {
    final bloc = OtaBloc(
      initialState: const InitializedOtaState(version: 'review'),
      client: GalleryTestClient(),
    );
    addTearDown(bloc.close);
    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('en'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: BlocProvider.value(value: bloc, child: const OtaPageContent()),
        ),
      ),
    );
    await tester.tap(find.widgetWithText(ElevatedButton, 'Update'));
    final error = tester.takeException();
    expect(error, isA<TypeError>());
    expect(bloc.state, isA<InitializedOtaState>());
  });
}
