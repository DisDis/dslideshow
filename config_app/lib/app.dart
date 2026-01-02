import 'package:config_app/config/routes/app_router.dart';
import 'package:config_app/features/auth/presentation/bloc/authentication_bloc.dart';
import 'package:config_app/features/theme/presentation/l10n/l10n.dart';
import 'package:config_app/features/theme/presentation/theme.dart';
import 'package:config_app/features/upload/presentation/bloc/upload_queue_bloc.dart';
import 'package:config_app/injection_container.dart';
import 'package:dslideshow_i18n/i18n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UploadQueueBloc>.value(
          value: sl(),
        ),
        BlocProvider<AuthenticationBloc>(
          create: (_) =>
              sl() /*..add(const AuthenticationRestoreAuthRequested())*/,
        )
      ],
      child: Builder(builder: (context) {
        final appRouter = createAppRouter(context);
        return MaterialApp.router(
          supportedLocales: L10n.all,
          locale: const Locale('en'),
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          theme: createLightTheme(),
          darkTheme: createDarkTheme(),
          themeMode: ThemeMode.light,
          routeInformationParser: appRouter.routeInformationParser,
          routerDelegate: appRouter.routerDelegate,
          routeInformationProvider: appRouter.routeInformationProvider,
        );
      }),
    );
  }
}
