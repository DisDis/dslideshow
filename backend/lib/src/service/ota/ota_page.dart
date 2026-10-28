import 'dart:convert';

import 'ota_page_localizations.dart';

const _htmlEscape = HtmlEscape(HtmlEscapeMode.attribute);
const _projectName = 'DSlideshow';

/// Escape both text nodes and quoted attribute values in server-rendered pages.
String htmlEscape(String value) => _htmlEscape.convert(value);

String renderOtaCodeField(OtaPageLocalizations strings) =>
    '''
<label for="code">${htmlEscape(strings.code)}</label>
<input type="text" id="code" name="code" required autocomplete="off"
  autocapitalize="none" autocorrect="off" spellcheck="false" aria-describedby="code-help">
<p class="hint" id="code-help">${htmlEscape(strings.codeHint)}</p>
''';

String renderOtaBusyNotice(OtaPageLocalizations strings, bool busy) => busy
    ? '''
<aside class="notice" id="busy-state" role="status">
  <strong>${htmlEscape(strings.busyTitle)}</strong>
  <p>${htmlEscape(strings.busyMessage)}</p>
</aside>
'''
    : '';

String renderOtaNavigation(
  OtaPageLocalizations strings, {
  bool back = true,
  bool showCancel = true,
}) =>
    '''
<nav class="page-actions" aria-label="${htmlEscape(strings.navigation)}">
  ${back ? '<a class="back-link" href="/ota_start">${htmlEscape(strings.back)}</a>' : ''}
  ${showCancel ? '<a class="button button-quiet" href="/ota_stop">${htmlEscape(strings.cancel)}</a>' : ''}
</nav>
''';

