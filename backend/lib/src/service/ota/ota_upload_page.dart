import 'ota_page.dart';
import 'ota_page_localizations.dart';
import 'ota_upload_script.dart';

String renderOtaUploadPage({
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
    title: strings.recovery,
    description: strings.recoveryDescription,
    back: false,
    body:
        '''
${renderOtaBusyNotice(strings, busy)}
<section class="section" aria-labelledby="firmware-title">
  <h2 id="firmware-title">${htmlEscape(strings.firmware)}</h2>
  <p>${htmlEscape(strings.firmwareDescription)}</p>
  <ol>
    <li>${htmlEscape(strings.firmwareStepCode)}</li>
    <li>${htmlEscape(strings.firmwareStepFile)}</li>
    <li>${htmlEscape(strings.firmwareStepWait)}</li>
  </ol>
  <form id="firmware-upload" method="post" enctype="multipart/form-data" action="/ota_upload">
    <fieldset${busy ? ' disabled aria-describedby="busy-state"' : ''}>
      ${renderOtaCodeField(strings)}
      <label for="file">${htmlEscape(strings.firmwareFile)}</label>
      <input type="file" id="file" name="file" accept=".deb" required aria-describedby="file-help">
      <p class="hint" id="file-help">${htmlEscape(strings.firmwareFileHint)}</p>
      <button id="firmware-submit" class="button button-primary" type="submit" data-uploading-label="${htmlEscape(strings.uploading)}">${htmlEscape(strings.install)}</button>
    </fieldset>
  </form>
  <p class="hint">${htmlEscape(strings.powerHint)}</p>
</section>
<section class="section" aria-labelledby="config-title">
  <h2 id="config-title">${htmlEscape(strings.config)}</h2>
  <p class="description">${htmlEscape(strings.configDescription)}</p>
  <div class="config-actions">
    <a class="button button-secondary" href="/ota_download_config">${htmlEscape(strings.downloadConfig)}</a>
    <a class="button button-secondary" href="/ota_upload_config">${htmlEscape(strings.uploadConfig)}</a>
  </div>
</section>
<script>$otaUploadScript</script>
''',
  );
}
