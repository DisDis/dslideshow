@TestOn('browser')
library;

import 'dart:js_interop';

import 'package:config_app/features/config/data/repository/photoframe_repository.dart';
import 'package:config_app/features/config/presentation/pages/config_screen.dart';
import 'package:config_app/src/browser_exit_guard/browser_exit_guard.dart';
import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_i18n/i18n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

@JS('window.dispatchEvent')
external bool _dispatchEvent(_BeforeUnloadEvent event);

@JS('Event')
extension type _BeforeUnloadEvent._(JSObject _) implements JSObject {
  external factory _BeforeUnloadEvent(String type, _EventOptions options);

  external bool get defaultPrevented;
}

extension type _EventOptions._(JSObject _) implements JSObject {
  external factory _EventOptions({required bool cancelable});
}

bool _dispatchBeforeUnload() {
  final event = _BeforeUnloadEvent(
    'beforeunload',
    _EventOptions(cancelable: true),
  );
  _dispatchEvent(event);
  return event.defaultPrevented;
}

void main() {
  // Synthetic events exercise the DOM listener without asking Chrome to show
  // its native reload/close prompt, which requires real user interaction.
  test('a clean page allows beforeunload', () {
    var checks = 0;
    final guard = BrowserExitGuard(() {
      checks++;
      return false;
    });
    addTearDown(guard.dispose);

    expect(_dispatchBeforeUnload(), isFalse);
    expect(checks, 1);
  });

  test('the listener reads current dirty and busy values on every event', () {
    var dirty = false;
    var busy = false;
    var checks = 0;
    final guard = BrowserExitGuard(() {
      checks++;
      return dirty || busy;
    });
    addTearDown(guard.dispose);

    expect(_dispatchBeforeUnload(), isFalse);
    dirty = true;
    expect(_dispatchBeforeUnload(), isTrue);
    dirty = false;
    busy = true;
    expect(_dispatchBeforeUnload(), isTrue);
    busy = false;
    expect(_dispatchBeforeUnload(), isFalse);
    expect(checks, 4);
  });

  test('dispose removes its listener and can be repeated safely', () {
    var checks = 0;
    final guard = BrowserExitGuard(() {
      checks++;
      return true;
    });
    addTearDown(guard.dispose);

    expect(_dispatchBeforeUnload(), isTrue);
    expect(checks, 1);
    guard.dispose();
    expect(_dispatchBeforeUnload(), isFalse);
    expect(checks, 1);
    guard.dispose();
    expect(_dispatchBeforeUnload(), isFalse);
    expect(checks, 1);
  });

  testWidgets('open clock draft and invalid raw input protect beforeunload', (
    tester,
  ) async {
    final repository = _Repository();
    final screen = GlobalKey<ConfigScreenState>();
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: ConfigScreen(key: screen, repository: repository),
      ),
    );
    await tester.pumpAndSettle();
    expect(_dispatchBeforeUnload(), isFalse);
    await tester.tap(find.text('Special screens'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Original clock'));
    await tester.pumpAndSettle();
    expect(_dispatchBeforeUnload(), isFalse);

    final name = find.widgetWithText(TextFormField, 'Name').first;
    await tester.ensureVisible(name);
    await tester.enterText(name, 'Uncommitted clock');
    expect(_dispatchBeforeUnload(), isTrue);
    await tester.enterText(name, 'Original clock');
    expect(_dispatchBeforeUnload(), isFalse);
    final duration = find.widgetWithText(
      TextFormField,
      'Display duration (seconds)',
    );
    await tester.ensureVisible(duration);
    await tester.enterText(duration, 'not-a-number');
    expect(_dispatchBeforeUnload(), isTrue);
    await tester.enterText(duration, '10.0');
    expect(_dispatchBeforeUnload(), isFalse);
    await tester.enterText(duration, '');
    expect(_dispatchBeforeUnload(), isTrue);
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();
    expect(_dispatchBeforeUnload(), isFalse);

    await tester.tap(find.text('Original clock'));
    await tester.pumpAndSettle();
    await tester.ensureVisible(name);
    await tester.enterText(name, 'Done clock');
    await tester.tap(find.text('Done'));
    await tester.pumpAndSettle();
    // Done transfers ownership of the edit from the local form to the root.
    expect(_dispatchBeforeUnload(), isTrue);
    await tester.pageBack();
    await tester.pumpAndSettle();
    final discard = screen.currentState!.confirmExit();
    await tester.pumpAndSettle();
    await tester.tap(find.text('Discard changes'));
    await tester.pumpAndSettle();
    expect(await discard, isTrue);
    expect(_dispatchBeforeUnload(), isFalse);
    expect(
      repository.config.slideshow.specialScreens.single.name,
      'Original clock',
    );
    await tester.pumpWidget(const SizedBox.shrink());
    expect(_dispatchBeforeUnload(), isFalse);
    expect(tester.takeException(), isNull);
  });
}

class _Repository implements PhotoframeRepository {
  final config = AppConfig.fromJson({
    'slideshow': {
      'specialScreens': [
        {'id': 'clock', 'type': 'clock', 'name': 'Original clock'},
      ],
    },
  });

  @override
  Future<AppConfig> getConfig() async => config;

  @override
  Future<WebSocketResult> saveConfig(AppConfig config) async =>
      const WSResultOk(id: 1);

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
