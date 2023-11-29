import 'package:config_app/src/bloc/authentication_repository.dart';
import 'package:config_app/src/page/login/bloc/login_bloc.dart';
import 'package:config_app/src/page/login/view/login_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const LoginPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: BlocProvider(
          create: (context) {
            return LoginBloc(
              authenticationRepository: RepositoryProvider.of<AuthenticationRepository>(context),
            )..add(const LoginConnectUriAutoChanged());
          },
          child: const LoginForm(),
        ),
      ),
    );
  }
}
