import 'dart:async';

import 'package:config_app/features/config/data/repository/photoframe_repository.dart';
import 'package:config_app/features/config/presentation/pages/config_screen.dart';
import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_i18n/i18n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

final _save = find.byKey(const Key('config-save'));
final _reload = find.byKey(const Key('config-reload'));
final _gpio = find.widgetWithText(TextFormField, 'GPIO Smoothing (ms)');

void main() {
  late _Repository repository;
  late GlobalKey<ConfigScreenState> screen;

  setUp(() {
    repository = _Repository();
    screen = GlobalKey<ConfigScreenState>();
  });

  Future<void> mount(WidgetTester tester) async {
    tester.view.physicalSize = const Size(1400, 2200);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(() async {
      await tester.pumpWidget(const SizedBox.shrink());
    });
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: ConfigScreen(key: screen, repository: repository),
      ),
    );
    await tester.pump();
    expect(repository.loads, hasLength(1));
  }

  Future<void> load(WidgetTester tester, [int smoothing = 150]) async {
    await mount(tester);
    repository.loads.single.complete(_config(smoothing));
    await tester.pumpAndSettle();
    expect(_gpio, findsOneWidget);
  }

  Future<void> edit(WidgetTester tester, String value) async {
    await tester.ensureVisible(_gpio);
    await tester.enterText(_gpio, value);
    await tester.pump();
  }

  String gpioValue(WidgetTester tester) => tester
      .widget<EditableText>(
        find.descendant(of: _gpio, matching: find.byType(EditableText)),
      )
      .controller
      .text;

  testWidgets('initial load failure offers a working retry', (tester) async {
    await mount(tester);
    repository.loads.single.completeError(StateError('download failed'));
    await tester.pumpAndSettle();

    expect(find.textContaining('download failed'), findsWidgets);
    expect(find.byKey(const Key('config-retry')), findsOneWidget);
    await tester.tap(find.byKey(const Key('config-retry')));
    await tester.pump();
    expect(repository.loads, hasLength(2));

    repository.loads.last.complete(_config(250));
    await tester.pumpAndSettle();
    expect(gpioValue(tester), '250');
    expect(await screen.currentState!.confirmExit(), isTrue);
  });

  testWidgets('reload replaces the model and existing text field value', (
    tester,
  ) async {
    await load(tester, 150);
    expect(gpioValue(tester), '150');

    await tester.tap(_reload);
    await tester.pump();
    expect(repository.loads, hasLength(2));
    expect(tester.widget<IconButton>(_reload).onPressed, isNull);
    repository.loads.last.complete(_config(350));
    await tester.pumpAndSettle();

    expect(gpioValue(tester), '350');
    expect(await screen.currentState!.confirmExit(), isTrue);
  });

  testWidgets('save disables operations and acknowledges the saved draft', (
    tester,
  ) async {
    await load(tester);
    await edit(tester, '275');
    expect(tester.widget<FilledButton>(_save).onPressed, isNotNull);

    await tester.tap(_save);
    await tester.pump();
    expect(repository.saved.single.hardware.smoothingGPIOMs, 275);
    expect(tester.widget<FilledButton>(_save).onPressed, isNull);
    expect(tester.widget<IconButton>(_reload).onPressed, isNull);

    repository.saves.single.complete(const WSResultOk(id: 1));
    await tester.pumpAndSettle();

    expect(gpioValue(tester), '275');
    expect(find.text('Config saved successfully'), findsOneWidget);
    expect(
      find.textContaining(RegExp('restart', caseSensitive: false)),
      findsWidgets,
    );
    expect(await screen.currentState!.confirmExit(), isTrue);
    expect(find.byType(AlertDialog), findsNothing);
  });

  testWidgets('save error keeps entered values and permits a retry', (
    tester,
  ) async {
    await load(tester);
    await edit(tester, '425');
    await tester.tap(_save);
    await tester.pump();
    repository.saves.single.completeError(StateError('upload failed'));
    await tester.pumpAndSettle();

    expect(gpioValue(tester), '425');
    expect(find.textContaining('upload failed'), findsWidgets);
    expect(tester.widget<FilledButton>(_save).onPressed, isNotNull);
    await tester.tap(_save);
    await tester.pump();
    expect(repository.saved, hasLength(2));
    expect(repository.saved.last.hardware.smoothingGPIOMs, 425);

    repository.saves.last.complete(const WSResultOk(id: 2));
    await tester.pumpAndSettle();
    expect(await screen.currentState!.confirmExit(), isTrue);
  });

  for (final save in [true, false]) {
    testWidgets(
      'pending ${save ? 'save' : 'reload'} releases keyboard focus and '
      'preserves the draft after an error',
      (tester) async {
        await load(tester);
        await tester.ensureVisible(_gpio);
        await tester.tap(_gpio);
        await tester.pump();
        final editable = find.descendant(
          of: _gpio,
          matching: find.byType(EditableText),
        );
        expect(
          tester.widget<EditableText>(editable).focusNode.hasFocus,
          isTrue,
        );
        expect(tester.testTextInput.hasAnyClients, isTrue);
        tester.testTextInput.enterText('825');
        await tester.pump();

        await tester.tap(save ? _save : _reload);
        if (!save) {
          await tester.pumpAndSettle();
          await tester.tap(find.text('Discard changes'));
        }
        await tester.pump();
        expect(
          tester.widget<EditableText>(editable).focusNode.hasFocus,
          isFalse,
        );
        expect(tester.testTextInput.hasAnyClients, isFalse);

        // Traverse with a real keyboard event. No body control should regain
        // focus while the request is pending. A late IME update is ignored.
        for (var i = 0; i < 16; i++) {
          await tester.sendKeyEvent(LogicalKeyboardKey.tab);
          await tester.pump();
          expect(
            tester.widget<EditableText>(editable).focusNode.hasFocus,
            isFalse,
          );
        }
        tester.testTextInput.enterText('999');
        await tester.pump();
        expect(gpioValue(tester), '825');
        expect(tester.testTextInput.hasAnyClients, isFalse);
        if (save) {
          expect(repository.saved.single.hardware.smoothingGPIOMs, 825);
          repository.saves.single.completeError(StateError('request failed'));
        } else {
          repository.loads.last.completeError(StateError('request failed'));
        }
        await tester.pumpAndSettle();

        expect(gpioValue(tester), '825');
        expect(tester.widget<FilledButton>(_save).onPressed, isNotNull);
        await tester.tap(_gpio);
        await tester.pump();
        expect(tester.testTextInput.hasAnyClients, isTrue);
        tester.testTextInput.enterText('925');
        await tester.pump();
        await tester.tap(_save);
        await tester.pump();
        expect(repository.saved.last.hardware.smoothingGPIOMs, 925);
        repository.saves.last.complete(const WSResultOk(id: 2));
        await tester.pumpAndSettle();
        expect(gpioValue(tester), '925');
        expect(await screen.currentState!.confirmExit(), isTrue);
      },
    );
  }

  testWidgets('cancelled or failed dirty reload preserves unsaved values', (
    tester,
  ) async {
    await load(tester);
    await edit(tester, '525');

    await tester.tap(_reload);
    await tester.pumpAndSettle();
    expect(find.text('Reload settings?'), findsOneWidget);
    await tester.tap(find.text('Keep editing'));
    await tester.pumpAndSettle();
    expect(repository.loads, hasLength(1));
    expect(gpioValue(tester), '525');

    await tester.tap(_reload);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Discard changes'));
    await tester.pump();
    expect(repository.loads, hasLength(2));
    repository.loads.last.completeError(StateError('reload failed'));
    await tester.pumpAndSettle();
    expect(gpioValue(tester), '525');
    expect(tester.widget<FilledButton>(_save).onPressed, isNotNull);

    await tester.tap(_reload);
    await tester.pumpAndSettle();
    expect(find.text('Reload settings?'), findsOneWidget);
    await tester.tap(find.text('Discard changes'));
    await tester.pump();
    repository.loads.last.complete(_config(625));
    await tester.pumpAndSettle();
    expect(gpioValue(tester), '625');
    expect(await screen.currentState!.confirmExit(), isTrue);
  });

  testWidgets('keyboard edits trigger the exit guard and can be discarded', (
    tester,
  ) async {
    await load(tester);
    await edit(tester, '725');

    final keepEditing = screen.currentState!.confirmExit();
    await tester.pumpAndSettle();
    expect(
      find.descendant(
        of: find.byType(AlertDialog),
        matching: find.text('Unsaved changes'),
      ),
      findsOneWidget,
    );
    await tester.tap(find.text('Keep editing'));
    await tester.pumpAndSettle();
    expect(await keepEditing, isFalse);
    expect(gpioValue(tester), '725');

    final discard = screen.currentState!.confirmExit();
    await tester.pumpAndSettle();
    await tester.tap(find.text('Discard changes'));
    await tester.pumpAndSettle();
    expect(await discard, isTrue);
    expect(await screen.currentState!.confirmExit(), isTrue);
  });

  testWidgets('returning from a child editor detects its unsaved changes', (
    tester,
  ) async {
    await load(tester);
    await tester.tap(find.text('Welcome Screen'));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.byKey(const Key('welcome-text')),
      'Changed welcome',
    );
    await tester.pageBack();
    await tester.pumpAndSettle();

    expect(find.text('Changed welcome'), findsOneWidget);
    expect(tester.widget<FilledButton>(_save).onPressed, isNotNull);
    final exit = screen.currentState!.confirmExit();
    await tester.pumpAndSettle();
    expect(
      find.descendant(
        of: find.byType(AlertDialog),
        matching: find.text('Unsaved changes'),
      ),
      findsOneWidget,
    );
    await tester.tap(find.text('Keep editing'));
    await tester.pumpAndSettle();
    expect(await exit, isFalse);
  });
  testWidgets(
    'Undo edits confirms and restores the saved form without a request',
    (tester) async {
      await load(tester, 150);
      await edit(tester, '900');
      final reset = find.byKey(const Key('config-reset'));
      await tester.tap(reset);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Keep editing'));
      await tester.pumpAndSettle();
      expect(gpioValue(tester), '900');
      await tester.tap(reset);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Discard changes'));
      await tester.pumpAndSettle();
      expect(gpioValue(tester), '150');
      expect(tester.widget<FilledButton>(_save).onPressed, isNull);
      expect(find.text('No unsaved changes'), findsOneWidget);
      expect(repository.loads, hasLength(1));
      expect(repository.saved, isEmpty);
      expect(await screen.currentState!.confirmExit(), isTrue);
    },
  );

  testWidgets(
    'invalid raw input is protected and reset restores the valid value',
    (tester) async {
      await load(tester, 150);
      await edit(tester, '');
      expect(
        find.text('Enter zero or a positive whole number.'),
        findsOneWidget,
      );
      expect(tester.widget<FilledButton>(_save).onPressed, isNull);
      final exit = screen.currentState!.confirmExit();
      await tester.pumpAndSettle();
      expect(find.byType(AlertDialog), findsOneWidget);
      await tester.tap(find.text('Keep editing'));
      await tester.pumpAndSettle();
      expect(await exit, isFalse);
      expect(gpioValue(tester), '');
      await tester.tap(find.byKey(const Key('config-reset')));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Discard changes'));
      await tester.pumpAndSettle();
      expect(gpioValue(tester), '150');
      expect(find.text('Enter zero or a positive whole number.'), findsNothing);
      expect(find.text('No unsaved changes'), findsOneWidget);
      expect(await screen.currentState!.confirmExit(), isTrue);
    },
  );
  testWidgets('resizing the app shell preserves incomplete field input', (
    tester,
  ) async {
    await load(tester, 150);
    await edit(tester, '');
    tester.view.physicalSize = const Size(375, 900);
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(_gpio, 250);
    expect(gpioValue(tester), '');
    expect(find.text('Enter zero or a positive whole number.'), findsOneWidget);
    final exit = screen.currentState!.confirmExit();
    await tester.pumpAndSettle();
    await tester.tap(find.text('Keep editing'));
    await tester.pumpAndSettle();
    expect(await exit, isFalse);
    tester.view.physicalSize = const Size(1400, 2200);
    await tester.pumpAndSettle();
    expect(gpioValue(tester), '');
    expect(tester.takeException(), isNull);
  });
}

AppConfig _config(int smoothing) => AppConfig.fromJson({
  'hardware': {'smoothingGPIOMs': smoothing},
});

class _Repository implements PhotoframeRepository {
  final loads = <Completer<AppConfig>>[];
  final saves = <Completer<WebSocketResult>>[];
  final saved = <AppConfig>[];

  @override
  Future<AppConfig> getConfig() {
    final result = Completer<AppConfig>();
    loads.add(result);
    return result.future;
  }

  @override
  Future<WebSocketResult> saveConfig(AppConfig config) {
    saved.add(config);
    final result = Completer<WebSocketResult>();
    saves.add(result);
    return result.future;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
