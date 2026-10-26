import 'dart:async';

import 'package:config_app/app.dart';
import 'package:config_app/config/routes/app_router.dart';
import 'package:config_app/features/auth/presentation/bloc/authentication_bloc.dart';
import 'package:config_app/features/config/data/repository/photoframe_repository.dart';
import 'package:config_app/features/config/presentation/pages/config_screen.dart';
import 'package:config_app/features/config/presentation/pages/welcome_editor_page.dart';
import 'package:config_app/features/permission/domain/entities/permission.dart';
import 'package:config_app/features/permission/domain/services/permission_service.dart';
import 'package:config_app/features/theme/presentation/app_preferences.dart';
import 'package:config_app/features/theme/presentation/extensions/build_context_ext.dart';
import 'package:config_app/features/theme/presentation/l10n/app_locale.dart';
import 'package:config_app/features/theme/presentation/theme.dart';
import 'package:config_app/features/upload/domain/upload_task.dart';
import 'package:config_app/features/upload/presentation/bloc/upload_queue_bloc.dart';
import 'package:config_app/features/user/domain/entities/avatarUrl.dart';
import 'package:config_app/features/user/domain/entities/user.dart';
import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_backend/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

void main() {
  test('appearance defaults follow the system and notify only on changes', () {
    final preferences = AppPreferences();
    addTearDown(preferences.dispose);
    var notifications = 0;
    preferences.addListener(() => notifications++);

    expect(preferences.themeMode, ThemeMode.system);
    expect(preferences.appLocale, AppLocale.system);
    expect(preferences.appLocale.locale, isNull);
    preferences.setThemeMode(ThemeMode.system);
    preferences.setLocale(AppLocale.system);
    expect(notifications, 0);
    preferences.setThemeMode(ThemeMode.dark);
    preferences.setLocale(AppLocale.ru);
    expect(notifications, 2);
    expect(preferences.appLocale.locale, const Locale('ru'));
  });

  test('both themes use readable semantic colors and complete typography', () {
    for (final theme in [createLightTheme(), createDarkTheme()]) {
      final scheme = theme.colorScheme;
      expect(theme.brightness, scheme.brightness);
      expect(
        _contrast(scheme.onSurface, scheme.surface),
        greaterThanOrEqualTo(7),
      );
      expect(
        _contrast(scheme.onSurfaceVariant, scheme.surfaceContainerLow),
        greaterThanOrEqualTo(4.5),
      );
      expect(
        _contrast(scheme.onPrimary, scheme.primary),
        greaterThanOrEqualTo(4.5),
      );
      expect(theme.textTheme.bodySmall!.fontSize, greaterThanOrEqualTo(12));
      expect(theme.textTheme.labelSmall!.fontSize, greaterThanOrEqualTo(12));
      expect(theme.cardTheme.color, scheme.surfaceContainerLow);
      expect(
        theme.inputDecorationTheme.fillColor,
        scheme.surfaceContainerLowest,
      );
      expect(
        theme.extension<ThemeColors>()!.unselectedLabel,
        scheme.onSurfaceVariant,
      );
      expect(
        theme.extension<ThemeTextStyles>()!.appDescription.color,
        scheme.onSurfaceVariant,
      );
    }
    expect(createDarkTheme().brightness, Brightness.dark);
    expect(createLightTheme().brightness, Brightness.light);
  });

  testWidgets('optional preference lookup supports standalone screens', (
    tester,
  ) async {
    AppPreferences? result;
    await tester.pumpWidget(
      Builder(
        builder: (context) {
          result = AppPreferencesScope.maybeOf(context);
          return const SizedBox();
        },
      ),
    );
    expect(result, isNull);
  });

  group('application appearance', () {
    late _AuthenticationBloc authentication;
    late _UploadQueueBloc uploads;
    late _Repository repository;
    late AppPreferences preferences;

    setUp(() async {
      await GetIt.instance.reset();
      authentication = _AuthenticationBloc();
      uploads = _UploadQueueBloc();
      repository = _Repository();
      preferences = AppPreferences();
      GetIt.instance.registerSingleton<AuthenticationBloc>(authentication);
      GetIt.instance.registerSingleton<UploadQueueBloc>(uploads);
      GetIt.instance.registerSingleton<PhotoframeRepository>(repository);
      GetIt.instance.registerSingleton<PermissionService>(
        PermissionService()..loadData([Permission.NONE.id]),
      );
    });

    tearDown(() async {
      preferences.dispose();
      await uploads.close();
      if (!authentication.isClosed) await authentication.close();
      await GetIt.instance.reset();
    });

    testWidgets('system appearance follows platform locale and brightness', (
      tester,
    ) async {
      tester.platformDispatcher.localesTestValue = const [Locale('ru')];
      tester.platformDispatcher.platformBrightnessTestValue = Brightness.dark;
      addTearDown(tester.platformDispatcher.clearLocalesTestValue);
      addTearDown(tester.platformDispatcher.clearPlatformBrightnessTestValue);
      await tester.pumpWidget(App(preferences: preferences));
      await tester.pumpAndSettle();
      final router =
          tester.widget<MaterialApp>(find.byType(MaterialApp)).routerConfig!
              as GoRouter;
      router.go('/config');
      await tester.pumpAndSettle();
      final context = tester.element(find.byType(ConfigScreen));
      expect(Localizations.localeOf(context).languageCode, 'ru');
      expect(Theme.of(context).brightness, Brightness.dark);
      expect(context.color.coursorColor, Theme.of(context).colorScheme.primary);
      expect(
        context.text.appTitle.color,
        Theme.of(context).colorScheme.onSurface,
      );

      preferences.setLocale(AppLocale.en);
      preferences.setThemeMode(ThemeMode.light);
      await tester.pumpAndSettle();
      expect(Localizations.localeOf(context).languageCode, 'en');
      expect(Theme.of(context).brightness, Brightness.light);
      expect(AppLocale.system.toLanguage(context), 'System default');
    });

    testWidgets(
      'changing appearance retains router, draft, auth, and upload queue',
      (tester) async {
        preferences.setLocale(AppLocale.en);
        await tester.pumpWidget(App(preferences: preferences));
        await tester.pumpAndSettle();
        final materialApp = tester.widget<MaterialApp>(
          find.byType(MaterialApp),
        );
        final router = materialApp.routerConfig! as GoRouter;
        router.go('/config');
        await tester.pumpAndSettle();
        final configState = tester.state(find.byType(ConfigScreen));
        final configContext = tester.element(find.byType(ConfigScreen));
        await tester.tap(find.text('Welcome Screen'));
        await tester.pumpAndSettle();
        await tester.enterText(
          find.byKey(const ValueKey('welcome-text')),
          'Session draft',
        );
        final editorState = tester.state(find.byType(WelcomeEditorPage));

        preferences.setThemeMode(ThemeMode.dark);
        preferences.setLocale(AppLocale.ru);
        await tester.pumpAndSettle();
        expect(
          tester.widget<MaterialApp>(find.byType(MaterialApp)).routerConfig,
          same(router),
        );
        expect(
          tester.state(find.byType(ConfigScreen, skipOffstage: false)),
          same(configState),
        );
        expect(tester.state(find.byType(WelcomeEditorPage)), same(editorState));
        expect(find.text('Session draft'), findsWidgets);
        expect(repository.loads, 1);
        expect(configContext.read<AuthenticationBloc>(), same(authentication));
        expect(configContext.read<UploadQueueBloc>(), same(uploads));
        expect(uploads.state.tasks.single.id, 'pending-upload');
        expect(authentication.isClosed, isFalse);
        await tester.tap(find.byType(BackButton));
        await tester.pumpAndSettle();
        expect(find.text('Session draft'), findsOneWidget);
      },
    );

    testWidgets('disposing a router cancels its authentication subscription', (
      tester,
    ) async {
      late GoRouter router;
      await tester.pumpWidget(
        BlocProvider<AuthenticationBloc>.value(
          value: authentication,
          child: Builder(
            builder: (context) {
              router = createAppRouter(context);
              return const SizedBox();
            },
          ),
        ),
      );
      final listeners = authentication.activeStreamListeners;
      expect(listeners, greaterThanOrEqualTo(1));
      router.dispose();
      await tester.pump();
      // BlocProvider has its own listener; only the router's is removed here.
      expect(authentication.activeStreamListeners, listeners - 1);
    });
  });
}

