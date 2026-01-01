export 'package:config_app/src/env/default.dart'
    if (dart.library.html) 'package:config_app/src/env/web.dart'
    if (dart.library.io) 'package:config_app/src/env/standalone.dart';

/*
const _kIsWeb = bool.hasEnvironment('dart.library.js_util')
    ? bool.fromEnvironment('dart.library.js_util')
    : identical(0, 0.0);
    */
