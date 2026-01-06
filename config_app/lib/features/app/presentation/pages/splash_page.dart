import 'package:config_app/features/auth/presentation/bloc/authentication_bloc.dart';
import 'package:config_app/features/login/presentation/pages/login_page.dart';
import 'package:config_app/features/uikit/presentation/widgets/photo_frame_config_logo.dart'; 
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: prefer-match-file-name
class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        Future.delayed(const Duration(milliseconds: 1000), () {
            if (context.mounted) {
                 LoginPage.route(context);
            }
        });
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: Center(
          child: PhotoFrameConfigLogo(
            size: 150,
            color: Theme.of(context).colorScheme.onSurface, 
          ),
        ),
      ),
    );
  }
}