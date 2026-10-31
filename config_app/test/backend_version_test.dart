import 'dart:async';

import 'package:config_app/features/auth/presentation/bloc/authentication_bloc.dart';
import 'package:config_app/features/device/data/device_repository.dart';
import 'package:config_app/features/realtime/domain/services/realtime_service.dart';
import 'package:config_app/features/uikit/presentation/bloc/backend_version_bloc.dart';
import 'package:config_app/features/uikit/presentation/widgets/navigation_bar/configapp_navigation_bar.dart';
import 'package:config_app/features/user/domain/entities/avatarUrl.dart';
import 'package:config_app/features/user/domain/entities/user.dart';
import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_i18n/i18n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logging/logging.dart';

const _user = User(id: 'version-user', firstName: 'Frame', lastName: '', avatarUrl: AvatarUrl.empty);
const _authenticated = AuthenticationState.authenticated(_user);

FrameState _frame(String version) => FrameState(
  sampledAt: DateTime.utc(2026, 10, 30),
  presence: FramePresence.unknown,
  isScreenLocked: false,
  isScreenOn: true,
  screenPhase: FrameScreenPhase.on,
  backendVersion: version,
);

class _Authentication extends Cubit<AuthenticationState> implements AuthenticationBloc {
  _Authentication() : super(_authenticated);
  void publish(AuthenticationState value) => emit(value);
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _Client implements RealtimeService {
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _Repository extends DeviceRepository {
  _Repository() : super(_Client());
  final requests = <Completer<FrameState>>[];
  @override
  Future<FrameState> getState() {
    final response = Completer<FrameState>();
    requests.add(response);
    return response.future;
  }
}

void main() {
  for (final (version, compatibility) in [
    ('17.9.1+23', BackendCompatibility.matching),
    ('17.0.0-dev.1', BackendCompatibility.matching),
    ('16.9.0', BackendCompatibility.mismatched),
    ('18.0.0', BackendCompatibility.mismatched),
    ('', BackendCompatibility.unknown),
    ('private-invalid-version', BackendCompatibility.unknown),
  ]) {
    test('reported backend "$version" has $compatibility compatibility with the panel target', () async {
      final authentication = _Authentication();
      final repository = _Repository();
      final records = <LogRecord>[];
      final subscription = Logger.root.onRecord.listen(records.add);
      final bloc = BackendVersionBloc(
        authentication: authentication,
        repository: repository,
        expectedVersion: '17.0.0+6',
      );
      final loaded = bloc.stream.firstWhere((state) => state.status == BackendVersionStatus.ready);
      repository.requests.single.complete(_frame(version));
      final state = await loaded;
      expect(state.version, version);
      expect(state.compatibility, compatibility);
      expect(repository.requests, hasLength(1));
      expect(records.any((record) => record.message.contains('action=load result=started')), isTrue);
      expect(records.any((record) => record.message.contains('compatibility=${compatibility.name}')), isTrue);
      expect(records.any((record) => record.message.contains('private-')), isFalse);
      
      expect(
        records
            .where((record) => record.error != null)
            .every((record) => record.stackTrace != null && record.stackTrace.toString().isNotEmpty),
        isTrue,
      );
      await bloc.close();
      await authentication.close();
      await subscription.cancel();
    });
  }

  test('logout clears the version and a late response cannot overwrite the next authenticated session', () async {
    final authentication = _Authentication();
    final repository = _Repository();
    final bloc = BackendVersionBloc(authentication: authentication, repository: repository, expectedVersion: '17.0.0');
    final cleared = bloc.stream.firstWhere((state) => state.status == BackendVersionStatus.idle);
    authentication.publish(const AuthenticationState.unauthenticated());
    expect((await cleared).version, isNull);
    final loading = bloc.stream.firstWhere((state) => state.status == BackendVersionStatus.loading);
    authentication.publish(_authenticated);
    await loading;
    expect(repository.requests, hasLength(2));
    repository.requests.first.complete(_frame('99.0.0'));
    await repository.requests.first.future;
    expect(bloc.state.status, BackendVersionStatus.loading);
    final loaded = bloc.stream.firstWhere((state) => state.status == BackendVersionStatus.ready);
    repository.requests.last.complete(_frame('17.3.0'));
    expect((await loaded).compatibility, BackendCompatibility.matching);
    await bloc.close();
    await authentication.close();
  });

  test('failure and disposal during a pending request leave compatibility unknown and log safe outcomes', () async {
    final authentication = _Authentication();
    final repository = _Repository();
    final records = <LogRecord>[];
    final subscription = Logger.root.onRecord.listen(records.add);
    final bloc = BackendVersionBloc(authentication: authentication, repository: repository, expectedVersion: '17.0.0');
    final failed = bloc.stream.firstWhere((state) => state.status == BackendVersionStatus.failure);
    repository.requests.single.completeError(StateError('private-url'));
    expect((await failed).compatibility, BackendCompatibility.unknown);
    final cleared = bloc.stream.firstWhere((state) => state.status == BackendVersionStatus.idle);
    authentication.publish(const AuthenticationState.unauthenticated());
    await cleared;
    final loading = bloc.stream.firstWhere((state) => state.status == BackendVersionStatus.loading);
    authentication.publish(_authenticated);
    await loading;
    await bloc.close();
    repository.requests.last.complete(_frame('18.0.0'));
    await repository.requests.last.future;
    expect(records.any((record) => record.message.contains('action=load result=failed type=StateError')), isTrue);
    expect(records.any((record) => record.message.contains('action=load result=cancelled')), isTrue);
    expect(records.any((record) => record.message.contains('private-')), isFalse);
    await authentication.close();
    await subscription.cancel();
  });

  testWidgets('navigation shows the reported version and a red mismatch icon with an explanatory tooltip', (
    tester,
  ) async {
    final authentication = _Authentication();
    final repository = _Repository();
    final bloc = BackendVersionBloc(
      authentication: authentication,
      repository: repository,
      expectedVersion: '17.0.0+6',
    );
    await tester.pumpWidget(
      BlocProvider<BackendVersionBloc>.value(
        value: bloc,
        child: MaterialApp(
          locale: const Locale('en'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const Scaffold(body: SizedBox(width: 248, child: ConfigAppNavigationBar(embedded: true))),
        ),
      ),
    );
    expect(find.text('Backend —'), findsOneWidget);
    expect(find.byKey(const Key('backend-major-mismatch')), findsNothing);
    repository.requests.single.complete(_frame('18.1.0'));
    await tester.pump();
    expect(find.text('Backend 18.1.0'), findsOneWidget);
    final warning = find.byKey(const Key('backend-major-mismatch'));
    expect(warning, findsOneWidget);
    final icon = find.descendant(of: warning, matching: find.byType(Icon));
    expect(tester.widget<Icon>(icon).color, Theme.of(tester.element(warning)).colorScheme.error);
    await tester.longPress(warning);
    await tester.pumpAndSettle();
    expect(find.text('Backend 18.1.0 and the panel target 17.0.0+6 have different major versions.'), findsOneWidget);
    await tester.pumpWidget(const SizedBox.shrink());
    await tester.runAsync(bloc.close);
    await tester.runAsync(authentication.close);
  });
}
