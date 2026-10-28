/// OTA pages deliberately use no Flutter or application localization runtime.
enum OtaPageLanguage { en, ru }

/// Select a supported language from the browser's ordered, weighted preferences.
/// Unsupported, missing and invalid preferences fall back to English.
OtaPageLanguage otaPageLanguage(String? acceptLanguage) {
  var selected = OtaPageLanguage.en;
  var bestQuality = 0.0;
  var bestSpecificity = -1;
  final preferences = (acceptLanguage ?? '').split(',');
  var bestOrder = preferences.length;
  for (final language in OtaPageLanguage.values) {
    var languageQuality = 0.0;
    var languageSpecificity = -1;
    var languageOrder = preferences.length;
    for (var index = 0; index < preferences.length; index++) {
      final parts = preferences[index].trim().toLowerCase().split(';');
      final range = parts.first.trim();
      final primary = range.split('-').first;
      if (primary != language.name && range != '*') continue;
      var quality = 1.0;
      for (final parameter in parts.skip(1)) {
        final pair = parameter.trim().split('=');
        if (pair.first.trim() != 'q') continue;
        quality = pair.length == 2 ? double.tryParse(pair[1].trim()) ?? 0 : 0;
      }
      if (!quality.isFinite || quality < 0 || quality > 1) continue;
      final specificity = range == '*' ? 0 : 1;
      // An explicit exclusion overrides a wildcard, e.g. en;q=0,*;q=1.
      if (specificity > languageSpecificity ||
          (specificity == languageSpecificity && quality > languageQuality)) {
        languageQuality = quality;
        languageSpecificity = specificity;
        languageOrder = index;
      }
    }
    if (languageQuality <= 0) continue;
    if (languageQuality > bestQuality ||
        (languageQuality == bestQuality &&
            languageSpecificity > bestSpecificity) ||
        (languageQuality == bestQuality &&
            languageSpecificity == bestSpecificity &&
            languageOrder < bestOrder)) {
      selected = language;
      bestQuality = languageQuality;
      bestSpecificity = languageSpecificity;
      bestOrder = languageOrder;
    }
  }
  return selected;
}

/// Static strings keep recovery pages independent of the normal application UI.
class OtaPageLocalizations {
  final OtaPageLanguage language;

  const OtaPageLocalizations(this.language);

  String _text(String en, String ru) =>
      language == OtaPageLanguage.ru ? ru : en;

