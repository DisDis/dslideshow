import 'dart:js_interop';

@JS('window.addEventListener')
external void _addEventListener(JSString type, JSFunction listener);

@JS('window.removeEventListener')
external void _removeEventListener(JSString type, JSFunction listener);

extension type _BeforeUnloadEvent(JSObject _) implements JSObject {
  external void preventDefault();

  external set returnValue(JSString value);
}

/// Requests the browser's native confirmation before losing the current draft.
///
/// Browsers decide whether to show the prompt, generally after user interaction;
/// its text is supplied by the browser. The callback reads the current draft so
/// edits in an open child editor are covered without rebuilding its parent.
class BrowserExitGuard {
  BrowserExitGuard(bool Function() shouldBlock) {
    _listener = ((JSObject event) {
      if (_disposed || !shouldBlock()) return;
      final beforeUnload = _BeforeUnloadEvent(event);
      beforeUnload.preventDefault();
      beforeUnload.returnValue = ' '.toJS;
    }).toJS;
    _addEventListener('beforeunload'.toJS, _listener);
  }

  late final JSFunction _listener;
  bool _disposed = false;

  void dispose() {
    if (_disposed) return;
    _disposed = true;
    _removeEventListener('beforeunload'.toJS, _listener);
  }
}
