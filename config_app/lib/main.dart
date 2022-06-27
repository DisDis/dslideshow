import 'package:config_app/app.dart';
import 'package:config_app/src/page/config/config_page.dart';
import 'package:config_app/src/bloc/authentication_repository.dart';
import 'package:config_app/src/repository/user_repository.dart';
import 'package:dslideshow_common/log.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

final Logger _log = Logger('main');

void main() {
  initLog('f_config');
  _log.info("Run");

  runApp(App(
    authenticationRepository: AuthenticationRepository(),
    userRepository: UserRepository(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DSlideShow config',
      theme: ThemeData(
        // backgroundColor: Colors.black,
        brightness: Brightness.dark,
        // primaryColor: Colors.lightBlue[800],
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,

      //AppLocalizations.supportedLocales,
      home: Container(),
      routes: <String, WidgetBuilder>{
        '/config': (BuildContext context) => const ConfigPage(),
      },
      //onGenerateRoute: _onGenerateRoute,
    );
  }
}
