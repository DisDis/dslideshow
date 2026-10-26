/// Browser close/reload protection has no platform listener outside the web.
class BrowserExitGuard {
  BrowserExitGuard(bool Function() shouldBlock);

  void dispose() {}
}