/// [body] is trusted markup from the page renderers; all interpolated user data
/// must be escaped before insertion. Styling and markup require no remote files.
String renderOtaPage({
  required String frontendVersion,
  required String backendVersion,
  required OtaPageLanguage language,
  required String title,
  required String description,
  required String body,
  bool back = true,
  bool showCancel = true,
}) {
  final strings = OtaPageLocalizations(language);
  return '''<!doctype html>
<html lang="${language.name}">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <meta name="color-scheme" content="light dark">
  <title>${htmlEscape(title)} · $_projectName</title>
  <style>
    :root {
      color-scheme: light dark;
      --bg: #f2f5f8; --surface: #fff; --text: #182638; --muted: #526174;
      --line: #d6dfe8; --accent: #185a9f; --accent-hover: #10477f;
      --tint: #edf5ff; --notice: #fff7df; --notice-line: #d9b047;
      --error: #a92834; --error-bg: #fff1f1;
      --version-color: #b91c1c;
      --disabled-bg: #d1d5db; --disabled-text: #4b5563;
    }
    * { box-sizing: border-box; }
    body { margin: 0; background: var(--bg); color: var(--text); font-family: system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", sans-serif; line-height: 1.55; }
    main { width: min(100% - 32px, 720px); margin: 48px auto 24px; }
    .card { background: var(--surface); border: 1px solid var(--line); border-radius: 20px; padding: 32px; box-shadow: 0 12px 40px #142d4610; }
    .brand { margin: 0 0 14px; color: var(--accent); font-size: .8rem; font-weight: 750; letter-spacing: .12em; }
    h1 { margin: 0 0 12px; font-size: clamp(1.7rem, 4vw, 2.2rem); line-height: 1.2; letter-spacing: -.025em; overflow-wrap: anywhere; }
    h2 { margin: 0 0 8px; font-size: 1.2rem; line-height: 1.35; }
    p { margin: 0 0 16px; }
    .description, .hint { color: var(--muted); }
    .versions { display: flex; flex-wrap: wrap; gap: 8px; margin: 20px 0 28px; }
    .version { padding: 6px 12px; border: 1px solid var(--line); border-radius: 7px; font-size: 1rem; overflow-wrap: anywhere; max-width: 100%; }
    .version-number { color: var(--version-color); font-size: 1.15rem; font-weight: 800; }
    .section + .section { border-top: 1px solid var(--line); padding-top: 24px; margin-top: 28px; }
    ol { margin: 14px 0 22px; padding-left: 24px; color: var(--muted); }
    li { padding-left: 3px; margin-bottom: 6px; }
    form { margin-top: 20px; }
    fieldset { min-width: 0; border: 0; padding: 0; margin: 0; }
    fieldset:disabled { opacity: .65; }
    label { display: block; font-weight: 650; margin-bottom: 7px; }
    input { display: block; width: 100%; min-width: 0; padding: 12px; font: inherit; color: var(--text); background: var(--surface); border: 1px solid var(--line); border-radius: 9px; }
    input[type="text"] { font-family: ui-monospace, SFMono-Regular, Consolas, monospace; }
    input[type="file"] { font-size: .9rem; overflow: hidden; }
    input::file-selector-button { margin-right: 12px; padding: 7px 10px; border: 1px solid var(--line); border-radius: 5px; background: var(--bg); color: var(--text); cursor: pointer; }
    .hint { font-size: .86rem; margin: 8px 0 22px; overflow-wrap: anywhere; }
    .button { display: inline-flex; justify-content: center; align-items: center; min-height: 46px; padding: 11px 18px; border: 1px solid transparent; border-radius: 9px; font: inherit; font-weight: 650; text-align: center; text-decoration: none; cursor: pointer; line-height: 1.4; }
    .button-primary { color: #fff; background: var(--accent); }
    .button-primary:hover { background: var(--accent-hover); }
    .button-secondary { color: var(--accent); background: var(--tint); border-color: var(--line); }
    .button-quiet { color: var(--text); background: var(--surface); border-color: var(--line); width: 100%; }
    .button-secondary:hover, .button-quiet:hover { border-color: var(--accent); }
    button:disabled { cursor: default; }
    button.button-primary:disabled { background: var(--disabled-bg); color: var(--disabled-text); border-color: var(--disabled-bg); cursor: not-allowed; }
    a { color: var(--accent); text-underline-offset: 3px; }
    a:focus-visible, button:focus-visible, input:focus-visible { outline: 3px solid var(--accent); outline-offset: 3px; }
    .config-actions { display: grid; grid-template-columns: repeat(2, minmax(0, 1fr)); gap: 12px; margin-top: 18px; }
    .notice { background: var(--notice); border: 1px solid var(--notice-line); border-radius: 10px; padding: 16px; margin: 20px 0; }
    .notice p { margin: 5px 0 0; }
    .notice-result { background: var(--tint); border-color: var(--line); }
    .notice-error { background: var(--error-bg); border-color: var(--error); }
    .notice-error strong { color: var(--error); }
    .page-actions { display: flex; flex-direction: column; gap: 20px; border-top: 1px solid var(--line); padding-top: 24px; margin-top: 28px; }
    .back-link { align-self: flex-start; }
    footer { text-align: center; color: var(--muted); font-size: .78rem; padding: 18px 12px; }
    @media (prefers-color-scheme: dark) {
      :root { --bg: #111922; --surface: #1b2734; --text: #eaf0f8; --muted: #afbed0; --line: #405165; --accent: #8cc5ff; --accent-hover: #b0d7ff; --tint: #223b52; --notice: #3c341f; --notice-line: #937d43; --error: #ffadb5; --error-bg: #41272e; }
      :root { --version-color: #ff8a8a; --disabled-bg: #4b5563; --disabled-text: #e5e7eb; }
      .button-primary { background: #2669ae; color: #fff; }
      .button-primary:hover { background: #317bc9; }
    }
    @media (max-width: 520px) {
      main { width: min(100% - 20px, 720px); margin-top: 18px; }
      .card { border-radius: 14px; padding: 24px 18px; }
      .config-actions { grid-template-columns: 1fr; }
      form .button { width: 100%; }
    }
  </style>
</head>
<body>
  <main>
    <article class="card">
      <header>
        <p class="brand">$_projectName · OTA</p>
        <h1>${htmlEscape(title)}</h1>
        ${description.isEmpty ? '' : '<p class="description">${htmlEscape(description)}</p>'}
        <div class="versions" aria-label="${htmlEscape(strings.versions)}">
          <span class="version">frontend: <strong class="version-number">${htmlEscape(frontendVersion)}</strong></span>
          <span class="version">backend: <strong class="version-number">${htmlEscape(backendVersion)}</strong></span>
        </div>
      </header>
      $body
      ${renderOtaNavigation(strings, back: back, showCancel: showCancel)}
    </article>
    <footer>${htmlEscape(strings.standaloneHint)}</footer>
  </main>
</body>
</html>
''';
}

String renderOtaResultPage({
  required String frontendVersion,
  required String backendVersion,
  required OtaPageLanguage language,
  required String title,
  required String message,
  bool error = false,
  bool showCancel = true,
}) => renderOtaPage(
  frontendVersion: frontendVersion,
  backendVersion: backendVersion,
  language: language,
  title: title,
  description: '',
  showCancel: showCancel,
  body:
      '<div class="notice ${error ? 'notice-error' : 'notice-result'}" role="${error ? 'alert' : 'status'}"><p>${htmlEscape(message)}</p></div>',
);
