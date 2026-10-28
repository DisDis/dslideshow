export 'package:config_app/src/env/default.dart'
    if (dart.library.js_interop) 'package:config_app/src/env/web.dart'
    if (dart.library.io) 'package:config_app/src/env/standalone.dart';
