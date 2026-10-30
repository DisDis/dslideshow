import 'package:config_app/features/login/presentation/bloc/login_bloc.dart';
import 'package:config_app/features/login/presentation/widgets/login_form.dart';
import 'package:config_app/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/foundation.dart';
import 'package:dslideshow_common/frame_discovery.dart';

import '../bloc/frame_discovery_bloc.dart';

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
        onTap: () => FocusScope.of(context).unfocus(), // Скрываем клавиатуру при клике на фон
        child: Container(
          color: Theme.of(context).colorScheme.surface,
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) {
                      final bloc = LoginBloc(authenticationRepository: sl());
                      if (kIsWeb) bloc.add(const LoginConnectUriAutoChanged());
                      return bloc;
                    },
                  ),
                  if (!kIsWeb)
                    BlocProvider(
                      lazy: false,
                      create: (context) =>
                          FrameDiscoveryBloc(provider: sl<FrameDiscoveryProvider>())
                            ..add(const FrameDiscoveryEvent.search()),
                    ),
                ],
                child: ConstrainedBox(constraints: const BoxConstraints(maxWidth: 480), child: const LoginForm()),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
