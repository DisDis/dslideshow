import 'package:config_app/app.dart';
import 'package:config_app/environment.dart';
import 'package:config_app/injection_container.dart';
import 'package:dslideshow_common/log.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

final Logger _log = Logger('main');

Future _setup() async {
  _log.info("Url: '${Uri.base}'");
  final currentUrl = Uri.parse(Uri.base.toString());
  final apiUrl = currentUrl.scheme == 'file' ? null : '${currentUrl.scheme}://${currentUrl.host}:${currentUrl.port}/v1';
  _log.info("currentUrl: '${Uri.base}' , apiUrl: '$apiUrl'");
  await initializeAllDependencies(apiUrl: apiUrl);
}

void main() async {
  initLog('f_config');
  _log.info("Run");
  WidgetsFlutterBinding.ensureInitialized();
  initEnvironment();
  await _setup();
  runApp(
    const App(),
  );
}
