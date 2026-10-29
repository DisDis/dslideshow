import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_flutter/src/frame_language.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'support/frame_app_harness.dart';

void main() {
  test(
    'configured frame languages select a locale or delegate to the system',
    () {
      expect(FrameLanguage.system.locale, isNull);
      expect(FrameLanguage.en.locale, const Locale('en'));
      expect(FrameLanguage.ru.locale, const Locale('ru'));
      expect(AppConfig.fromJson({}).language.locale, const Locale('en'));
      expect(
        AppConfig.fromJson({'language': 'unsupported'}).language.locale,
        const Locale('en'),
      );
    },
  );

  testWidgets('the configured Russian language reaches the real OTA page', (
    tester,
  ) async {
    await mountFrameOtaApp(
      tester,
      config: AppConfig.fromJson({'language': 'ru'}),
    );
    expect(find.text('83472'), findsOneWidget);
    expect(find.text('Готово к обновлению'), findsOneWidget);
    expect(find.text('Текущая версия'), findsOneWidget);
    expect(find.text('Код доступа'), findsOneWidget);
    expect(find.text('Update firmware'), findsNothing);
    expect(tester.takeException(), isNull);
  });
}