  String get recovery =>
      _text('Update & recovery', 'Обновление и восстановление');
  String get recoveryDescription => _text(
    'Update the frame or recover its settings. Use the code shown on the frame to confirm an operation.',
    'Обновите рамку или восстановите её настройки. Для подтверждения операции введите код с экрана рамки.',
  );
  String get versions => _text('Installed versions', 'Установленные версии');
  String get firmware => _text('Update firmware', 'Обновить прошивку');
  String get firmwareDescription => _text(
    'Install a firmware package from your device.',
    'Установите пакет прошивки со своего устройства.',
  );
  String get firmwareStepCode => _text(
    'Enter the code exactly as shown on the frame.',
    'Введите код точно так, как он показан на экране рамки.',
  );
  String get firmwareStepFile => _text(
    'Choose the .deb firmware package.',
    'Выберите файл прошивки .deb.',
  );
  String get firmwareStepWait => _text(
    'Submit once and wait for the response. Then follow the frame screen.',
    'Отправьте форму один раз и дождитесь ответа. Затем следите за экраном рамки.',
  );
  String get code => _text('Code from the frame', 'Код с экрана рамки');
  String get codeHint => _text(
    'The code may contain any characters. Preserve spaces, letter case and leading zeroes.',
    'Код может содержать любые символы. Сохраняйте пробелы, регистр букв и ведущие нули.',
  );
  String get firmwareFile =>
      _text('Firmware file (.deb)', 'Файл прошивки (.deb)');
  String get firmwareFileHint => _text(
    'Choose one .deb package intended for this frame.',
    'Выберите один пакет .deb, предназначенный для этой рамки.',
  );
  String get install => _text('Upload and install', 'Загрузить и установить');
  String get uploading => _text('Uploading…', 'Загрузка…');
  String get powerHint => _text(
    'Keep the frame powered on during installation. After the file is accepted, installation cannot be safely cancelled. This page does not show live progress.',
    'Не отключайте питание рамки во время установки. После приёма файла безопасная отмена установки невозможна. На этой странице нет живого индикатора прогресса.',
  );
  String get config => _text('Frame configuration', 'Конфигурация рамки');
  String get configDescription => _text(
    'Save a backup or restore a config.json file.',
    'Сохраните резервную копию или восстановите файл config.json.',
  );
  String get downloadConfig =>
      _text('Download config.json', 'Скачать config.json');
  String get uploadConfig =>
      _text('Upload config.json', 'Загрузить config.json');
  String get downloadDescription => _text(
    'Download the saved configuration before making changes. You can also retrieve a damaged file to repair it.',
    'Скачайте сохранённую конфигурацию перед изменениями. Повреждённый файл тоже можно получить, чтобы исправить его.',
  );
  String get downloadHint => _text(
    'The file may contain passwords and access tokens. Keep your backup in a safe place.',
    'Файл может содержать пароли и токены доступа. Храните резервную копию в надёжном месте.',
  );
  String get downloadButton =>
      _text('Download configuration', 'Скачать конфигурацию');
  String get uploadDescription => _text(
    'Replace the saved configuration with a config.json file from your device.',
    'Замените сохранённую конфигурацию файлом config.json со своего устройства.',
  );
  String get backupHint => _text(
    'Download a backup of the current configuration before replacing it.',
    'Перед заменой скачайте резервную копию текущей конфигурации.',
  );
  String get configFile =>
      _text('Configuration file (.json)', 'Файл конфигурации (.json)');
  String get configFileHint => _text(
    'Choose one JSON configuration file. It will be checked before saving.',
    'Выберите один JSON-файл конфигурации. Перед сохранением он будет проверен.',
  );
  String get saveConfig => _text(
    'Upload and replace configuration',
    'Загрузить и заменить конфигурацию',
  );
  String get restartHint => _text(
    'Changes take effect after the frame is restarted. Uploading this file does not restart it.',
    'Изменения вступят в силу после перезапуска рамки. Загрузка файла не перезапускает её.',
  );
  String get back =>
      _text('Back to update & recovery', 'К обновлению и восстановлению');
  String get cancel => _text(
    'Cancel and return to slideshow',
    'Отменить и вернуться к слайдшоу',
  );
  String get navigation =>
      _text('Recovery navigation', 'Навигация восстановления');
  String get standaloneHint => _text(
    'This page needs no JavaScript or internet connection.',
    'Для работы страницы не нужны JavaScript и подключение к интернету.',
  );
  String get busyTitle =>
      _text('An operation is already in progress', 'Операция уже выполняется');
  String get busyMessage => _text(
    'Wait for the current operation to finish before uploading another file. You can still download the saved configuration.',
    'Дождитесь завершения текущей операции перед загрузкой другого файла. Сохранённую конфигурацию по-прежнему можно скачать.',
  );
  String get firmwareAcceptedTitle =>
      _text('Firmware received', 'Прошивка получена');
  String get firmwareAcceptedMessage => _text(
    'The file was received and passed to the installer. This does not confirm a successful update. Follow the frame screen and keep its power connected.',
    'Файл получен и передан установщику. Это ещё не подтверждает успешное обновление. Следите за экраном рамки и не отключайте питание.',
  );
  String get configSavedTitle =>
      _text('Configuration saved', 'Конфигурация сохранена');
  String get configSavedMessage => _text(
    'The saved configuration was replaced. Restart the frame when you are ready to apply the changes. It has not been restarted automatically.',
    'Сохранённая конфигурация заменена. Перезапустите рамку, когда будете готовы применить изменения. Автоматический перезапуск не выполнялся.',
  );
  String get errorTitle => _text(
    'Operation could not be completed',
    'Не удалось выполнить операцию',
  );
  String get invalidCode => _text(
    'The code does not match. Return to the form and enter it exactly as shown on the frame.',
    'Код не совпадает. Вернитесь к форме и введите его точно так, как он показан на экране рамки.',
  );
  String get operationBusy => busyMessage;
  String get invalidRequest => _text(
    'The request is incomplete or has an unsupported format. Return to the form and try again.',
    'Запрос неполный или имеет неподдерживаемый формат. Вернитесь к форме и повторите попытку.',
  );
  String get invalidConfig => _text(
    'The configuration file is invalid. The previous configuration was preserved.',
    'Файл конфигурации некорректен. Прежняя конфигурация сохранена.',
  );
  String get configUnavailable => _text(
    'The saved configuration could not be read. Check the frame logs and try again.',
    'Не удалось прочитать сохранённую конфигурацию. Проверьте журнал рамки и повторите попытку.',
  );
  String get transferFailed => _text(
    'The file could not be received or saved. Check the connection and available storage, then try again.',
    'Не удалось получить или сохранить файл. Проверьте соединение и свободное место, затем повторите попытку.',
  );
  String get transferTooLarge => _text(
    'The upload exceeds the allowed size. Choose a smaller file and try again.',
    'Размер загрузки превышает допустимый. Выберите файл меньшего размера и повторите попытку.',
  );
  String get transferTimedOut => _text(
    'The upload timed out. Check the connection and submit the file again.',
    'Время ожидания загрузки истекло. Проверьте соединение и отправьте файл снова.',
  );
  String get unsupportedFirmware => _text(
    'Choose a .deb firmware package intended for this frame.',
    'Выберите пакет прошивки .deb, предназначенный для этой рамки.',
  );
  String get insufficientStorage => _text(
    'There is not enough free storage to save the file. Free some space on the frame and try again.',
    'На рамке недостаточно свободного места для сохранения файла. Освободите место и повторите попытку.',
  );
  String get serviceUnavailable => _text(
    'The OTA service is unavailable. Reopen this page when the frame is ready.',
    'Сервис OTA недоступен. Откройте эту страницу снова, когда рамка будет готова.',
  );
  String get slideshowTitle =>
      _text('Returning to slideshow', 'Возврат к слайдшоу');
  String get slideshowMessage => _text(
    'The frame was asked to close the OTA screen and return to the slideshow.',
    'Рамке отправлена команда закрыть экран OTA и вернуться к слайдшоу.',
  );
}
