import 'package:config_app/config/routes/app_router.dart';
import 'package:config_app/features/auth/presentation/bloc/authentication_bloc.dart';
import 'package:config_app/features/theme/presentation/l10n/l10n.dart';
import 'package:config_app/features/theme/presentation/theme.dart';
import 'package:config_app/features/theme/presentation/app_preferences.dart';
import 'package:config_app/features/upload/presentation/bloc/upload_queue_bloc.dart';
import 'package:config_app/injection_container.dart';
import 'package:dslideshow_i18n/i18n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class App extends StatelessWidget {
  const App({super.key, this.preferences});

  final AppPreferences? preferences;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UploadQueueBloc>.value(value: sl()),
        BlocProvider<AuthenticationBloc>(
          create: (_) =>
              sl() /*..add(const AuthenticationRestoreAuthRequested())*/,
        ),
      ],
      child: _AppView(preferences: preferences),
    );
  }
}

class _AppView extends StatefulWidget {
  const _AppView({this.preferences});

  final AppPreferences? preferences;

  @override
  State<_AppView> createState() => _AppViewState();
}

class _AppViewState extends State<_AppView> {
  late AppPreferences _preferences;
  bool _ownsPreferences = false;
  GoRouter? _router;
  late final ThemeData _lightTheme = createLightTheme();
  late final ThemeData _darkTheme = createDarkTheme();

  @override
  void initState() {
    super.initState();
    _preferences = widget.preferences ?? AppPreferences();
    _ownsPreferences = widget.preferences == null;
  }

  @override
  void didUpdateWidget(covariant _AppView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (identical(oldWidget.preferences, widget.preferences)) return;
    if (_ownsPreferences) _preferences.dispose();
    _preferences = widget.preferences ?? AppPreferences();
    _ownsPreferences = widget.preferences == null;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Keep the navigator, active editors, and authentication stream subscription
    // alive when MaterialApp rebuilds for a new theme or language.
    _router ??= createAppRouter(context);
  }

  @override
  void dispose() {
    _router?.dispose();
    if (_ownsPreferences) _preferences.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AppPreferencesScope(
    preferences: _preferences,
    child: ListenableBuilder(
      listenable: _preferences,
      builder: (context, _) => MaterialApp.router(
        onGenerateTitle: (context) =>
            AppLocalizations.of(context).config_app_title,
        supportedLocales: L10n.all,
        locale: _preferences.appLocale.locale,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        theme: _lightTheme,
        darkTheme: _darkTheme,
        themeMode: _preferences.themeMode,
        routerConfig: _router,
      ),
    ),
  );
}
