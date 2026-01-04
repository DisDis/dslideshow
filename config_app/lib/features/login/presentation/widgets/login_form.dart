import 'package:config_app/features/login/presentation/bloc/login_bloc.dart';
import 'package:config_app/features/theme/presentation/extensions/build_context_ext.dart';
import 'package:dslideshow_common/version.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:flutter/foundation.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.status.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: const Text('Authentication Failure'),
                backgroundColor: Theme.of(context).colorScheme.error,
                behavior: SnackBarBehavior.floating,
              ),
            );
        }
      },
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        color: Theme.of(context).colorScheme.surface,
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Icon(
                Icons.admin_panel_settings,
                size: 64,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 16),
              Text(
                context.localizations.login_page_name, // "Login"
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                "Please sign in to continue",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
              ),
              Text(
                "v${ApplicationInfo.frontendVersion}/v${ApplicationInfo.backendVersion}",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
              ),
              const SizedBox(height: 32),

              // Inputs
              _ConnectUriInput(),
              const SizedBox(height: 16),
              _UsernameInput(),
              const SizedBox(height: 16),
              _PasswordInput(),
              const SizedBox(height: 32),

              // Button
              _LoginButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class _ConnectUriInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.connectUri != current.connectUri,
      builder: (context, state) {
        // Мы сохраняем логику с созданием контроллера на лету,
        // так как это единственный способ обновить текст из Блока в Stateless
        // без использования хуков.
        return TextField(
          key: const Key('loginForm_connectUriInput_textField'),
          controller: state.connectUri.isPure ? TextEditingController(text: state.connectUri.value) : null,
          onChanged: (connectUri) => context.read<LoginBloc>().add(LoginConnectUriChanged(connectUri)),
          decoration: InputDecoration(
            labelText: 'Server URI',
            hintText: 'ws://192.168.1.x:8080/ws',
            prefixIcon: const Icon(Icons.link),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            enabled: !kIsWeb,
            filled: true,
            fillColor: Theme.of(context).colorScheme.surfaceContainerHighest.withAlpha((255.0 * 0.3).round()),
            errorText: state.connectUri.displayError != null ? 'Invalid URI' : null,
          ),
          keyboardType: TextInputType.url,
        );
      },
    );
  }
}

class _UsernameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.username != current.username,
      builder: (context, state) {
        return TextField(
          key: const Key('loginForm_usernameInput_textField'),
          controller: state.username.isPure ? TextEditingController(text: state.username.value) : null,
          onChanged: (username) => context.read<LoginBloc>().add(LoginUsernameChanged(username)),
          decoration: InputDecoration(
            labelText: 'Username',
            prefixIcon: const Icon(Icons.person_outline),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            filled: true,
            fillColor: Theme.of(context).colorScheme.surfaceContainerHighest.withAlpha((255.0 * 0.3).round()),
            errorText: state.username.displayError != null ? 'Invalid username' : null,
          ),
          textInputAction: TextInputAction.next,
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          key: const Key('loginForm_passwordInput_textField'),
          controller: state.password.isPure ? TextEditingController(text: state.password.value) : null,
          onChanged: (password) => context.read<LoginBloc>().add(LoginPasswordChanged(password)),
          obscureText: true, // Всегда скрыт, так как мы в Stateless
          decoration: InputDecoration(
            labelText: 'Password',
            prefixIcon: const Icon(Icons.lock_outline),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            filled: true,
            fillColor: Theme.of(context).colorScheme.surfaceContainerHighest.withAlpha((255.0 * 0.3).round()),
            errorText: state.password.displayError != null ? 'Invalid password' : null,
          ),
          textInputAction: TextInputAction.done,
          onSubmitted: (_) {
            if (state.isValid) {
              context.read<LoginBloc>().add(const LoginSubmitted());
            }
          },
        );
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => (previous.status != current.status) || (previous.isValid != current.isValid),
      builder: (context, state) {
        if (state.status.isInProgress) {
          return const Center(child: CircularProgressIndicator());
        }

        return SizedBox(
          width: double.infinity,
          height: 50,
          child: FilledButton(
            key: const Key('loginForm_continue_raisedButton'),
            style: FilledButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 2,
            ),
            onPressed: state.isValid
                ? () {
                    context.read<LoginBloc>().add(const LoginSubmitted());
                  }
                : null,
            child: const Text(
              'Sign In',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
        );
      },
    );
  }
}
