import 'ota_page.dart';
import 'ota_page_localizations.dart';

String renderOtaUploadConfigPage({
  required String frontendVersion,
  required String backendVersion,
  required OtaPageLanguage language,
  bool busy = false,
}) {
  final strings = OtaPageLocalizations(language);
  return renderOtaPage(
    frontendVersion: frontendVersion,
    backendVersion: backendVersion,
    language: language,
    title: strings.uploadConfig,
    description: strings.uploadDescription,
    body:
        '''
${renderOtaBusyNotice(strings, busy)}
<aside class="notice">
  <p>${htmlEscape(strings.backupHint)}</p>
  <a href="/ota_download_config">${htmlEscape(strings.downloadConfig)}</a>
</aside>
<form method="post" enctype="multipart/form-data" action="/ota_upload_config">
  <fieldset${busy ? ' disabled aria-describedby="busy-state"' : ''}>
    ${renderOtaCodeField(strings)}
    <label for="file">${htmlEscape(strings.configFile)}</label>
    <input type="file" id="file" name="file" accept=".json" required aria-describedby="file-help">
    <p class="hint" id="file-help">${htmlEscape(strings.configFileHint)}</p>
    <button class="button button-primary" type="submit">${htmlEscape(strings.saveConfig)}</button>
  </fieldset>
</form>
<p class="hint">${htmlEscape(strings.restartHint)}</p>
''',
  );
}
