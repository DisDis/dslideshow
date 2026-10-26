import 'dart:async';

import 'package:config_app/features/auth/domain/repository/authentication_repository.dart';
import 'package:config_app/features/auth/presentation/bloc/authentication_bloc.dart';
import 'package:config_app/features/permission/domain/entities/permission.dart';
import 'package:config_app/features/permission/domain/services/permission_service.dart';
import 'package:config_app/features/user/domain/entities/avatarUrl.dart';
import 'package:config_app/features/user/domain/entities/user.dart';
import 'package:config_app/features/user/domain/repository/user_repository.dart';
import 'package:flutter_test/flutter_test.dart';

const _user = User(
  id: 'frame-user',
  firstName: 'Frame',
  lastName: 'User',
  avatarUrl: AvatarUrl.empty,
);
const _newUser = User(
  id: 'new-user',
  firstName: 'New',
  lastName: 'User',
  avatarUrl: AvatarUrl.empty,
);

void main() {
  late _AuthenticationRepository authentication;
  late _UserRepository users;
  late _PermissionService permissions;
  late AuthenticationBloc bloc;

  setUp(() {
    authentication = _AuthenticationRepository();
    users = _UserRepository();
    permissions = _PermissionService();
    bloc = AuthenticationBloc(
      authenticationRepository: authentication,
      userRepository: users,
      permissionService: permissions,
    );
    addTearDown(bloc.close);
  });

  Future<Completer<User?>> startLookup() async {
    authentication.emit(AuthenticationStatus.authenticated);
    await pumpEventQueue();
    return users.lookups.last;
  }

  test(
    'queued older authentication does not start a stale user lookup',
    () async {
      authentication.emit(AuthenticationStatus.authenticated);
      authentication.emit(AuthenticationStatus.unauthenticated);
      await pumpEventQueue();

      expect(users.lookups, isEmpty);
      expect(bloc.state, const AuthenticationState.unauthenticated());
      expect(permissions.loads, isEmpty);
      expect(permissions.check(Permission.NONE), isFalse);
    },
  );

  test(
    'a completed current lookup authenticates and grants permissions',
    () async {
      final lookup = await startLookup();
      expect(bloc.state, const AuthenticationState.unknown());
      expect(permissions.loads, isEmpty);

      lookup.complete(_user);
      await pumpEventQueue();

      expect(bloc.state, const AuthenticationState.authenticated(_user));
      expect(permissions.loads, [
        [Permission.NONE.id],
      ]);
      expect(permissions.check(Permission.NONE), isTrue);
    },
  );

  for (final logout in [false, true]) {
    for (final failedLookup in [false, true]) {
      test(
        '${logout ? 'logout' : 'disconnect'} ignores a delayed user lookup ${failedLookup ? 'failure' : 'success'}',
        () async {
          permissions.loadData([Permission.NONE.id]);
          permissions.loads.clear();
          final lookup = await startLookup();
          final states = <AuthenticationState>[];
          final subscription = bloc.stream.listen(states.add);
          addTearDown(subscription.cancel);

          if (logout) {
            bloc.add(const AuthenticationLogoutRequested());
          } else {
            authentication.emit(AuthenticationStatus.unauthenticated);
          }
          await pumpEventQueue();
          expect(bloc.state, const AuthenticationState.unauthenticated());
          expect(permissions.check(Permission.NONE), isFalse);

          if (failedLookup) {
            lookup.completeError(StateError('old lookup failed'));
          } else {
            lookup.complete(_user);
          }
          await pumpEventQueue();

          expect(states, [const AuthenticationState.unauthenticated()]);
          expect(permissions.loads, isEmpty);
          expect(permissions.check(Permission.NONE), isFalse);
          expect(authentication.logoutCount, logout ? 1 : 0);
          expect(users.clearCount, logout ? 1 : 0);
        },
      );
    }
  }

  test('the newer login owns permissions when an older lookup fails', () async {
    final first = await startLookup();
    authentication.emit(AuthenticationStatus.unauthenticated);
    final second = await startLookup();

    second.complete(_newUser);
    await pumpEventQueue();
    first.completeError(StateError('previous user lookup failed'));
    await pumpEventQueue();

    expect(bloc.state, const AuthenticationState.authenticated(_newUser));
    expect(permissions.loads, [
      [Permission.NONE.id],
    ]);
    expect(permissions.check(Permission.NONE), isTrue);
  });

  for (final absentUser in <User?>[null, User.empty]) {
    test(
      'a ${absentUser == null ? 'null' : 'empty'} user cannot grant access',
      () async {
        permissions.loadData([Permission.NONE.id]);
        permissions.loads.clear();
        final lookup = await startLookup();

        lookup.complete(absentUser);
        await pumpEventQueue();

        expect(bloc.state, const AuthenticationState.unauthenticated());
        expect(permissions.loads, isEmpty);
        expect(permissions.check(Permission.NONE), isFalse);
      },
    );
  }

  test(
    'a current user lookup failure clears permissions and reports signed out',
    () async {
      permissions.loadData([Permission.NONE.id]);
      permissions.loads.clear();
      final lookup = await startLookup();

      lookup.completeError(StateError('user lookup failed'));
      await pumpEventQueue();

      expect(bloc.state, const AuthenticationState.unauthenticated());
      expect(permissions.loads, isEmpty);
      expect(permissions.check(Permission.NONE), isFalse);
    },
  );

  for (final failedLookup in [false, true]) {
    test(
      'close ignores a delayed lookup ${failedLookup ? 'failure' : 'success'}',
      () async {
        final lookup = await startLookup();
        final states = <AuthenticationState>[];
        final subscription = bloc.stream.listen(states.add);
        addTearDown(subscription.cancel);

        await bloc.close();
        if (failedLookup) {
          lookup.completeError(StateError('lookup failed after close'));
        } else {
          lookup.complete(_user);
        }
        await pumpEventQueue();

        expect(bloc.isClosed, isTrue);
        expect(states, isEmpty);
        expect(permissions.loads, isEmpty);
        expect(authentication.disposed, isTrue);
      },
    );
  }
}

class _AuthenticationRepository implements AuthenticationRepository {
  final _statuses = StreamController<AuthenticationStatus>.broadcast(
    sync: true,
  );
  int logoutCount = 0;
  bool disposed = false;

  @override
  Stream<AuthenticationStatus> get status => _statuses.stream;

  void emit(AuthenticationStatus status) => _statuses.add(status);

  @override
  void logOut() {
    logoutCount++;
    emit(AuthenticationStatus.unauthenticated);
  }

  @override
  void dispose() {
    if (disposed) return;
    disposed = true;
    unawaited(_statuses.close());
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _UserRepository implements UserRepository {
  final lookups = <Completer<User?>>[];
  int clearCount = 0;

  @override
  Future<User?> getUser() {
    final lookup = Completer<User?>();
    lookups.add(lookup);
    return lookup.future;
  }

  @override
  void clear() => clearCount++;
}

class _PermissionService extends PermissionService {
  final loads = <List<int>>[];

  @override
  void loadData(List<int> permissionIds) {
    loads.add(List.of(permissionIds));
    super.loadData(permissionIds);
  }
}
