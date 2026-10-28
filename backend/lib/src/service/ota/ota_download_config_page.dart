import 'ota_page.dart';
import 'ota_page_localizations.dart';

String renderOtaDownloadConfigPage({
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
    title: strings.downloadConfig,
    description: strings.downloadDescription,
    body:
        '''
${renderOtaBusyNotice(strings, busy)}
<form method="post" action="/ota_download_config">
  ${renderOtaCodeField(strings)}
  <button class="button button-primary" type="submit">${htmlEscape(strings.downloadButton)}</button>
</form>
<p class="hint">${htmlEscape(strings.downloadHint)}</p>
''',
  );
}
