import 'package:config_app/src/bloc/authentication_bloc.dart';
import 'package:config_app/src/bloc/authentication_repository.dart';
import 'package:config_app/src/bloc/authentication_state.dart';
import 'package:config_app/src/page/home/view/home_page.dart';
import 'package:config_app/src/page/login/view/login_page.dart';
import 'package:config_app/src/page/splash/splash.dart';
import 'package:config_app/src/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({
    Key? key,
    required this.authenticationRepository,
    required this.userRepository,
  }) : super(key: key);

  final AuthenticationRepository authenticationRepository;
  final UserRepository userRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider<AuthenticationRepository>(
            create: (context) => authenticationRepository,
          ),
          RepositoryProvider<UserRepository>(
            create: (context) => userRepository,
          ),
        ],
        child: BlocProvider(
          create: (_) => AuthenticationBloc(
            authenticationRepository: authenticationRepository,
            userRepository: userRepository,
          ),
          child: const AppView(),
        ));

    /*return RepositoryProvider.value(
      value: authenticationRepository,
      child: BlocProvider(
        create: (_) => AuthenticationBloc(
          authenticationRepository: authenticationRepository,
          userRepository: userRepository,
        ),
        child: const AppView(),
      ),
    );*/
  }
}

class AppView extends StatefulWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      builder: (context, child) {
        return BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            switch (state.status) {
              case AuthenticationStatus.authenticated:
                _navigator.pushAndRemoveUntil<void>(
                  HomePage.route(),
                  (route) => false,
                );
                break;
              case AuthenticationStatus.unauthenticated:
                _navigator.pushAndRemoveUntil<void>(
                  LoginPage.route(),
                  (route) => false,
                );
                break;
              default:
                break;
            }
          },
          child: child,
        );
      },
      onGenerateRoute: (_) => SplashPage.route(),
    );
  }
}
