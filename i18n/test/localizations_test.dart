import 'dart:convert';
import 'dart:io';

import 'package:dslideshow_i18n/i18n.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

Map<String, dynamic> _messages(String locale) =>
    jsonDecode(File('app_$locale.arb').readAsStringSync())
        as Map<String, dynamic>;

void main() {
  test('Russian translations cover every English message', () {
    final english = _messages('en');
    final russian = _messages('ru');

    expect(russian.keys.toSet(), english.keys.toSet());
    for (final entry in russian.entries) {
      if (entry.key.startsWith('@')) continue;
      expect(entry.value, isA<String>(), reason: entry.key);
      expect((entry.value as String).trim(), isNotEmpty, reason: entry.key);
    }
  });

  test('Russian messages preserve placeholder metadata and substitutions', () {
    final english = _messages('en');
    final russian = _messages('ru');

    for (final entry in english.entries) {
      if (!entry.key.startsWith('@')) continue;
      expect(russian[entry.key], entry.value, reason: entry.key);
      final metadata = entry.value as Map<String, dynamic>;
      final placeholders = metadata['placeholders'] as Map<String, dynamic>?;
      if (placeholders == null) continue;
      final message = russian[entry.key.substring(1)] as String;
      for (final placeholder in placeholders.keys) {
        expect(
          message,
          matches('\\{${RegExp.escape(placeholder)}(?:\\}|\\s*,)'),
          reason: entry.key,
        );
      }
    }
  });

  test(
    'generated delegates load both languages and interpolate messages',
    () async {
      expect(AppLocalizations.supportedLocales, const [
        Locale('en'),
        Locale('ru'),
      ]);
      final english = await AppLocalizations.delegate.load(const Locale('en'));
      final russian = await AppLocalizations.delegate.load(const Locale('ru'));

      expect(english.config_save_button, 'Save');
      expect(russian.config_save_button, 'Сохранить');
      expect(english.otaReceiving, 'Receiving firmware');
      expect(russian.otaReceiving, 'Получение прошивки');
      expect(russian.otaInstalled, 'Прошивка установлена');
      expect(russian.otaRestartTitle, 'Перезапуск приложения');
      expect(russian.otaStepReceive, '1. Получение');
      expect(russian.otaStepInstall, '2. Установка');
      expect(russian.otaStepRestart, '3. Перезапуск');
      expect(russian.not_found_with_id('photo-123'), 'Не найдено: «photo-123»');
      expect(
        russian.transition_display_times(250, 5000),
        'Переход: 250 мс\nПоказ: 5000 мс',
      );
      expect(
        russian.device_connection_info('wlan0', 'Wi-Fi'),
        'Устройство: wlan0 • Wi-Fi',
      );
      expect(russian.items_selected(0), 'Ничего не выбрано');
      expect(russian.items_selected(1), 'Выбран 1 элемент');
      expect(russian.items_selected(2), 'Выбрано 2 элемента');
      expect(russian.items_selected(5), 'Выбрано 5 элементов');
      expect(russian.items_selected(21), 'Выбран 21 элемент');
      expect(
        AppLocalizations.delegate.isSupported(const Locale('ru', 'RU')),
        isTrue,
      );
      expect(
        AppLocalizations.delegate.isSupported(const Locale('de')),
        isFalse,
      );
    },
  );
}
