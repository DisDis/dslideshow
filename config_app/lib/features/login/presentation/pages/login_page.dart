import 'package:config_app/features/login/presentation/bloc/login_bloc.dart';
import 'package:config_app/features/login/presentation/widgets/login_form.dart';
import 'package:config_app/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  static void route(BuildContext context) {
    context.go('/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Убираем AppBar, делаем полноэкранный дизайн с фоном
      body: GestureDetector(
        onTap: () => FocusScope.of(context)
            .unfocus(), // Скрываем клавиатуру при клике на фон
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Theme.of(context).colorScheme.primary,
                Theme.of(context).colorScheme.tertiaryContainer,
              ],
            ),
          ),
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: BlocProvider(
                create: (context) {
                  return LoginBloc(
                    authenticationRepository: sl(),
                  )..add(
                      const LoginConnectUriAutoChanged()); // Авто-определение хоста при старте
                },
                child: const LoginForm(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
