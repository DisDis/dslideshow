import 'package:config_app/src/page/config/config_page.dart';
import 'package:config_app/src/page/login_page.dart';
import 'package:dslideshow_common/log.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

final Logger _log = Logger('main');
void main() {
  initLog('f_config');
  _log.info("Run");
  runApp(const MyApp());
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
      home: const AuthPage(),
      routes: <String, WidgetBuilder>{
        '/auth': (BuildContext context) => const AuthPage(),
        '/config': (BuildContext context) => const ConfigPage(),
      },
      //onGenerateRoute: _onGenerateRoute,
    );
  }
}