double _contrast(Color first, Color second) {
  final firstLuminance = first.computeLuminance();
  final secondLuminance = second.computeLuminance();
  final light = firstLuminance > secondLuminance
      ? firstLuminance
      : secondLuminance;
  final dark = firstLuminance < secondLuminance
      ? firstLuminance
      : secondLuminance;
  return (light + .05) / (dark + .05);
}

class _Repository implements PhotoframeRepository {
  final config = AppConfig.fromJson({
    'welcome': {'text': 'Original welcome'},
  });
  var loads = 0;
  @override
  Future<AppConfig> getConfig() async {
    loads++;
    return config;
  }

  @override
  Future<WebSocketResult> saveConfig(AppConfig config) async =>
      const WSResultOk(id: 1);
  @override
  void dispose() {}
}

class _AuthenticationBloc extends Cubit<AuthenticationState>
    implements AuthenticationBloc {
  _AuthenticationBloc()
    : super(
        const AuthenticationState.authenticated(
          User(
            id: 'appearance-user',
            firstName: 'Frame',
            lastName: 'User',
            avatarUrl: AvatarUrl.empty,
          ),
        ),
      ) {
    _changes = StreamController<AuthenticationState>.broadcast();
    _stream = Stream.multi((controller) {
      activeStreamListeners++;
      final subscription = _changes.stream.listen(
        controller.add,
        onError: controller.addError,
        onDone: controller.close,
      );
      controller.onCancel = () {
        activeStreamListeners--;
        return subscription.cancel();
      };
    }, isBroadcast: true);
  }
  late final StreamController<AuthenticationState> _changes;
  late final Stream<AuthenticationState> _stream;
  var activeStreamListeners = 0;
  @override
  Stream<AuthenticationState> get stream => _stream;
  @override
  Future<void> close() async {
    await _changes.close();
    await super.close();
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _UploadQueueBloc extends Cubit<UploadQueueState>
    implements UploadQueueBloc {
  _UploadQueueBloc()
    : super(
        const UploadQueueState(
          tasks: [
            UploadTask(
              id: 'pending-upload',
              localPath: 'photo.jpg',
              serverPath: 'photo.jpg',
              status: UploadStatus.queued,
            ),
          ],
        ),
      );
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
