import 'dart:convert';

import 'package:crypto/crypto.dart';

/// Optional feedback only: the browser remains responsible for the native POST.
/// Keep this exact text between the script tags so its CSP hash stays valid.
const otaUploadScript = r'''
(function () {
  try {
    var form = document.getElementById('firmware-upload');
    var button = document.getElementById('firmware-submit');
    if (!form || !button) return;
    var uploadingText = button.getAttribute('data-uploading-label');
    if (!uploadingText) return;
    var idleText = button.textContent;
    var idleDisabled = button.disabled;
    form.addEventListener('submit', function () {
      try {
        button.textContent = uploadingText;
        button.disabled = true;
      } catch (error) {}
    });
    window.addEventListener('pageshow', function () {
      try {
        button.textContent = idleText;
        button.disabled = idleDisabled;
      } catch (error) {}
    });
  } catch (error) {}
}());
''';

final String otaUploadScriptHash =
    'sha256-${base64.encode(sha256.convert(utf8.encode(otaUploadScript)).bytes)}';
