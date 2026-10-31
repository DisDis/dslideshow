import 'dart:async';

import 'package:config_app/features/auth/domain/repository/authentication_repository.dart';
import 'package:config_app/features/login/presentation/bloc/login_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:logging/logging.dart';

class _AuthenticationRepository implements AuthenticationRepository {
  _AuthenticationRepository(this.handle);

  final Future<void> Function() handle;
  int loginCount = 0;

  @override
  Future<void> logIn({required Uri connectUrl, required String username, required String password}) {
    loginCount++;
    return handle();
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

Future<void> _validateForm(LoginBloc bloc) async {
  final valid = bloc.stream.firstWhere((state) => state.isValid);
  bloc.add(const LoginConnectUriChanged('ws://localhost:8080/ws'));
  await valid;
}

void main() {
  test('repeated submit keeps one login request until it finishes', () async {
    final result = Completer<void>();
    final repository = _AuthenticationRepository(() => result.future);
    final bloc = LoginBloc(authenticationRepository: repository);
    addTearDown(bloc.close);
    await _validateForm(bloc);
    final succeeded = bloc.stream.firstWhere((state) => state.status.isSuccess);

    bloc.add(const LoginSubmitted());
    bloc.add(const LoginSubmitted());
    await pumpEventQueue();

    expect(repository.loginCount, 1);
    expect(bloc.state.status, FormzSubmissionStatus.inProgress);

    result.complete();
    await succeeded;
    expect(repository.loginCount, 1);
  });

  test('a failed login preserves original diagnostics and can be retried', () async {
    final results = [Completer<void>(), Completer<void>()];
    var requestIndex = 0;
    final repository = _AuthenticationRepository(() => results[requestIndex++].future);
    final bloc = LoginBloc(authenticationRepository: repository);
    addTearDown(bloc.close);
    final records = <LogRecord>[];
    final logSubscription = Logger.root.onRecord.listen(records.add);
    addTearDown(logSubscription.cancel);
    await _validateForm(bloc);

    final failed = bloc.stream.firstWhere((state) => state.status.isFailure);
    bloc.add(const LoginSubmitted());
    await pumpEventQueue();
    final error = StateError('private-auth-response');
    final stack = StackTrace.fromString('#0 login-source\n#1 login-caller');
    results[0].completeError(error, stack);
    await failed;

    final succeeded = bloc.stream.firstWhere((state) => state.status.isSuccess);
    bloc.add(const LoginSubmitted());
    await pumpEventQueue();
    expect(repository.loginCount, 2);
    results[1].complete();
    await succeeded;

    final loginRecords = records.where((record) => record.loggerName == 'LoginBloc');
    expect(loginRecords, isNotEmpty);
    expect(loginRecords.map((record) => record.message).join(), isNot(contains('private-auth-response')));
    final diagnostic = loginRecords.singleWhere((record) => record.error != null);
    expect(diagnostic.error, same(error));
    expect(diagnostic.stackTrace, same(stack));
  });
}
