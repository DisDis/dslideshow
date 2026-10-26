import 'dart:async';

import 'package:config_app/app.dart';
import 'package:config_app/features/app/presentation/pages/home_page.dart';
import 'package:config_app/features/app/presentation/pages/splash_page.dart';
import 'package:config_app/features/auth/domain/repository/authentication_repository.dart';
import 'package:config_app/features/auth/presentation/bloc/authentication_bloc.dart';
import 'package:config_app/features/login/presentation/pages/login_page.dart';
import 'package:config_app/features/permission/domain/entities/permission.dart';
import 'package:config_app/features/permission/domain/services/permission_service.dart';
import 'package:config_app/features/upload/presentation/bloc/upload_queue_bloc.dart';
import 'package:config_app/features/user/domain/entities/avatarUrl.dart';
import 'package:config_app/features/user/domain/entities/user.dart';
import 'package:config_app/features/user/domain/repository/user_repository.dart';
import 'package:dslideshow_i18n/i18n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

void main() {
  late _AuthenticationRepository repository;
  late AuthenticationBloc authentication;
  late _UploadQueueBloc uploads;

  setUp(() async {
    await GetIt.instance.reset();
    repository = _AuthenticationRepository();
    final permissions = PermissionService()..loadData([Permission.NONE.id]);
    authentication = AuthenticationBloc(
      authenticationRepository: repository,
      userRepository: _UserRepository(),
      permissionService: permissions,
    );
    uploads = _UploadQueueBloc();
    GetIt.instance.registerSingleton<AuthenticationRepository>(repository);
    GetIt.instance.registerSingleton<AuthenticationBloc>(authentication);
    GetIt.instance.registerSingleton<PermissionService>(permissions);
    GetIt.instance.registerSingleton<UploadQueueBloc>(uploads);
  });

  tearDown(() async {
    if (!authentication.isClosed) await authentication.close();
    await uploads.close();
    await GetIt.instance.reset();
  });

  GoRouter routerOf(WidgetTester tester) =>
      tester.widget<MaterialApp>(find.byType(MaterialApp)).routerConfig!
          as GoRouter;

  Future<void> publish(WidgetTester tester, AuthenticationStatus status) async {
    // setUp constructs the real BLoC outside the widget test's fake clock.
    // Wait for its observed state instead of advancing an unrelated fake timer.
    await tester.runAsync(() async {
      final next = authentication.stream.firstWhere(
        (state) => status == AuthenticationStatus.authenticated
            ? state is AuthenticationAuthenticatedState
            : state == const AuthenticationState.unauthenticated(),
      );
      repository.publish(status);
      await next;
    });
  }

  testWidgets(
    'already unauthenticated startup opens login without another status event',
    (tester) async {
      // DI creates AuthenticationBloc before runApp. Reproduce a transport
      // status that has already been consumed before any screen is mounted.
      await publish(tester, AuthenticationStatus.unauthenticated);
      expect(authentication.state, const AuthenticationState.unauthenticated());
      await tester.pumpWidget(const App());
      await tester.pumpAndSettle();
      expect(find.byType(LoginPage), findsOneWidget);
      expect(find.byType(SplashPage), findsNothing);
      expect(
        routerOf(tester).routeInformationProvider.value.uri.path,
        '/login',
      );
      await tester.pump(const Duration(seconds: 2));
      expect(repository.published, 1);
      expect(find.byType(LoginPage), findsOneWidget);
    },
  );

  testWidgets('unknown startup and later unauthenticated status show login', (
    tester,
  ) async {
    expect(authentication.state, const AuthenticationState.unknown());
    await tester.pumpWidget(const App());
    await tester.pumpAndSettle();
    expect(find.byType(LoginPage), findsOneWidget);
    await publish(tester, AuthenticationStatus.unauthenticated);
    await tester.pumpAndSettle();
    expect(find.byType(LoginPage), findsOneWidget);
    expect(find.byType(SplashPage), findsNothing);

    await publish(tester, AuthenticationStatus.authenticated);
    await tester.pumpAndSettle();
    expect(find.byType(HomePage), findsOneWidget);
    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();
    expect(find.byType(HomePage), findsOneWidget);
    expect(find.byType(LoginPage), findsNothing);
    expect(routerOf(tester).routeInformationProvider.value.uri.path, '/home');
  });

  testWidgets('already authenticated startup opens home and stays there', (
    tester,
  ) async {
    await publish(tester, AuthenticationStatus.authenticated);
    expect(authentication.state, isA<AuthenticationAuthenticatedState>());
    await tester.pumpWidget(const App());
    await tester.pumpAndSettle();
    expect(find.byType(HomePage), findsOneWidget);
    final router = routerOf(tester);
    router.go('/splash');
    await tester.pumpAndSettle();
    expect(find.byType(HomePage), findsOneWidget);
    router.go('/login');
    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 2));
    expect(find.byType(HomePage), findsOneWidget);
    expect(find.byType(SplashPage), findsNothing);
    expect(find.byType(LoginPage), findsNothing);
    expect(repository.published, 1);
  });

  testWidgets('fallback splash does not schedule navigation on auth changes', (
    tester,
  ) async {
    final router = GoRouter(
      initialLocation: '/splash',
      routes: [
        GoRoute(path: '/splash', builder: (_, _) => const SplashPage()),
        GoRoute(
          path: '/login',
          builder: (_, _) => const Text('Unexpected login'),
        ),
      ],
    );
    addTearDown(router.dispose);
    await tester.pumpWidget(
      BlocProvider<AuthenticationBloc>.value(
        value: authentication,
        child: MaterialApp.router(
          routerConfig: router,
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
        ),
      ),
    );
    await publish(tester, AuthenticationStatus.authenticated);
    await tester.pump();
    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();
    expect(find.byType(SplashPage), findsOneWidget);
    expect(find.text('Unexpected login'), findsNothing);
    expect(tester.takeException(), isNull);
  });
}

class _AuthenticationRepository implements AuthenticationRepository {
  final _statuses = StreamController<AuthenticationStatus>.broadcast();
  int published = 0;

  void publish(AuthenticationStatus status) {
    published++;
    _statuses.add(status);
  }

  @override
  Stream<AuthenticationStatus> get status => _statuses.stream;

  @override
  Future<void> logIn({
    required Uri connectUrl,
    required String username,
    required String password,
  }) async {}

  @override
  void logOut() => publish(AuthenticationStatus.unauthenticated);

  @override
  void dispose() {
    if (!_statuses.isClosed) unawaited(_statuses.close());
  }
}

class _UserRepository implements UserRepository {
  @override
  Future<User?> getUser() async => const User(
    id: 'startup-user',
    firstName: 'Frame',
    lastName: 'User',
    avatarUrl: AvatarUrl.empty,
  );

  @override
  void clear() {}
}

class _UploadQueueBloc extends Cubit<UploadQueueState>
    implements UploadQueueBloc {
  _UploadQueueBloc() : super(const UploadQueueState());
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
