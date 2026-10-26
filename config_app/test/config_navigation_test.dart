import 'package:config_app/features/auth/presentation/bloc/authentication_bloc.dart';
import 'package:config_app/features/config/config/router.dart' as config_routes;
import 'package:config_app/features/config/data/repository/photoframe_repository.dart';
import 'package:config_app/features/config/presentation/pages/config_screen.dart';
import 'package:config_app/features/permission/domain/entities/permission.dart';
import 'package:config_app/features/permission/domain/services/permission_service.dart';
import 'package:config_app/features/user/domain/entities/avatarUrl.dart';
import 'package:config_app/features/user/domain/entities/user.dart';
import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_i18n/i18n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

const _originalWelcome = 'Original welcome';
const _editedWelcome = 'Edited welcome';

Finder get _confirmationTitle => find.descendant(
  of: find.byType(AlertDialog),
  matching: find.text('Unsaved changes'),
);

void main() {
  late _AuthenticationBloc authentication;
  late _Repository repository;

  setUp(() async {
    await GetIt.instance.reset();
    authentication = _AuthenticationBloc();
    repository = _Repository();
    GetIt.instance.registerSingleton<PhotoframeRepository>(repository);
    GetIt.instance.registerSingleton<PermissionService>(
      PermissionService()..loadData([Permission.NONE.id]),
    );
  });

  tearDown(() async {
    await authentication.close();
    await GetIt.instance.reset();
  });

  Future<GoRouter> openConfig(WidgetTester tester) async {
    late GoRouter router;
    await tester.pumpWidget(
      BlocProvider<AuthenticationBloc>.value(
        value: authentication,
        child: Builder(
          builder: (context) {
            router = GoRouter(
              initialLocation: '/config',
              routes: [
                config_routes.createRoute(context),
                GoRoute(
                  path: '/home',
                  builder: (_, _) => const Scaffold(body: Text('Home page')),
                ),
                GoRoute(
                  path: '/login',
                  builder: (_, _) => const Scaffold(body: Text('Login page')),
                ),
              ],
              redirect: (_, state) =>
                  authentication.state is! AuthenticationAuthenticatedState &&
                      state.uri.path != '/login'
                  ? '/login'
                  : null,
            );
            return MaterialApp.router(
              routerConfig: router,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
            );
          },
        ),
      ),
    );
    addTearDown(router.dispose);
    await tester.pumpAndSettle();
    expect(find.byType(ConfigScreen), findsOneWidget);
    return router;
  }

  Future<void> editWelcome(WidgetTester tester) async {
    await tester.tap(find.text('Welcome Screen'));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Text'),
      _editedWelcome,
    );
    // Popping an editor preserves the settings draft without prompting.
    await tester.pageBack();
    await tester.pumpAndSettle();
    expect(find.byType(AlertDialog), findsNothing);
    expect(find.text(_editedWelcome), findsOneWidget);
  }

  testWidgets('a clean configuration route exits without confirmation', (
    tester,
  ) async {
    final router = await openConfig(tester);
    router.go('/home');
    await tester.pumpAndSettle();
    expect(find.text('Home page'), findsOneWidget);
    expect(find.byType(AlertDialog), findsNothing);
    expect(repository.saveCount, 0);
  });

  testWidgets(
    'Cancel keeps the current draft; Discard exits the actual route',
    (tester) async {
      final router = await openConfig(tester);
      await editWelcome(tester);
      // Mutating a draft must not mutate the repository's loaded configuration.
      expect(repository.config.welcome.text, _originalWelcome);

      router.go('/home');
      await tester.pumpAndSettle();
      expect(_confirmationTitle, findsOneWidget);
      await tester.tap(find.text('Keep editing'));
      await tester.pumpAndSettle();
      expect(find.byType(ConfigScreen), findsOneWidget);
      expect(find.text(_editedWelcome), findsOneWidget);
      expect(find.text('Home page'), findsNothing);

      router.go('/home');
      await tester.pumpAndSettle();
      await tester.tap(find.text('Discard changes'));
      await tester.pumpAndSettle();
      expect(find.text('Home page'), findsOneWidget);
      expect(repository.saveCount, 0);
    },
  );

  testWidgets('repeated navigation requests share a single confirmation', (
    tester,
  ) async {
    final router = await openConfig(tester);
    await editWelcome(tester);
    router.go('/home');
    await tester.pumpAndSettle();
    router.go('/home');
    await tester.pumpAndSettle();
    expect(find.byType(AlertDialog), findsOneWidget);
    await tester.tap(find.text('Keep editing'));
    await tester.pumpAndSettle();
    expect(find.byType(ConfigScreen), findsOneWidget);
    expect(find.byType(AlertDialog), findsNothing);
  });

  testWidgets('an open child editor contributes its current unsaved changes', (
    tester,
  ) async {
    final router = await openConfig(tester);
    await tester.tap(find.text('Welcome Screen'));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Text'),
      _editedWelcome,
    );

    router.go('/home');
    await tester.pumpAndSettle();
    expect(_confirmationTitle, findsOneWidget);
    await tester.tap(find.text('Keep editing'));
    await tester.pumpAndSettle();
    expect(find.text('Welcome Settings'), findsOneWidget);
    expect(find.text(_editedWelcome), findsOneWidget);

    router.go('/home');
    await tester.pumpAndSettle();
    await tester.tap(find.text('Discard changes'));
    await tester.pumpAndSettle();
    expect(find.text('Home page'), findsOneWidget);
    expect(repository.config.welcome.text, _originalWelcome);
  });

  testWidgets(
    'uncommitted clock edits guard navigation and reverting clears it',
    (tester) async {
      repository.config.slideshow.specialScreens.add(
        SpecialScreenConfig(
          id: 'clock',
          type: SpecialScreenType.clock,
          name: 'Original clock',
        ),
      );
      final router = await openConfig(tester);
      await tester.tap(find.text('Special screens'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Original clock'));
      await tester.pumpAndSettle();
      final name = find.widgetWithText(TextFormField, 'Name').first;
      await tester.ensureVisible(name);
      await tester.enterText(name, 'Uncommitted clock');

      router.go('/home');
      await tester.pumpAndSettle();
      expect(_confirmationTitle, findsOneWidget);
      await tester.tap(find.text('Keep editing'));
      await tester.pumpAndSettle();
      expect(find.text('Uncommitted clock'), findsOneWidget);
      expect(
        repository.config.slideshow.specialScreens.single.name,
        'Original clock',
      );

      await tester.enterText(name, 'Original clock');
      router.go('/home');
      await tester.pumpAndSettle();
      expect(find.text('Home page'), findsOneWidget);
      expect(find.byType(AlertDialog), findsNothing);
      expect(repository.saveCount, 0);
    },
  );

  testWidgets(
    'invalid local clock input is guarded before it reaches the model',
    (tester) async {
      repository.config.slideshow.specialScreens.add(
        SpecialScreenConfig(
          id: 'clock',
          type: SpecialScreenType.clock,
          name: 'Original clock',
        ),
      );
      final router = await openConfig(tester);
      await tester.tap(find.text('Special screens'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Original clock'));
      await tester.pumpAndSettle();
      final duration = find.widgetWithText(
        TextFormField,
        'Display duration (seconds)',
      );
      await tester.ensureVisible(duration);
      await tester.enterText(duration, 'not-a-number');

      router.go('/home');
      await tester.pumpAndSettle();
      expect(_confirmationTitle, findsOneWidget);
      await tester.tap(find.text('Keep editing'));
      await tester.pumpAndSettle();
      expect(find.text('not-a-number'), findsOneWidget);

      router.go('/home');
      await tester.pumpAndSettle();
      await tester.tap(find.text('Discard changes'));
      await tester.pumpAndSettle();
      expect(find.text('Home page'), findsOneWidget);
      expect(
        repository.config.slideshow.specialScreens.single.displayTimeMs,
        10000,
      );
      expect(repository.saveCount, 0);
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets('system Back can be cancelled while the configuration is dirty', (
    tester,
  ) async {
    final router = await openConfig(tester);
    await editWelcome(tester);
    final pop = router.routerDelegate.popRoute();
    await tester.pumpAndSettle();
    expect(_confirmationTitle, findsOneWidget);
    await tester.tap(find.text('Keep editing'));
    await tester.pumpAndSettle();
    expect(await pop, isTrue);
    expect(find.byType(ConfigScreen), findsOneWidget);
    expect(find.text(_editedWelcome), findsOneWidget);
  });

  testWidgets(
    'authentication expiry redirects without trapping a dirty screen',
    (tester) async {
      final router = await openConfig(tester);
      await editWelcome(tester);
      authentication.disconnect();
      router.refresh();
      await tester.pumpAndSettle();
      expect(find.text('Login page'), findsOneWidget);
      expect(find.byType(AlertDialog), findsNothing);
      expect(repository.saveCount, 0);
    },
  );

  testWidgets('authentication expiry supersedes an open exit confirmation', (
    tester,
  ) async {
    final router = await openConfig(tester);
    await editWelcome(tester);
    router.go('/home');
    await tester.pumpAndSettle();
    expect(_confirmationTitle, findsOneWidget);

    authentication.disconnect();
    router.refresh();
    await tester.pumpAndSettle();
    expect(find.text('Login page'), findsOneWidget);
    expect(find.text('Home page'), findsNothing);
    expect(find.byType(AlertDialog), findsNothing);
  });

  testWidgets('explicit logout confirms before ending authentication', (
    tester,
  ) async {
    // The drawer's decorative network images are unrelated to navigation.
    // Seed Flutter's image cache so this remains a fully local widget test.
    final image = await tester.runAsync(() => createTestImage(cache: false));
    for (final url in [
      AvatarUrl.empty.medium,
      'https://oflutter.com/wp-content/uploads/2021/02/profile-bg3.jpg',
    ]) {
      PaintingBinding.instance.imageCache.putIfAbsent(
        NetworkImage(url),
        () => OneFrameImageStreamCompleter(
          Future.value(ImageInfo(image: image!.clone())),
        ),
      );
    }
    image!.dispose();
    addTearDown(() {
      PaintingBinding.instance.imageCache
        ..clear()
        ..clearLiveImages();
    });
    final router = await openConfig(tester);
    await editWelcome(tester);
    await tester.tap(find.byTooltip('Open navigation menu'));
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(
      find.text('Exit'),
      250,
      scrollable: find.descendant(
        of: find.byType(Drawer),
        matching: find.byType(Scrollable),
      ),
    );
    await tester.tap(find.text('Exit'));
    await tester.pumpAndSettle();
    expect(authentication.logoutCount, 0);
    await tester.tap(find.text('Keep editing'));
    await tester.pumpAndSettle();
    expect(authentication.state, isA<AuthenticationAuthenticatedState>());
    expect(authentication.logoutCount, 0);

    await tester.tap(find.text('Exit'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Discard changes'));
    await tester.pumpAndSettle();
    expect(authentication.logoutCount, 1);
    router.refresh();
    await tester.pumpAndSettle();
    expect(find.text('Login page'), findsOneWidget);
  });
}

class _Repository implements PhotoframeRepository {
  final config = AppConfig.fromJson({
    'welcome': {'text': _originalWelcome},
  });
  int saveCount = 0;

  @override
  Future<AppConfig> getConfig() async => config;

  @override
  Future<WebSocketResult> saveConfig(AppConfig config) async {
    saveCount++;
    return const WSResultOk(id: 1);
  }

  @override
  void dispose() {}
}

class _AuthenticationBloc extends Cubit<AuthenticationState>
    implements AuthenticationBloc {
  _AuthenticationBloc()
    : super(
        const AuthenticationState.authenticated(
          User(
            id: 'navigation-user',
            firstName: 'Frame',
            lastName: 'User',
            avatarUrl: AvatarUrl.empty,
          ),
        ),
      );

  int logoutCount = 0;

  void disconnect() => emit(const AuthenticationState.unauthenticated());

  @override
  void add(AuthenticationEvent event) {
    if (event is AuthenticationLogoutRequested) {
      logoutCount++;
      disconnect();
    }
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
